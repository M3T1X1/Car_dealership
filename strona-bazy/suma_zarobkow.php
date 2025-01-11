<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once "db_connection.php";

header('Content-Type: application/json');

try {
    // Sprawdzenie poprawności parametru placowkaid
    if (!array_key_exists('placowkaid', $_GET) || !is_numeric($_GET['placowkaid'])) {
        throw new Exception('Nieprawidłowy identyfikator placówki.');
    }
    

    $placowkaId = intval($_GET['placowkaid']);

    // Wywołanie funkcji sumazarobkow z podanym id_placowki
    $sql = "SELECT sumazarobkow($1::INTEGER);";
    $result = pg_query_params($conn, $sql, [$placowkaId]);

    if (!$result) {
        throw new Exception('Błąd wykonania zapytania: ' . pg_last_error($conn));
    }

    $row = pg_fetch_row($result);
    if (!$row) {
        throw new Exception('Brak danych dla wybranej placówki.');
    }

    $sum = $row[0];
    echo json_encode(['success' => true, 'sum' => $sum]);

} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => htmlspecialchars($e->getMessage())]);
} finally {
    if (isset($conn)) {
        pg_close($conn);
    }
}
?>
