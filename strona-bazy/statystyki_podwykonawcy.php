<?php
require_once "db_connection.php";

if (isset($_GET['nip'])) {
    $nip = $_GET['nip'];

    try {
        $sql = 'SELECT * FROM "Podwykonawcy".oblicz_statystyki_podwykonawcy($1)';
        $result = pg_query_params($conn, $sql, [$nip]);

        if (!$result) {
            throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
        }

        $stats = pg_fetch_all($result);
        echo json_encode($stats);

        pg_free_result($result);
    } catch (Exception $e) {
        echo json_encode(['error' => $e->getMessage()]);
    } finally {
        pg_close($conn);
    }
} else {
    echo json_encode(['error' => 'Brak NIP w żądaniu']);
}
?>
