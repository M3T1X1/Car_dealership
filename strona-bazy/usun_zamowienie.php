<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_zamowienia = $_POST['id_zamowienia'];

    try {
        // Wywołanie procedury usuwania
        $sql = "CALL usunzamowienie($1)";
        $result = pg_query_params($conn, $sql, [$id_zamowienia]);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Zamówienie zostało usunięte."]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    } finally {
        pg_close($conn);
    }
} else {
    http_response_code(405);
    echo json_encode(["success" => false, "error" => "Nieobsługiwana metoda HTTP"]);
}
?>
