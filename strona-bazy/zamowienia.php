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
    
    <h1>Zamowienia</h1>
    <button id="add-order-button">Dodaj zamówienie</button>

    <table id="zamowienia-table">
        <thead>
            <tr>
                <th>Id_zamowienia</th>
                <th>Kwota</th>
                <th>Pesel klienta</th>
                <th>VIN</th>
                <th>Usługa naprawy</th>
                <th>Pesel pracownika</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>
        <?php
            require_once "db_connection.php";

            try {
                // Przygotowanie wywołania funkcji PL/SQL
                $sql = 'SELECT * FROM "Zamowienia".pobierz_zamowienia() ORDER BY id_zamowienia ASC';
                

                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-id_zamowienia='" . $row['id_zamowienia'] . "'
                            data-kwota='" . $row['kwota'] . "'
                            data-pesel_klienta='" . $row['pesel_klienta'] . "'
                            data-vin='" . $row['vin'] . "'
                            data-usluganaprawy='" . $row['usluganaprawy'] . "'
                            data-pesel_pracownika='" . $row['pesel_pracownika'] . "'>";
                    echo "<td>" . $row['id_zamowienia'] . "</td>";
                    echo "<td>" . $row['kwota'] . "</td>";
                    echo "<td>" . $row['pesel_klienta'] . "</td>";
                    echo "<td>" . $row['vin'] . "</td>";
                    echo "<td>" . $row['usluganaprawy'] . "</td>";
                    echo "<td>" . $row['pesel_pracownika'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-id_zamowienia='" . $row['id_zamowienia'] . "'>Usuń</button>";
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
    <div class="modal" id="add-order-modal">
        <h2>Dodaj zamówienie</h2>
        <form id="add-order-form">
            <label>Kwota:</label><br>
            <input type="text" name="kwota" required><br>
            <label>Pesel_klienta:</label><br>
            <input type="text" name="pesel_klienta" required><br>
            <label>VIN:</label><br>
            <input type="text" name="vin" required><br>
            <label>Usługa naprawy:</label><br>
            <input type="radio" name="usluganaprawy" id="usluga_true" value="TRUE" required>
            <label for="usluga_true">Tak</label><br>
            <input type="radio" name="usluganaprawy" id="usluga_false" value="FALSE">
            <label for="usluga_false">Nie</label><br>
            <label>Pesel pracownika:</label><br>
            <input type="text" name="pesel_pracownika" required><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-order-modal">
        <h2>Usuń zamówienie</h2>
        <p style="font-weight: bold;">Czy na pewno chcesz usunąć zamówienie o ID: <span id="delete-id_zamowienia" style="text-decoration: underline;"></span> ?</p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="edit-order-modal">
        <h2>Edytuj Zamówienie</h2>
        <form id="edit-order-form">
            <label>Id_zamówienia (do edycji):</label><br>
            <input type="text" name="id_zamowienia_do_edycji" id="edit-id_zamowienia-do-edycji" readonly><br>
            <label>Kwota:</label><br>
            <input type="text" name="kwota" id="edit-kwota" required><br>
            <label>Pesel klienta:</label><br>
            <input type="text" name="pesel_klienta" id="edit-pesel_klienta" required><br>
            <label>VIN:</label><br>
            <input type="text" name="vin" id="edit-vin" required><br>
            <label>Usługa naprawy:</label><br>
            <div>
            <label>
                <input type="radio" name="usluganaprawy" value="true" id="edit-usluganaprawy-true" required>
                Tak
            </label>
            <label>
                <input type="radio" name="usluganaprawy" value="false" id="edit-usluganaprawy-false" required>
                Nie
            </label>
            </div>

            <label>Pesel pracownika:</label><br>
            <input type="text" name="pesel_pracownika" id="edit-pesel_pracownika" required><br>

            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>


    <script>
        $(document).ready(function() {
            const modal = $('#add-order-modal');
            const overlay = $('.modal-overlay');

            $('#add-order-button').on('click', function() {
                $('#add-order-form').trigger('reset');
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

            $('#add-order-form').on('submit', function(event) {
                event.preventDefault();

                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_zamowienie.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Zamówienie zostało dodane.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas dodawania zamówienia.');
                    }
                });
            });
        });

        $(document).ready(function() {
            const deleteModal = $('#delete-order-modal');
            const deleteOverlay = $('.modal-overlay');
            let currentOrderId = null;

            function showDeleteModal(orderId) {
                currentOrderId = orderId;
                $('#delete-id_zamowienia').text(orderId);
                deleteModal.show();
                deleteOverlay.show();
            }

            function hideDeleteModal() {
                currentOrderId = null;
                deleteModal.hide();
                deleteOverlay.hide();
            }

            // Obsługa kliknięcia przycisku „Usuń”
            $(document).on('click', '.delete-button', function() {
                const orderId = $(this).data('id_zamowienia');
                showDeleteModal(orderId);
            });

            // Obsługa anulowania
            $('#cancel-delete-button, .modal-overlay').on('click', function() {
                hideDeleteModal();
            });

            // Obsługa potwierdzenia usunięcia
            $('#confirm-delete-button').on('click', function() {
                if (currentOrderId) {
                    $.ajax({
                        url: 'usun_zamowienie.php',
                        method: 'POST',
                        data: { id_zamowienia: currentOrderId },
                        success: function(response) {
                            alert('Zamówienie zostało usunięte.');
                            location.reload();
                        },
                        error: function() {
                            alert('Wystąpił błąd podczas usuwania zamówienia.');
                        }
                    });
                }
                hideDeleteModal();
            });
        });

        $(document).ready(function() {
            const editModal = $('#edit-order-modal');
            const overlay = $('.modal-overlay');

            function showEditModal(data) {
                // Wypełnij pola formularza danymi
                $('#edit-id_zamowienia-do-edycji').val(data.id_zamowienia);
                $('#edit-kwota').val(data.kwota);
                $('#edit-pesel_klienta').val(data.pesel_klienta);
                $('#edit-vin').val(data.vin);

                // Ustaw radio buttony dla usluganaprawy
                if (data.usluganaprawy === true || data.usluganaprawy === "true") {
                    $('#edit-usluganaprawy-true').prop('checked', true);
                } else {
                    $('#edit-usluganaprawy-false').prop('checked', true);
                }

                $('#edit-pesel_pracownika').val(data.pesel_pracownika);

                // Pokaż modal
                editModal.show();
                overlay.show();
            }


            // Obsługa kliknięcia "Edytuj"
            $(document).on('click', '.edit-button', function() {
                const row = $(this).closest('tr');
                const data = {
                    id_zamowienia: row.data('id_zamowienia'),
                    kwota: row.data('kwota'),
                    pesel_klienta: row.data('pesel_klienta'),
                    vin: row.data('vin'),
                    usluganaprawy: row.data('usluganaprawy'),
                    pesel_pracownika: row.data('pesel_pracownika')
                };

                showEditModal(data);
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editModal.hide();
                overlay.hide();
            });

            // Obsługa zapisu zmian
            $('#edit-order-form').on('submit', function (event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_zamowienie.php', // Plik obsługujący edycję
                    method: 'POST',
                    data: formData,
                    dataType: 'json', // Oczekujemy JSON w odpowiedzi
                    success: function(response) {
                        alert('Zamówienie zostało zaktualizowane.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas aktualizacji zamówienia.');
                    }
                });
            });
        });
    </script>


</body>
</html>
 