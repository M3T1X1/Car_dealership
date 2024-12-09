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
    </style>
</head>
<body>
    
    <h1>Podwykonawcy</h1>
    <table id="podwykonawcy-table">
        <thead>
            <tr>
                <th>NIP podwykonawcy</th>
                <th>Nazwa</th>
                <th>Specjalizacja</th>
                <th>Akcja</th>
            </tr>
        </thead>
        <tbody>
        <?php
    require_once "db_connection.php";

    try {
        // Przygotowanie wywołania funkcji PL/SQL
        $sql = "SELECT * FROM pobierz_podwykonawcy();";
        

        $result = pg_query($conn, $sql);

        if (!$result) {
            throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
        }

        // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
        while ($row = pg_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>" . $row['nippodwykonawcy'] . "</td>";
            echo "<td>" . $row['nazwa'] . "</td>";
            echo "<td>" . $row['specjalizacja'] . "</td>";
            echo "<td><button onclick='deleteCar(" . $row['nippodwykonawcya'] . ")'>Delete</button></td>";
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
 