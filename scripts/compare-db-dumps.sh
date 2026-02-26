#!/bin/bash
# compare-db-dumps.sh
# Compare deux dumps pour détecter les nouvelles données

BACKUP_DIR="/home/kody/Bureau/AGILFLOWv3/AgilFlow_2026/back/db_dumps"
OLD_DUMP="$1"
NEW_DUMP="$2"

if [ -z "$OLD_DUMP" ] || [ -z "$NEW_DUMP" ]; then
  echo "Usage: ./compare-db-dumps.sh old_dump.sql new_dump.sql"
  exit 1
fi

echo "🔍 Comparaison des dumps DB..."
echo "📄 Ancien: $OLD_DUMP"
echo "📄 Nouveau: $NEW_DUMP"
echo ""

# Comparer les users
echo "👥 USERS:"
OLD_USERS=$(grep -c "^[0-9]" "$OLD_DUMP" | head -1 || echo "0")
NEW_USERS=$(grep -c "^[0-9]" "$NEW_DUMP" | head -1 || echo "0")
echo "Ancien: $OLD_USERS users | Nouveau: $NEW_USERS users"

if [ "$NEW_USERS" -gt "$OLD_USERS" ]; then
  echo "⚠️  NOUVEAUX USERS DÉTECTÉS !"
  echo "Différence:"
  diff <(grep "^[0-9]" "$OLD_DUMP") <(grep "^[0-9]" "$NEW_DUMP") || true
fi

# Comparer les user stories
echo ""
echo "📝 USER STORIES:"
OLD_US=$(grep -E "^[0-9]+\s+En tant que" "$OLD_DUMP" | wc -l)
NEW_US=$(grep -E "^[0-9]+\s+En tant que" "$NEW_DUMP" | wc -l)
echo "Ancien: $OLD_US stories | Nouveau: $NEW_US stories"

if [ "$NEW_US" -gt "$OLD_US" ]; then
  echo "⚠️  NOUVELLES USER STORIES DÉTECTÉES !"
  echo "Différence:"
  diff <(grep -E "^[0-9]+\s+En tant que" "$OLD_DUMP") <(grep -E "^[0-9]+\s+En tant que" "$NEW_DUMP") || true
fi

echo ""
if [ "$NEW_USERS" -eq "$OLD_USERS" ] && [ "$NEW_US" -eq "$OLD_US" ]; then
  echo "✅ AUCUNE NOUVELLE DONNÉE - MIGRATION SÉCURISÉE"
  exit 0
else
  echo "⚠️  NOUVELLES DONNÉES DÉTECTÉES - ATTENTION LORS DE LA MIGRATION"
  exit 1
fi