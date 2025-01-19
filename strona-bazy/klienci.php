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
    
    <h1>Klienci</h1>
    <button id="add-client-button">Dodaj klienta</button>

    <table id="klienci-table">
        <thead>
            <tr>
                <th>Pesel</th>
                <th>Imie</th>
                <th>Nazwisko</th>
                <th>NIP</th>
                <th>Telefon</th>
                <th>Akcje</th>
            </tr>
        </thead>
        <tbody>

        <?php
            require_once "db_connection.php";

            try {
                // Przygotowanie wywołania funkcji PL/SQL
                $sql = 'SELECT * FROM "Klienci".pobierz_klienci();';
                

                $result = pg_query($conn, $sql);

                if (!$result) {
                    throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
                }

                // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
                while ($row = pg_fetch_assoc($result)) {
                    echo "<tr data-pesel='" . $row['pesel'] . "'
                            data-imie='" . $row['imie'] . "'
                            data-nazwisko='" . $row['nazwisko'] . "'
                            data-nip='" . $row['nip'] . "'
                            data-telefon='" . $row['telefon'] . "'>";
                    echo "<td>" . $row['pesel'] . "</td>";
                    echo "<td>" . $row['imie'] . "</td>";
                    echo "<td>" . $row['nazwisko'] . "</td>";
                    echo "<td>" . $row['nip'] . "</td>";
                    echo "<td>" . $row['telefon'] . "</td>";
                    echo "<td>";
                    echo "<button class='edit-button'>Edytuj</button>";
                    echo "<button class='delete-button' data-pesel='" . $row['pesel'] . "'>Usuń</button>";
                    echo "<button class='orders-button' data-pesel='" . $row['pesel'] . "'>Zobacz zamówienia</button>";
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
    <div class="modal" id="add-client-modal">
        <h2>Dodaj klienta</h2>
        <form id="add-client-form">
            <label>Pesel:</label><br>
            <input type="text" name="pesel" required><br>
            <label>Imię:</label><br>
            <input type="text" name="imie" required><br>
            <label>Nazwikso:</label><br>
            <input type="text" name="nazwisko" required><br>
            <label>Telefon:</label><br>
            <input type="text" name="telefon" required><br>
            <label>NIP:</label><br>
            <input type="text" name="nip"><br>
            <button type="submit">Dodaj</button>
            <button type="button" id="cancel-button">Anuluj</button>
        </form>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="delete-client-modal">
        <h2>Usuń klienta</h2>
        <p style="font-weight: bold;">Czy na pewno chcesz usunąć klienta o peselu: <span id="delete-pesel" style="text-decoration: underline;"></span> ?</p>
        <button id="confirm-delete-button">Usuń</button>
        <button id="cancel-delete-button">Anuluj</button>
    </div>

    <div class="modal-overlay"></div>
    <div class="modal" id="edit-client-modal">
        <h2>Edytuj klienta</h2>
        <form id="edit-client-form">
            <label>Pesel (do edycji):</label><br>
            <input type="text" name="pesel_do_edycji" id="edit-pesel-do-edycji" readonly><br>
            <label>Pesel:</label><br>
            <input type="text" name="pesel" id="edit-pesel" required><br>
            <label>Imię:</label><br>
            <input type="text" name="imie" id="edit-imie" required><br>
            <label>Nazwikso:</label><br>
            <input type="text" name="nazwisko" id="edit-nazwisko" required><br>
            <label>Telefon:</label><br>
            <input type="text" name="telefon" id="edit-telefon" required><br>
            <label>NIP:</label><br>
            <input type="text" name="nip" id="edit-nip" ><br>
            <button type="submit">Zapisz</button>
            <button type="button" id="cancel-edit-button">Anuluj</button>
        </form>
    </div>

    <div id="orders-modal" style="display: none;">
    <div>
        <h2>Zamówienia Klienta</h2>
        <table>
            <thead>
                <tr>
                    <th>ID Zamówienia</th>
                    <th>Kwota</th>
                    <th>Pesel Klienta</th>
                    <th>VIN</th>
                    <th>Usługa Naprawy</th>
                    <th>Pesel Pracownika</th>
                </tr>
            </thead>
            <tbody id="orders-table-body"></tbody>
        </table>
        <button id="close-orders-modal">Zamknij</button>
    </div>
</div>



    <script>
        $(document).ready(function() {
            const modal = $('#add-client-modal');
            const overlay = $('.modal-overlay');

            $('#add-client-button').on('click', function() {
                $('#add-client-form').trigger('reset');
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

            $('#add-client-form').on('submit', function(event) {
                event.preventDefault();

                const formData = $(this).serialize();

                $.ajax({
                    url: 'dodaj_klienta.php',
                    method: 'POST',
                    data: formData,
                    success: function(response) {
                        alert('Klient został dodany.');
                        location.reload();
                    },
                    error: function(xhr) {
                        const errorResponse = JSON.parse(xhr.responseText);
                        //alert('Wystąpił błąd podczas dodawania klienta.');
                        console.error("Trace:", errorResponse.trace); // Wypisanie śladu stosu w konsoli
                        alert('Wystąpił błąd: ' + errorResponse.error);
                    }
                });
            });
        });

        
        $(document).ready(function() {
            const deleteModal = $('#delete-client-modal');
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
                        url: 'usun_klienta.php',
                        method: 'POST',
                        data: { pesel: currentPesel },
                        success: function(response) {
                            alert('Klient został usunięty.');
                            location.reload();
                        },
                        error: function() {
                            alert('Wystąpił błąd podczas usuwania klienta.');
                        }
                    });
                }
                hideDeleteModal();
            });
        });

        $(document).ready(function() {
            const editModal = $('#edit-client-modal');
            const overlay = $('.modal-overlay');

            function showEditModal(data) {
                // Wypełnij pola formularza danymi
                $('#edit-pesel-do-edycji').val(data.pesel); // Pesel do edycji
                $('#edit-pesel').val(data.pesel);
                $('#edit-imie').val(data.imie);
                $('#edit-nazwisko').val(data.nazwisko);
                $('#edit-telefon').val(data.telefon);
                $('#edit-nip').val(data.nip);
                
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
                    telefon: row.data('telefon'),
                    nip: row.data('nip'),
                };

                showEditModal(data);
            });

            // Obsługa zamknięcia modala
            $('#cancel-edit-button, .modal-overlay').on('click', function() {
                editModal.hide();
                overlay.hide();
            });

            // Obsługa zapisu zmian
            $('#edit-client-form').on('submit', function (event) {
                event.preventDefault();
                const formData = $(this).serialize();

                $.ajax({
                    url: 'edytuj_klienta.php', // Plik obsługujący edycję
                    method: 'POST',
                    data: formData,
                    dataType: 'json', // Oczekujemy JSON w odpowiedzi
                    success: function(response) {
                        console.log("Odpowiedź z serwera: ", response); // Logowanie odpowiedzi
                        alert('Klient został zaktualizowany.');
                        location.reload();
                    },
                    error: function(xhr) {
                        console.log("Błąd: ", xhr.responseText); // Logowanie błędu
                        alert('Wystąpił błąd podczas aktualizacji klienta.');
                    }
                });
            });

        });

        document.addEventListener("DOMContentLoaded", function () {
            const ordersTableBody = document.getElementById("orders-table-body");
            const ordersModal = document.getElementById("orders-modal");
            const closeOrdersModalButton = document.getElementById("close-orders-modal");

            // Obsługa kliknięcia przycisku "Zobacz zamówienia"
            document.querySelectorAll(".orders-button").forEach(button => {
                button.addEventListener("click", function () {
                    const pesel = this.dataset.pesel;

                    fetch(`historia_klienta.php?pesel=${pesel}`)
                        .then(response => response.json())
                        .then(data => {
                            let rows = data.map(order => `
                                <tr>
                                    <td>${order.id_zamowienia}</td>
                                    <td>${order.kwota}</td>
                                    <td>${order.pesel_klienta}</td>
                                    <td>${order.vin}</td>
                                    <td>${order.usluganaprawy === true ? "Tak" : "Nie"}</td>
                                    <td>${order.pesel_pracownika}</td>
                                </tr>
                            `).join("");

                            ordersTableBody.innerHTML = rows || `<tr><td colspan="6">Brak zamówień</td></tr>`;
                            ordersModal.style.display = "block";
                        })
                        .catch(error => console.error("Błąd:", error));
                });
            });

            // Obsługa zamykania modala
            closeOrdersModalButton.addEventListener("click", function () {
                ordersModal.style.display = "none";
            });
        });




    </script>

</body>
</html>
 