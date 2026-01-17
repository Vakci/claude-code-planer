#!/bin/bash
set -e

# PLANER Uninstallation Script
# Removes PLANER skills from ~/.claude/skills/

echo "🗑️  Uninstalling PLANER from Claude Code..."
echo ""

# Detect Claude skills directory
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

# Check if any PLANER skills are installed
FOUND_ANY=false

if [ -d "$CLAUDE_SKILLS_DIR/planer" ]; then
  FOUND_ANY=true
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-zero" ]; then
  FOUND_ANY=true
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-progress" ]; then
  FOUND_ANY=true
fi

if [ "$FOUND_ANY" = false ]; then
  echo "ℹ️  No PLANER installation found in $CLAUDE_SKILLS_DIR"
  echo ""
  echo "Nothing to uninstall."
  exit 0
fi

# Confirm uninstallation
echo "⚠️  This will remove the following:"
echo ""

if [ -d "$CLAUDE_SKILLS_DIR/planer" ]; then
  echo "   - $CLAUDE_SKILLS_DIR/planer/"
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-zero" ]; then
  echo "   - $CLAUDE_SKILLS_DIR/planer-zero/"
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-progress" ]; then
  echo "   - $CLAUDE_SKILLS_DIR/planer-progress/"
fi

echo ""
read -p "Are you sure you want to uninstall PLANER? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Uninstallation cancelled."
  exit 0
fi

# Remove PLANER skills
echo ""
echo "🗑️  Removing PLANER skills..."

if [ -d "$CLAUDE_SKILLS_DIR/planer" ]; then
  rm -rf "$CLAUDE_SKILLS_DIR/planer"
  echo "   ✓ Removed planer/"
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-zero" ]; then
  rm -rf "$CLAUDE_SKILLS_DIR/planer-zero"
  echo "   ✓ Removed planer-zero/"
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-progress" ]; then
  rm -rf "$CLAUDE_SKILLS_DIR/planer-progress"
  echo "   ✓ Removed planer-progress/"
fi

echo ""
echo "✅ PLANER uninstalled successfully!"
echo ""
echo "Note: Generated specialist agents in ~/.claude/agents/ were not removed."
echo "You can manually delete them if no longer needed."
