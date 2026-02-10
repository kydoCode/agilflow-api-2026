import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

export const createSprint = async (req, res) => {
  try {
    const { name, goal, startDate, endDate } = req.body;
    const sprint = await prisma.sprint.create({
      data: { name, goal, startDate: new Date(startDate), endDate: new Date(endDate) }
    });
    res.status(201).json(sprint);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const getSprints = async (req, res) => {
  try {
    const sprints = await prisma.sprint.findMany({
      include: { userStories: true },
      orderBy: { startDate: 'desc' }
    });
    res.json(sprints);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const getSprintById = async (req, res) => {
  try {
    const sprint = await prisma.sprint.findUnique({
      where: { id: parseInt(req.params.id) },
      include: { userStories: { include: { user: true } } }
    });
    if (!sprint) return res.status(404).json({ error: 'Sprint not found' });
    res.json(sprint);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const updateSprint = async (req, res) => {
  try {
    const { name, goal, startDate, endDate, status } = req.body;
    const sprint = await prisma.sprint.update({
      where: { id: parseInt(req.params.id) },
      data: { name, goal, startDate: startDate ? new Date(startDate) : undefined, endDate: endDate ? new Date(endDate) : undefined, status }
    });
    res.json(sprint);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const deleteSprint = async (req, res) => {
  try {
    await prisma.sprint.delete({ where: { id: parseInt(req.params.id) } });
    res.status(204).send();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const addUserStoryToSprint = async (req, res) => {
  try {
    const { userStoryId } = req.body;
    const userStory = await prisma.userStory.update({
      where: { id: userStoryId },
      data: { sprintId: parseInt(req.params.id) }
    });
    res.json(userStory);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
