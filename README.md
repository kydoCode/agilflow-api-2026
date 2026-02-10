# AgilFlow Backend API

API REST pour gérer les User Stories et l'authentification des utilisateurs.

## Prérequis

- Node.js 20.19+ ou 22.12+
- PostgreSQL (ou compte Neon gratuit)
- npm ou yarn

## Installation

1. Cloner le repository
2. Installer les dépendances :

```bash
npm install
```

3. Créer un fichier `.env` à la racine :

```env
DATABASE_URL="postgresql://user:password@host/database?sslmode=require"
JWT_SECRET="votre-cle-secrete-minimum-32-caracteres"
PORT=3000
FRONTEND_URL="http://localhost:5173"
NODE_ENV="development"
```

**Important** : Pour un déploiement serverless (Vercel), utiliser une URL de connexion avec `-pooler` dans le nom d'hôte Neon.

4. Initialiser la base de données :

```bash
npx prisma generate
npx prisma migrate dev --name init
```

## Lancer l'API

### Mode développement

```bash
npm run dev
```

L'API sera accessible sur `http://localhost:3000`

### Mode production

```bash
npm start
```

## Utiliser l'API

### Documentation interactive

La documentation OpenAPI est disponible au format JSON :
```
http://localhost:3000/api/docs.json
```

Importer ce fichier dans Postman, Insomnia ou tout client REST pour tester les endpoints.

### Endpoints disponibles

#### Authentification

**Inscription**
```
POST /api/auth/register
Content-Type: application/json

{
  "name": "Jean Dupont",
  "email": "jean@example.com",
  "password": "motdepasse123",
  "role": "developer"
}
```

Rôles disponibles : `productOwner`, `scrumMaster`, `developer`, `tester`, `designer`, `stakeholder`, `teammate`

**Connexion**
```
POST /api/auth/login
Content-Type: application/json

{
  "email": "jean@example.com",
  "password": "motdepasse123"
}
```

Retourne un token JWT à utiliser pour les requêtes protégées.

#### User Stories (authentification requise)

**Lister vos User Stories**
```
GET /api/userstories
Authorization: Bearer VOTRE_TOKEN_JWT
```

**Créer une User Story**
```
POST /api/userstories
Authorization: Bearer VOTRE_TOKEN_JWT
Content-Type: application/json

{
  "title": "En tant que utilisateur, je veux me connecter",
  "description": "Afin d'accéder à mon compte",
  "priority": "High",
  "status": "Todo"
}
```

Priorités : `Low`, `Medium`, `High`  
Statuts : `Todo`, `Doing`, `Done`

**Modifier une User Story**
```
PUT /api/userstories/:id
Authorization: Bearer VOTRE_TOKEN_JWT
Content-Type: application/json

{
  "title": "Titre modifié",
  "description": "Description modifiée",
  "priority": "Medium",
  "status": "Doing"
}
```

**Supprimer une User Story**
```
DELETE /api/userstories/:id
Authorization: Bearer VOTRE_TOKEN_JWT
```

#### Mot de passe

**Changer le mot de passe**
```
PUT /api/password/change
Authorization: Bearer VOTRE_TOKEN_JWT
Content-Type: application/json

{
  "oldPassword": "ancien",
  "newPassword": "nouveau"
}
```

## Base de données

### Visualiser les données

```bash
npx prisma studio
```

Ouvre une interface web pour consulter et modifier les données.

### Créer une nouvelle migration

Après modification du fichier `prisma/schema.prisma` :

```bash
npx prisma migrate dev --name nom_de_la_migration
```

## Sécurité

- Les mots de passe sont hashés avec bcrypt
- Les tokens JWT expirent après 24h
- Toutes les entrées sont validées avec Zod
- Protection contre les injections SQL via Prisma ORM
- CORS configuré pour autoriser uniquement le frontend

## Déploiement

L'API peut être déployée sur Vercel, Railway, Render ou tout hébergeur Node.js.

**Variables d'environnement à configurer** :
- `DATABASE_URL` : URL PostgreSQL (avec `-pooler` pour serverless)
- `JWT_SECRET` : Clé secrète pour les tokens
- `FRONTEND_URL` : URL du frontend pour CORS
- `NODE_ENV` : `production`

## Technologies utilisées

- Express 5
- Prisma ORM
- PostgreSQL
- JWT pour l'authentification
- Zod pour la validation
- Pino pour les logs

## Licence

Projet fil rouge TP DWWM 2024/2025
