#!/bin/bash
set -e

# PLANER Installation Script
# Installs PLANER skills to ~/.claude/skills/ for Claude Code

echo "🚀 Installing PLANER for Claude Code..."
echo ""

# Detect Claude skills directory
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

# Check if Claude skills directory exists
if [ ! -d "$CLAUDE_SKILLS_DIR" ]; then
  echo "❌ Claude skills directory not found: $CLAUDE_SKILLS_DIR"
  echo ""
  echo "Please ensure Claude Code is installed and configured."
  echo "Expected directory: ~/.claude/skills/"
  echo ""
  echo "If Claude Code is installed, try running it once to initialize the skills directory."
  exit 1
fi

# Get the script's directory (repo root/scripts)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Check if skills/ directory exists in repo
if [ ! -d "$REPO_ROOT/skills" ]; then
  echo "❌ Skills directory not found in repository: $REPO_ROOT/skills"
  echo ""
  echo "Please ensure you're running this script from the claude-code-planer repository."
  exit 1
fi

echo "📦 Copying PLANER skills..."
echo "   Source: $REPO_ROOT/skills/"
echo "   Destination: $CLAUDE_SKILLS_DIR/"
echo ""

# Backup existing PLANER skills if they exist
if [ -d "$CLAUDE_SKILLS_DIR/planer" ]; then
  echo "⚠️  Existing PLANER installation found."
  echo "   Creating backup: $CLAUDE_SKILLS_DIR/planer.backup.$(date +%Y%m%d_%H%M%S)"
  mv "$CLAUDE_SKILLS_DIR/planer" "$CLAUDE_SKILLS_DIR/planer.backup.$(date +%Y%m%d_%H%M%S)"
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-zero" ]; then
  echo "   Creating backup: $CLAUDE_SKILLS_DIR/planer-zero.backup.$(date +%Y%m%d_%H%M%S)"
  mv "$CLAUDE_SKILLS_DIR/planer-zero" "$CLAUDE_SKILLS_DIR/planer-zero.backup.$(date +%Y%m%d_%H%M%S)"
fi

if [ -d "$CLAUDE_SKILLS_DIR/planer-progress" ]; then
  echo "   Creating backup: $CLAUDE_SKILLS_DIR/planer-progress.backup.$(date +%Y%m%d_%H%M%S)"
  mv "$CLAUDE_SKILLS_DIR/planer-progress" "$CLAUDE_SKILLS_DIR/planer-progress.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Copy skills to Claude directory
cp -r "$REPO_ROOT/skills/planer" "$CLAUDE_SKILLS_DIR/"
cp -r "$REPO_ROOT/skills/planer-zero" "$CLAUDE_SKILLS_DIR/"
cp -r "$REPO_ROOT/skills/planer-progress" "$CLAUDE_SKILLS_DIR/"

echo ""
echo "✅ Verifying installation..."

# Verify installation
MISSING_FILES=()

if [ ! -f "$CLAUDE_SKILLS_DIR/planer/SKILL.md" ]; then
  MISSING_FILES+=("planer/SKILL.md")
fi

if [ ! -f "$CLAUDE_SKILLS_DIR/planer/shared/phase-2-problem-research.md" ]; then
  MISSING_FILES+=("planer/shared/phase-2-problem-research.md")
fi

if [ ! -f "$CLAUDE_SKILLS_DIR/planer-zero/SKILL.md" ]; then
  MISSING_FILES+=("planer-zero/SKILL.md")
fi

if [ ! -f "$CLAUDE_SKILLS_DIR/planer-progress/SKILL.md" ]; then
  MISSING_FILES+=("planer-progress/SKILL.md")
fi

if [ ! -f "$CLAUDE_SKILLS_DIR/planer-progress/templates/project_structure.json" ]; then
  MISSING_FILES+=("planer-progress/templates/project_structure.json")
fi

if [ ${#MISSING_FILES[@]} -gt 0 ]; then
  echo "❌ Installation incomplete. Missing files:"
  for file in "${MISSING_FILES[@]}"; do
    echo "   - $file"
  done
  echo ""
  echo "Please check file permissions and try again."
  exit 1
fi

echo "✅ All required files present!"
echo ""
echo "🎉 PLANER installed successfully!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📖 Usage:"
echo ""
echo "   For new projects:"
echo "   $ cd ~/my-new-project"
echo "   $ /planer \"Build a Next.js blog with Supabase\""
echo ""
echo "   For existing projects:"
echo "   $ cd ~/my-existing-project"
echo "   $ /planer"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Documentation: https://github.com/Vakci/claude-code-planer"
echo "🐛 Report issues: https://github.com/Vakci/claude-code-planer/issues"
echo ""
echo "Happy planning! 🚀"
