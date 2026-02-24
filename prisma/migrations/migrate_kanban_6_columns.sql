-- ============================================
-- MIGRATION : Kanban 6 colonnes + position
-- Strategie : expand/contract (sans perte)
-- ============================================

BEGIN;

-- 1. Creer les ENUM
CREATE TYPE "UserStoryStatus" AS ENUM ('BACKLOG', 'TO_DO', 'DOING', 'TO_TEST', 'ISSUE', 'DONE');
CREATE TYPE "UserStoryPriority" AS ENUM ('Low', 'Medium', 'High');

-- 2. Ajouter colonnes temporaires + position
ALTER TABLE "UserStory"
  ADD COLUMN "status_new" "UserStoryStatus",
  ADD COLUMN "priority_new" "UserStoryPriority",
  ADD COLUMN "position" INTEGER DEFAULT 0 NOT NULL;

-- 3. Migrer les donnees existantes
UPDATE "UserStory" SET "status_new" =
  CASE
    WHEN "status" = 'Todo'  THEN 'TO_DO'::"UserStoryStatus"
    WHEN "status" = 'Doing' THEN 'DOING'::"UserStoryStatus"
    WHEN "status" = 'Done'  THEN 'DONE'::"UserStoryStatus"
    ELSE 'BACKLOG'::"UserStoryStatus"
  END;

UPDATE "UserStory" SET "priority_new" =
  CASE
    WHEN "priority" = 'High' THEN 'High'::"UserStoryPriority"
    WHEN "priority" = 'Low'  THEN 'Low'::"UserStoryPriority"
    ELSE 'Medium'::"UserStoryPriority"
  END;

-- 4. Supprimer anciennes colonnes
ALTER TABLE "UserStory"
  DROP COLUMN "status",
  DROP COLUMN "priority";

-- 5. Renommer nouvelles colonnes
ALTER TABLE "UserStory"
  RENAME COLUMN "status_new" TO "status";
ALTER TABLE "UserStory"
  RENAME COLUMN "priority_new" TO "priority";

-- 6. Contraintes NOT NULL + DEFAULT
ALTER TABLE "UserStory"
  ALTER COLUMN "status" SET NOT NULL,
  ALTER COLUMN "status" SET DEFAULT 'BACKLOG'::"UserStoryStatus",
  ALTER COLUMN "priority" SET NOT NULL,
  ALTER COLUMN "priority" SET DEFAULT 'Medium'::"UserStoryPriority";

-- 7. Index
CREATE INDEX "idx_userstory_status" ON "UserStory"("status");
CREATE INDEX "idx_userstory_priority" ON "UserStory"("priority");
CREATE INDEX "idx_userstory_status_position" ON "UserStory"("status", "position");

-- 8. Validation avant commit
DO $$
DECLARE
  total_count INTEGER;
  null_status INTEGER;
  null_priority INTEGER;
BEGIN
  SELECT COUNT(*) INTO total_count FROM "UserStory";
  SELECT COUNT(*) INTO null_status FROM "UserStory" WHERE "status" IS NULL;
  SELECT COUNT(*) INTO null_priority FROM "UserStory" WHERE "priority" IS NULL;

  RAISE NOTICE 'Total UserStories: %', total_count;
  RAISE NOTICE 'Status NULL: %', null_status;
  RAISE NOTICE 'Priority NULL: %', null_priority;

  IF null_status > 0 OR null_priority > 0 THEN
    RAISE EXCEPTION 'Migration echouee: valeurs NULL detectees';
  END IF;

  RAISE NOTICE 'Migration validee avec succes';
END $$;

COMMIT;

-- Verification finale
SELECT status, COUNT(*) as count FROM "UserStory" GROUP BY status ORDER BY status;
SELECT priority, COUNT(*) as count FROM "UserStory" GROUP BY priority ORDER BY priority;
