<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobranie danych z żądania POST
    $id_zamowienia_do_edycji = $_POST['id_zamowienia_do_edycji'];
    $kwota = ($_POST['kwota']);
    $pesel_klienta = $_POST['pesel_klienta'];
    $vin = $_POST['vin'];
    $usluganaprawy = $_POST['usluganaprawy'];
    $pesel_pracownika = $_POST['pesel_pracownika'];

    try {
        // Przygotowanie wywołania procedury
        $sql = 'CALL "Zamowienia".edytujzamowienie($1, $2, $3, $4, $5, $6)';
        $params = [$id_zamowienia_do_edycji, $kwota, $pesel_klienta, $vin, $usluganaprawy, $pesel_pracownika];

        // Wywołanie procedury z parametrami
        $result = pg_query_params($conn, $sql, $params);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Zamówienie zostało zaktualizowane."]);
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