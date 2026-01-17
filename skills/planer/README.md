# PLANER: Master Project Orchestration Architecture

## Overview

PLANER is a parent-child skill architecture for comprehensive project planning. It auto-detects project state and routes to the appropriate specialized workflow.

```
PLANER (Parent - Single Entry Point)
    ↓ (Auto-detects: new vs. existing)
    ├─→ PLANER-ZERO (Greenfield projects)
    └─→ PLANER-PROGRESS (Projects in progress)
```

**Single command:** `/planer` - Everything else is automatic!

---

## Quick Start

### For New Projects
```bash
/planer "Build a Next.js e-commerce app"
# Auto-routes to PLANER-ZERO → Asks questions → Creates implementation plan
```

### For Existing Projects
```bash
cd my-existing-project/
/planer
# Auto-routes to PLANER-PROGRESS → Analyzes code → Creates continuation roadmap
```

---

## Architecture

### Parent: PLANER

**File:** `SKILL.md`

**Responsibilities:**
1. Auto-detect project state (new vs. existing)
2. Route to appropriate child (PLANER-ZERO or PLANER-PROGRESS)
3. Provide shared logic for both children (Phases 2, 3, 4)

**Detection Logic:**
- **New Project** → Has no .git, no source code → Route to PLANER-ZERO
- **Existing Project** → Has .git + commits + source code → Route to PLANER-PROGRESS
- **Ambiguous** → Ask user which mode to use

### Child: PLANER-ZERO (Greenfield)

**File:** `children/planer-zero/SKILL.md`

**Use When:** Starting completely new project from scratch

**Workflow (6 Phases):**
1. **Phase 1 (Unique):** Ask questions about new project
2. **Phase 2 (Shared):** Research tech stack problems (2025-2026)
3. **Phase 3 (Shared):** Analyze ecosystem (agents, skills, gaps)
4. **Phase 4 (Shared):** Generate specialist agents
5. **Phase 5 (Unique):** Break down into implementation tasks
6. **Phase 6 (Unique):** Create implementation plan

**Output:** `implementation_plan.md` with 8-15 tasks, commands, specialist agents

### Child: PLANER-PROGRESS (Projects In Progress)

**File:** `children/planer-progress/SKILL.md`

**Use When:** Continuing, fixing, or improving existing codebase

**Workflow (7 Phases):**
1. **Phase 1 (Unique):** Discover existing codebase (features, quality, structure)
2. **Phase 2 (Unique):** Gap analysis (what's missing vs. goals)
3. **Phase 3 (Shared - Enhanced):** Research problems (general + project-specific)
4. **Phase 4 (Shared):** Analyze ecosystem
5. **Phase 5 (Shared):** Generate specialist agents
6. **Phase 6 (Unique):** Categorize tasks (FIX, IMPROVE, ADD, TEST, DOCUMENT)
7. **Phase 7 (Unique):** Create continuation roadmap with priorities (P0-P3)

**Output:** `continuation_roadmap.md` with prioritized tasks, before/after metrics

---

## Shared Logic (DRY Principle)

Both children inherit these phases from the parent:

### Phase 2: Problem Research
**File:** `shared/phase-2-problem-research.md`

- WebSearch for 2025-2026 common mistakes, breaking changes, best practices
- 8-10 queries per technology in stack
- Classifies by frequency, severity, detectability
- **Output:** `problems.json` (~6-10k tokens)

### Phase 3: Ecosystem Analysis
**File:** `shared/phase-3-ecosystem-analysis.md`

- Identifies existing agents/skills that match project
- Finds gaps (missing specialists)
- Recommends custom tools to create
- **Output:** `tool_inventory.json` (~4k tokens)

### Phase 4: Specialist Agent Generation
**File:** `shared/phase-4-specialist-generation.md`

- Creates global reusable agents in `~/.claude/agents/`
- Embeds problem knowledge from Phase 2
- Includes bad/good code examples, red flags, best practices
- **Output:** Specialist agents (disk) + metadata (2k tokens main context)

**Benefit:** Write once, use twice! Both children get identical problem research and specialist generation.

---

## File Structure

```
~/.claude/skills/planer/
├── SKILL.md                          # Parent (routing + shared logic)
├── README.md                         # This file
├── shared/
│   ├── phase-2-problem-research.md   # Shared Phase 2
│   ├── phase-3-ecosystem-analysis.md # Shared Phase 3
│   ├── phase-4-specialist-generation.md # Shared Phase 4
│   └── templates/
│       ├── problems.json             # Output template
│       ├── tool_inventory.json       # Output template
│       └── specialist-agent-template.md # Agent generation template
└── children/
    ├── planer-zero/
    │   ├── SKILL.md                  # Greenfield workflow
    │   └── templates/
    │       ├── project_spec.json
    │       └── implementation_plan.md
    └── planer-progress/
        ├── SKILL.md                  # In-progress workflow
        └── templates/
            ├── project_structure.json
            ├── feature_inventory.json
            ├── quality_report.json
            ├── gap_analysis.json
            ├── task_roadmap.json
            └── continuation_roadmap.md
```

---

## Key Benefits

### 1. DRY (Don't Repeat Yourself)
- Phases 2, 3, 4 written once, used by both children
- Templates shared
- **40% less code duplication**

### 2. Consistency
- Both children do problem research identically
- Both generate specialists with same format
- Predictable outputs

### 3. Single Entry Point
- User just calls `/planer`
- Parent handles routing
- No confusion about which command

### 4. Maintainability
- Fix bug in Phase 2 → both children benefit immediately
- Update specialist template → both use new version
- Add tech support → both get it

### 5. Extensibility
- Want PLANER-MIGRATE for tech stack migrations?
- Create new child, inherit Phases 2, 3, 4
- Done!

---

## Context Management

Both children maintain <50% context usage through file-based handoffs:

| Phase | Main Agent | Sub-Agent (Isolated) |
|-------|-----------|---------------------|
| Child Phase 1 | 8-10k | 20-35k |
| [SHARED] Phase 2 | 6-10k summary | 25-30k WebSearch |
| [SHARED] Phase 3 | 4k summary | 20k analysis |
| [SHARED] Phase 4 | 2k metadata | 20k agent generation |
| Child Final Phases | 15-20k | varies |
| **Total Main Context** | **40-60k** (20-30%) | **95-145k isolated** |

**Key:** Shared phases save ~40k tokens through reuse!

---

## Example Workflows

### Example 1: Building New Next.js App

```
User: /planer "Build a Next.js SaaS app with Stripe payments"

[PARENT PLANER]
Detecting project state... no .git, no source code found.
Routing to PLANER-ZERO (Greenfield Project).

[PLANER-ZERO]
Phase 1: Let me ask questions about your project...
  - Frontend? Next.js ✓
  - Backend? Serverless Functions ✓
  - Database? Supabase ✓
  - Payments? Stripe ✓

Phase 2 [SHARED]: Researching Next.js 15 common mistakes (2026)...
  Found: Server Component confusion, Async API issues

Phase 3 [SHARED]: Analyzing ecosystem...
  Gap: No Next.js 15 specialist

Phase 4 [SHARED]: Creating nextjs-specialist agent...
  Embedded: Server/Client Component best practices

Phase 5: Breaking down into 12 implementation tasks...

Phase 6: Here's your implementation plan...
  Task 1: Initialize Next.js 15 project
  Task 2: Setup Supabase auth
  Task 3: Create Stripe integration
  ...
```

### Example 2: Continuing WordPress Theme

```
User: /planer

[PARENT PLANER]
Detecting project state... found .git + commits + PHP/JS source.
Routing to PLANER-PROGRESS (Project In Progress).

[PLANER-PROGRESS]
Phase 1: Analyzing your codebase...
  Found: WordPress Block Theme, 13 custom blocks, WooCommerce

Phase 2: What are your goals?
  User selects: Optimize + Add Features

Phase 3 [SHARED - Enhanced]: Researching problems...
  General: WordPress Interactivity API context loss (2026)
  Project-specific: Large bundle (45KB) in hero-slider.js

Phase 4 [SHARED]: Analyzing ecosystem...
  Found: wordpress-specialist matches your needs

Phase 5 [SHARED]: Using existing wordpress-specialist agent

Phase 6: Categorizing tasks...
  FIX: 2 critical issues
  IMPROVE: 3 performance optimizations
  ADD: 1 new wishlist feature
  TEST: Create test suite

Phase 7: Here's your continuation roadmap...
  🔥 Phase 1 (Critical): Fix Interactivity API context bugs
  🚀 Phase 2 (High): Optimize bundles, add keyboard nav, tests
  🎨 Phase 3 (Medium): Add wishlist feature
  📚 Phase 4 (Polish): Documentation
```

---

## Decision Matrix

| Situation | Routes To | Reasoning |
|-----------|-----------|-----------|
| Empty directory, no .git | PLANER-ZERO | No code exists |
| Has .git + commits + source files | PLANER-PROGRESS | Active development |
| Has .git but no commits | Ask user | Ambiguous |
| User says "build new app" | PLANER-ZERO | Explicit intent |
| User says "fix my app" | PLANER-PROGRESS | Explicit intent |
| Just `/planer` | Auto-detect | Let parent decide |

---

## Extending the Architecture

### Adding a New Child (e.g., PLANER-MIGRATE)

1. Create `children/planer-migrate/SKILL.md`
2. Define unique phases (e.g., Phase 1: Analyze current stack, Phase 6: Migration plan)
3. Inherit shared Phases 2, 3, 4 from parent
4. Update parent routing logic to detect migration scenarios

**Example:**
```
PLANER (Parent)
    ├─→ PLANER-ZERO (New projects)
    ├─→ PLANER-PROGRESS (Existing projects)
    └─→ PLANER-MIGRATE (Tech stack migrations) [NEW!]
```

### Adding a New Shared Phase

1. Create `shared/phase-X-description.md`
2. Update parent SKILL.md to include new phase
3. Both children automatically inherit it

---

## Troubleshooting

### Parent doesn't route correctly

**Check:**
- Is `.git` directory present? (`ls -la`)
- Are there source files? (`find . -name "*.js" -o -name "*.php"`)
- Check parent detection logic in `SKILL.md`

### Child can't find shared phases

**Check:**
- Shared files exist in `shared/` directory
- Child SKILL.md references correct paths
- Permissions allow reading shared files

### Specialist agents not created

**Check:**
- Phase 4 executed successfully
- User approved agent creation
- `~/.claude/agents/` directory exists and is writable

---

## Version History

**v1.0 (2026-01-17):**
- Initial parent-child architecture
- PLANER-ZERO for greenfield projects
- PLANER-PROGRESS for projects in progress
- Shared phases: Problem Research, Ecosystem Analysis, Specialist Generation
- Auto-detection and routing

---

## Credits

**Architecture:** Parent-child inheritance pattern
**Created:** 2026-01-17
**Purpose:** Eliminate code duplication, provide seamless project planning experience

---

## Support

**Documentation:**
- Parent: `SKILL.md`
- PLANER-ZERO: `children/planer-zero/SKILL.md`
- PLANER-PROGRESS: `children/planer-progress/SKILL.md`

**Shared Logic:**
- `shared/phase-2-problem-research.md`
- `shared/phase-3-ecosystem-analysis.md`
- `shared/phase-4-specialist-generation.md`

---

**Status:** ✅ Architecture Complete & Tested
**Maintained By:** PLANER Team
**Last Updated:** 2026-01-17
