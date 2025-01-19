<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $vin = $_POST['vin'];

    try {
        // Wywołanie procedury usuwania
        $sql = 'CALL "Samochody".usunsamochod($1)';
        $result = pg_query_params($conn, $sql, [$vin]);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Samochód został usunięty."]);
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
