<?php
require_once "db_connection.php"; // Połączenie z bazą danych

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sprawdzenie, czy w $_POST istnieje pole id_placowki
    if (!isset($_POST['nippodwykonawcy']) || empty($_POST['nippodwykonawcy'])) {
        echo json_encode(["success" => false, "error" => "Brak wymaganego pola: nippodwykonawcy"]);
        exit;
    }

    // Pobranie id_placowki z formularza
    $nippodwykonawcy = $_POST['nippodwykonawcy'];

    try {
        // Wywołanie procedury usunięcia placówki
        $sql = "CALL usunpodwykonawce($1)";
        $result = pg_query_params($conn, $sql, [$nippodwykonawcy]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Jeśli procedura zakończyła się powodzeniem
        echo json_encode(["success" => true, "message" => "Podwykonawca został usunięty."]);
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
