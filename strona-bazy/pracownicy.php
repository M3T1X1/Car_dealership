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
    
    <h1>Pracownicy</h1>
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
        $sql = "SELECT * FROM pobierz_pracownicy();";
        

        $result = pg_query($conn, $sql);

        if (!$result) {
            throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
        }

        // Iteracja przez wyniki zwrócone przez kursor i generowanie opcji do select
        while ($row = pg_fetch_assoc($result)) {
            echo "<tr>";
            echo "<td>" . $row['pesel'] . "</td>";
            echo "<td>" . $row['imie'] . "</td>";
            echo "<td>" . $row['nazwisko'] . "</td>";
            echo "<td>" . $row['stanowiskoid'] . "</td>";
            echo "<td>" . $row['placowkaid'] . "</td>";
            echo "<td>" . $row['zarobki'] . "</td>";
            echo "<td><button onclick='deleteCar(" . $row['pesel'] . ")'>Delete</button></td>";
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
<!--
    CREATE OR REPLACE FUNCTION pobierz_pracownicy()
RETURNS TABLE(
    pesel CHARACTER(11),
    imie CHARACTER VARYING(50),
    nazwisko CHARACTER VARYING(50),
    stanowiskoid INT,
    placowkaid INT,
    zarobki NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.pesel,
        p.imie,
        p.nazwisko,
        p.stanowiskoid,
        p.placowkaid,
        p.zarobki
    FROM pracownicy p;
END;
$$ LANGUAGE plpgsql;
-->
</body>
</html>
 