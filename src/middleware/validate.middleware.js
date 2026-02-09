/**
 * Middleware de validation avec Zod
 * @param {import('zod').ZodSchema} schema - Schéma Zod à valider
 * @returns {Function} Middleware Express
 */
export const validate = (schema) => {
  return (req, res, next) => {
    try {
      schema.parse(req.body);
      next();
    } catch (error) {
      return res.status(400).json({ 
        error: 'Validation échouée', 
        details: error.errors 
      });
    }
  };
};
