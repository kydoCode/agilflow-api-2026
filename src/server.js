import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import userStoryRoutes from './routes/userstory.routes.js';
import swaggerSpec from './config/swagger.js';
import logger from './config/logger.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:5173',
  credentials: true
}));
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/userstories', userStoryRoutes);

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
  logger.info(`🚀 Server running on http://localhost:${PORT}`);
  logger.info(`📚 API Docs: http://localhost:${PORT}/api/docs.json`);
});
