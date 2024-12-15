<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobranie danych z żądania POST
    $vin_do_edycji = $_POST['vin_do_edycji'];
    $vin = $_POST['vin'];
    $marka = $_POST['marka'];
    $model = $_POST['model'];
    $rocznik = intval($_POST['rocznik']);
    $silnik = $_POST['silnik'];
    $skrzynia = $_POST['skrzynia'];
    $stan = $_POST['stan'];
    $cena = floatval($_POST['cena']);
    $placowkaid = intval($_POST['placowkaid']);

    try {
        // Przygotowanie wywołania procedury
        $sql = "CALL edytujSamochod($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)";
        $params = [$vin_do_edycji, $vin, $marka, $model, $rocznik, $silnik, $skrzynia, $stan, $cena, $placowkaid];

        // Wywołanie procedury z parametrami
        $result = pg_query_params($conn, $sql, $params);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Samochód został zaktualizowany."]);
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
