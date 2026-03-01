import { z } from 'zod';

export const registerSchema = z.object({
  name: z.string().min(2, 'Le nom doit contenir au moins 2 caractères'),
  email: z.string().email('Email invalide'),
  password: z.string().min(6, 'Le mot de passe doit contenir au moins 6 caractères'),
  role: z.enum(['developer', 'tester', 'product owner', 'scrum master', 'teammate', 'administrator']).default('teammate')
});

export const loginSchema = z.object({
  email: z.string().email('Email invalide'),
  password: z.string().min(1, 'Mot de passe requis')
});

export const userStorySchema = z.object({
  title: z.string().min(3, 'Le titre doit contenir au moins 3 caractères'),
  description: z.string().optional(),
  priority: z.enum(['Low', 'Medium', 'High']).default('Medium'),
  status: z.enum(['BACKLOG', 'TO_DO', 'DOING', 'TO_TEST', 'ISSUE', 'DONE']).default('BACKLOG'),
  storyPoints: z.number().int().nullable().optional()
});
