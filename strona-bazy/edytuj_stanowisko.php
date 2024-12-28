<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_stanowiska = intval($_POST['id_stanowiska_do_edycji']);
    $nazwa = $_POST['nazwa'] ?? '';
    $min_zarobki = intval($_POST['min_zarobki']);
    $max_zarobki = intval($_POST['max_zarobki']);
    $doswiadczenie = ($_POST['doswiadczenie']);

    try {
        if (!$conn) {
            throw new Exception('Błąd połączenia z bazą danych.');
        }

        // Wywołanie procedury aktualizacji stanowiska
        $sql = "CALL edytujstanowisko($1, $2, $3, $4, $5)";
        $result = pg_query_params($conn, $sql, [
            $id_stanowiska,
            $nazwa,
            $min_zarobki,
            $max_zarobki,
            $doswiadczenie
        ]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        echo json_encode([
            "success" => true,
            "message" => "Stanowisko o ID $id_stanowiska zostało zaktualizowane."
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
