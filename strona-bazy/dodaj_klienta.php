<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobranie i przekształcenie danych wejściowych
    $pesel = isset($_POST['pesel']) && $_POST['pesel'] !== '' ? strval($_POST['pesel']) : null;
    $imie = isset($_POST['imie']) && $_POST['imie'] !== '' ? strval($_POST['imie']) : null;
    $nazwisko = isset($_POST['nazwisko']) && $_POST['nazwisko'] !== '' ? strval($_POST['nazwisko']) : null;
    $telefon = isset($_POST['telefon']) && $_POST['telefon'] !== '' ? strval($_POST['telefon']) : null;
    $nip = isset($_POST['nip']) && $_POST['nip'] !== '' ? strval($_POST['nip']) : null;

    try {
        // Przygotowanie wywołania procedury
        $sql = 'CALL "Klienci".dodajklienta($1, $2, $3, $4, $5)';
        $params = [
            $pesel,
            $imie,
            $nazwisko,
            $telefon,
            $nip
        ];

        // Wywołanie procedury z parametrami
        $result = pg_query_params($conn, $sql, $params);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        // Zwrot sukcesu w formacie JSON
        echo json_encode(["success" => true, "message" => "Klient został dodany."]);
    } catch (Exception $e) {
        // Obsługa błędów
        http_response_code(500);
        echo json_encode([
            "success" => false,
            "error" => $e->getMessage(),
            "trace" => $e->getTraceAsString()
        ]);
    } finally {
        // Zamknięcie połączenia
        pg_close($conn);
    }
} else {
    // Obsługa niepoprawnej metody HTTP
    http_response_code(405); // Method Not Allowed
    echo json_encode(["success" => false, "error" => "Nieobsługiwana metoda HTTP"]);
}
?>
