<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobranie danych z żądania POST
    $pesel_do_edycji = $_POST['pesel_do_edycji'];
    $pesel = $_POST['pesel'];
    $imie = $_POST['imie'];
    $nazwisko = $_POST['nazwisko'];
    $telefon = $_POST['telefon'];
    $nip = isset($_POST['nip']) && $_POST['nip'] !== '' ? $_POST['nip'] : null;

    try {
        // Przygotowanie wywołania procedury
        $sql = "CALL edytujklienta($1, $2, $3, $4, $5, $6)";
        $params = [
            $pesel_do_edycji,
            $pesel,
            $imie,
            $nazwisko,
            $telefon,
            $nip !== null ? $nip : null
        ];

        // Wywołanie procedury z parametrami
        $result = pg_query_params($conn, $sql, $params);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Klient został zaktualizowany."]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    } finally {
        pg_close($conn);
    }
} else {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["success" => false, "error" => "Nieobsługiwana metoda HTTP"]);
}
?>
