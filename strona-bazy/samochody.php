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
    </style>
</head>
<body>
    <h1>Samochody</h1>
    <button id="add-car-button">Dodaj samochód</button>

    <table id="samochody-table">
        <thead>
            <tr>
                <th>VIN</th>
                <th>Marka</th>
                <th>Model</th>
                <th>Rocznik</th>
                <th>Silnik</th>
                <th>Skrzynia</th>
                <th>Stan</th>
                <th>Cena</th>
                <th>Placówka ID</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>
        <?php
            require_once "db_connection.php";

            try {
                $sql = "SELECT * FROM pobierz_samochody();";
                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-vin='" . $row['vin'] . "'
                            data-marka='" . $row['marka'] . "'
                            data-model='" . $row['model'] . "'
                            data-rocznik='" . $row['rocznik'] . "'
                            data-silnik='" . $row['silnik'] . "'
                            data-skrzynia='" . $row['skrzynia'] . "'
                            data-stan='" . $row['stan'] . "'
                            data-cena='" . $row['cena'] . "'
                            data-placowkaid='" . $row['placowkaid'] . "'>";
                    echo "<td>" . $row['vin'] . "</td>";
                    echo "<td>" . $row['marka'] . "</td>";
                    echo "<td>" . $row['model'] . "</td>";
                    echo "<td>" . $row['rocznik'] . "</td>";
                    echo "<td>" . $row['silnik'] . "</td>";
                    echo "<td>" . $row['skrzynia'] . "</td>";
                    echo "<td>" . $row['stan'] . "</td>";
                    echo "<td>" . $row['cena'] . "</td>";
                    echo "<td>" . $row['placowkaid'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-vin='" . $row['vin'] . "'>Usuń</button>";
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
    <div class="modal" id="add-car-modal">
        <h2>Dodaj samochód</h2>
        <form id="add-car-form">
            <label>VIN: <input type="text" name="vin" required></label><br>
            <label>Marka: <input type="text" name="marka" required></label><br>
            <label>Model: <input type="text" name="model" required></label><br>
            <label>Rocznik: <input type="number" name="rocznik" required></label><br>
            <label>Silnik: <input type="text" name="silnik" required></label><br>
            <label>Skrzynia: <input type="text" name="skrzynia" required></label><br>
            <label>Stan: <input type="text" name="stan" required></label><br>
            <label>Cena: <input type="number" name="cena" required></label><br>
            <label>Placówka ID: <input type="text" name="placowkaid" required></label><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-car-modal">
        <h2>Usuń samochód</h2>
        <p>Czy na pewno chcesz usunąć samochód o VIN: <span id="delete-vin"></span>?</p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="edit-car-modal">
        <h2>Edytuj samochód</h2>
        <form id="edit-car-form">
            <label>VIN: <input type="text" name="vin" id="edit-vin" readonly></label><br>
            <label>Marka: <input type="text" name="marka" id="edit-marka" required></label><br>
            <label>Model: <input type="text" name="model" id="edit-model" required></label><br>
            <label>Rocznik: <input type="number" name="rocznik" id="edit-rocznik" required></label><br>
            <label>Silnik: <input type="text" name="silnik" id="edit-silnik" required></label><br>
            <label>Skrzynia: <input type="text" name="skrzynia" id="edit-skrzynia" required></label><br>
            <label>Stan: <input type="text" name="stan" id="edit-stan" required></label><br>
            <label>Cena: <input type="number" name="cena" id="edit-cena" required></label><br>
            <label>Placówka ID: <input type="text" name="placowkaid" id="edit-placowkaid" required></label><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>


    <script>
        $(document).ready(function() {
            const modal = $('#add-car-modal');
            const overlay = $('.modal-overlay');

            $('#add-car-button').on('click', function() {
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

            $('#add-car-form').on('submit', function(event) {
                event.preventDefault();

                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_samochod.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Samochód został dodany.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas dodawania samochodu.');
                    }
                });
            });
        });

        
        $(document).ready(function() {
            const deleteModal = $('#delete-car-modal');
            const deleteOverlay = $('.modal-overlay');
            let currentVin = null;

            function showDeleteModal(vin) {
                currentVin = vin;
                $('#delete-vin').text(vin);
                deleteModal.show();
                deleteOverlay.show();
            }

            function hideDeleteModal() {
                currentVin = null;
                deleteModal.hide();
                deleteOverlay.hide();
            }

            // Obsługa kliknięcia przycisku „Usuń”
            $(document).on('click', '.delete-button', function() {
                const vin = $(this).data('vin');
                showDeleteModal(vin);
            });

            // Obsługa anulowania
            $('#cancel-delete-button, .modal-overlay').on('click', function() {
                hideDeleteModal();
            });

            // Obsługa potwierdzenia usunięcia
            $('#confirm-delete-button').on('click', function() {
                if (currentVin) {
                    $.ajax({
                        url: 'usun_samochod.php',
                        method: 'POST',
                        data: { vin: currentVin },
                        success: function(response) {
                            alert('Samochód został usunięty.');
                            location.reload();
                        },
                        error: function() {
                            alert('Wystąpił błąd podczas usuwania samochodu.');
                        }
                    });
                }
                hideDeleteModal();
            });
        });

        $(document).ready(function() {
            const editModal = $('#edit-car-modal');
            const overlay = $('.modal-overlay');

            function showEditModal(data) {
                // Wypełnij pola formularza danymi
                $('#edit-vin').val(data.vin);
                $('#edit-marka').val(data.marka);
                $('#edit-model').val(data.model);
                $('#edit-rocznik').val(data.rocznik);
                $('#edit-silnik').val(data.silnik);
                $('#edit-skrzynia').val(data.skrzynia);
                $('#edit-stan').val(data.stan);
                $('#edit-cena').val(data.cena);
                $('#edit-placowkaid').val(data.placowkaid);

                // Pokaż modal
                editModal.show();
                overlay.show();
            }

            // Obsługa kliknięcia "Edytuj"
            $(document).on('click', '.edit-button', function() {
                const row = $(this).closest('tr');
                const data = {
                    vin: row.data('vin'),
                    marka: row.data('marka'),
                    model: row.data('model'),
                    rocznik: row.data('rocznik'),
                    silnik: row.data('silnik'),
                    skrzynia: row.data('skrzynia'),
                    stan: row.data('stan'),
                    cena: row.data('cena'),
                    placowkaid: row.data('placowkaid'),
                };

                showEditModal(data);
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editModal.hide();
                overlay.hide();
            });

            // Obsługa zapisu zmian
            $('#edit-car-form').on('submit', function(event) {
                event.preventDefault();

                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_samochod.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Samochód został zaktualizowany.');
                        location.reload();
                    },
                    error: function() {
                        alert('Wystąpił błąd podczas aktualizacji samochodu.');
                    }
                });
            });
        });


    </script>
</body>
</html>
