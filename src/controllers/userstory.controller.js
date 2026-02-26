import { PrismaClient } from '@prisma/client';
import logger from '../config/logger.js';

const prisma = new PrismaClient();

/**
 * Récupérer toutes les User Stories de l'utilisateur
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 */
const getAll = async (req, res) => {
  try {
    const stories = await prisma.userStory.findMany({
      where: { userId: req.userId },
      orderBy: { createdAt: 'desc' }
    });
    res.json(stories);
  } catch (error) {
    logger.error({ err: error }, 'Erreur récupération stories');
    res.status(500).json({ error: 'Erreur lors de la récupération' });
  }
};

/**
 * Créer une nouvelle User Story
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 */
const create = async (req, res) => {
  try {
    const { title, description, priority, status, storyPoints } = req.body;
    const story = await prisma.userStory.create({
      data: { title, description, priority, status, storyPoints: storyPoints ?? null, userId: req.userId }
    });
    res.status(201).json(story);
  } catch (error) {
    logger.error({ err: error }, 'Erreur création story');
    res.status(500).json({ error: 'Erreur lors de la création' });
  }
};

/**
 * Mettre à jour une User Story
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 */
const update = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description, priority, status, position, storyPoints } = req.body;
    
    const story = await prisma.userStory.findFirst({
      where: { id: parseInt(id), userId: req.userId }
    });
    
    if (!story) {
      return res.status(404).json({ error: 'User Story non trouvée' });
    }
    
    const updated = await prisma.userStory.update({
      where: { id: parseInt(id) },
      data: { title, description, priority, status, position, storyPoints: storyPoints ?? null }
    });
    
    res.json(updated);
  } catch (error) {
    logger.error({ err: error }, 'Erreur mise à jour story');
    res.status(500).json({ error: 'Erreur lors de la mise à jour' });
  }
};

const updateStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status, position } = req.body;

    const story = await prisma.userStory.findFirst({
      where: { id: parseInt(id), userId: req.userId }
    });

    if (!story) return res.status(404).json({ error: 'User Story non trouvée' });

    const updated = await prisma.userStory.update({
      where: { id: parseInt(id) },
      data: { status, ...(position !== undefined && { position }) }
    });

    res.json(updated);
  } catch (error) {
    logger.error({ err: error }, 'Erreur update status story');
    res.status(500).json({ error: 'Erreur lors de la mise à jour du statut' });
  }
};

/**
 * Supprimer une User Story
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 */
const remove = async (req, res) => {
  try {
    const { id } = req.params;
    
    const story = await prisma.userStory.findFirst({
      where: { id: parseInt(id), userId: req.userId }
    });
    
    if (!story) {
      return res.status(404).json({ error: 'User Story non trouvée' });
    }
    
    await prisma.userStory.delete({ where: { id: parseInt(id) } });
    res.json({ message: 'User Story supprimée' });
  } catch (error) {
    logger.error({ err: error }, 'Erreur suppression story');
    res.status(500).json({ error: 'Erreur lors de la suppression' });
  }
};

export { getAll, create, update, updateStatus, remove };
