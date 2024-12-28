<?php
require_once "db_connection.php"; // Upewnij się, że masz odpowiednie połączenie z bazą danych

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobierz dane z formularza
    $id_placowki = $_POST['id_placowki_do_edycji'];
    $miasto = $_POST['miasto'];
    $ulica = $_POST['ulica'];
    $numerbudynku = $_POST['numerbudynku'];
    $iloscsamochodow = $_POST['iloscsamochodow'];
    $iloscmiejscapozostalego = $_POST['iloscmiejscapozostalego'];

    try {
        // Wywołanie procedury edytowania placówki
        $sql = "CALL edytujplacowke($1, $2, $3, $4, $5, $6)";
        $result = pg_query_params($conn, $sql, [
            $id_placowki,
            $miasto,
            $ulica,
            $numerbudynku,
            $iloscsamochodow,
            $iloscmiejscapozostalego
        ]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Jeśli procedura zakończyła się powodzeniem
        echo json_encode(["success" => true, "message" => "Placówka została zaktualizowana."]);
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
