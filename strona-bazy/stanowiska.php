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
    
    <h1>Stanowiska</h1>
    <table id="stanowiska-table">
        <thead>
            <tr>
                <th>Stanowiskoid</th>
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
        // Przygotowanie wywołania funkcji PL/SQL
        $sql = "SELECT * FROM pobierz_stanowiska();";
        

        $result = pg_query($conn, $sql);

        if (!$result) {
            throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
        }

        // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
        while ($row = pg_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>" . $row['stanowiskoid'] . "</td>";
            echo "<td>" . $row['nazwastanowiska'] . "</td>";
            echo "<td>" . $row['minzarobki'] . "</td>";
            echo "<td>" . $row['maxzarobki'] . "</td>";
            echo "<td>" . $row['doswiadczenie'] . "</td>";
            echo "<td><button onclick='deleteCar(" . $row['stanowiskoid'] . ")'>Delete</button></td>";
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
 