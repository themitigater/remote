#!/bin/bash

# Exit on any error
set -e

# Format staged files
git --no-pager diff --name-only --diff-filter=d --cached | grep -E "\\.(ex|exs)$" | xargs mix format
git --no-pager diff --name-only --diff-filter=d --cached | grep -E "\\.(ex|exs)$" | xargs git add

mix lint