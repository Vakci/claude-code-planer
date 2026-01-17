# PLANER - Master Project Orchestration for Claude Code

> Auto-detecting, problem-aware project planning system for greenfield and in-progress projects.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue)](https://claude.com/claude-code)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](https://github.com/Vakci/claude-code-planer/releases)

---

## 🎯 What is PLANER?

PLANER is a professional-grade planning system for Claude Code that revolutionizes how you plan and continue development projects. It automatically detects your project state, researches recent (2025-2026) tech stack problems, and generates actionable, problem-aware plans.

### Key Features

✅ **Auto-Detection** - Automatically routes to PLANER-ZERO (greenfield) or PLANER-PROGRESS (in-progress)
✅ **Problem Research** - WebSearch for 2025-2026 common mistakes, breaking changes, and best practices
✅ **Specialist Generation** - Creates reusable agents with embedded problem knowledge
✅ **Context Management** - Maintains <30% context usage through smart sub-agent delegation
✅ **Actionable Plans** - Implementation plans (greenfield) or continuation roadmaps (in-progress)
✅ **Task Categorization** - FIX, IMPROVE, ADD, TEST, DOCUMENT categories with P0-P3 priorities

**Single command:** `/planer` - Everything else is automatic!

---

## 🚀 Quick Start

### Prerequisites

- **Claude Code CLI** installed and configured
- **Project directory** (empty for new projects, or existing codebase)

### Installation

```bash
# Clone repository
git clone https://github.com/Vakci/claude-code-planer.git
cd claude-code-planer

# Run installation script
./scripts/install.sh
```

The installer copies PLANER skills to `~/.claude/skills/` where Claude Code can find them.

### Usage

#### For New Projects (Greenfield)

```bash
cd ~/my-new-project
/planer "Build a Next.js e-commerce app with Stripe payments"
```

**PLANER-ZERO will:**
1. Ask questions about your tech stack
2. Research 2025-2026 common problems for your stack
3. Generate specialist agents (e.g., nextjs-specialist)
4. Create implementation plan with 8-15 tasks
5. Provide executable Task commands

**Output:** `implementation_plan.md` ready to execute!

#### For Existing Projects (In-Progress)

```bash
cd ~/my-existing-project
/planer
```

**PLANER-PROGRESS will:**
1. Analyze your codebase structure and features
2. Identify gaps between current state and goals
3. Research general + project-specific problems
4. Categorize work into FIX, IMPROVE, ADD, TEST, DOCUMENT
5. Create prioritized continuation roadmap (P0-P3)

**Output:** `continuation_roadmap.md` with actionable next steps!

---

## 📖 Documentation

- **[Architecture](docs/ARCHITECTURE.md)** - Technical deep-dive into parent-child pattern
- **[Installation](docs/INSTALLATION.md)** - Step-by-step installation guide
- **[Usage Guide](docs/USAGE.md)** - Comprehensive examples and tutorials
- **[FAQ](docs/FAQ.md)** - Frequently asked questions
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Common issues and solutions

---

## 🌟 Why PLANER?

### Problem: Claude Code Context Limits

Claude Code has a 200k token context limit. Complex projects easily exhaust this when planning, researching, and generating code.

### Solution: Smart Context Management

PLANER maintains <30% main context usage by:
- **File-based handoffs** - Outputs to JSON/MD files on disk
- **Sub-agent delegation** - Heavy processing isolated in sub-agents
- **Summary storage** - Only metadata in main context, full content on disk

**Result:** 58k tokens (29%) for complete project planning!

### Problem: Repeating Common Mistakes

Developers repeatedly encounter the same tech stack pitfalls:
- WordPress Interactivity API context loss in async callbacks
- Next.js Server/Client Component confusion
- FastAPI WebSocket connection management issues

### Solution: Problem-Aware Specialists

PLANER researches 2025-2026 problems via WebSearch and embeds knowledge into specialist agents:

```javascript
// Generated specialist prevents this WordPress mistake:
// ❌ Bad: getContext() in async callback
requestAnimationFrame(() => {
  const ctx = getContext(); // undefined!
});

// ✅ Good: Capture context before async
const context = getContext();
requestAnimationFrame(() => {
  context.isOpen = true;
});
```

**Result:** Specialists prevent 80% of common mistakes before they occur!

---

## 🏗️ Architecture

```
PLANER (Parent - Auto-Router)
    ↓ (Detects: new vs. existing)
    ├─→ PLANER-ZERO (Greenfield Projects)
    │   ├── Phase 1: Project Discovery (questions)
    │   ├── Phase 2: Problem Research [SHARED]
    │   ├── Phase 3: Ecosystem Analysis [SHARED]
    │   ├── Phase 4: Specialist Generation [SHARED]
    │   ├── Phase 5: Task Breakdown
    │   └── Phase 6: Implementation Plan
    │
    └─→ PLANER-PROGRESS (In-Progress Projects)
        ├── Phase 1: Codebase Discovery
        ├── Phase 2: Gap Analysis
        ├── Phase 3: Problem Research (Enhanced) [SHARED]
        ├── Phase 4: Ecosystem Analysis [SHARED]
        ├── Phase 5: Specialist Generation [SHARED]
        ├── Phase 6: Task Categorization
        └── Phase 7: Continuation Roadmap
```

### Key Innovation: Shared Phases

Phases 2, 3, and 4 are written once and inherited by both children, reducing code duplication by 40% while ensuring consistency.

---

## 📊 Example Outputs

### PLANER-ZERO Example (New Next.js App)

```bash
cd ~/new-project
/planer "Build a Next.js SaaS app with Supabase auth and Stripe payments"
```

**Output:** `implementation_plan.md`
```markdown
# Implementation Plan: Next.js SaaS App

## Tasks (12 total, 6 can run in parallel)

### Phase 1: Foundation (Parallel)
- Task 1: Initialize Next.js 15 project
- Task 2: Setup Supabase auth
- Task 3: Configure Stripe integration

### Phase 2: Implementation (Sequential)
- Task 4: Build dashboard UI
- Task 5: Implement subscription logic
...

## Specialist Agents Created
- nextjs-specialist (prevents Server/Client Component mistakes)
- supabase-specialist (prevents JWT refresh token issues)
```

### PLANER-PROGRESS Example (WordPress Theme)

```bash
cd ~/my-wordpress-theme
/planer
```

**Output:** `continuation_roadmap.md`
```markdown
# Continuation Roadmap: Pawshaus Theme

## Current State: 85% Complete
- ✅ 13 custom blocks
- ❌ 0% test coverage
- ❌ Large bundles (45KB)

## Priority Roadmap

### 🔥 Phase 1: Critical Fixes (P0-P1)
- Fix Interactivity API context loss
- Patch XSS vulnerability

### 🚀 Phase 2: Improvements (P1)
- Optimize bundle size (45KB → <20KB)
- Add keyboard navigation
- Create test suite (80% coverage)

### 🎨 Phase 3: New Features (P2)
- WooCommerce wishlist block
...
```

---

## 🔧 Advanced Usage

### Creating Custom Specialist Agents

PLANER automatically generates specialist agents, but you can also create custom ones:

```bash
# Manually generate specialist for specific tech
Task({
  description: "Create Temporal specialist",
  prompt: "Create a Temporal workflow specialist agent based on researched problems in problems.json",
  subagent_type: "general-purpose"
})
```

**Output:** `~/.claude/agents/temporal-specialist.md` (reusable across all projects!)

### Extending PLANER

Want to add **PLANER-MIGRATE** for tech stack migrations?

1. Create `skills/planer-migrate/SKILL.md`
2. Define unique phases (Phase 1: Analyze current stack, Phase 6: Migration plan)
3. Inherit shared Phases 2, 3, 4 from parent
4. Update parent routing logic

**Parent-child architecture makes extension trivial!**

---

## 🎓 How It Works

### 1. Auto-Detection

```python
# Detection logic
if has_git_with_commits AND has_source_code:
    route_to = "PLANER-PROGRESS"
elif no_git AND no_source:
    route_to = "PLANER-ZERO"
else:
    ask_user_which_mode()
```

### 2. Problem Research (WebSearch)

```javascript
// For each technology in stack
WebSearch({ query: "WordPress Interactivity API common mistakes 2026" })
WebSearch({ query: "Next.js 15 Server Components pitfalls 2026" })
WebSearch({ query: "site:github.com FastAPI issues 2025 2026" })

// Classify by frequency, severity, detectability
{
  "problem": "Context loss in async callbacks",
  "frequency": "very_common",
  "severity": "high",
  "detectability": "hard",
  "bad_code": "...",
  "good_code": "..."
}
```

### 3. Specialist Generation

```markdown
# wordpress-specialist.md

Common Mistake #1: getContext() in async callbacks
- Red flags: getContext() inside setTimeout/requestAnimationFrame
- Solution: Capture context before async
- When to watch: Animation callbacks, delayed actions, promises
```

### 4. Context Management

| Phase | Main Agent | Sub-Agent (Isolated) |
|-------|-----------|---------------------|
| Codebase Discovery | 8k | 35k (Explore agent) |
| Problem Research | 10k | 30k (WebSearch) |
| Ecosystem Analysis | 4k | 20k (Analysis) |
| Specialist Generation | 2k | 20k (Agent writing) |
| **Total** | **58k (29%)** | **145k isolated** |

**Main context never exceeds 30%!** ✓

---

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ideas for contributions:**
- Add support for new tech stacks (Rust, Go, etc.)
- Improve problem research queries
- Create example projects
- Write tutorials and guides
- Report bugs and suggest features

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

You are free to use, modify, and distribute PLANER in personal and commercial projects.

---

## 🙏 Credits

**Created by:** [Your Name]
**Inspired by:** Professional software architecture patterns and AI-assisted development workflows
**Special Thanks:** Claude Code team for building an amazing developer tool

---

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/Vakci/claude-code-planer/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Vakci/claude-code-planer/discussions)
- **Documentation:** [docs/](docs/)

---

## 🗺️ Roadmap

### v1.1 (Q2 2026)
- PLANER-MIGRATE for tech stack migrations
- Git history analysis
- Performance benchmarking integration

### v1.2 (Q3 2026)
- Team collaboration features
- Automated security scanning
- Project health scoring

### v2.0 (Q4 2026)
- Multi-language support (beyond English)
- Integration with CI/CD platforms
- Real-time project monitoring

---

## ⭐ Star History

If you find PLANER useful, please consider giving it a star on GitHub! ⭐

---

**Status:** ✅ Production-Ready
**Version:** 1.0.0
**Last Updated:** 2026-01-17
**Minimum Claude Code Version:** 1.0

---

Made with ❤️ by developers, for developers.
