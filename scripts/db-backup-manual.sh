#!/bin/bash
# db-backup-manual.sh
# Usage : ./scripts/db-backup-manual.sh
# Cree un dump de la DB Neon dans back/db_dumps/

BACKUP_DIR="/home/kody/Bureau/AGILFLOWv3/AgilFlow_2026/back/db_dumps"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT="$BACKUP_DIR/agilflow_backup_$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"

/usr/lib/postgresql/17/bin/pg_dump \
  "postgresql://neondb_owner:npg_7HJAEtdQ3Ryl@ep-divine-term-agvr6ezt-pooler.c-2.eu-central-1.aws.neon.tech/neondb?sslmode=require" \
  > "$OUTPUT"

echo "Backup cree : $OUTPUT"
ls -lh "$OUTPUT"
