import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js';
import userStoryRoutes from './routes/userstory.routes.js';
import sprintRoutes from './routes/sprint.routes.js';
import passwordResetRoutes from './routes/passwordReset.js';
import swaggerSpec from './config/swagger.js';
import logger from './config/logger.js';

const app = express();
const PORT = process.env.PORT || 3000;

// CORS Configuration
const corsOptions = {
  origin: function (origin, callback) {
    const extra = process.env.ALLOWED_ORIGINS ? process.env.ALLOWED_ORIGINS.split(',').map(o => o.trim()) : [];
    const allowedOrigins = [
      'http://localhost:5173',
      'https://agilflow.app',
      'https://www.agilflow.app',
      ...extra
    ];
    
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(null, false);
    }
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With'],
  optionsSuccessStatus: 204
};

app.use(cors(corsOptions));

app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/auth', passwordResetRoutes);
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
