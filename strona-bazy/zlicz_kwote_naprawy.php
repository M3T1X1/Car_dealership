<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        // Wywołanie funkcji do zliczania kwoty naprawy
        $sql = 'SELECT "Zamowienia".suma_kwoty_zamowien_usluga_naprawy() AS total_amount';
        $result = pg_query($conn, $sql);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania funkcji: " . pg_last_error($conn));
        }

        // Pobieranie wyniku
        $row = pg_fetch_assoc($result);
        if ($row && isset($row['total_amount'])) {
            $totalAmount = $row['total_amount'];
            // Sprawdzenie, czy wartość jest null
            if ($totalAmount === null) {
                $totalAmount = 0;  // Możesz ustawić na 0, jeśli brak wartości
            }
            echo json_encode(["success" => true, "total_amount" => $totalAmount]);
        } else {
            throw new Exception("Brak danych do zliczenia lub funkcja nie zwróciła wartości.");
        }

    } catch (Exception $e) {
        http_response_code(500);
        // Możemy także dodać debugowanie
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    } finally {
        pg_close($conn);
    }
} else {
    http_response_code(405);
    echo json_encode(["success" => false, "error" => "Nieobsługiwana metoda HTTP"]);
}
?>
