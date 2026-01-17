#!/bin/bash

# PLANER Validation Script
# Validates PLANER installation and file structure

set -e

echo "🔍 Validating PLANER installation..."
echo ""

# Detect Claude skills directory
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0
CHECKS=0

# Function to check file exists
check_file() {
  local file="$1"
  local description="$2"
  CHECKS=$((CHECKS + 1))

  if [ -f "$file" ]; then
    echo -e "${GREEN}✓${NC} $description"
    return 0
  else
    echo -e "${RED}✗${NC} $description"
    echo "   Missing: $file"
    ERRORS=$((ERRORS + 1))
    return 1
  fi
}

# Function to check directory exists
check_dir() {
  local dir="$1"
  local description="$2"
  CHECKS=$((CHECKS + 1))

  if [ -d "$dir" ]; then
    echo -e "${GREEN}✓${NC} $description"
    return 0
  else
    echo -e "${RED}✗${NC} $description"
    echo "   Missing: $dir"
    ERRORS=$((ERRORS + 1))
    return 1
  fi
}

# Function to validate YAML frontmatter
validate_yaml() {
  local file="$1"
  local description="$2"
  CHECKS=$((CHECKS + 1))

  if ! head -n 10 "$file" | grep -q "^---$"; then
    echo -e "${YELLOW}⚠${NC} $description - No YAML frontmatter found"
    WARNINGS=$((WARNINGS + 1))
    return 1
  fi

  # Check for required fields
  local has_name=$(head -n 10 "$file" | grep -c "^name:" || true)
  local has_description=$(head -n 10 "$file" | grep -c "^description:" || true)

  if [ "$has_name" -eq 0 ] || [ "$has_description" -eq 0 ]; then
    echo -e "${YELLOW}⚠${NC} $description - Missing required frontmatter fields"
    WARNINGS=$((WARNINGS + 1))
    return 1
  fi

  echo -e "${GREEN}✓${NC} $description - YAML frontmatter valid"
  return 0
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking Required Files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check main PLANER files
check_file "$CLAUDE_SKILLS_DIR/planer/SKILL.md" "PLANER parent SKILL.md"
check_file "$CLAUDE_SKILLS_DIR/planer/README.md" "PLANER README"

# Check shared files
check_dir "$CLAUDE_SKILLS_DIR/planer/shared" "PLANER shared directory"
check_file "$CLAUDE_SKILLS_DIR/planer/shared/phase-2-problem-research.md" "Shared Phase 2"
check_file "$CLAUDE_SKILLS_DIR/planer/shared/phase-3-ecosystem-analysis.md" "Shared Phase 3"
check_file "$CLAUDE_SKILLS_DIR/planer/shared/phase-4-specialist-generation.md" "Shared Phase 4"

# Check shared templates
check_dir "$CLAUDE_SKILLS_DIR/planer/shared/templates" "Shared templates directory"
check_file "$CLAUDE_SKILLS_DIR/planer/shared/templates/problems.json" "problems.json template"
check_file "$CLAUDE_SKILLS_DIR/planer/shared/templates/tool_inventory.json" "tool_inventory.json template"
check_file "$CLAUDE_SKILLS_DIR/planer/shared/templates/specialist-agent-template.md" "Specialist agent template"

# Check PLANER-ZERO
check_file "$CLAUDE_SKILLS_DIR/planer-zero/SKILL.md" "PLANER-ZERO SKILL.md"

# Check PLANER-PROGRESS
check_file "$CLAUDE_SKILLS_DIR/planer-progress/SKILL.md" "PLANER-PROGRESS SKILL.md"
check_dir "$CLAUDE_SKILLS_DIR/planer-progress/templates" "PLANER-PROGRESS templates directory"
check_file "$CLAUDE_SKILLS_DIR/planer-progress/templates/project_structure.json" "project_structure.json template"
check_file "$CLAUDE_SKILLS_DIR/planer-progress/templates/feature_inventory.json" "feature_inventory.json template"
check_file "$CLAUDE_SKILLS_DIR/planer-progress/templates/quality_report.json" "quality_report.json template"
check_file "$CLAUDE_SKILLS_DIR/planer-progress/templates/gap_analysis.json" "gap_analysis.json template"
check_file "$CLAUDE_SKILLS_DIR/planer-progress/templates/task_roadmap.json" "task_roadmap.json template"
check_file "$CLAUDE_SKILLS_DIR/planer-progress/templates/continuation_roadmap.md" "continuation_roadmap.md template"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Validating YAML Frontmatter..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -f "$CLAUDE_SKILLS_DIR/planer/SKILL.md" ]; then
  validate_yaml "$CLAUDE_SKILLS_DIR/planer/SKILL.md" "PLANER parent"
fi

if [ -f "$CLAUDE_SKILLS_DIR/planer-zero/SKILL.md" ]; then
  validate_yaml "$CLAUDE_SKILLS_DIR/planer-zero/SKILL.md" "PLANER-ZERO"
fi

if [ -f "$CLAUDE_SKILLS_DIR/planer-progress/SKILL.md" ]; then
  validate_yaml "$CLAUDE_SKILLS_DIR/planer-progress/SKILL.md" "PLANER-PROGRESS"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Validation Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Total checks: $CHECKS"
echo -e "${GREEN}Passed:${NC} $((CHECKS - ERRORS - WARNINGS))"

if [ $WARNINGS -gt 0 ]; then
  echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
fi

if [ $ERRORS -gt 0 ]; then
  echo -e "${RED}Errors:${NC} $ERRORS"
fi

echo ""

if [ $ERRORS -gt 0 ]; then
  echo -e "${RED}❌ Validation FAILED${NC}"
  echo ""
  echo "Please fix the errors above and run validation again."
  exit 1
else
  if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Validation PASSED with warnings${NC}"
    echo ""
    echo "Installation is functional but has minor issues."
  else
    echo -e "${GREEN}✅ Validation PASSED${NC}"
    echo ""
    echo "PLANER is correctly installed and ready to use!"
  fi
  exit 0
fi
