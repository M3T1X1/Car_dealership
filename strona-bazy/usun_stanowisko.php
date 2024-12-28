<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_stanowiska = intval($_POST['id_stanowiska']);

    try {
        if (!$conn) {
            throw new Exception('Błąd połączenia z bazą danych.');
        }

        $sql = "CALL usunstanowisko($1)";
        $result = pg_query_params($conn, $sql, [$id_stanowiska]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Poprawna odpowiedź
        echo json_encode([
            "success" => true,
            "message" => "Stanowisko o ID $id_stanowiska zostało usunięte."
        ]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode([
            "success" => false,
            "error" => $e->getMessage()
        ]);
    } finally {
        pg_close($conn);
    }
} else {
    http_response_code(405);
    echo json_encode([
        "success" => false,
        "error" => "Nieprawidłowa metoda HTTP."
    ]);
}
?>
