import bcrypt from 'bcryptjs';
import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { PrismaClient } from '@prisma/client';
import { z } from 'zod';
import { Resend } from 'resend';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const prisma = new PrismaClient();
const resend = new Resend(process.env.RESEND_API_KEY);

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

    await prisma.passwordReset.deleteMany({ where: { email } });

    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 60 * 60 * 1000);

    await prisma.passwordReset.create({ data: { email, token, expiresAt } });

    const resetUrl = `${process.env.FRONTEND_URL || 'http://localhost:5173'}/reset-password/${token}`;
    const legalUrl = `${process.env.FRONTEND_URL || 'https://www.agilflow.app'}/legal`;

    const templatePath = path.join(__dirname, '../templates/resetPassword.html');
    const html = fs.readFileSync(templatePath, 'utf-8')
      .replaceAll('{{RESET_URL}}', resetUrl)
      .replaceAll('{{LEGAL_URL}}', legalUrl);

    await resend.emails.send({
      from: process.env.FROM_EMAIL,
      to: email,
      subject: 'Réinitialisation de votre mot de passe - AgilFlow',
      html
    });

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
