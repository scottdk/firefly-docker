#!/bin/bash

SECRETS_DIR=".secrets"
OUTPUT_FILE="secrets.yml"
OUTPUT_FILE1="secrets-compose.yml"


echo "secrets:" > "$OUTPUT_FILE"

for secret_file in "$SECRETS_DIR"/*; do
    [ -e "$secret_file" ] || continue
    secret_name=$(basename "$secret_file")
    echo "  $secret_name:" >> "$OUTPUT_FILE"
    echo "    file: $SECRETS_DIR/$secret_name" >> "$OUTPUT_FILE"
done


echo "# This file is auto-generated by create_secrets.sh." > "$OUTPUT_FILE1"
echo "# Paste the contents into each service of the  docker-compose.yml where required." >> "$OUTPUT_FILE1"
echo "    secrets:" >> "$OUTPUT_FILE1"
for secret_file in "$SECRETS_DIR"/*; do
    [ -e "$secret_file" ] || continue
    secret_name=$(basename "$secret_file")
    echo "      - $secret_name" >> "$OUTPUT_FILE1"
done