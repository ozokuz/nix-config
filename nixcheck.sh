#!/usr/bin/env bash

# We'll remove -e since we want to continue on errors
set -uo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Checking all .nix files recursively..."
echo "----------------------------------------"

# First verify we have the files and store them in an array
mapfile -t files < <(find . -type f -name "*.nix")
if [ ${#files[@]} -eq 0 ]; then
  echo "No .nix files found!"
  exit 1
fi

# Initialize counters
errors_found=0
files_checked=0

# Process each .nix file
for file in "${files[@]}"; do
  # Skip empty lines
  if [ -z "$file" ]; then
    echo -e "${RED} Empty file $file${NC}"
    continue
  fi

  ((files_checked++))

  if output=$(nix-instantiate --parse "$file" 2>&1); then
    echo -e "${GREEN}✓ ${file} - OK${NC}"
  else
    echo -e "${RED}✗ ${file} - Error:${NC}"
    echo "$output"
    ((errors_found++))
  fi
done

echo "----------------------------------------"
echo "Files checked: $files_checked"
echo "Errors found: $errors_found"

# Exit with error if any problems were found
[ "$errors_found" -eq 0 ] || exit 1
