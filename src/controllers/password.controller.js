import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import logger from '../config/logger.js';

const prisma = new PrismaClient();

/**
 * Changer le mot de passe utilisateur
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 */
const changePassword = async (req, res) => {
  try {
    const { oldPassword, newPassword } = req.body;
    const userId = req.userId;

    const user = await prisma.user.findUnique({ where: { id: userId } });
    if (!user) {
      return res.status(404).json({ error: 'Utilisateur non trouvé' });
    }

    const validPassword = await bcrypt.compare(oldPassword, user.password);
    if (!validPassword) {
      return res.status(401).json({ error: 'Ancien mot de passe incorrect' });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await prisma.user.update({
      where: { id: userId },
      data: { password: hashedPassword }
    });

    logger.info({ userId }, 'Mot de passe modifié');
    res.json({ message: 'Mot de passe modifié avec succès' });
  } catch (error) {
    logger.error({ err: error }, 'Erreur changement mot de passe');
    res.status(500).json({ error: 'Erreur lors du changement de mot de passe' });
  }
};

export { changePassword };
