<?php
require_once "db_connection.php"; // Połączenie z bazą danych

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sprawdzenie, czy w $_POST istnieje pole id_placowki
    if (!isset($_POST['id_placowki']) || empty($_POST['id_placowki'])) {
        echo json_encode(["success" => false, "error" => "Brak wymaganego pola: id_placowki"]);
        exit;
    }

    // Pobranie id_placowki z formularza
    $id_placowki = $_POST['id_placowki'];

    try {
        // Wywołanie procedury usunięcia placówki
        $sql = 'CALL "Placowki".usunplacowke($1)';
        $result = pg_query_params($conn, $sql, [$id_placowki]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Jeśli procedura zakończyła się powodzeniem
        echo json_encode(["success" => true, "message" => "Placówka została usunięta."]);
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
