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
    <h1>Stanowiska</h1>
    <button id="add-position-button">Dodaj stanowisko</button>

    <table id="positions-table">
        <thead>
            <tr>
                <th>Id_stanowiska</th>
                <th>Nazwa stanowiska</th>
                <th>Min zarobki</th>
                <th>Max zarobki</th>
                <th>Doświadczenie</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>
        <?php
            require_once "db_connection.php";

            try {
                $sql = 'SELECT * FROM "Stanowiska".pobierz_stanowiska();';
                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-id_stanowiska='" . $row['id_stanowiska'] . "'
                            data-nazwa='" . $row['nazwastanowiska'] . "'
                            data-min-zarobki='" . $row['minzarobki'] . "'
                            data-max-zarobki='" . $row['maxzarobki'] . "'
                            data-doswiadczenie='" . $row['doswiadczenie'] . "'>";
                    echo "<td>" . $row['id_stanowiska'] . "</td>";
                    echo "<td>" . $row['nazwastanowiska'] . "</td>";
                    echo "<td>" . $row['minzarobki'] . "</td>";
                    echo "<td>" . $row['maxzarobki'] . "</td>";
                    echo "<td>" . $row['doswiadczenie'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-id_stanowiska='" . $row['id_stanowiska'] . "'>Usuń</button>";
                    echo "</td>";
                    echo "</tr>";
                }

                pg_free_result($result);
                pg_close($conn);

            } catch (Exception $e) {
                echo "Wystąpił błąd: " . htmlspecialchars($e->getMessage());
            }
        ?>
        </tbody>
    </table>

    <div class="modal-overlay"></div>
    <div class="modal" id="add-position-modal">
    <h2>Dodaj stanowisko</h2>
        <form id="add-position-form">
            <label>Nazwa stanowiska:</label><br>
            <input type="text" name="nazwa" required><br>
            <label>Min zarobki:</label><br>
            <input type="text" name="min_zarobki" required><br>
            <label>Max zarobki:</label><br>
            <input type="text" name="max_zarobki" required><br>
            <label>Doświadczenie:</label><br>
            <input type="text" name="doswiadczenie" required><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-add-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-position-modal">
        <h2>Usuń stanowisko</h2>
        <p style="font-weight: bold;">
            Czy na pewno chcesz usunąć stanowisko o ID: 
            <span id="delete-id_stanowiska" style="text-decoration: underline;"></span>?
        </p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>


    <div class="modal-overlay"></div>
    <div class="modal" id="edit-position-modal">
        <h2>Edytuj Stanowisko</h2>
        <form id="edit-position-form">
            <label>ID (do edycji):</label><br>
            <input type="text" name="id_stanowiska_do_edycji" id="edit-id_stanowiska" readonly><br>
            <label>Nazwa stanowiska:</label><br>
            <input type="text" name="nazwa" id="edit-nazwa" required><br>
            <label>Min zarobki:</label><br>
            <input type="text" name="min_zarobki" id="edit-min-zarobki" required><br>
            <label>Max zarobki:</label><br>
            <input type="text" name="max_zarobki" id="edit-max-zarobki" required><br>
            <label>Doświadczenie:</label><br>
            <input type="text" name="doswiadczenie" id="edit-doswiadczenie" required><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            const addPositionModal = $('#add-position-modal');
            const editPositionModal = $('#edit-position-modal');
            const deletePositionModal = $('#delete-position-modal');
            const overlay = $('.modal-overlay');

            // Dodawanie stanowiska
            $('#add-position-button').on('click', function() {
                $('#add-position-form').trigger('reset');
                addPositionModal.show();
                overlay.show();
            });

            $('#cancel-add-button, .modal-overlay').on('click', function() {
                addPositionModal.hide();
                overlay.hide();
            });

            $('#add-position-form').on('submit', function(event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_stanowisko.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Stanowisko zostało dodane.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas dodawania stanowiska.');
                    }
                });
            });

            // Edycja stanowiska
            $(document).on('click', '.edit-button', function () {
                const row = $(this).closest('tr');
                const data = {
                    id_stanowiska: row.data('id_stanowiska'),
                    nazwastanowiska: row.data('nazwa'),
                    minzarobki: row.data('min-zarobki'),
                    maxzarobki: row.data('max-zarobki'),
                    doswiadczenie: row.data('doswiadczenie'),
                };

                $('#edit-id_stanowiska').val(data.id_stanowiska);
                $('#edit-nazwa').val(data.nazwastanowiska);
                $('#edit-min-zarobki').val(data.minzarobki);
                $('#edit-max-zarobki').val(data.maxzarobki);
                $('#edit-doswiadczenie').val(data.doswiadczenie);

                $('#edit-position-modal').show();
                $('.modal-overlay').show();
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editPositionModal.hide();
                overlay.hide();
            });

            $('#edit-position-form').on('submit', function (event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_stanowisko.php',
                    method: 'POST',
                    data: formData,
                    success: function (response) {
                        const jsonResponse = typeof response === 'string' ? JSON.parse(response) : response;

                        if (jsonResponse.success) {
                            alert(jsonResponse.message); // Komunikat o sukcesie
                            location.reload();
                        } else {
                            alert('Błąd aktualizacji: ' + (jsonResponse.error || 'Nieznany błąd.'));
                        }
                    },
                    error: function (xhr) {
                        try {
                            const errorResponse = JSON.parse(xhr.responseText);
                            alert('Błąd: ' + errorResponse.error);
                        } catch (e) {
                            console.error('Niepoprawny JSON:', xhr.responseText);
                            alert('Wystąpił nieoczekiwany błąd serwera.');
                        }
                    },
                });
            });



            // Otwórz modal do usuwania
            $('.delete-button').on('click', function () {
                const overlay = $('.modal-overlay');
                const id = $(this).data('id_stanowiska');
                $('#delete-id_stanowiska').text(id); // Wyświetlenie ID w modalu
                $('#confirm-delete-button').data('id_stanowiska', id); // Przypisanie ID do przycisku potwierdzenia
                $('#delete-position-modal').show();
                overlay.show();
            });

            // Anulowanie usuwania
            $('#cancel-delete-button, .modal-overlay').on('click', function () {
                $('#delete-position-modal').hide();
                overlay.hide();
            });

            // Potwierdzenie usuwania
            $('#confirm-delete-button').on('click', function () {
                const id = $(this).data('id_stanowiska');

                $.ajax({
                    url: 'usun_stanowisko.php',
                    method: 'POST',
                    data: { id_stanowiska: id },
                    success: function (response) {
                        // Parsowanie odpowiedzi JSON
                        const jsonResponse = typeof response === 'string' ? JSON.parse(response) : response;

                        if (jsonResponse.success) {
                            alert(jsonResponse.message); // Wyświetlenie komunikatu sukcesu
                            location.reload();
                        } else {
                            alert('Nie udało się usunąć stanowiska: ' + (jsonResponse.error || 'Nieznany błąd.'));
                        }
                    },
                    error: function (xhr) {
                        try {
                            const errorResponse = JSON.parse(xhr.responseText);
                            alert('Błąd: ' + errorResponse.error);
                        } catch (e) {
                            console.error('Niepoprawny JSON:', xhr.responseText);
                            alert('Wystąpił nieoczekiwany błąd serwera.');
                        }
                    },
                });
            });

        });
</script>


</body>
</html>
 