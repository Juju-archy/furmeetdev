<?php

// Vos paramètres de base de données
$servername = "localhost";
$username = "archyroot";
$password = "Bavav732!";
$dbname = "flutter_test";

// Crée une connexion à la base de données
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérifie la connexion
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Récupère les données du formulaire (remplacez 'email' et 'password' par les noms de vos champs dans le formulaire)
$email = $_POST['uemail'];
$password = $_POST['UPASS'];

// Prépare la requête SQL pour récupérer l'utilisateur avec l'email et le mot de passe correspondants
$sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";

$result = $conn->query($sql);

// Vérifie s'il y a des résultats
if ($result->num_rows > 0) {
    // L'utilisateur est authentifié avec succès
    $response['success'] = true;
    $response['message'] = "Login successful!";
} else {
    // L'authentification a échoué
    $response['success'] = false;
    $response['message'] = "Invalid email or password.";
}

// Convertit la réponse en format JSON
echo json_encode($response);

// Ferme la connexion à la base de données
$conn->close();

?>
