#!/usr/bin/env bash

REPO="technoyoake/gitignore"
BASE="https://raw.githubusercontent.com/$REPO/main"
OUTPUT=".gitignore"

# Получаем список файлов из репы
FILES=$(curl -s "https://api.github.com/repos/$REPO/contents" \
  | grep '"name"' \
  | grep '\.gitignore' \
  | sed 's/.*"name": "\(.*\)\.gitignore".*/\1/')

PARTS=($FILES)

echo "Выбери компоненты (пробел между номерами):"
for i in "${!PARTS[@]}"; do
  echo "  $((i+1))) ${PARTS[$i]}"
done
echo ""
read -rp "Номера: " input

> "$OUTPUT"
for n in $input; do
  part="${PARTS[$((n-1))]}"
  echo "# === $part ===" >> "$OUTPUT"
  curl -s "$BASE/$part.gitignore" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "✓ $part"
done

echo ""
echo "Готово → $OUTPUT"
