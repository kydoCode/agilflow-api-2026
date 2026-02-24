import express from 'express';
import { getAll, create, update, updateStatus, remove } from '../controllers/userstory.controller.js';
import authMiddleware from '../middleware/auth.middleware.js';
import { validate } from '../middleware/validate.middleware.js';
import { userStorySchema } from '../validators/schemas.js';

const router = express.Router();

router.use(authMiddleware);

/**
 * @openapi
 * /userstories:
 *   get:
 *     tags:
 *       - User Stories
 *     summary: Récupérer toutes les User Stories
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Liste des User Stories
 *       401:
 *         description: Non authentifié
 */
router.get('/', getAll);

/**
 * @openapi
 * /userstories:
 *   post:
 *     tags:
 *       - User Stories
 *     summary: Créer une User Story
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - title
 *             properties:
 *               title:
 *                 type: string
 *               description:
 *                 type: string
 *               priority:
 *                 type: string
 *                 enum: [Low, Medium, High]
 *               status:
 *                 type: string
 *                 enum: [Todo, Doing, Done]
 *     responses:
 *       201:
 *         description: User Story créée
 */
router.post('/', validate(userStorySchema), create);

/**
 * @openapi
 * /userstories/{id}:
 *   put:
 *     tags:
 *       - User Stories
 *     summary: Mettre à jour une User Story
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: User Story mise à jour
 */
router.put('/:id', validate(userStorySchema), update);
router.patch('/:id/status', updateStatus);

/**
 * @openapi
 * /userstories/{id}:
 *   delete:
 *     tags:
 *       - User Stories
 *     summary: Supprimer une User Story
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: User Story supprimée
 */
router.delete('/:id', remove);

export default router;
