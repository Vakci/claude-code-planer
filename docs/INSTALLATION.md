# Installation Guide

Step-by-step instructions for installing PLANER on your system.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Installation](#quick-installation)
3. [Manual Installation](#manual-installation)
4. [Verification](#verification)
5. [Updating](#updating)
6. [Uninstallation](#uninstallation)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before installing PLANER, ensure you have:

### Required

- **Claude Code CLI** installed and configured
  - Download from: [https://claude.com/claude-code](https://claude.com/claude-code)
  - Minimum version: 1.0
  - Run `claude --version` to verify

- **Git** (for cloning the repository)
  - Check: `git --version`
  - Install: [https://git-scm.com/downloads](https://git-scm.com/downloads)

### Operating Systems

PLANER supports:
- ✅ macOS (tested on macOS 14+)
- ✅ Linux (Ubuntu, Debian, Fedora, etc.)
- ✅ Windows (via WSL or Git Bash)

---

## Quick Installation

The fastest way to install PLANER:

```bash
# 1. Clone repository
git clone https://github.com/Vakci/claude-code-planer.git
cd claude-code-planer

# 2. Run installer
./scripts/install.sh

# 3. Verify installation
./tests/validate.sh
```

**Done!** You can now use `/planer` in any project directory.

---

## Manual Installation

If you prefer to install manually or the automated script doesn't work:

### Step 1: Clone Repository

```bash
git clone https://github.com/Vakci/claude-code-planer.git
cd claude-code-planer
```

### Step 2: Locate Claude Skills Directory

Claude Code stores skills in:
- **macOS/Linux:** `~/.claude/skills/`
- **Windows (WSL):** `~/.claude/skills/`

Verify the directory exists:
```bash
ls ~/.claude/skills/
```

If it doesn't exist, create it:
```bash
mkdir -p ~/.claude/skills/
```

### Step 3: Copy Skills

Copy PLANER skills to Claude's skills directory:

```bash
# From the claude-code-planer directory:
cp -r skills/planer ~/.claude/skills/
cp -r skills/planer-zero ~/.claude/skills/
cp -r skills/planer-progress ~/.claude/skills/
```

### Step 4: Verify Installation

Check that files were copied correctly:

```bash
ls ~/.claude/skills/planer/
ls ~/.claude/skills/planer-zero/
ls ~/.claude/skills/planer-progress/
```

You should see `SKILL.md` files in each directory.

---

## Verification

After installation, verify PLANER is working:

### Method 1: Run Validation Script

```bash
cd claude-code-planer
./tests/validate.sh
```

**Expected output:**
```
✅ Validation PASSED
PLANER is correctly installed and ready to use!
```

### Method 2: Test in Claude Code

```bash
# Create test directory
mkdir ~/test-planer
cd ~/test-planer

# Invoke PLANER
/planer "Test installation"
```

**Expected:** PLANER should ask you questions about your new project.

---

## Updating

To update PLANER to the latest version:

### Option 1: Pull and Reinstall

```bash
cd claude-code-planer
git pull origin main
./scripts/install.sh
```

The installer will automatically backup existing installations before updating.

### Option 2: Manual Update

```bash
cd claude-code-planer
git pull origin main

# Remove old installation
rm -rf ~/.claude/skills/planer
rm -rf ~/.claude/skills/planer-zero
rm -rf ~/.claude/skills/planer-progress

# Copy new version
cp -r skills/planer ~/.claude/skills/
cp -r skills/planer-zero ~/.claude/skills/
cp -r skills/planer-progress ~/.claude/skills/
```

---

## Uninstallation

To completely remove PLANER:

### Option 1: Uninstall Script

```bash
cd claude-code-planer
./scripts/uninstall.sh
```

The script will:
1. Confirm you want to uninstall
2. Remove PLANER skills from `~/.claude/skills/`
3. Preserve generated specialist agents (you can delete manually if needed)

### Option 2: Manual Uninstall

```bash
rm -rf ~/.claude/skills/planer
rm -rf ~/.claude/skills/planer-zero
rm -rf ~/.claude/skills/planer-progress
```

**Note:** Generated specialist agents in `~/.claude/agents/` are not removed. Delete them manually if you don't need them:

```bash
# List generated specialists
ls ~/.claude/agents/

# Remove specific specialist
rm ~/.claude/agents/wordpress-specialist.md

# Remove all specialists (careful!)
rm -rf ~/.claude/agents/
```

---

## Troubleshooting

### Issue: "Claude skills directory not found"

**Problem:** `~/.claude/skills/` doesn't exist

**Solution:**
```bash
# Create directory
mkdir -p ~/.claude/skills/

# Run Claude Code once to initialize
claude --version

# Try installation again
./scripts/install.sh
```

### Issue: "Permission denied" when running installer

**Problem:** Script not executable

**Solution:**
```bash
chmod +x scripts/install.sh
chmod +x tests/validate.sh
./scripts/install.sh
```

### Issue: "Validation failed - missing files"

**Problem:** Files didn't copy correctly

**Solution:**
```bash
# Check source files exist
ls skills/planer/SKILL.md
ls skills/planer-zero/SKILL.md
ls skills/planer-progress/SKILL.md

# If files exist, try manual copy:
cp -r skills/* ~/.claude/skills/

# Verify again
./tests/validate.sh
```

### Issue: "/planer command not found"

**Problem:** Claude Code can't find PLANER skill

**Possible causes:**
1. **Skills not in correct directory**
   - Check: `ls ~/.claude/skills/planer/`
   - Should see: `SKILL.md`, `README.md`, etc.

2. **Claude Code not recognizing skills**
   - Restart Claude Code CLI
   - Try: `claude skills list` (if available)

3. **YAML frontmatter invalid**
   - Run: `./tests/validate.sh`
   - Check for warnings about YAML

**Solution:**
```bash
# Re-install PLANER
./scripts/uninstall.sh
./scripts/install.sh

# Verify
./tests/validate.sh
```

### Issue: "Auto-detection not working"

**Problem:** PLANER doesn't route to correct child

**Check:**
```bash
# In empty directory (should route to PLANER-ZERO)
mkdir ~/test-new && cd ~/test-new
/planer "Test"

# In existing project (should route to PLANER-PROGRESS)
cd ~/my-existing-project
/planer
```

**If still not working:**
- Manually invoke child skills:
  - `/planer-zero` for new projects
  - `/planer-progress` for existing projects

### Issue: "Context exceeded" errors

**Problem:** PLANER uses too much context

**Unlikely:** PLANER is designed to use <30% context.

**If it happens:**
1. Check project size (very large projects may exceed limits)
2. Report issue: [https://github.com/Vakci/claude-code-planer/issues](https://github.com/Vakci/claude-code-planer/issues)

---

## Advanced Configuration

### Custom Skills Directory

If you use a custom Claude skills directory:

```bash
# Set environment variable
export CLAUDE_SKILLS_DIR="/path/to/custom/skills"

# Copy skills
cp -r skills/* $CLAUDE_SKILLS_DIR/
```

### Multi-User Installation

For system-wide installation (requires sudo):

```bash
# Install to shared location
sudo cp -r skills/* /usr/local/share/claude/skills/

# Each user creates symlink
ln -s /usr/local/share/claude/skills ~/.claude/skills
```

---

## Verification Checklist

After installation, verify:

- [ ] `~/.claude/skills/planer/SKILL.md` exists
- [ ] `~/.claude/skills/planer-zero/SKILL.md` exists
- [ ] `~/.claude/skills/planer-progress/SKILL.md` exists
- [ ] `~/.claude/skills/planer/shared/` directory exists
- [ ] Validation script passes: `./tests/validate.sh`
- [ ] Can invoke `/planer` in test directory

---

## Next Steps

After successful installation:

1. **Read Usage Guide:** [USAGE.md](USAGE.md)
2. **Review Architecture:** [ARCHITECTURE.md](ARCHITECTURE.md)
3. **Try Examples:** See [examples/](../examples/)
4. **Join Community:** [GitHub Discussions](https://github.com/Vakci/claude-code-planer/discussions)

---

## Getting Help

- **Documentation:** [README.md](../README.md)
- **FAQ:** [FAQ.md](FAQ.md)
- **Issues:** [GitHub Issues](https://github.com/Vakci/claude-code-planer/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Vakci/claude-code-planer/discussions)

---

**Last Updated:** 2026-01-17
**Tested with:** Claude Code 1.0+
**Supported OS:** macOS, Linux, Windows (WSL)
