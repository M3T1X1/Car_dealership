<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $vin_do_edycji = $_POST['vin_do_edycji'];  // VIN do edycji (niezmienny)
    $vin = $_POST['vin'];  // Nowy VIN
    $nippodwykonawcy = $_POST['nippodwykonawcy'];  // Nowy NIP Podwykonawcy

    try {
        // Wywołanie procedury edytowania relacji
        $sql = 'CALL "Samochody_Podwykonawcy".edytujsamochody_podwykonawcy($1, $2, $3)';
        $result = pg_query_params($conn, $sql, [$vin_do_edycji, $vin, $nippodwykonawcy]);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Relacja została zaktualizowana."]);
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
