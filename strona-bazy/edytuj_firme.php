<?php
require_once "db_connection.php"; 
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobierz dane z formularza
    $nazwafirmy_do_edycji = $_POST['nazwafirmy_do_edycji']; 
    $nazwafirmy = $_POST['nazwafirmy']; 
    $nip = $_POST['nip']; 

    try {
        // Wywołanie procedury edytowania firmy
        $sql = 'CALL "Firmy".edytujfirme($1, $2, $3)';
        $result = pg_query_params($conn, $sql, [
            $nazwafirmy_do_edycji, 
            $nazwafirmy,
            $nip 
        ]);

        if (!$result) {
            throw new Exception('Błąd wykonania procedury: ' . pg_last_error($conn));
        }

        // Jeśli procedura zakończyła się powodzeniem
        echo json_encode(["success" => true, "message" => "Firma została zaktualizowana."]);
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
