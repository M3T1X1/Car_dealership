<?php
require_once "db_connection.php"; // Połączenie z bazą danych

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sprawdzenie, czy w $_POST istnieje pole nazwa firmy
    if (!isset($_POST['nazwafirmy']) || empty($_POST['nazwafirmy'])) {
        echo json_encode(["success" => false, "error" => "Brak wymaganego pola: nazwafirmy"]);
        exit;
    }

    // Pobranie danych
    $nazwafirmy = $_POST['nazwafirmy'];

    try {
        // Wywołanie procedury usunięcia firmy
        $sql = 'CALL "Firmy".usunfirme($1)';
        $result = pg_query_params($conn, $sql, [$nazwafirmy]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Jeśli procedura zakończyła się powodzeniem
        echo json_encode(["success" => true, "message" => "Firma została usunięta."]);
    } catch (Exception $e) {
        // Jeśli wystąpił błąd
        http_response_code(500); // Błąd serwera
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    } finally {
        pg_close($conn); // Zamknięcie połączenia z bazą
    }
} else {
    // Jeśli metoda HTTP jest inna niż POST
    http_response_code(405); // Metoda nie jest dozwolona
    echo json_encode(["success" => false, "error" => "Nieprawidłowa metoda HTTP."]);
}
?>
