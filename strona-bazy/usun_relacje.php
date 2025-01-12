<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $vin = $_POST['vin'];
    $nippodwykonawcy = $_POST['nippodwykonawcy'];

    try {
        // Wywołanie procedury usuwania dla konkretnego VIN i NIP Podwykonawcy
        $sql = 'CALL "Samochody_Podwykonawcy".usunsamochody_podwykonawcy($1, $2)';
        $result = pg_query_params($conn, $sql, [$vin, $nippodwykonawcy]);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        // Jeżeli procedura się powiedzie, zwróć JSON z sukcesem
        echo json_encode(["success" => true, "message" => "Relacja została usunięta."]);
    } catch (Exception $e) {
        // W przypadku błędu zwróć kod odpowiedzi 500 oraz błąd
        http_response_code(500);
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    } finally {
        pg_close($conn);  // Zamykanie połączenia z bazą danych
    }
} else {
    // Jeśli metoda HTTP jest różna od POST, zwróć kod 405 (Method Not Allowed)
    http_response_code(405);
    echo json_encode(["success" => false, "error" => "Nieobsługiwana metoda HTTP"]);
}
?>
