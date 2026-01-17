# Contributing to PLANER

Thank you for your interest in contributing to PLANER! This document provides guidelines and instructions for contributing.

---

## 🎯 Ways to Contribute

### 1. Report Bugs

Found a bug? Please [open an issue](https://github.com/Vakci/claude-code-planer/issues/new) with:

- **Title:** Clear, descriptive title
- **Description:** Steps to reproduce, expected vs actual behavior
- **Environment:** Claude Code version, OS, project type
- **Logs:** Relevant error messages or output
- **Screenshots:** If applicable

### 2. Suggest Features

Have an idea? Open a [feature request issue](https://github.com/Vakci/claude-code-planer/issues/new) with:

- **Use case:** Why this feature is needed
- **Proposed solution:** How you envision it working
- **Alternatives:** Other approaches you've considered
- **Additional context:** Examples, mockups, references

### 3. Improve Documentation

- Fix typos and clarify unclear sections
- Add examples and tutorials
- Create video walkthroughs
- Translate documentation (future)

### 4. Submit Code

- Fix bugs
- Implement features
- Add new tech stack support
- Improve problem research queries
- Optimize context management

---

## 🚀 Development Setup

### Prerequisites

- Claude Code CLI installed
- Git
- Basic understanding of Claude Code skills/agents

### Setup

```bash
# Fork and clone
git clone https://github.com/Vakci/claude-code-planer.git
cd claude-code-planer

# Install to local Claude skills directory for testing
./scripts/install.sh

# Make changes in skills/
# ...

# Test changes
cd ~/test-project
/planer
```

---

## 📝 Pull Request Process

### 1. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

**Branch naming:**
- `feature/feature-name` - New features
- `fix/bug-description` - Bug fixes
- `docs/description` - Documentation changes
- `refactor/description` - Code refactoring

### 2. Make Changes

- Follow existing code style and patterns
- Add comments for complex logic
- Update documentation if needed
- Test your changes thoroughly

### 3. Commit

**Commit message format:**
```
type: Short description (50 chars max)

Longer explanation if needed (72 chars per line).
- Bullet points for multiple changes
- Reference issues: Fixes #123

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `test:` Test additions/changes
- `chore:` Maintenance tasks

**Examples:**
```
feat: Add PLANER-MIGRATE for tech stack migrations

- Implement Phase 1-7 workflow for migrations
- Add migration-specific problem research
- Create migration roadmap template

Fixes #42
```

### 4. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:

- **Title:** Clear description of changes
- **Description:**
  - What changed and why
  - How to test
  - Related issues (Fixes #123, Relates to #456)
  - Screenshots/examples if applicable

### 5. Code Review

- Address feedback promptly
- Keep PR focused (one feature/fix per PR)
- Update branch if main branch changes

---

## 🎨 Code Style Guidelines

### Markdown Files (Skills)

```markdown
# Clear hierarchical headings

**Bold for emphasis** on important points

\```javascript
// Code blocks with syntax highlighting
Task({
  description: "Clear description",
  prompt: "Detailed prompt"
})
\```

**Lists:**
- Use bullet points for unordered items
- Keep items concise

**Tables:**
| Column 1 | Column 2 |
|----------|----------|
| Data     | Data     |
```

### JSON Templates

```json
{
  "field_name": "snake_case for consistency",
  "nested_object": {
    "property": "value"
  },
  "arrays": [
    "item1",
    "item2"
  ]
}
```

### Commenting

```markdown
# Phase 1: Codebase Discovery

**Goal:** Clear statement of what this phase does

**Approach:** How it works

**Output:** What it produces
```

---

## 🧪 Testing

### Manual Testing

Before submitting:

1. **Test PLANER-ZERO:**
   ```bash
   cd ~/test-new-project
   /planer "Build a [tech stack] app"
   # Verify: questions asked, plan generated, context <50%
   ```

2. **Test PLANER-PROGRESS:**
   ```bash
   cd ~/existing-project
   /planer
   # Verify: codebase analyzed, roadmap generated, context <50%
   ```

3. **Test Auto-Detection:**
   ```bash
   # Empty directory → should route to PLANER-ZERO
   # Existing project → should route to PLANER-PROGRESS
   ```

### Validation

```bash
# Run validation script
./tests/validate.sh

# Check for:
# - All required files present
# - Valid YAML frontmatter
# - No broken links
# - Template files exist
```

---

## 📚 Adding New Tech Stack Support

Want to add support for Rust, Go, or another tech stack?

### 1. Update Problem Research

Add queries to `shared/phase-2-problem-research.md`:

```markdown
For Rust:
\```
"Rust async/await common mistakes 2026"
"Rust borrow checker pitfalls 2026"
"site:github.com Rust issues 2025 2026"
\```
```

### 2. Create Specialist Template

Add to `shared/templates/specialist-agent-template.md`:

```markdown
### For Rust Projects

Common Mistake: Lifetime annotations
- Red flags: Compiler errors about lifetimes
- Solution: Use explicit lifetime annotations
- When to watch: Function parameters, structs with references
```

### 3. Update Examples

Add to `examples/rust-api/`:
- Sample project structure
- Generated plan output
- Specialist agent output

### 4. Document

Update:
- `README.md` - Add Rust to supported stacks
- `docs/USAGE.md` - Add Rust example
- `CHANGELOG.md` - Note new support

---

## 🐛 Reporting Security Issues

**DO NOT** open public issues for security vulnerabilities.

Instead, email: [your-email@example.com]

Include:
- Description of vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

We'll respond within 48 hours.

---

## 📖 Documentation Guidelines

### Writing Style

- **Clear and concise** - Avoid jargon
- **Active voice** - "Use Task tool" not "Task tool should be used"
- **Examples first** - Show, then explain
- **Progressive disclosure** - Simple → complex

### Structure

```markdown
# Title

> Brief overview (1-2 sentences)

## Section 1

Explanation with examples.

\```javascript
// Code example
\```

## Section 2

...
```

---

## 🎓 Learning Resources

New to Claude Code skills development?

- [Claude Code Documentation](https://docs.anthropic.com/claude/claude-code)
- [Existing Skills](https://github.com/anthropics/claude-code)
- [PLANER Architecture](docs/ARCHITECTURE.md)

---

## ❓ Questions?

- **General questions:** [GitHub Discussions](https://github.com/Vakci/claude-code-planer/discussions)
- **Bug reports:** [GitHub Issues](https://github.com/Vakci/claude-code-planer/issues)
- **Feature requests:** [GitHub Issues](https://github.com/Vakci/claude-code-planer/issues)

---

## 🙏 Recognition

Contributors will be:
- Listed in `CONTRIBUTORS.md`
- Mentioned in release notes
- Credited in documentation

---

## 📜 Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors.

### Standards

**Positive behaviors:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community

**Unacceptable behaviors:**
- Harassment, trolling, or insulting comments
- Personal or political attacks
- Publishing private information
- Other conduct inappropriate in a professional setting

### Enforcement

Violations may result in temporary or permanent ban from the project.

Report issues to: [your-email@example.com]

---

Thank you for contributing to PLANER! 🚀

---

**Last Updated:** 2026-01-17
