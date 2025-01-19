<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="style.css">

</head>
<body>
    <h1>Relacje VIN - NIP Podwykonawcy</h1>
    <button id="add-relation-button">Dodaj relację</button>

    <table id="relacje-table">
        <thead>
            <tr>
                <th>VIN</th>
                <th>NIP Podwykonawcy</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>
            <?php
                require_once "db_connection.php";

                try {
                    // Przygotowanie wywołania funkcji PL/SQL
                    $sql = 'SELECT * FROM "Samochody_Podwykonawcy".pobierz_samochody_podwykonawcy() ORDER BY vin ASC';

                    $result = pg_query($conn, $sql);

                    if (!$result) {
                        throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                    }

                    // Iteracja przez wyniki zwrócone przez kursor i generowanie wierszy tabeli
                    while ($row = pg_fetch_assoc($result)) {
                        echo "<tr data-vin='" . $row['vin'] . "' data-nippodwykonawcy='" . $row['nippodwykonawcy'] . "'>";
                        echo "<td>" . $row['vin'] . "</td>";
                        echo "<td>" . $row['nippodwykonawcy'] . "</td>";
                        echo "<td>";
                        echo "<button class='edit-button'>Edytuj</button>";
                        echo "<button class='delete-button' data-vin='" . htmlspecialchars($row['vin']) . "' data-nippodwykonawcy='" . htmlspecialchars($row['nippodwykonawcy']) . "'>Usuń</button>";
                        echo "</td>";
                        echo "</tr>";
                    }

                    // Zwolnienie zasobów i zamknięcie połączenia
                    pg_free_result($result);
                    pg_close($conn);

                } catch (Exception $e) {
                    echo "Wystąpił błąd: " . htmlspecialchars($e->getMessage());
                }
            ?>
        </tbody>
    </table>

    <div class="modal-overlay"></div>
    <div class="modal" id="add-relation-modal">
        <h2>Dodaj relację</h2>
        <form id="add-relation-form">
            <label>VIN:</label><br>
            <input type="text" name="vin" required><br>
            <label>NIP Podwykonawcy:</label><br>
            <input type="text" name="nippodwykonawcy" required><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-add-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-relation-modal">
        <h2>Usuń relację</h2>
        <p style="font-weight: bold;">
            Czy na pewno chcesz usunąć relację dla VIN: 
            <span id="delete-vin" style="text-decoration: underline;"></span> i NIP Podwykonawcy: 
            <span id="delete-nippodwykonawcy" style="text-decoration: underline;"></span>?
        </p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>


    <div class="modal-overlay"></div>
    <div class="modal" id="edit-relation-modal">
        <h2>Edytuj relację</h2>
        <form id="edit-relation-form">
            <label>VIN (do edycji):</label><br>
            <input type="text" name="vin_do_edycji" id="edit-vin-do-edycji" readonly><br>
            <label>VIN:</label><br>
            <input type="text" name="vin" id="edit-vin" required><br>
            <label>NIP Podwykonawcy:</label><br>
            <input type="text" name="nippodwykonawcy" id="edit-nippodwykonawcy" required><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>

    <script>
        $(document).ready(function () {
            const addModal = $('#add-relation-modal');
            const overlay = $('.modal-overlay');

            $('#add-relation-button').on('click', function () {
                $('#add-relation-form').trigger('reset');
                addModal.show();
                overlay.show();
            });

            $('#cancel-add-button, .modal-overlay').on('click', function () {
                addModal.hide();
                overlay.hide();
            });

            $('#add-relation-form').on('submit', function (event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_relacje.php',
                    method: 'POST',
                    data: formData,
                    success: function (response) {
                        alert('Relacja została dodana.');
                        location.reload();
                    },
                    error: function () {
                        alert('Wystąpił błąd podczas dodawania relacji.');
                    }
                });
            });
        });

        $(document).ready(function() {
            const deleteModal = $('#delete-relation-modal');
            const deleteOverlay = $('.modal-overlay');
            let currentVin = null;
            let currentNippodwykonawcy = null;

            // Funkcja do pokazania modala
            function showDeleteModal(vin, nippodwykonawcy) {
                currentVin = vin;
                currentNippodwykonawcy = nippodwykonawcy;
                $('#delete-vin').text(vin);
                $('#delete-nippodwykonawcy').text(nippodwykonawcy);
                deleteModal.show();
                deleteOverlay.show();
            }

            // Funkcja do zamknięcia modala
            function hideDeleteModal() {
                currentVin = null;
                currentNippodwykonawcy = null;
                deleteModal.hide();
                deleteOverlay.hide();
            }

            // Obsługa kliknięcia przycisku "Usuń"
            $(document).on('click', '.delete-button', function() {
                const vin = $(this).data('vin');
                const nippodwykonawcy = $(this).data('nippodwykonawcy');
                showDeleteModal(vin, nippodwykonawcy);
            });

            // Obsługa anulowania
            $('#cancel-delete-button, .modal-overlay').on('click', function() {
                hideDeleteModal();
            });

            // Obsługa potwierdzenia usunięcia
            $('#confirm-delete-button').on('click', function() {
                if (currentVin && currentNippodwykonawcy) {
                    $.ajax({
                        url: 'usun_relacje.php',
                        method: 'POST',
                        data: { vin: currentVin, nippodwykonawcy: currentNippodwykonawcy },
                        success: function(response) {
                            alert('Relacja została usunięta.');
                            location.reload();
                        },
                        error: function() {
                            alert('Wystąpił błąd podczas usuwania relacji.');
                        }
                    });
                }
                hideDeleteModal();
            });
        });



        $(document).ready(function() {
            const editModal = $('#edit-relation-modal');
            const overlay = $('.modal-overlay');

            function showEditModal(data) {
                // Wypełnij pola formularza danymi
                $('#edit-vin-do-edycji').val(data.vin); // VIN do edycji
                $('#edit-vin').val(data.vin);
                $('#edit-nippodwykonawcy').val(data.nippodwykonawcy);

                // Pokaż modal
                editModal.show();
                overlay.show();
            }

            // Obsługa kliknięcia "Edytuj"
            $(document).on('click', '.edit-button', function() {
                const row = $(this).closest('tr');
                const data = {
                    vin: row.data('vin'),
                    nippodwykonawcy: row.data('nippodwykonawcy'),
                };

                showEditModal(data);
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editModal.hide();
                overlay.hide();
            });

            // Obsługa zapisu zmian
            $('#edit-relation-form').on('submit', function(event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_relacje.php', // Plik obsługujący edycję
                    method: 'POST',
                    data: formData,
                    dataType: 'json', // Oczekujemy JSON w odpowiedzi
                    success: function(response) {
                        alert('Relacja została zaktualizowana.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas aktualizacji relacji.');
                    }
                });
            });
        });

    </script>

</body>
</html>