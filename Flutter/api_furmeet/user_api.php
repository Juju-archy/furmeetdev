<?php

// Configuration de la base de données
$servername = "localhost";
$username = "archyroot";
$password = "Bavav732!";
$dbname = "flutter_test";

// Création de la connexion à la base de données
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérifiez la connexion à la base de données
if ($conn->connect_error) {
    die("Erreur de connexion à la base de données : " . $conn->connect_error);
}

// Vérifiez la méthode de la requête HTTP
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Récupérez tous les utilisateurs
    $result = $conn->query("SELECT * FROM user");
    $users = array();

    // Convertissez le résultat en tableau associatif
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }

    // Répondez avec les utilisateurs au format JSON
    header('Content-Type: application/json');
    echo json_encode($users);
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Récupérez les données du corps de la requête
    $data = json_decode(file_get_contents('php://input'), true);

    // Insertion d'un nouvel utilisateur
    $stmt = $conn->prepare("INSERT INTO user (uemail, upseudo, uabout, ubirthday, ucity, ugender, UPASS, SALT, isdarkmode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('ssssssssi', $data['uemail'], $data['upseudo'], $data['uabout'], $data['ubirthday'], $data['ucity'], $data['ugender'], $data['UPASS'], $data['SALT'], $data['isdarkmode']);
    $stmt->execute();
    $stmt->close();

    // Répondez avec un statut 200 (OK)
    http_response_code(200);
} else {
    // Répondez avec un statut 405 (Méthode non autorisée)
    http_response_code(405);
    echo json_encode(['message' => 'Méthode non autorisée']);
}

// Fermer la connexion à la base de données
$conn->close();
?>
