<?php
require_once "db_connection.php";

if (isset($_GET['nip'])) {
    $nip = $_GET['nip'];

    try {
        $sql = 'SELECT * FROM "Podwykonawcy".historia_podwykonawcy($1)';
        $result = pg_query_params($conn, $sql, [$nip]);

        if (!$result) {
            throw new Exception('Błąd wykonania zapytania: ' . pg_last_error());
        }

        $rows = [];
        while ($row = pg_fetch_assoc($result)) {
            $rows[] = $row;
        }

        pg_free_result($result);
        echo json_encode($rows);

    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["error" => $e->getMessage()]);
    } finally {
        pg_close($conn);
    }
} else {
    http_response_code(400);
    echo json_encode(["error" => "Nie podano NIP podwykonawcy."]);
}
?>
