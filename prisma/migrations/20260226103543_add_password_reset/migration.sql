/*
  Warnings:

  - The `priority` column on the `UserStory` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `UserStory` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "UserStoryPriority" AS ENUM ('Low', 'Medium', 'High');

-- CreateEnum
CREATE TYPE "UserStoryStatus" AS ENUM ('BACKLOG', 'TO_DO', 'DOING', 'TO_TEST', 'ISSUE', 'DONE');

-- AlterTable
ALTER TABLE "UserStory" ADD COLUMN     "position" INTEGER NOT NULL DEFAULT 0,
DROP COLUMN "priority",
ADD COLUMN     "priority" "UserStoryPriority" NOT NULL DEFAULT 'Medium',
DROP COLUMN "status",
ADD COLUMN     "status" "UserStoryStatus" NOT NULL DEFAULT 'BACKLOG';

-- CreateTable
CREATE TABLE "PasswordReset" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PasswordReset_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PasswordReset_token_key" ON "PasswordReset"("token");

-- CreateIndex
CREATE INDEX "PasswordReset_token_idx" ON "PasswordReset"("token");

-- CreateIndex
CREATE INDEX "PasswordReset_email_idx" ON "PasswordReset"("email");

-- CreateIndex
CREATE INDEX "idx_userstory_priority" ON "UserStory"("priority");

-- CreateIndex
CREATE INDEX "idx_userstory_status" ON "UserStory"("status");

-- CreateIndex
CREATE INDEX "idx_userstory_status_position" ON "UserStory"("status", "position");

-- AddForeignKey
ALTER TABLE "PasswordReset" ADD CONSTRAINT "PasswordReset_email_fkey" FOREIGN KEY ("email") REFERENCES "User"("email") ON DELETE CASCADE ON UPDATE CASCADE;
