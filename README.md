# GameAPI App  
L'application GameAPI est une application de découverte de jeux vidéo qui utilise l'API de RAWG pour trouver des jeux en scrollant ou en sélectionnant une catégorie disponible dans l'API et Supabase pour se souvenir de ceux que tu veux jouer ou que tu as déjà joués.

|Outil|Rôle|
|-----|----|
|Flutter/Dart|Le language qui crée les écrans, les boutons et les cartes de jeu.|
|API RAWG|La bibliothèque de jeux. On l'appelle pour avoir la liste des jeux et leurs détails (description, images, date de sortie, etc.).|
|Supabase|Il enregistre les jeux que mis dans les listes "À jouer" et "Déjà joué".|

# Configuration et Installation
Prérequis
* Flutter SDK installé et configuré.
* Un compte Supabase.
* Une clé d'API RAWG.

# Étapes d'installation
Cloner le dépôt :
```
git clone [URL_DU_VOTRE_DEPOT]
cd GameApi
```
Installer les dépendances :
```
flutter pub get
```
Configuration des clés (Fichier constants.dart):

Vous devez créer un fichier lib/services/utils/constants.dart et y définir vos clés secrètes :
```
// Dans lib/services/utils/constants.dart

// Clé d'API RAWG
const String RAWG_API_KEY = 'VOTRE_CLE_RAWG_ICI';

// Clé publique (anon) Supabase
const String SUPABASE_ANON_KEY = 'VOTRE_CLE_ANON_SUPABASE_ICI';
```
Configuration de la Base de Données Supabase :

Votre base de données Supabase doit contenir une table nommée user_games avec la structure suivante :

|Colonne|Type|Description|Contraintes|
|-------|----|-----------|-----------|
|id|int8|	Clé primaire auto-incrémentée|	PRIMARY KEY|
|game_id|	int4|	L'ID du jeu de l'API RAWG|	UNIQUE (pour gérer le conflit dans l'upsert)|
|status|	text|	Statut du jeu ('to_play' ou 'played')|	-|

Exécuter l'application :
```
flutter run
```

# Les URL's
* Pour demander votre clé RAWG (attention la clé est temporaire)
https://rawg.io/apidocs
* Créer votre table Supabase
https://supabase.com

# La page d'accueil
<img width="499" height="867" alt="image" src="https://github.com/user-attachments/assets/9b8439e8-ab3c-4b8d-9e14-5d0c0abc36f3" />

# La page des jeux déja joué
<img width="484" height="867" alt="image" src="https://github.com/user-attachments/assets/47b6a9f1-5d01-46eb-ab60-84639fb77100" />

# La page des jeux à joué
<img width="491" height="862" alt="image" src="https://github.com/user-attachments/assets/26012828-91f1-4c3e-9c58-d0f6c71f74ac" />


La sélection de catégorie.

<img width="144" height="392" alt="image" src="https://github.com/user-attachments/assets/a42dec4c-8184-4088-a9f6-5bb96acbc33f" />

