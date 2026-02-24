import express from 'express';
import { createSprint, getSprints, getSprintById, updateSprint, deleteSprint, addUserStoryToSprint } from '../controllers/sprint.controller.js';
import { authenticate } from '../middleware/auth.middleware.js';

const router = express.Router();

router.post('/', authenticate, createSprint);
router.get('/', authenticate, getSprints);
router.get('/:id', authenticate, getSprintById);
router.put('/:id', authenticate, updateSprint);
router.delete('/:id', authenticate, deleteSprint);
router.post('/:id/userstories', authenticate, addUserStoryToSprint);

export default router;
