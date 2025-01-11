<?php
require_once "db_connection.php"; // Upewnij się, że masz odpowiednie połączenie z bazą danych

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobierz dane z formularza
    $nippodwykonawcy_do_edycji = $_POST['nippodwykonawcy_do_edycji'];
    $nippodwykonawcy = $_POST['nippodwykonawcy'];
    $nazwa = $_POST['nazwa'];
    $specjalizacja = $_POST['specjalizacja'];

    try {
        // Wywołanie procedury edytowania placówki
        $sql = 'CALL "Podwykonawcy".edytujpodwykonawce($1, $2, $3, $4)';
        $result = pg_query_params($conn, $sql, [
            $nippodwykonawcy_do_edycji,
            $nippodwykonawcy, 
            $nazwa, 
            $specjalizacja
        ]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Jeśli procedura zakończyła się powodzeniem
        echo json_encode(["success" => true, "message" => "Podwykonawca został zaktualizowany."]);
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
