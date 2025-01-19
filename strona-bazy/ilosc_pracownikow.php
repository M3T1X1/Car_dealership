<?php
require_once "db_connection.php";

header('Content-Type: application/json');

try {
    if (!array_key_exists('placowkaid', $_GET) || !is_numeric($_GET['placowkaid'])) {
        throw new Exception('Nieprawidłowy identyfikator placówki.');
    }

    $placowkaId = intval($_GET['placowkaid']);

    // Wywołanie funkcji PL/pgSQL z argumentem
    $sql = 'SELECT "Stanowiska".ilosc_pracownikow($1::INTEGER);';
    $result = pg_query_params($conn, $sql, [$placowkaId]);

    if (!$result) {
        throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
    }

    $row = pg_fetch_row($result);
    $count = $row[0];

    echo json_encode(['success' => true, 'count' => $count]);

    pg_free_result($result);
    pg_close($conn);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => htmlspecialchars($e->getMessage())]);
}
?>
