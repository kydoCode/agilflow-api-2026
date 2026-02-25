#!/bin/bash
# db-backup-manual.sh
# Usage : ./scripts/db-backup-manual.sh
# Cree un dump de la DB Neon dans back/db_dumps/

BACKUP_DIR="/home/kody/Bureau/AGILFLOWv3/AgilFlow_2026/back/db_dumps"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT="$BACKUP_DIR/agilflow_backup_$TIMESTAMP.sql"

# Charger DATABASE_URL depuis .env
if [ -f "$(dirname "$0")/../.env" ]; then
  export $(grep -v '^#' "$(dirname "$0")/../.env" | grep DATABASE_URL)
fi

if [ -z "$DATABASE_URL" ]; then
  echo "Erreur : DATABASE_URL non definie. Verifiez le fichier .env"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

/usr/lib/postgresql/17/bin/pg_dump "$DATABASE_URL" > "$OUTPUT"

echo "Backup cree : $OUTPUT"
ls -lh "$OUTPUT"
