<?php
require_once "db_connection.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pobranie danych z żądania POST
    $nazwaStanowiska = $_POST['nazwa'];
    $minZarobki = $_POST['min_zarobki'];
    $maxZarobki = $_POST['max_zarobki'];
    $doswiadczenie = $_POST['doswiadczenie'];

    try {
        // Sprawdzenie poprawności danych wejściowych
        
        if (!is_numeric($minZarobki) || !is_numeric($maxZarobki)) {
            throw new Exception("Min i Max zarobki muszą być liczbami.");
        }

        // Przygotowanie wywołania procedury
        $sql = "CALL dodajstanowisko($1, $2, $3, $4)";
        $params = [$nazwaStanowiska, (int)$minZarobki, (int)$maxZarobki, $doswiadczenie];

        // Wywołanie procedury z parametrami
        $result = pg_query_params($conn, $sql, $params);

        if (!$result) {
            throw new Exception("Błąd podczas wywoływania procedury: " . pg_last_error($conn));
        }

        echo json_encode(["success" => true, "message" => "Stanowisko zostało dodane."]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "error" => $e->getMessage()]);
    } finally {
        if ($conn) {
            pg_close($conn);
        }
    }
} else {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["success" => false, "error" => "Nieobsługiwana metoda HTTP"]);
}
