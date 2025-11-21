
CREATE TABLE Produits (
    produit_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    prix DECIMAL(10, 2) NOT NULL, -- Prix en EUR
    type_produit ENUM('flashcard', 'e-book', 'logiciel') NOT NULL,
    duree_acces_jours INT, -- 0 ou NULL pour accès à vie
    stock_disponible INT DEFAULT 1 -- 1 si numérique, géré différemment si physique
);

CREATE TABLE Clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    mot_de_passe_hash VARCHAR(255) NOT NULL,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pays VARCHAR(100)
);

CREATE TABLE Commandes (
    commande_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    montant_total DECIMAL(10, 2) NOT NULL,
    statut ENUM('payee', 'en_attente', 'annulee') NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

CREATE TABLE LignesDeCommande (
    ligne_id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT,
    produit_id INT,
    quantite INT NOT NULL DEFAULT 1,
    prix_unitaire DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES Commandes(commande_id),
    FOREIGN KEY (produit_id) REFERENCES Produits(produit_id)
);

INSERT INTO Produits (nom, description, prix, type_produit, duree_acces_jours) VALUES
('Pack Essentiel Vocabulaire', '1000 cartes de vocabulaire, niveau débutant', 30.00, 'flashcard', 45),
('Pack Pro Concepts Avancés', '2500 cartes de concepts avancés pour développeurs', 60.00, 'flashcard', 90),
('Pack Illimité (à vie)', 'Accès à toutes les ressources flashcards actuelles et futures', 80.00, 'flashcard', NULL);