import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import userStoryRoutes from './routes/userstory.routes.js';
import sprintRoutes from './routes/sprint.routes.js';
import swaggerSpec from './config/swagger.js';
import logger from './config/logger.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware CORS
app.use((req, res, next) => {
  const allowedOrigins = [
    'http://localhost:5173',
    'https://agilflow.app',
    'https://www.agilflow.app'
  ];
  
  const origin = req.headers.origin;
  if (allowedOrigins.includes(origin)) {
    res.setHeader('Access-Control-Allow-Origin', origin);
  }
  
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }
  
  next();
});
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/userstories', userStoryRoutes);
app.use('/api/sprints', sprintRoutes);

// OpenAPI Documentation (JSON uniquement, serverless compatible)
app.get('/api/docs.json', (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.send(swaggerSpec);
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'AgilFlow API is running' });
});

// Error handler
app.use((err, req, res, next) => {
  logger.error({ err }, 'Erreur serveur');
  res.status(500).json({ error: 'Something went wrong!' });
});

app.listen(PORT, () => {
  logger.info(`Server running on http://localhost:${PORT}`);
  logger.info(`📚 API Docs: http://localhost:${PORT}/api/docs.json`);
});
