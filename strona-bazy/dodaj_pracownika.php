<?php
require_once "db_connection.php";

echo "aweaew";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobranie danych z żądania POST
    $pesel = $_POST['pesel'];
    $imie = $_POST['imie'];
    $nazwisko = $_POST['nazwisko'];
    $stanowiskoid = intval($_POST['stanowiskoid']);
    $placowkaid = intval($_POST['placowkaid']);
    $zarobki = floatval($_POST['zarobki']);

    try {
        // Przygotowanie wywołania procedury
        $sql = "CALL dodajpracownika($1, $2, $3, $4, $5, $6)";
        $params = [$pesel, $imie, $nazwisko, $stanowiskoid, $placowkaid, $zarobki];



        // Wywołanie procedury z parametrami
        $result = pg_query_params($conn, $sql, $params);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Pracownik został dodany."]);
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
