---
name: planer
description: Master project orchestration - auto-detects project state and routes to PLANER-ZERO (greenfield) or PLANER-PROGRESS (in-progress). Single entry point for all project planning.
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, TodoWrite, AskUserQuestion, Task, WebSearch, Write
---

# PLANER: Master Project Orchestration

## Overview

**PLANER** is your unified entry point for project planning. It automatically detects whether you're starting a new project or continuing an existing one, then routes to the appropriate specialized workflow:

- **PLANER-ZERO** → For greenfield (new) projects
- **PLANER-PROGRESS** → For projects in progress

Both children share common phases (Problem Research, Ecosystem Analysis, Specialist Generation) managed by this parent skill.

---

## Usage

```bash
# Auto-detects and routes appropriately
/planer

# Or provide context
/planer "Build a Next.js e-commerce app"
/planer "Continue my WordPress theme"
```

---

## Auto-Detection Logic

When you invoke `/planer`, the parent automatically detects project state:

### Detection Rules

```python
# Checks performed:
1. Does .git directory exist with commits?
2. Are there package/dependency files? (package.json, composer.json, requirements.txt, etc.)
3. Are there source code files? (*.js, *.php, *.py, *.tsx, etc.)
4. Are there build artifacts or config files?

# Decision matrix:
if has_git_with_commits AND has_source_code:
    route_to = "PLANER-PROGRESS"  # Existing project
elif no_git AND no_source:
    route_to = "PLANER-ZERO"  # New project
else:
    ask_user_which_mode()  # Ambiguous state
```

### Project State Detection

**New Project (PLANER-ZERO):**
- Empty directory or no git history
- No package/dependency files
- No source code files
- User explicitly says "build new" or "start from scratch"

**Existing Project (PLANER-PROGRESS):**
- Has .git directory with commit history
- Has package.json, composer.json, or similar
- Has source code files (*.js, *.php, *.py, etc.)
- User explicitly says "continue" or "improve existing"

**Ambiguous (Ask User):**
- Has .git but no commits (just initialized)
- Has only config files, no actual source code
- Cannot determine intent from context

---

## Routing Implementation

When invoked, PLANER:

1. **Detects project state** using rules above
2. **Announces routing decision** to user
3. **Delegates to appropriate child** (PLANER-ZERO or PLANER-PROGRESS)
4. **Child executes its workflow** using shared phases from parent

---

## Shared Phases (Inherited by Both Children)

The following phases are shared between PLANER-ZERO and PLANER-PROGRESS. Both children execute these identically.

### Phase 2: Problem Research (Shared)

**File:** `shared/phase-2-problem-research.md`

**Goal:** Research recent common problems, pitfalls, and best practices for the tech stack (2025-2026)

**Process:**
1. Identify technologies in project (from child's Phase 1)
2. Run 8-10 WebSearch queries per technology
3. Classify problems by frequency, severity, detectability
4. Output `problems.json` (6-10k tokens)

**Queries:**
- "[Technology] common mistakes 2026"
- "[Technology] pitfalls 2025 2026"
- "site:github.com [Technology] issues 2025 2026"
- "[Technology] breaking changes 2025"
- "[Technology] security best practices 2026"

**Used by:**
- PLANER-ZERO: After user answers questions about new project
- PLANER-PROGRESS: After codebase discovery identifies tech stack

---

### Phase 3: Ecosystem Analysis (Shared)

**File:** `shared/phase-3-ecosystem-analysis.md`

**Goal:** Identify existing agents/skills and gaps

**Process:**
1. Read project spec + problems.json
2. Identify existing tools that match project needs
3. Find gaps - missing specialists
4. Recommend custom tools to create
5. Output `tool_inventory.json` (4k tokens)

**Used by:**
- PLANER-ZERO: Identifies tools for greenfield implementation
- PLANER-PROGRESS: Identifies tools for code analysis, refactoring, testing

---

### Phase 4: Specialist Agent Generation (Shared)

**File:** `shared/phase-4-specialist-generation.md`

**Goal:** Create reusable, problem-aware specialist agents

**Process:**
1. Read `problems.json` from Phase 2
2. For each gap in `tool_inventory.json`:
   - Extract relevant problems for that technology
   - Generate agent using template
   - Write to `~/.claude/agents/[technology]-specialist.md`
3. Ask user for approval
4. Store metadata only in main context (2k tokens)

**Template:** `shared/templates/specialist-agent-template.md`

**Output:**
- Global agent files in `~/.claude/agents/`
- Metadata in main context (agent names + capabilities)

**Used by:**
- PLANER-ZERO: Creates specialists for new project technologies
- PLANER-PROGRESS: Creates specialists or uses existing ones

---

## Child Workflows

### PLANER-ZERO (Greenfield Projects)

**Location:** `children/planer-zero/`

**Workflow:**
1. **Phase 1 (Unique):** Project Discovery via questions
   - Ask about: Frontend, Backend, Database, Auth, etc.
   - Output: `project_spec.json`

2. **Phase 2 (Shared):** Problem Research
   - Use shared phase from parent
   - Output: `problems.json`

3. **Phase 3 (Shared):** Ecosystem Analysis
   - Use shared phase from parent
   - Output: `tool_inventory.json`

4. **Phase 4 (Shared):** Specialist Generation
   - Use shared phase from parent
   - Output: Specialist agents

5. **Phase 5 (Unique):** Task Breakdown
   - Break project into 8-15 implementation tasks
   - Create dependency graph
   - Output: `task_dag.json`

6. **Phase 6 (Unique):** Implementation Plan
   - Assemble final plan with commands
   - Output: `implementation_plan.md`

**See:** `children/planer-zero/SKILL.md` for details

---

### PLANER-PROGRESS (Projects In Progress)

**Location:** `children/planer-progress/`

**Workflow:**
1. **Phase 1 (Unique):** Codebase Discovery
   - Analyze existing code structure
   - Catalog features, blocks, integrations
   - Scan for quality issues
   - Output: `project_structure.json`, `feature_inventory.json`, `quality_report.json`

2. **Phase 2 (Unique):** Gap Analysis
   - Ask user about goals
   - Compare existing vs. standards
   - Identify incomplete work, technical debt
   - Output: `gap_analysis.json`

3. **Phase 3 (Shared - Enhanced):** Problem Research
   - Use shared phase from parent
   - PLUS: Search for problems specific to existing codebase patterns
   - Output: `problems.json` (enhanced with project-specific issues)

4. **Phase 4 (Shared):** Ecosystem Analysis
   - Use shared phase from parent
   - Output: `tool_inventory.json`

5. **Phase 5 (Shared):** Specialist Generation
   - Use shared phase from parent
   - Output: Specialist agents

6. **Phase 6 (Unique):** Task Categorization
   - Break work into: FIX, IMPROVE, ADD, REFACTOR, TEST, DOCUMENT
   - Assign priorities: P0 (critical) → P3 (low)
   - Output: `task_roadmap.json`

7. **Phase 7 (Unique):** Continuation Roadmap
   - Generate prioritized action plan
   - Include before/after metrics
   - Output: `continuation_roadmap.md`

**See:** `children/planer-progress/SKILL.md` for details

---

## Shared Templates

**Location:** `shared/templates/`

### problems.json
Template for Phase 2 output. Contains:
- Technologies with common mistakes
- Breaking changes
- Best practices
- Performance tips
- Security checklist
- Cross-cutting concerns
- Project-specific problems (PLANER-PROGRESS only)

### tool_inventory.json
Template for Phase 3 output. Contains:
- Existing tools (agents, skills, commands)
- Gaps in tooling
- Recommendations for new tools

### specialist-agent-template.md
Template for Phase 4 specialist agent generation. Contains:
- Agent frontmatter
- Critical knowledge base structure
- Common mistakes format
- Breaking changes format
- Best practices checklist
- Example interventions

---

## Context Management

Both children follow the same context budget strategy:

| Phase | Main Agent | Sub-Agent (Isolated) | Running Total |
|-------|-----------|---------------------|---------------|
| Child Phase 1 | 8-10k | 20-35k exploration | 8-10k |
| [SHARED] Phase 2 | 6-10k summary | 25-30k WebSearch | 16-20k |
| [SHARED] Phase 3 | 4k summary | 20k analysis | 20-24k |
| [SHARED] Phase 4 | 2k metadata | 20k generation | 22-26k |
| Child Final Phases | 15-20k | varies | 40-60k |

**Target:** <50% (100k tokens) for both children ✓

**Shared phases save ~40k tokens** through reuse!

---

## Example User Experiences

### Scenario 1: New Project (Auto-detects PLANER-ZERO)

```
User: /planer "Build a Next.js SaaS app"

PLANER: Analyzing current directory... no existing code found.
        Routing to PLANER-ZERO (Greenfield Project).

PLANER-ZERO: Let me ask you some questions about your project...
[Questions about tech stack]

[Shared Phase 2: Problem Research]
Researching common Next.js 15 mistakes (2026)...
Found: Server Component confusion, Async API issues

[Shared Phase 3: Ecosystem Analysis]
Analyzing available tools...
Gap found: No Next.js 15 specialist

[Shared Phase 4: Specialist Generation]
Creating nextjs-specialist agent...
Embedded: Server/Client Component best practices

PLANER-ZERO: Here's your implementation plan with 12 tasks...
```

---

### Scenario 2: Existing Project (Auto-detects PLANER-PROGRESS)

```
User: /planer

PLANER: Analyzing current directory... found .git + source code.
        Routing to PLANER-PROGRESS (Project In Progress).

PLANER-PROGRESS: Analyzing your codebase...
Found: WordPress Block Theme, 13 custom blocks, WooCommerce

[Phase 2: Gap Analysis]
What are your goals? [Complete, Add Features, Optimize, Launch]
User selects: Optimize + Add Features

[Shared Phase 3: Problem Research]
Researching WordPress Interactivity API issues (2026)...
Researching WooCommerce performance optimization...
Found: Context loss in async, large bundle sizes

[Shared Phase 4: Ecosystem Analysis]
Found wordpress-specialist agent matches your needs...

PLANER-PROGRESS: Here's your continuation roadmap:
- Phase 1 (Critical): Fix Interactivity API context issues
- Phase 2 (High Priority): Optimize JavaScript bundles
- Phase 3 (Medium): Add wishlist feature
- Phase 4 (Polish): Documentation
```

---

## File Structure

```
~/.claude/skills/planer/
├── SKILL.md (this file - parent router)
├── shared/
│   ├── phase-2-problem-research.md
│   ├── phase-3-ecosystem-analysis.md
│   ├── phase-4-specialist-generation.md
│   └── templates/
│       ├── problems.json
│       ├── tool_inventory.json
│       └── specialist-agent-template.md
└── children/
    ├── planer-zero/
    │   ├── SKILL.md (Phase 1, 5, 6)
    │   └── templates/
    │       ├── project_spec.json
    │       └── implementation_plan.md
    └── planer-progress/
        ├── SKILL.md (Phase 1, 2, 6, 7)
        └── templates/
            ├── project_structure.json
            ├── feature_inventory.json
            ├── quality_report.json
            ├── gap_analysis.json
            ├── task_roadmap.json
            └── continuation_roadmap.md
```

---

## Benefits of Parent-Child Architecture

1. **DRY (Don't Repeat Yourself)**
   - Phases 2, 3, 4 written once, used twice
   - Templates shared between children
   - 40% less code duplication

2. **Consistency**
   - Both children do problem research identically
   - Both generate specialists with same format
   - Predictable outputs

3. **Single Entry Point**
   - User just calls `/planer`
   - Parent handles routing logic
   - No confusion about which command to use

4. **Maintainability**
   - Fix bug in Phase 2 → both children benefit
   - Update specialist template → both children use new version
   - Add new tech support → both children get it

5. **Extensibility**
   - Want PLANER-MIGRATE for tech stack migrations?
   - Create new child, inherit shared phases (2, 3, 4)
   - Done!

---

## Decision Matrix

| Situation | Routes To | Why |
|-----------|-----------|-----|
| Empty directory | PLANER-ZERO | No code exists yet |
| Has .git + commits + source | PLANER-PROGRESS | Active development detected |
| Has .git but no commits | Ask user | Ambiguous state |
| User says "build new app" | PLANER-ZERO | Explicit new project |
| User says "fix my app" | PLANER-PROGRESS | Explicit continuation |
| User just says "/planer" | Auto-detect | Let parent decide |

---

## Success Criteria

### For Parent (PLANER):
- ✅ Detects project state correctly 95%+ of time
- ✅ Routes to appropriate child seamlessly
- ✅ Shared phases work for both children
- ✅ Single entry point simplifies UX

### For Both Children:
- ✅ Maintain <50% context usage
- ✅ Produce actionable, prioritized plans
- ✅ Prevent common mistakes through specialists
- ✅ Reuse shared logic without duplication

---

## Version History

**v1.0 (2026-01-17):**
- Initial parent-child architecture
- Shared phases: Problem Research, Ecosystem Analysis, Specialist Generation
- Auto-detection and routing logic
- Support for: PLANER-ZERO (greenfield), PLANER-PROGRESS (in-progress)

---

**Created by:** PLANER Architecture Team
**Parent Version:** 1.0
**Last Updated:** 2026-01-17
