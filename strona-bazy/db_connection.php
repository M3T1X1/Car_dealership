<?php
// Dane do połączenia
$host = "localhost"; // lub IP serwera
$port = "5432";
$dbname = "baza";
$user = "postgres";
$password = "123456";

// Tworzenie połączenia
$conn = pg_connect("host=$host port=$port dbname=$dbname user=$user password=$password");

if (!$conn) {
    die("Błąd połączenia z bazą danych.");
}
?>
