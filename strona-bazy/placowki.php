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
    
    <h1>Placówki</h1>
    <button id="add-institution-button">Dodaj stanowisko</button>

    <table id="placowki-table">
        <thead>
            <tr>
                <th>Id_placowki</th>
                <th>Miasto</th>
                <th>Ulica</th>
                <th>Numer budynku</th>
                <th>Ilosc samochodow</th>
                <th>Ilosc miejsca pozostalego</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>

        <?php
            require_once "db_connection.php";

            try {
                // Przygotowanie wywołania funkcji PL/SQL
                $sql = "SELECT * FROM pobierz_placowki() ORDER BY id_placowki ASC";
                

                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-id_placowki='" . $row['id_placowki'] . "'
                            data-miasto='" . $row['miasto'] . "'
                            data-ulica='" . $row['ulica'] . "'
                            data-numerbudynku='" . $row['numerbudynku'] . "'
                            data-iloscsamochodow='" . $row['iloscsamochodow'] . "'
                            data-iloscmiejscapozostalego='" . $row['iloscmiejscapozostalego'] . "'>";
                    echo "<td>" . $row['id_placowki'] . "</td>";
                    echo "<td>" . $row['miasto'] . "</td>";
                    echo "<td>" . $row['ulica'] . "</td>";
                    echo "<td>" . $row['numerbudynku'] . "</td>";
                    echo "<td>" . $row['iloscsamochodow'] . "</td>";
                    echo "<td>" . $row['iloscmiejscapozostalego'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-id_placowki='" . $row['id_placowki'] . "'>Usuń</button>";
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
    <div class="modal" id="add-institution-modal">
    <h2>Dodaj placowke</h2>
        <form id="add-institution-form">
            <label>Miasto:</label><br>
            <input type="text" name="miasto" required><br>
            <label>Ulica:</label><br>
            <input type="text" name="ulica" required><br>
            <label>NR budynku:</label><br>
            <input type="text" name="numerbudynku" required><br>
            <label>Ilość miejsca w placówce:</label><br>
            <input type="text" name="iloscmiejscapozostalego" required><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-add-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-institution-modal">
        <h2>Usuń placówke</h2>
        <p style="font-weight: bold;">
            Czy na pewno chcesz usunąć placówke o ID: 
            <span id="delete-id_placowki" style="text-decoration: underline;"></span>?
        </p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>


    <div class="modal-overlay"></div>
    <div class="modal" id="edit-institution-modal">
        <h2>Edytuj Placówke</h2>
        <form id="edit-institution-form">
            <label>ID (do edycji):</label><br>
            <input type="text" name="id_placowki_do_edycji" id="edit-id_placowki" readonly><br>
            <label>Miasto:</label><br>
            <input type="text" name="miasto" id="edit-miasto" required><br>
            <label>Ulica:</label><br>
            <input type="text" name="ulica" id="edit-ulica" required><br>
            <label>NR budynku:</label><br>
            <input type="text" name="numerbudynku" id="edit-numerbudynku" required><br>
            <label>Ilość samochodów:</label><br>
            <input type="text" name="iloscsamochodow" id="edit-iloscsamochodow" required><br>
            <label>Ilość miejsca pozostałego:</label><br>
            <input type="text" name="iloscmiejscapozostalego" id="edit-iloscmiejscapozostalego" required><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            const addInstitutionModal = $('#add-institution-modal');
            const editInstitutionModal = $('#edit-institution-modal');
            const deleteInstitutionModal = $('#delete-institution-modal');
            const overlay = $('.modal-overlay');

            // Dodawanie placówki
            $('#add-institution-button').on('click', function() {
                $('#add-institution-form').trigger('reset');
                addInstitutionModal.show();
                overlay.show();
            });

            $('#cancel-add-button, .modal-overlay').on('click', function() {
                addInstitutionModal.hide();
                overlay.hide();
            });

            $('#add-institution-form').on('submit', function(event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_placowke.php', // Zmieniono na odpowiedni plik PHP
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Placówka została dodana.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas dodawania placówki.');
                    }
                });
            });

            // Edycja placówki
            $(document).on('click', '.edit-button', function() {
                const row = $(this).closest('tr');
                const data = {
                    id_placowki: row.data('id_placowki'),
                    miasto: row.data('miasto'),
                    ulica: row.data('ulica'),
                    numerbudynku: row.data('numerbudynku'),
                    iloscsamochodow: row.data('iloscsamochodow'),
                    iloscmiejscapozostalego: row.data('iloscmiejscapozostalego')
                };

                $('#edit-id_placowki').val(data.id_placowki);
                $('#edit-miasto').val(data.miasto);
                $('#edit-ulica').val(data.ulica);
                $('#edit-numerbudynku').val(data.numerbudynku);
                $('#edit-iloscsamochodow').val(data.iloscsamochodow);
                $('#edit-iloscmiejscapozostalego').val(data.iloscmiejscapozostalego);

                editInstitutionModal.show();
                overlay.show();
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editInstitutionModal.hide();
                overlay.hide();
            });

            $('#edit-institution-form').on('submit', function(event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_placowke.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        console.log(response); // Sprawdzanie odpowiedzi serwera w konsoli
                        try {
                            const jsonResponse = typeof response === 'string' ? JSON.parse(response) : response;
                            if (jsonResponse.success) {
                                alert(jsonResponse.message); // Komunikat o sukcesie
                                location.reload();
                            } else {
                                alert('Błąd aktualizacji: ' + (jsonResponse.error || 'Nieznany błąd.'));
                            }
                        } catch (e) {
                            alert('Błąd: Niepoprawny JSON - sprawdź odpowiedź serwera.');
                            console.error('Błąd podczas parsowania odpowiedzi:', e);
                        }
                    },
                    error: function(xhr) {
                        try {
                            const errorResponse = JSON.parse(xhr.responseText);
                            alert('Błąd: ' + errorResponse.error);
                        } catch (e) {
                            console.error('Niepoprawny JSON:', xhr.responseText);
                            alert('Wystąpił nieoczekiwany błąd serwera.');
                        }
                    }
                });
            });

            // Otwórz modal do usuwania
            $('.delete-button').on('click', function() {
                const overlay = $('.modal-overlay');
                const id = $(this).data('id_placowki');
                $('#delete-id_placowki').text(id); // Wyświetlenie ID w modalu
                $('#confirm-delete-button').data('id_placowki', id); // Przypisanie ID do przycisku potwierdzenia
                $('#delete-institution-modal').show();
                overlay.show();
            });

            // Anulowanie usuwania
            $('#cancel-delete-button, .modal-overlay').on('click', function() {
                $('#delete-institution-modal').hide();
                overlay.hide();
            });

            // Potwierdzenie usuwania
            $('#confirm-delete-button').on('click', function() {
                const id = $(this).data('id_placowki');

                $.ajax({
                    url: 'usun_placowke.php', // Zmieniono na odpowiedni plik PHP
                    method: 'POST',
                    data: { id_placowki: id },
                    success: function(response) {
                        const jsonResponse = typeof response === 'string' ? JSON.parse(response) : response;

                        if (jsonResponse.success) {
                            alert(jsonResponse.message); // Wyświetlenie komunikatu sukcesu
                            location.reload();
                        } else {
                            alert('Nie udało się usunąć placówki: ' + (jsonResponse.error || 'Nieznany błąd.'));
                        }
                    },
                    error: function(xhr) {
                        try {
                            const errorResponse = JSON.parse(xhr.responseText);
                            alert('Błąd: ' + errorResponse.error);
                        } catch (e) {
                            console.error('Niepoprawny JSON:', xhr.responseText);
                            alert('Wystąpił nieoczekiwany błąd serwera.');
                        }
                    }
                });
            });
        });
    </script>



</body>
</html>
 