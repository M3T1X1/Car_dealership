<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
    </style>
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
                    $sql = "SELECT * FROM pobierz_samochody_podwykonawcy() ORDER BY vin ASC";

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
                        echo "<button class='delete-button' data-vin='" . $row['vin'] . "' data-nippodwykonawcy='" . $row['nippodwykonawcy'] . "'>Usuń</button>";
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

</body>
</html>