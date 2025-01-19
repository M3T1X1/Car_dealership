<?php
require_once "db_connection.php";

// Włącz wyświetlanie błędów (tylko na etapie debugowania!)
ini_set('display_errors', 1);
error_reporting(E_ALL);

if (isset($_GET['pesel'])) {
    $pesel = $_GET['pesel'];

    try {
        // Przygotowanie zapytania
        $sql = 'SELECT * FROM "Zamowienia".zamowienia_danego_klienta($1)';

        $result = pg_query_params($conn, $sql, [$pesel]);

        if (!$result) {
            throw new Exception('Błąd wykonania zapytania: ' . pg_last_error($conn));
        }

        $orders = [];
        while ($row = pg_fetch_assoc($result)) {
            // Konwersja BOOLEAN z PostgreSQL
            $row['usluganaprawy'] = ($row['usluganaprawy'] === 't') ? true : false;
            $orders[] = $row;
        }

        // Zwróć dane w formacie JSON
        echo json_encode($orders);

        pg_free_result($result);
    } catch (Exception $e) {
        // Obsługa błędów
        http_response_code(500);
        echo json_encode(["error" => $e->getMessage()]);
    } finally {
        pg_close($conn);
    }
} else {
    // Brak parametru "pesel"
    http_response_code(400);
    echo json_encode(["error" => "Nie podano numeru PESEL"]);
}
?>
