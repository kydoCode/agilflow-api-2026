import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import crypto from 'crypto';
import { PrismaClient } from '@prisma/client';
import { z } from 'zod';

const prisma = new PrismaClient();

const forgotPasswordSchema = z.object({
  email: z.string().email('Email invalide')
});

const resetPasswordSchema = z.object({
  token: z.string().min(1, 'Token requis'),
  password: z.string().min(6, 'Mot de passe minimum 6 caractères')
});

export const forgotPassword = async (req, res) => {
  try {
    const { email } = forgotPasswordSchema.parse(req.body);
    
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) {
      return res.status(404).json({ error: 'Utilisateur non trouvé' });
    }

    // Supprimer les anciens tokens
    await prisma.passwordReset.deleteMany({ where: { email } });

    // Créer nouveau token
    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1h

    await prisma.passwordReset.create({
      data: { email, token, expiresAt }
    });

    // TODO: Envoyer email avec lien reset
    console.log(`Reset link: http://localhost:5173/reset-password/${token}`);
    
    res.json({ message: 'Email de réinitialisation envoyé' });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors[0].message });
    }
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

export const resetPassword = async (req, res) => {
  try {
    const { token, password } = resetPasswordSchema.parse(req.body);
    
    const resetRecord = await prisma.passwordReset.findUnique({
      where: { token },
      include: { User: true }
    });

    if (!resetRecord || resetRecord.expiresAt < new Date()) {
      return res.status(400).json({ error: 'Token invalide ou expiré' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    
    await prisma.user.update({
      where: { email: resetRecord.email },
      data: { password: hashedPassword }
    });

    await prisma.passwordReset.delete({ where: { token } });
    
    res.json({ message: 'Mot de passe réinitialisé avec succès' });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: error.errors[0].message });
    }
    res.status(500).json({ error: 'Erreur serveur' });
  }
};