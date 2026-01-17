---
name: planer-progress
description: Master orchestration for continuing existing projects. Analyzes codebase, identifies gaps, researches problems (general + project-specific), and creates prioritized continuation roadmaps. Use when working on in-progress projects.
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, TodoWrite, AskUserQuestion, Task, WebSearch, Write
---

# PLANER-PROGRESS: Project Continuation Orchestration

## Overview

**PLANER-PROGRESS** is your master orchestrator for **continuing existing projects**. While PLANER-ZERO starts from scratch, PLANER-PROGRESS picks up where you left off - analyzing your codebase, identifying gaps, researching both general and project-specific problems, and creating actionable continuation roadmaps.

**Parent:** PLANER (auto-routes to this skill for existing projects)

**Key Innovation:** Combines codebase analysis with 2026 problem research to create **problem-aware continuation plans** that prevent common mistakes while guiding you toward completion.

---

## When to Use This Skill

Invoke `/planer-progress` (or let parent `/planer` auto-route) when:

✅ **Continuing existing project** (has .git + commits + source code)
✅ **Inherited codebase** you didn't write
✅ **Mid-development** need to assess progress and plan next steps
✅ **Stuck on project** unsure what to do next
✅ **Want roadmap** to completion or next milestone
✅ **Need gap analysis** between current state and goals

❌ **Don't use for:**
- Brand new projects (use PLANER-ZERO instead)
- Simple bug fixes (use relevant specialist directly)
- Projects with no existing code

---

## Workflow: 7 Phases

```
Phase 1: Codebase Discovery
    ↓ (Explore agent analyzes existing code)
Phase 2: Gap Analysis
    ↓ (Ask user about goals)
Phase 3: Problem Research [SHARED from parent]
    ↓ (WebSearch for tech stack + existing code issues)
Phase 4: Ecosystem Analysis [SHARED from parent]
    ↓ (Identify existing tools + gaps)
Phase 5: Specialist Generation [SHARED from parent]
    ↓ (Create problem-aware agents if needed)
Phase 6: Task Categorization
    ↓ (Break into FIX, IMPROVE, ADD, TEST, DOCUMENT)
Phase 7: Continuation Roadmap
    ↓ (Prioritized actionable plan with commands)
```

**Context Budget:** Main context <30% (58k tokens), Sub-agents isolated (145k)

---

## Phase 1: Codebase Discovery & Analysis

**Goal:** Understand what exists, what works, what's broken, what's incomplete

**Approach:** Use Task tool with Explore agent to analyze the codebase

### 1.1 Project Structure Analysis

Use Task tool to delegate structure analysis:

```javascript
Task({
  description: "Analyze project structure",
  prompt: `Analyze this project and identify:

  1. Project type (WordPress theme, Next.js app, FastAPI backend, etc.)
  2. Tech stack (frameworks, libraries, build tools, languages)
  3. Directory structure and organization patterns
  4. Entry points and main configuration files
  5. Build system (webpack, vite, npm scripts, etc.)
  6. Estimated project size (files, LOC, complexity)

  Provide a comprehensive overview in JSON format matching the template:
  {
    "project_type": "...",
    "tech_stack": {...},
    "directory_structure": {...},
    "entry_points": {...},
    "estimated_size": {...}
  }

  Output this to a file named: project_structure.json`,
  subagent_type: "Explore",
  model: "sonnet"
})
```

**Output:** `project_structure.json` (~3k tokens)

### 1.2 Feature Inventory

```javascript
Task({
  description: "Catalog all features",
  prompt: `Catalog all implemented features in this project:

  1. List all major components/modules and their functionality
  2. Identify integrations with third-party services
  3. Find API endpoints, routes, or custom blocks
  4. Map database schemas or data models
  5. Identify UI components and pages
  6. Estimate completion status for each feature

  Output format: feature_inventory.json with structure:
  {
    "features": [
      {
        "name": "...",
        "type": "component | integration | endpoint | etc",
        "status": "complete | partial | broken",
        "dependencies": [],
        "description": "..."
      }
    ],
    "total_features": N,
    "completion_estimate": "X%"
  }`,
  subagent_type: "Explore",
  model: "sonnet"
})
```

**Output:** `feature_inventory.json` (~3k tokens)

### 1.3 Code Quality Scan

```javascript
Task({
  description: "Scan code quality",
  prompt: `Scan the codebase for quality indicators:

  1. TODO/FIXME comments (incomplete work)
  2. Console.log/var_dump (debug code left behind)
  3. Deprecated function usage
  4. Missing error handling patterns
  5. Security concerns (unescaped output, unsanitized input)
  6. Performance issues (N+1 queries, large bundle sizes)
  7. Code duplication
  8. Complexity hotspots

  Classify findings by severity: critical, high, medium, low

  Output format: quality_report.json`,
  subagent_type: "Explore",
  model: "sonnet"
})
```

**Output:** `quality_report.json` (~2k tokens)

**Phase 1 Total Output:** 8k tokens stored in main context (summaries only)

---

## Phase 2: Gap Analysis

**Goal:** Identify what's built vs. what's needed/planned

**Approach:** Ask user about goals, compare against standards

### 2.1 User Requirements Clarification

Use `AskUserQuestion` to understand project goals:

```javascript
AskUserQuestion({
  questions: [
    {
      question: "What is the primary goal for this project's next phase?",
      header: "Project Goal",
      multiSelect: false,
      options: [
        {
          label: "Complete Existing Features",
          description: "Finish incomplete work, fix bugs, polish what exists"
        },
        {
          label: "Add New Features",
          description: "Extend functionality with new capabilities"
        },
        {
          label: "Refactor & Optimize",
          description: "Improve code quality, performance, security"
        },
        {
          label: "Prepare for Launch",
          description: "Testing, documentation, deployment readiness"
        }
      ]
    },
    {
      question: "What specific areas need attention? (Select all that apply)",
      header: "Priorities",
      multiSelect: true,
      options: [
        {
          label: "Performance Optimization",
          description: "Faster load times, smaller bundles, better metrics"
        },
        {
          label: "Accessibility (a11y)",
          description: "WCAG compliance, keyboard nav, screen readers"
        },
        {
          label: "Security Hardening",
          description: "Input validation, output escaping, vulnerability fixes"
        },
        {
          label: "Testing & Quality",
          description: "Unit tests, integration tests, E2E tests, CI/CD"
        },
        {
          label: "Documentation",
          description: "Developer docs, user guides, inline comments"
        },
        {
          label: "Bug Fixes",
          description: "Fix known issues and broken functionality"
        }
      ]
    },
    {
      question: "Are there any known critical bugs or blockers?",
      header: "Critical Issues",
      multiSelect: false,
      options: [
        {
          label: "Yes - Critical bugs",
          description: "Blocking issues that need immediate attention"
        },
        {
          label: "Yes - Minor issues",
          description: "Small bugs that should be fixed when possible"
        },
        {
          label: "No known issues",
          description: "Everything works as expected currently"
        }
      ]
    }
  ]
})
```

### 2.2 Standards Comparison

Based on project type detected in Phase 1, check for missing standard features:

**For WordPress Block Theme:**
- Automated testing (PHPUnit, Jest)
- Internationalization (i18n)
- RTL support
- Performance monitoring
- CI/CD pipeline

**For Next.js App:**
- Error boundaries
- Loading states
- SEO optimization (metadata, sitemap)
- Analytics integration
- E2E tests

**For FastAPI Backend:**
- API documentation (OpenAPI)
- Authentication/authorization
- Rate limiting
- Logging and monitoring
- Database migrations

### 2.3 Gap Analysis Output

Write `gap_analysis.json`:

```json
{
  "user_goals": {
    "primary_goal": "Complete Existing Features",
    "priorities": ["Performance Optimization", "Testing & Quality"]
  },
  "feature_gaps": {
    "critical": [
      {
        "feature": "Automated Testing",
        "why_important": "Prevent regressions, ensure quality",
        "estimated_effort": "medium",
        "priority": "high"
      }
    ],
    "recommended": [...],
    "nice_to_have": [...]
  },
  "incomplete_work": [
    {
      "item": "Feature X not fully implemented",
      "source": "TODO comment in code",
      "priority": "medium"
    }
  ],
  "technical_debt": [
    {
      "item": "Large bundle size",
      "impact": "Slow mobile performance",
      "recommendation": "Code splitting, lazy loading",
      "priority": "high"
    }
  ]
}
```

**Phase 2 Output:** 6k tokens

---

## Phase 3: Problem Research (Enhanced) [SHARED]

**Goal:** Research BOTH general tech stack issues AND existing codebase-specific problems

**Approach:** Two-pronged WebSearch strategy

This phase inherits the shared logic from parent PLANER (`shared/phase-2-problem-research.md`), but **enhances** it with project-specific research.

### 3.1 General Tech Stack Research

Same as PLANER-ZERO Phase 2:
- WebSearch for common mistakes in detected tech stack (2025-2026)
- Breaking changes
- Best practices
- Security vulnerabilities

### 3.2 NEW: Project-Specific Problem Research

**Pattern-Based Searches:**

Based on quality_report.json findings:

```javascript
// If found: "Large JavaScript bundle (45KB)"
WebSearch({
  query: "webpack code splitting optimization 2026"
})
WebSearch({
  query: "[framework] bundle size reduction techniques 2026"
})

// If found: "Missing error handling"
WebSearch({
  query: "[framework] error handling best practices 2026"
})

// If found: "WooCommerce AJAX cart"
WebSearch({
  query: "WooCommerce AJAX cart security 2026"
})
```

**Technology-Specific Deep Dives:**

```javascript
// For discovered tech stack
WebSearch({
  query: "WordPress 6.8 Interactivity API breaking changes"
})
WebSearch({
  query: "@wordpress/scripts webpack 5 migration issues 2026"
})
WebSearch({
  query: "WooCommerce 8.x compatibility WordPress 6.8"
})
```

### 3.3 Enhanced Output

Write `problems.json` with both general and project-specific sections:

```json
{
  "research_date": "2026-01-17",
  "project_specific_problems": [
    {
      "problem": "Large JavaScript bundle affecting mobile",
      "current_state": "45KB bundle for hero-slider.js",
      "why": "Webpack bundling all dependencies, no code splitting",
      "solution": "Implement dynamic imports",
      "bad_code": "import { all } from 'library';",
      "good_code": "const lib = await import('library');",
      "impact": "3-5s faster on 3G",
      "files_affected": ["hero-slider.js"],
      "priority": "high"
    }
  ],
  "general_tech_problems": [
    // Same format as PLANER-ZERO
  ]
}
```

**Phase 3 Output:** 10k tokens

---

## Phase 4: Ecosystem Analysis [SHARED]

**Goal:** Identify existing tools and gaps

This phase is inherited from parent PLANER (`shared/phase-3-ecosystem-analysis.md`).

Use Task tool with general-purpose agent:

```javascript
Task({
  description: "Analyze tool ecosystem",
  prompt: `Read project_structure.json, feature_inventory.json, and problems.json.

  Based on the tech stack and researched problems:
  1. Identify existing Claude Code agents/skills that match project needs
  2. Identify gaps - missing specialists for key technologies
  3. Recommend which agents to use for each task category
  4. Suggest custom tools to create (if gaps found)

  Output: tool_inventory.json`,
  subagent_type: "general-purpose",
  model: "sonnet"
})
```

**Output:** `tool_inventory.json` (4k tokens)

---

## Phase 5: Specialist Agent Generation [SHARED]

**Goal:** Create reusable problem-aware specialist agents

This phase is inherited from parent PLANER (`shared/phase-4-specialist-generation.md`).

For each gap identified in Phase 4:
1. Extract relevant problems from `problems.json`
2. Generate agent using template
3. Write to `~/.claude/agents/[technology]-specialist.md`
4. Ask user for approval

**Output:** Specialist agent files (disk) + metadata (2k tokens in main context)

---

## Phase 6: Task Categorization & Prioritization

**Goal:** Break work into categorized, prioritized tasks

**Task Categories:**

1. **FIX** - Bugs, security issues, critical problems
2. **IMPROVE** - Performance, accessibility, code quality
3. **REFACTOR** - Technical debt, code organization
4. **ADD** - New features, functionality
5. **TEST** - Automated tests, quality assurance
6. **DOCUMENT** - Docs, comments, guides
7. **DEPLOY** - CI/CD, production readiness

### Prioritization Matrix

| Priority | Criteria | Examples |
|----------|----------|----------|
| **P0 - Critical** | Security vulnerabilities, broken core functionality, data loss risk | XSS vulnerability, auth bypass, database corruption |
| **P1 - High** | Major bugs, significant performance issues, user-facing problems | Broken checkout, slow page loads, missing features |
| **P2 - Medium** | User-requested features, moderate technical debt, minor bugs | New wishlist feature, refactor old code, style fixes |
| **P3 - Low** | Nice-to-have features, documentation, non-critical improvements | Dark mode, extra docs, code comments |

### Task Breakdown Process

Analyze all data from previous phases:
- quality_report.json → FIX tasks
- gap_analysis.json → ADD, IMPROVE tasks
- problems.json → Preventive IMPROVE tasks
- user_goals → Prioritization

Write `task_roadmap.json`:

```json
{
  "tasks_by_category": {
    "FIX": [
      {
        "id": "fix_001",
        "priority": "P1",
        "name": "Fix Interactivity API context loss",
        "description": "Capture context before requestAnimationFrame",
        "agent_recommendation": "wordpress-specialist",
        "estimated_context": "10k",
        "files_affected": [
          "blocks/scroll-progress/view.js",
          "blocks/product-gallery/view.js"
        ],
        "problem_prevented": "Runtime undefined errors",
        "task_command": "Use Task tool with wordpress-specialist"
      }
    ],
    "IMPROVE": [
      {
        "id": "improve_001",
        "priority": "P1",
        "name": "Optimize JavaScript bundle size",
        "description": "Implement code splitting and lazy loading",
        "agent_recommendation": "general-purpose",
        "estimated_context": "15k",
        "files_affected": ["webpack.config.js", "blocks/*/view.js"],
        "impact": "3-5s faster mobile load time"
      }
    ],
    "ADD": [...],
    "TEST": [...],
    "DOCUMENT": [...]
  },
  "execution_phases": {
    "phase_1_critical": {
      "tasks": ["fix_001"],
      "parallelizable": false,
      "priority": "P0-P1"
    },
    "phase_2_improvements": {
      "tasks": ["improve_001", "improve_002", "test_001"],
      "parallelizable": true,
      "priority": "P1"
    },
    "phase_3_features": {
      "tasks": ["add_001"],
      "parallelizable": false,
      "priority": "P2"
    },
    "phase_4_polish": {
      "tasks": ["doc_001"],
      "parallelizable": true,
      "priority": "P2-P3"
    }
  },
  "total_tasks": 8,
  "by_priority": {
    "P0": 0,
    "P1": 4,
    "P2": 3,
    "P3": 1
  }
}
```

**Phase 6 Output:** 10k tokens

---

## Phase 7: Continuation Roadmap

**Goal:** Final actionable plan with priorities and executable commands

**Format:** Markdown file with:
- Executive summary (what exists, what's missing)
- Priority roadmap (phases with tasks)
- Executable commands for each task
- Problem-aware development notes
- Success metrics (before/after)
- Technical debt backlog

Write `continuation_roadmap.md`:

````markdown
# Continuation Roadmap: [Project Name]

**Generated:** [date]
**By:** PLANER-PROGRESS v1.0
**Project Type:** [from Phase 1]
**Current Completion:** [from Phase 2]

---

## Executive Summary

**What Exists:**
- ✅ [Major features from feature_inventory.json]
- ✅ [Tech stack components]
- ✅ [Integrations]

**What's Missing:**
- ❌ [Critical gaps from gap_analysis.json]
- ❌ [Recommended features]
- ❌ [Standard features for project type]

**Critical Issues Found:**
- 🔴 **P1:** [Issue from quality_report.json]
- 🟡 **P2:** [Issue]

---

## Priority Roadmap

### 🔥 Phase 1: Critical Fixes (Start Immediately)

**Goal:** Fix breaking issues, prevent runtime errors

#### Task: [Task Name from FIX category]
- **Priority:** P1 - High
- **Problem:** [Description]
- **Files:** [files_affected]
- **Agent:** [agent_recommendation]
- **Command:**
  ```javascript
  Task({
    description: "[Short description]",
    prompt: "[Detailed task description]",
    subagent_type: "[agent]",
    model: "sonnet"
  })
  ```
- **Success Criteria:** [Criteria]

---

### 🚀 Phase 2: High-Priority Improvements (Parallel Execution)

**Goal:** Optimize performance, improve quality, add tests

[Repeat task format for IMPROVE category tasks]

**Run in parallel:**
```javascript
// Launch multiple tasks concurrently
Task({ description: "Optimize bundle", ... })
Task({ description: "Add keyboard nav", ... })
Task({ description: "Create tests", ... })
```

---

### 🎨 Phase 3: New Features (Sequential)

**Goal:** Extend functionality

[Tasks from ADD category]

---

### 📚 Phase 4: Documentation & Polish (Parallel)

**Goal:** Developer docs, deployment guides

[Tasks from DOCUMENT category]

---

## Problem-Aware Development

### Specialist Agents Available

Based on your [tech stack] stack:

1. **[technology]-specialist** (`~/.claude/agents/[technology]-specialist.md`)
   - ✅ Prevents [key problems from problems.json]
   - **Use for:** [Use cases]

### Common Pitfalls We'll Prevent

Based on 2026 research + your codebase analysis:

#### [Technology]
- ❌ **[Problem]** → ✅ [Solution]
- ❌ **[Problem]** → ✅ [Solution]

---

## Execution Commands

### Quick Start (Critical Path)

```javascript
// 1. Fix critical issues first
Task({
  description: "Fix critical issues",
  prompt: "[Detailed description]",
  subagent_type: "[agent]"
})

// 2. Run improvements in parallel
// Launch multiple tasks at once
Task({ description: "Optimize performance", ... })
Task({ description: "Add tests", ... })

// 3. Add new features
Task({ description: "Implement feature X", ... })

// 4. Document everything
Task({ description: "Create docs", ... })
```

---

## Success Metrics

### Before PLANER-PROGRESS
- ❌ [Current state metrics]
- ❌ [Issues]

### After PLANER-PROGRESS
- ✅ [Target metrics]
- ✅ [Improvements]

---

## Technical Debt Backlog

Items not in critical path but should be addressed:

1. **[Item]** - Priority: P3, Effort: [Low/Medium/High]
2. **[Item]** - Priority: P3, Effort: [Low/Medium/High]

---

**Generated by:** PLANER-PROGRESS v1.0
**Research Date:** [date]
**Next Review:** After Phase 2 completion
````

**Phase 7 Output:** 18k tokens

---

## Context Management Strategy

**Goal:** Keep main agent context under 50% (100k tokens)

### Token Budget Breakdown

| Phase | Main Agent | Sub-Agent (Isolated) | Running Total |
|-------|-----------|---------------------|---------------|
| Codebase Discovery (1) | 8k summary | 35k exploration | 8k |
| Gap Analysis (2) | 6k | 15k comparison | 14k |
| Problem Research (3) | 10k summary | 30k WebSearch | 24k |
| Ecosystem Analysis (4) | 4k summary | 20k analysis | 28k |
| Specialist Generation (5) | 2k metadata | 20k agent writing | 30k |
| Task Categorization (6) | 10k | 25k planning | 40k |
| Continuation Roadmap (7) | 18k | 0 (direct write) | 58k |
| **Total Main Context** | **58k (29%)** | **145k isolated** | **58k** ✓ |

**Main Context Usage:** 58k / 200k = **29%** ✓ (well under 50% target)

**Strategy:**
- ✅ File-based handoffs (JSON on disk)
- ✅ Sub-agents for heavy processing (Explore, WebSearch)
- ✅ Only summaries in main context
- ✅ Full content stored as files or in sub-agent contexts

---

## Integration with Parent PLANER

PLANER-PROGRESS is invoked by parent PLANER when auto-detection finds:
- Existing .git directory with commits
- Source code files present
- Project appears to be in progress

**Parent routing logic:**
```javascript
// In parent PLANER SKILL.md
if (has_git_with_commits && has_source_code) {
  // Route to PLANER-PROGRESS
  Skill({
    skill: "planer-progress"
  })
}
```

---

## Success Criteria

### Must Have (V1.0)
- ✅ Analyze existing codebase structure
- ✅ Identify gaps between current state and goals
- ✅ Research both general and project-specific problems
- ✅ Create categorized task roadmap (FIX, IMPROVE, ADD, etc.)
- ✅ Generate continuation plan with priorities
- ✅ Maintain <50% main context usage

### Metrics
- Context usage: <30% ✓
- Phase completion: 7/7 phases
- Output quality: Actionable, prioritized, executable
- Problem prevention: Specialist agents with embedded knowledge

---

## Example Workflow

**User invokes:**
```bash
cd ~/my-wordpress-theme
/planer-progress
```

**PLANER-PROGRESS executes:**

1. **Phase 1:** Analyzes WordPress theme structure
   - Finds: 13 custom blocks, WooCommerce integration, FSE theme

2. **Phase 2:** Asks user about goals
   - User selects: "Optimize + Add Features"

3. **Phase 3:** Researches problems
   - General: WordPress Interactivity API issues (2026)
   - Project-specific: Large bundle (45KB) in hero-slider.js

4. **Phase 4:** Analyzes ecosystem
   - Found: wordpress-specialist matches needs

5. **Phase 5:** Uses existing specialist (or creates new)

6. **Phase 6:** Categorizes tasks
   - FIX: 2 critical issues
   - IMPROVE: 3 performance optimizations
   - ADD: 1 new feature (wishlist)
   - TEST: Create test suite

7. **Phase 7:** Generates roadmap
   - 🔥 Phase 1 (Critical): Fix context bugs
   - 🚀 Phase 2 (High): Optimize bundles, add tests
   - 🎨 Phase 3 (Medium): Add wishlist
   - 📚 Phase 4 (Polish): Documentation

**Output files:**
- `project_structure.json`
- `feature_inventory.json`
- `quality_report.json`
- `gap_analysis.json`
- `problems.json`
- `tool_inventory.json`
- `task_roadmap.json`
- `continuation_roadmap.md`

**User receives:** Clear, prioritized, actionable roadmap to project completion!

---

## Version History

**v1.0 (2026-01-17):**
- Initial implementation
- 7-phase workflow
- Problem-aware task categorization
- Context management <30%
- Integration with parent PLANER

---

**Created by:** PLANER Architecture Team
**Skill Version:** 1.0
**Last Updated:** 2026-01-17
