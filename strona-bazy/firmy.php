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
    
    <h1>Firmy</h1>
    <button id="add-company-button">Dodaj firmę</button>

    <table id="firmy-table">
        <thead>
            <tr>
                <th>Nazwa firmy</th>
                <th>NIP</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>
        <?php
            require_once "db_connection.php";

            try {
                // Przygotowanie wywołania funkcji PL/SQL
                $sql = 'SELECT * FROM "Firmy".pobierz_firmy() ORDER BY nazwafirmy ASC';
                

                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-nazwafirmy='" . $row['nazwafirmy'] . "'
                            data-nip='" . $row['nip'] . "'>";
                    echo "<td>" . $row['nazwafirmy'] . "</td>";
                    echo "<td>" . $row['nip'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-nazwafirmy='" . $row['nazwafirmy'] . "'>Usuń</button>";
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
    <div class="modal" id="add-company-modal">
    <h2>Dodaj firmę</h2>
        <form id="add-company-form">
            <label>Nazwa Firmy:</label><br>
            <input type="text" name="nazwa" required><br>
            <label>NIP:</label><br>
            <input type="text" name="nip" required><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-add-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-company-modal">
        <h2>Usuń firmę</h2>
        <p style="font-weight: bold;">
            Czy na pewno chcesz usunąć firmę o nazwie: 
            <span id="delete-nazwafirmy" style="text-decoration: underline;"></span>?
        </p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>


    <div class="modal-overlay"></div>
    <div class="modal" id="edit-company-modal">
        <h2>Edytuj firmę</h2>
        <form id="edit-company-form">
            <label>Nazwa firmy (do edycji):</label><br>
            <input type="text" name="nazwafirmy_do_edycji" id="edit-nazwafirmy-do-edycji" readonly><br>
            <label>Nowa nazwa firmy:</label><br>
            <input type="text" name="nazwafirmy" id="edit-nazwafirmy" required><br>
            <label>NIP:</label><br>
            <input type="text" name="nip" id="edit-nip" required><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>


    <script>
        $(document).ready(function() {
            const addCompanyModal = $('#add-company-modal');
            const editCompanyModal = $('#edit-company-modal');
            const deleteCompanyModal = $('#delete-company-modal');
            const overlay = $('.modal-overlay');

            // Dodawanie firmy
            $('#add-company-button').on('click', function() {
                $('#add-company-form').trigger('reset');
                addCompanyModal.show();
                overlay.show();
            });

            $('#cancel-add-button, .modal-overlay').on('click', function() {
                addCompanyModal.hide();
                overlay.hide();
            });

            $('#add-company-form').on('submit', function(event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_firme.php', 
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Firma została dodana.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas dodawania firmy.');
                    }
                });
            });

            // Edycja firmy
            $(document).on('click', '.edit-button', function() {
                const row = $(this).closest('tr');
                const data = {
                    nazwafirmy: row.data('nazwafirmy'),
                    nip: row.data('nip')
                };

                $('#edit-nazwafirmy-do-edycji').val(data.nazwafirmy); 
                $('#edit-nazwafirmy').val(data.nazwafirmy); 
                $('#edit-nip').val(data.nip); 

                editCompanyModal.show();
                overlay.show();
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editCompanyModal.hide();
                overlay.hide();
            });

            $('#edit-company-form').on('submit', function(event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_firme.php', // Plik obsługujący edycję
                    method: 'POST',
                    data: formData,
                    dataType: 'json', // Oczekujemy JSON w odpowiedzi
                    success: function(response) {
                        alert('Firma została zaktualizowana.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas aktualizacji.');
                    }
                });
            });

            // Otwórz modal do usuwania firmy
            $('.delete-button').on('click', function() {
                const overlay = $('.modal-overlay');
                const nazwafirmy = $(this).data('nazwafirmy');
                $('#delete-nazwafirmy').text(nazwafirmy); // Wyświetlenie nazwy firmy w modalu
                $('#confirm-delete-button').data('nazwafirmy', nazwafirmy); // Przypisanie nazwy firmy do przycisku potwierdzenia
                $('#delete-company-modal').show();
                overlay.show();
            });

            // Anulowanie usuwania firmy
            $('#cancel-delete-button, .modal-overlay').on('click', function() {
                $('#delete-company-modal').hide();
                overlay.hide();
            });

            // Potwierdzenie usuwania firmy
            $('#confirm-delete-button').on('click', function() {
                const nazwafirmy = $(this).data('nazwafirmy');

                $.ajax({
                    type: "POST",
                    url: "edytuj_firme.php", // Ścieżka do skryptu PHP
                    data: formData,
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            // Jeśli sukces, zamknij modal, wyświetl komunikat i odśwież stronę
                            alert(response.message); // Komunikat sukcesu
                            $("#edit-company-modal").hide(); // Zamknięcie modala
                            $(".modal-overlay").hide(); // Ukrycie overlay
                            location.reload(); // Odświeżenie strony
                        } else {
                            // Obsługuje błąd, np. jeśli wystąpił problem z zapytaniem
                            alert(response.error || "Wystąpił błąd podczas przetwarzania.");
                        }
                    },
                    error: function(xhr, status, error) {
                        // Obsługuje błędy AJAX
                        alert("Wystąpił błąd podczas zapisywania danych.");
                    }
                });
            });
        });
    </script>

</body>
</html>
 