# 🔧 AgilFlow Backend API

API REST pour la gestion de User Stories avec authentification JWT.

## 🚀 Stack Technique

- **Runtime** : Node.js 20+ (ES6 Modules)
- **Framework** : Express 5
- **Base de données** : PostgreSQL (Neon)
- **ORM** : Prisma
- **Validation** : Zod
- **Logger** : Pino
- **Documentation** : OpenAPI 3.1
- **Auth** : JWT + Bcrypt

## 📦 Installation

```bash
npm install
```

## ⚙️ Configuration

```bash
cp .env.example .env
```

Éditer `.env` avec vos variables :
```env
DATABASE_URL="postgresql://user:pass@host/db?sslmode=require"
JWT_SECRET="your-secret-key"
PORT=3000
FRONTEND_URL="http://localhost:5173"
```

## 🗄️ Base de données

```bash
# Générer le client Prisma
npx prisma generate

# Créer et appliquer les migrations
npx prisma migrate dev --name init

# Ouvrir Prisma Studio (optionnel)
npx prisma studio
```

## 🏃 Développement

```bash
npm run dev
```

API disponible sur `http://localhost:3000`

## 📚 Documentation API

OpenAPI JSON : `http://localhost:3000/api/docs.json`

Importer dans Postman/Insomnia pour tester l'API.

## 🔐 Endpoints

### Authentication
- `POST /api/auth/register` - Inscription
- `POST /api/auth/login` - Connexion

### User Stories (protégé JWT)
- `GET /api/userstories` - Liste
- `POST /api/userstories` - Créer
- `PUT /api/userstories/:id` - Modifier
- `DELETE /api/userstories/:id` - Supprimer

## 🧪 Tests

```bash
npm test
```

## 🚀 Déploiement Vercel

1. Créer projet Vercel
2. Connecter repo GitHub
3. Ajouter variables d'environnement
4. Deploy automatique sur push

## 📝 Scripts

- `npm run dev` - Serveur développement (nodemon)
- `npm start` - Serveur production
- `npm run prisma:generate` - Générer client Prisma
- `npm run prisma:migrate` - Appliquer migrations
- `npm run prisma:studio` - Interface DB

## 🏗️ Structure

```
back/
├── src/
│   ├── config/          # Configuration (logger, swagger)
│   ├── controllers/     # Logique métier
│   ├── middleware/      # Middlewares (auth, validation)
│   ├── routes/          # Routes Express
│   ├── validators/      # Schémas Zod
│   └── server.js        # Point d'entrée
├── prisma/
│   └── schema.prisma    # Schéma base de données
└── package.json
```

## 🔒 Sécurité

- ✅ Passwords hashés (bcrypt)
- ✅ JWT tokens
- ✅ Validation Zod
- ✅ CORS configuré
- ✅ Variables sensibles en .env
- ✅ SQL injection protection (Prisma)

## 📄 Licence

Projet formation DWWM 2025
