<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edytowalna Tabela</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
         table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        .modal-header {
            background-color: #f2f2f2;
            padding: 10px;
            cursor: move;
        }
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    
<h1>Podwykonawcy</h1>
<button id="add-subcontractor-button">Dodaj podwykonawcę</button>

<table id="podwykonawcy-table">
    <thead>
        <tr>
            <th>NIP</th>
            <th>Nazwa</th>
            <th>Specjalizacja</th>
            <th>Akcje</th>
        </tr>
    </thead>
    <tbody>

    <?php
        require_once "db_connection.php";

        try {
            // Przygotowanie wywołania funkcji PL/SQL
            $sql = 'SELECT * FROM "Podwykonawcy".pobierz_podwykonawcy() ORDER BY nippodwykonawcy ASC';
            

            $result = pg_query($conn, $sql);

            if (!$result) {
                throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
            }

            // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
            while ($row = pg_fetch_assoc($result)) {
                echo "<tr data-nippodwykonawcy='" . $row['nippodwykonawcy'] . "' 
                        data-nazwa='" . $row['nazwa'] . "' 
                        data-specjalizacja='" . $row['specjalizacja'] . "'>";
                echo "<td>" . $row['nippodwykonawcy'] . "</td>";
                echo "<td>" . $row['nazwa'] . "</td>";
                echo "<td>" . $row['specjalizacja'] . "</td>";
                echo "<td>";
                echo "<button class='edit-button'>Edytuj</button>";
                echo "<button class='delete-button' data-nippodwykonawcy='" . $row['nippodwykonawcy'] . "'>Usuń</button>";
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
<div class="modal" id="add-subcontractor-modal">
<h2>Dodaj podwykonawcę</h2>
    <form id="add-subcontractor-form">
        <label>NIP:</label><br>
        <input type="text" name="nippodwykonawcy" required><br>
        <label>Nazwa:</label><br>
        <input type="text" name="nazwa" required><br>
        <label>Specjalizacja:</label><br>
        <input type="text" name="specjalizacja" required><br>
        <button type="submit">Dodaj</button>
        <button type="button" id="cancel-add-button">Anuluj</button>
    </form>
</div>

<div class="modal-overlay"></div>
<div class="modal" id="delete-subcontractor-modal">
    <h2>Usuń podwykonawcę</h2>
    <p style="font-weight: bold;">
        Czy na pewno chcesz usunąć podwykonawcę o NIP: 
        <span id="delete-nippodwykonawcy" style="text-decoration: underline;"></span>?
    </p>
    <button id="confirm-delete-button">Usuń</button>
    <button id="cancel-delete-button">Anuluj</button>
</div>


<div class="modal-overlay"></div>
<div class="modal" id="edit-subcontractor-modal">
    <h2>Edytuj Podwykonawcę</h2>
    <form id="edit-subcontractor-form">
        <label>NIP (do edycji):</label><br>
        <input type="text" name="nippodwykonawcy_do_edycji" id="edit-nippodwykonawcy-do-edycji" readonly><br>
        <label>NIP:</label><br>
        <input type="text" name="nippodwykonawcy" id="edit-nippodwykonawcy" required><br>
        <label>Nazwa:</label><br>
        <input type="text" name="nazwa" id="edit-nazwa" required><br>
        <label>Specjalizacja:</label><br>
        <input type="text" name="specjalizacja" id="edit-specjalizacja" required><br>
        <button type="submit">Zapisz</button>
        <button type="button" id="cancel-edit-button">Anuluj</button>
    </form>
</div>

<script>
    $(document).ready(function() {
        const modal = $('#add-subcontractor-modal');
        const overlay = $('.modal-overlay');

        // Otwieranie modalu dodawania podwykonawcy
        $('#add-subcontractor-button').on('click', function() {
            $('#add-subcontractor-form').trigger('reset'); // Resetowanie formularza
            modal.show();
            overlay.show();
        });

        // Zamknięcie modalu po kliknięciu przycisku anuluj
        $('#cancel-add-button').on('click', function() {
            modal.hide();
            overlay.hide();
        });

        // Zamknięcie modalu po kliknięciu na overlay
        overlay.on('click', function() {
            modal.hide();
            overlay.hide();
        });

        // Obsługa formularza dodawania podwykonawcy
        $('#add-subcontractor-form').on('submit', function(event) {
            event.preventDefault(); // Zapobiega przeładowaniu strony

            const formData = $(this).serialize(); // Pobiera dane formularza

            $.ajax({
                url: 'dodaj_podwykonawce.php', // Ścieżka do pliku obsługującego dodawanie
                method: 'POST',
                data: formData,
                success: function(response) {
                    alert('Podwykonawca został dodany.');
                    location.reload(); // Odświeża stronę
                },
                error: function() {
                    alert('Wystąpił błąd podczas dodawania podwykonawcy.');
                }
            });
        });
    });

    $(document).ready(function() {
        const deleteModal = $('#delete-subcontractor-modal');
        const deleteOverlay = $('.modal-overlay');
        let currentNIP = null;

        function showDeleteModal(nippodwykonawcy) {
            currentNIP = nippodwykonawcy;
            $('#delete-nippodwykonawcy').text(nippodwykonawcy);
            deleteModal.show();
            deleteOverlay.show();
        }

        function hideDeleteModal() {
            currentNIP = null;
            deleteModal.hide();
            deleteOverlay.hide();
        }

        // Obsługa kliknięcia przycisku „Usuń”
        $(document).on('click', '.delete-button', function() {
            const nippodwykonawcy = $(this).data('nippodwykonawcy');
            showDeleteModal(nippodwykonawcy);
        });

        // Obsługa anulowania
        $('#cancel-delete-button, .modal-overlay').on('click', function() {
            hideDeleteModal();
        });

        // Obsługa potwierdzenia usunięcia
        $('#confirm-delete-button').on('click', function() {
            console.log('Kliknięto przycisk potwierdzenia usunięcia.');
            if (currentNIP) {
                $.ajax({
                    url: 'usun_podwykonawce.php', // Ścieżka do pliku obsługującego usuwanie
                    method: 'POST',
                    data: { nippodwykonawcy: currentNIP },
                    success: function(response) {
                        alert('Podwykonawca został usunięty.');
                        location.reload(); // Odświeża stronę
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas usuwania podwykonawcy.');
                    }
                });
            }
            hideDeleteModal();
        });
    });

    $(document).ready(function() {
        const editModal = $('#edit-subcontractor-modal');
        const overlay = $('.modal-overlay');

        function showEditModal(data) {
            // Wypełnij pola formularza danymi
            $('#edit-nippodwykonawcy-do-edycji').val(data.nippodwykonawcy); // NIP do edycji (readonly)
            $('#edit-nippodwykonawcy').val(data.nippodwykonawcy); // Edytowalny NIP
            $('#edit-nazwa').val(data.nazwa);
            $('#edit-specjalizacja').val(data.specjalizacja);

            // Pokaż modal
            editModal.show();
            overlay.show();
        }

        // Obsługa kliknięcia "Edytuj"
        $(document).on('click', '.edit-button', function() {
            const row = $(this).closest('tr');
            const data = {
                nippodwykonawcy: row.data('nippodwykonawcy'),
                nazwa: row.data('nazwa'),
                specjalizacja: row.data('specjalizacja'),
            };

            showEditModal(data);
        });

        // Obsługa zamknięcia modala
        $('#cancel-edit-button, .modal-overlay').on('click', function() {
            editModal.hide();
            overlay.hide();
        });

        // Obsługa zapisu zmian
        $('#edit-subcontractor-form').on('submit', function(event) {
            event.preventDefault();
            const formData = $(this).serialize();

            $.ajax({
                url: 'edytuj_podwykonawce.php', // Plik obsługujący edycję
                method: 'POST',
                data: formData,
                dataType: 'json', // Oczekujemy JSON w odpowiedzi
                success: function(response) {
                    alert('Podwykonawca został zaktualizowany.');
                    location.reload();
                },
                error: function() {
                    alert('Wystąpił błąd podczas aktualizacji podwykonawcy.');
                }
            });
        });
    });



</script>

</body>
</html>
 