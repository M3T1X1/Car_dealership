<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edytowalna Tabela</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="style.css">

    
</head>
<body>
    
    <h1>Pracownicy</h1>
    <button id="add-employee-button">Dodaj pracownika</button>
    <label for="placowka-select">Wybierz placówkę:</label>
    <select id="placowka-select">
        <option value="">-- Wybierz placówkę --</option>
        <?php
        require_once "db_connection.php";

        // Pobierz listę placówek
        $sql = 'SELECT id_placowki, miasto FROM placowki;';
        $result = pg_query($conn, $sql);

        while ($row = pg_fetch_assoc($result)) {
            echo "<option value='" . $row['id_placowki'] . "'>" . htmlspecialchars($row['id_placowki']) . " - " . htmlspecialchars($row['miasto']) . "</option>";
        }
        

        pg_free_result($result);
      
        ?>
    </select>

    <button id="sum-salaries-button">Oblicz sumę zarobków</button>
    <p id="sum-salaries-result"></p>

    <table id="pracownicy-table">
        <thead>
            <tr>
                <th>Pesel</th>
                <th>Imie</th>
                <th>Nazwisko</th>
                <th>Stanowiskoid</th>
                <th>Placowkaid</th>
                <th>Zarobki</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>
        <?php
            require_once "db_connection.php";

            try {
                // Przygotowanie wywołania funkcji PL/SQL
                $sql = 'SELECT * FROM "Pracownicy".pobierz_pracownicy();';
                

                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-pesel='" . $row['pesel'] . "'
                            data-imie='" . $row['imie'] . "'
                            data-nazwisko='" . $row['nazwisko'] . "'
                            data-stanowiskoid='" . $row['stanowiskoid'] . "'
                            data-placowkaid='" . $row['placowkaid'] . "'
                            data-zarobki='" . $row['zarobki'] . "'>";
                    echo "<td>" . $row['pesel'] . "</td>";
                    echo "<td>" . $row['imie'] . "</td>";
                    echo "<td>" . $row['nazwisko'] . "</td>";
                    echo "<td>" . $row['stanowiskoid'] . "</td>";
                    echo "<td>" . $row['placowkaid'] . "</td>";
                    echo "<td>" . $row['zarobki'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-pesel='" . $row['pesel'] . "'>Usuń</button>";
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
    <div class="modal" id="add-employee-modal">
        <h2>Dodaj pracownika</h2>
        <form id="add-employee-form">
            <label>Pesel:</label><br>
            <input type="text" name="pesel" required><br>
            <label>Imie:</label><br>
            <input type="text" name="imie" required><br>
            <label>Nazwisko:</label><br>
            <input type="text" name="nazwisko" required><br>
            <label>Stanowisko Id:</label><br>
            <input type="text" name="stanowiskoid" required><br>
            <label>Placowka ID:</label><br>
            <input type="text" name="placowkaid" required><br>
            <label>Zarobki:</label><br>
            <input type="text" name="zarobki" required><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-employee-modal">
        <h2>Usuń pracownika</h2>
        <p style="font-weight: bold;">Czy na pewno chcesz usunąć pracownika o pesel: <span id="delete-pesel" style="text-decoration: underline;"></span> ?</p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="edit-employee-modal">
        <h2>Edytuj pracownika</h2>
        <form id="edit-employee-form">
            <label>Pesel (do edycji):</label><br>
            <input type="text" name="pesel_do_edycji" id="edit-pesel-do-edycji" readonly><br>
            <label>Pesel:</label><br>
            <input type="text" name="pesel" id="edit-pesel" required><br>
            <label>Imie:</label><br>
            <input type="text" name="imie" id="edit-imie" required><br>
            <label>Nazwisko:</label><br>
            <input type="text" name="nazwisko" id="edit-nazwisko" required><br>
            <label>Stanowisko Id:</label><br>
            <input type="text" name="stanowiskoid" id="edit-stanowiskoid" required><br>
            <label>Placowka Id:</label><br>
            <input type="text" name="placowkaid" id="edit-placowkaid" required><br>
            <label>Zarobki:</label><br>
            <input type="text" name="zarobki" id="edit-zarobki" required><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            const modal = $('#add-employee-modal');
            const overlay = $('.modal-overlay');

            $('#add-employee-button').on('click', function() {
                $('#add-employee-form').trigger('reset');
                modal.show();
                overlay.show();
            });

            $('#cancel-button').on('click', function() {
                modal.hide();
                overlay.hide();
            });

            overlay.on('click', function() {
                modal.hide();
                overlay.hide();
            });

            $('#add-employee-form').on('submit', function(event) {
                event.preventDefault();

                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_pracownika.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Pracownik został dodany.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas dodawania pracownika.');
                    }
                });
            });
        });

        $(document).ready(function() {
            const deleteModal = $('#delete-employee-modal');
            const deleteOverlay = $('.modal-overlay');
            let currentPesel = null;

            function showDeleteModal(pesel) {
                currentPesel = pesel;
                $('#delete-pesel').text(pesel);
                deleteModal.show();
                deleteOverlay.show();
            }

            function hideDeleteModal() {
                currentPesel = null;
                deleteModal.hide();
                deleteOverlay.hide();
            }

            // Obsługa kliknięcia przycisku „Usuń”
            $(document).on('click', '.delete-button', function() {
                const pesel = $(this).data('pesel');
                showDeleteModal(pesel);
            });

            // Obsługa anulowania
            $('#cancel-delete-button, .modal-overlay').on('click', function() {
                hideDeleteModal();
            });

            // Obsługa potwierdzenia usunięcia
            $('#confirm-delete-button').on('click', function() {
                if (currentPesel) {
                    $.ajax({
                        url: 'usun_pracownika.php',
                        method: 'POST',
                        data: { pesel: currentPesel },
                        success: function(response) {
                            alert('Pracownik został usunięty.');
                            location.reload();
                        },
                        error: function() {
                            alert('Wystąpił błąd podczas usuwania pracownika.');
                        }
                    });
                }
                hideDeleteModal();
            });
        });


        $(document).ready(function() {
            const editModal = $('#edit-employee-modal');
            const overlay = $('.modal-overlay');

            function showEditModal(data) {
                // Wypełnij pola formularza danymi
                $('#edit-pesel-do-edycji').val(data.pesel); // PESEL do edycji
                $('#edit-pesel').val(data.pesel);
                $('#edit-imie').val(data.imie);
                $('#edit-nazwisko').val(data.nazwisko);
                $('#edit-stanowiskoid').val(data.stanowiskoid);
                $('#edit-placowkaid').val(data.placowkaid);
                $('#edit-zarobki').val(data.zarobki);

                // Pokaż modal
                editModal.show();
                overlay.show();
            }

            // Obsługa kliknięcia "Edytuj"
            $(document).on('click', '.edit-button', function() {
                const row = $(this).closest('tr');
                const data = {
                    pesel: row.data('pesel'),
                    imie: row.data('imie'),
                    nazwisko: row.data('nazwisko'),
                    stanowiskoid: row.data('stanowiskoid'),
                    placowkaid: row.data('placowkaid'),
                    zarobki: row.data('zarobki'),
                };

                showEditModal(data);
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editModal.hide();
                overlay.hide();
            });

            // Obsługa zapisu zmian
            $('#edit-employee-form').on('submit', function (event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_pracownika.php', // Plik obsługujący edycję
                    method: 'POST',
                    data: formData,
                    dataType: 'json', // Oczekujemy JSON w odpowiedzi
                    success: function(response) {
                        alert('Pracownik został zaktualizowany.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas aktualizacji pracownika.');
                    }
                });
            });
        });


       
        document.getElementById('sum-salaries-button').addEventListener('click', async () => {
            const placowkaId = document.getElementById('placowka-select').value;

            if (!placowkaId) {
                alert('Wybierz placówkę!');
                return;
            }

            try {
                const response = await fetch(`suma_zarobkow.php?placowkaid=${placowkaId}`);
                const data = await response.json();

                if (data.success) {
                    document.getElementById('sum-salaries-result').textContent = `Suma zarobków: ${data.sum}`;
                } else {
                    document.getElementById('sum-salaries-result').textContent = `Błąd: ${data.error}`;
                }
            } catch (error) {
                document.getElementById('sum-salaries-result').textContent = `Błąd połączenia: ${error.message}`;
            }
        });

    </script>
</body>
</html>
 