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

// Middleware
const allowedOrigins = [
  'http://localhost:5173',
  'https://agilflow.app',
  'https://www.agilflow.app'
];

if (process.env.FRONTEND_URL) {
  allowedOrigins.push(process.env.FRONTEND_URL);
}

app.use(cors({
  origin: allowedOrigins,
  credentials: true
}));
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
