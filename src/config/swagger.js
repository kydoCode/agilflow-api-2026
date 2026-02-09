import swaggerJsdoc from 'swagger-jsdoc';

const options = {
  definition: {
    openapi: '3.1.0',
    info: {
      title: 'AgilFlow API',
      version: '1.0.0',
      description: 'API REST pour la gestion de User Stories',
      contact: {
        name: 'AgilFlow Team'
      }
    },
    servers: [
      {
        url: 'http://localhost:3000/api',
        description: 'Serveur de développement'
      }
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT'
        }
      }
    }
  },
  apis: ['./src/routes/*.js']
};

const swaggerSpec = swaggerJsdoc(options);

export default swaggerSpec;
