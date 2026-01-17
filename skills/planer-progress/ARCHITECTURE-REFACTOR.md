# PLANER Architecture Refactor: Parent-Child Inheritance

## Overview

Refactor PLANER-ZERO and PLANER-PROGRESS to share common logic through a parent PLANER skill.

```
┌─────────────────────────────────────────┐
│         PLANER (Parent Router)          │
│  - Detects project state                │
│  - Routes to appropriate child          │
│  - Contains shared phases (2,3,4)       │
└─────────────────────────────────────────┘
           ↓                    ↓
    ┌──────────────┐      ┌──────────────────┐
    │ PLANER-ZERO  │      │ PLANER-PROGRESS  │
    │ (Greenfield) │      │ (In-Progress)    │
    │              │      │                  │
    │ Phase 1: Q&A │      │ Phase 1: Analyze │
    │ Phase 5: Plan│      │ Phase 5: Roadmap │
    └──────────────┘      └──────────────────┘
           ↓                      ↓
    Both inherit:
    - Phase 2: Problem Research
    - Phase 3: Ecosystem Analysis
    - Phase 4: Specialist Generation
    - Shared templates & logic
```

---

## File Structure (Refactored)

```
~/.claude/skills/planer/
├── SKILL.md                          # Parent PLANER skill (router + shared logic)
├── shared/
│   ├── phase-2-problem-research.md   # Shared Phase 2 logic
│   ├── phase-3-ecosystem-analysis.md # Shared Phase 3 logic
│   ├── phase-4-specialist-gen.md     # Shared Phase 4 logic
│   └── templates/
│       ├── problems.json             # Shared template
│       ├── tool_inventory.json       # Shared template
│       ├── specialist-agent.md       # Shared agent template
│       └── websearch-queries.json    # Shared query patterns
├── children/
│   ├── planer-zero/
│   │   ├── phase-1-discovery.md      # Questions for new projects
│   │   ├── phase-5-implementation-plan.md
│   │   └── templates/
│   │       ├── project_spec.json
│   │       └── implementation_plan.md
│   └── planer-progress/
│       ├── phase-1-codebase-discovery.md  # Analyze existing code
│       ├── phase-2-gap-analysis.md        # What's missing
│       ├── phase-6-task-categorization.md # FIX/IMPROVE/ADD/etc.
│       └── templates/
│           ├── project_structure.json
│           ├── feature_inventory.json
│           ├── quality_report.json
│           ├── gap_analysis.json
│           ├── task_roadmap.json
│           └── continuation_roadmap.md
└── docs/
    ├── ARCHITECTURE.md               # This document
    └── USAGE.md                      # User guide
```

---

## Parent: PLANER (Router + Shared Logic)

### Entry Point: `/planer`

**User calls:** `/planer` or `/planer "Build a Next.js app"` or `/planer` (in existing project)

**Parent decides:**

```python
# Pseudo-code logic
if project_exists():
    if has_git_commits() and has_code_files():
        route_to = "PLANER-PROGRESS"
        reason = "Detected existing codebase with git history"
    else:
        ask_user_which_mode()
else:
    route_to = "PLANER-ZERO"
    reason = "No existing project detected, starting greenfield"

execute_child_workflow(route_to)
```

### Auto-Detection Logic

```json
{
  "detection_rules": {
    "existing_project": [
      "Has .git directory with commits",
      "Has package.json or composer.json or requirements.txt",
      "Has source code files (*.js, *.php, *.py, etc.)",
      "Has build artifacts or config files"
    ],
    "new_project": [
      "Empty directory or no git history",
      "No package/dependency files",
      "No source code files"
    ],
    "ambiguous": [
      "Has .git but no commits",
      "Has only config files, no source",
      "→ Ask user which mode to use"
    ]
  }
}
```

### Shared Phases (Inherited by Both Children)

#### Shared Phase 2: Problem Research
- WebSearch for general tech stack issues (2025-2026)
- Common mistakes, breaking changes, best practices
- **Input:** Tech stack from child Phase 1
- **Output:** `problems.json` (6-10k tokens)

**Logic lives in:** `shared/phase-2-problem-research.md`

**Used by:**
- PLANER-ZERO: After user answers questions about tech stack
- PLANER-PROGRESS: After codebase discovery identifies tech stack

#### Shared Phase 3: Ecosystem Analysis
- Identify existing agents/skills that match project needs
- Find gaps in available tools
- **Input:** Tech stack + problems.json
- **Output:** `tool_inventory.json` (4k tokens)

**Logic lives in:** `shared/phase-3-ecosystem-analysis.md`

**Used by:** Both children identically

#### Shared Phase 4: Specialist Agent Generation
- Create global reusable specialist agents
- Embed problem knowledge from Phase 2 research
- Save to `~/.claude/agents/[tech]-specialist.md`
- **Input:** problems.json + tool_inventory.json
- **Output:** Agent files + metadata (2k tokens)

**Logic lives in:** `shared/phase-4-specialist-gen.md`

**Used by:** Both children identically

---

## Child: PLANER-ZERO (Greenfield Projects)

### Unique Phases

#### Phase 1: Project Discovery (Questions)
- Use `AskUserQuestion` to understand requirements
- Ask about: Frontend, Backend, Database, Auth, Deployment, etc.
- **Output:** `project_spec.json` (5-10k tokens)

#### Phase 5: Implementation Plan
- Break project into 8-15 implementation tasks
- Create dependency graph
- Generate commands to execute
- **Output:** `implementation_plan.md` (15k tokens)

### Workflow

```
User calls /planer → Parent detects "new project"
    ↓
PLANER-ZERO activated
    ↓
1. Phase 1: Ask questions about project
    ↓ (outputs: project_spec.json with tech stack)
2. [SHARED] Phase 2: Research problems for tech stack
    ↓ (outputs: problems.json)
3. [SHARED] Phase 3: Analyze ecosystem
    ↓ (outputs: tool_inventory.json)
4. [SHARED] Phase 4: Generate specialists
    ↓ (outputs: agents + metadata)
5. Phase 5: Create implementation plan
    ↓ (outputs: implementation_plan.md)

✅ User receives: Full implementation plan for new project
```

---

## Child: PLANER-PROGRESS (Projects in Progress)

### Unique Phases

#### Phase 1: Codebase Discovery
- Use Explore agent to analyze existing code
- Catalog features, blocks, integrations
- Scan for quality issues, TODOs, security concerns
- **Output:**
  - `project_structure.json` (3k)
  - `feature_inventory.json` (3k)
  - `quality_report.json` (2k)

#### Phase 2: Gap Analysis
- Ask user about goals (Complete? Add features? Optimize?)
- Compare existing features vs. standards
- Identify incomplete work, technical debt
- **Output:** `gap_analysis.json` (6k tokens)

#### Phase 6: Task Categorization
- Break work into categories: FIX, IMPROVE, ADD, REFACTOR, TEST, DOCUMENT
- Assign priorities: P0 (critical) → P3 (low)
- Create execution phases
- **Output:** `task_roadmap.json` (10k tokens)

#### Phase 7: Continuation Roadmap
- Generate prioritized action plan
- Include before/after success metrics
- List technical debt backlog
- **Output:** `continuation_roadmap.md` (18k tokens)

### Workflow

```
User calls /planer → Parent detects "existing project"
    ↓
PLANER-PROGRESS activated
    ↓
1. Phase 1: Discover existing codebase
    ↓ (outputs: project_structure.json, feature_inventory.json, quality_report.json)
2. Phase 2: Gap analysis
    ↓ (outputs: gap_analysis.json with tech stack)
3. [SHARED] Phase 3: Research problems for tech stack + existing code
    ↓ (outputs: problems.json - enhanced with project-specific issues)
4. [SHARED] Phase 4: Analyze ecosystem
    ↓ (outputs: tool_inventory.json)
5. [SHARED] Phase 5: Generate specialists
    ↓ (outputs: agents + metadata)
6. Phase 6: Categorize tasks
    ↓ (outputs: task_roadmap.json)
7. Phase 7: Create continuation roadmap
    ↓ (outputs: continuation_roadmap.md)

✅ User receives: Prioritized roadmap with FIX, IMPROVE, ADD tasks
```

---

## Shared Templates (DRY)

### 1. problems.json (Shared)

Both children produce the same format:

```json
{
  "research_date": "2026-01-17",
  "technologies": [
    {
      "name": "WordPress",
      "version": "6.8+",
      "common_mistakes": [...],
      "breaking_changes": [...],
      "best_practices": [...],
      "performance_tips": [...],
      "security_checklist": [...]
    }
  ],
  "project_specific_problems": [
    // Only PLANER-PROGRESS adds this section
    {
      "problem": "Large bundle size in hero-slider.js",
      "current_state": "45KB",
      "solution": "Code splitting + lazy loading"
    }
  ]
}
```

**Location:** `shared/templates/problems.json`

### 2. tool_inventory.json (Shared)

```json
{
  "existing_tools": {
    "agents": [...],
    "skills": [...]
  },
  "gaps": [...],
  "recommendations": {
    "create_tools": true,
    "tools_to_create": [...]
  }
}
```

**Location:** `shared/templates/tool_inventory.json`

### 3. specialist-agent.md (Shared)

Template for generating specialist agents in Phase 4.

**Location:** `shared/templates/specialist-agent.md`

---

## Parent SKILL.md Structure

```markdown
---
name: planer
description: Master project orchestration - detects project state and routes to PLANER-ZERO (greenfield) or PLANER-PROGRESS (in-progress)
---

# PLANER: Master Project Orchestration

## Overview

Single entry point for project planning. Automatically detects whether you're starting a new project or continuing an existing one.

## Usage

\`\`\`bash
# Parent auto-detects and routes
/planer

# Or provide context
/planer "Build a Next.js e-commerce app"
\`\`\`

## Auto-Detection Logic

[Detection rules - checks for git, package files, source code]

## Routing

- **New Project (No git, no code)** → PLANER-ZERO
- **Existing Project (Has git + code)** → PLANER-PROGRESS
- **Ambiguous (Has git but no commits)** → Ask user

## Shared Phases (2, 3, 4)

[Include shared phase logic here or reference external files]

### Phase 2: Problem Research (Shared)

[Full Phase 2 logic that both children use]

### Phase 3: Ecosystem Analysis (Shared)

[Full Phase 3 logic that both children use]

### Phase 4: Specialist Generation (Shared)

[Full Phase 4 logic that both children use]

## Child Workflows

### PLANER-ZERO (Greenfield)
1. Ask questions about new project
2. → Shared Phase 2: Problem research
3. → Shared Phase 3: Ecosystem analysis
4. → Shared Phase 4: Specialist generation
5. Create implementation plan

### PLANER-PROGRESS (In-Progress)
1. Analyze existing codebase
2. Gap analysis
3. → Shared Phase 2: Problem research (enhanced)
4. → Shared Phase 3: Ecosystem analysis
5. → Shared Phase 4: Specialist generation
6. Categorize tasks (FIX, IMPROVE, ADD, etc.)
7. Create continuation roadmap

## Context Management

Both children maintain <50% context usage by delegating to sub-agents.
```

---

## Implementation Benefits

### 1. **DRY (Don't Repeat Yourself)**
- Phase 2 logic written once, used twice
- Phase 3 logic written once, used twice
- Phase 4 logic written once, used twice
- Templates shared

**Savings:** ~40% less code duplication

### 2. **Consistency**
- Both children do problem research the same way
- Both generate specialists with same format
- Both use same templates

**Result:** Predictable outputs, easier maintenance

### 3. **Single Entry Point**
- User just calls `/planer`
- Parent handles routing logic
- Seamless experience

**UX Improvement:** No confusion about which command to use

### 4. **Maintainability**
- Fix bug in Phase 2 → both children benefit
- Update specialist template → both children use new version
- Add new tech stack support → both children get it

**Long-term:** Much easier to maintain

### 5. **Extensibility**
- Want to add PLANER-MIGRATE (for tech stack migrations)?
  - Create new child
  - Inherit shared phases (2, 3, 4)
  - Add unique migration logic
  - Done!

**Future-proof:** Easy to extend

---

## Migration Plan

### Step 1: Create Shared Directory
```bash
mkdir -p ~/.claude/skills/planer/shared/templates
mkdir -p ~/.claude/skills/planer/children/planer-zero
mkdir -p ~/.claude/skills/planer/children/planer-progress
```

### Step 2: Extract Shared Logic from PLANER-ZERO
- Move Phase 2 (Problem Research) to `shared/phase-2-problem-research.md`
- Move Phase 3 (Ecosystem Analysis) to `shared/phase-3-ecosystem-analysis.md`
- Move Phase 4 (Specialist Gen) to `shared/phase-4-specialist-gen.md`
- Move templates to `shared/templates/`

### Step 3: Refactor PLANER-ZERO
- Keep only unique Phase 1 (Questions) and Phase 5 (Implementation Plan)
- Reference shared phases from parent
- Update SKILL.md to indicate inheritance

### Step 4: Create PLANER-PROGRESS
- Implement unique phases (1: Codebase Discovery, 2: Gap Analysis, 6: Task Categorization, 7: Roadmap)
- Reference shared phases from parent
- Create SKILL.md indicating inheritance

### Step 5: Create Parent PLANER
- Implement auto-detection logic
- Implement routing to children
- Include shared phase logic
- Create master SKILL.md

### Step 6: Test
- Test `/planer` in empty directory → should route to PLANER-ZERO
- Test `/planer` in Pawshaus directory → should route to PLANER-PROGRESS
- Verify shared phases work correctly in both contexts

---

## Context Management (Shared Strategy)

Both children follow same context budget:

| Phase | Main Agent | Sub-Agent (Isolated) | Running Total |
|-------|-----------|---------------------|---------------|
| Child Phase 1 | 8-10k | 20-35k | 8-10k |
| [SHARED] Phase 2 | 6-10k summary | 25-30k research | 16-20k |
| [SHARED] Phase 3 | 4k summary | 20k analysis | 20-24k |
| [SHARED] Phase 4 | 2k metadata | 20k generation | 22-26k |
| Child Final Phases | 15-20k | varies | 40-60k |

**Target:** <50% (100k tokens) for both children ✓

---

## File References (How Inheritance Works)

### In Parent SKILL.md:

```markdown
## Shared Phase 2: Problem Research

{{include: shared/phase-2-problem-research.md}}
```

### In Child SKILL.md (PLANER-ZERO):

```markdown
## Phase 2: Problem Research

This phase is inherited from parent PLANER.

See: `~/.claude/skills/planer/shared/phase-2-problem-research.md`

[Child-specific context or parameters can go here]
```

### In Child SKILL.md (PLANER-PROGRESS):

```markdown
## Phase 3: Problem Research

This phase is inherited from parent PLANER, but enhanced with project-specific research.

**Shared logic:** `~/.claude/skills/planer/shared/phase-2-problem-research.md`

**PLANER-PROGRESS enhancement:**
- Also search for problems specific to patterns found in existing codebase
- Example: If quality scan found "large bundle", search for optimization techniques
```

---

## Example User Experience

### Scenario 1: New Project (Auto-detects PLANER-ZERO)

```
User: /planer "Build a Next.js SaaS app"

PLANER: Detected new project (no existing code). Routing to PLANER-ZERO (Greenfield).

PLANER-ZERO: Let me ask you some questions about your project...
[Questions about tech stack]

[Shared Phase 2: Problem Research]
Researching common Next.js 15 mistakes (2026)...

[Shared Phase 3: Ecosystem Analysis]
Analyzing available agents and tools...

[Shared Phase 4: Specialist Generation]
Creating nextjs-specialist agent with embedded problem knowledge...

PLANER-ZERO: Here's your implementation plan with 12 tasks...
```

### Scenario 2: Existing Project (Auto-detects PLANER-PROGRESS)

```
User: /planer

PLANER: Detected existing project (found .git + source code). Routing to PLANER-PROGRESS (In-Progress).

PLANER-PROGRESS: Analyzing your codebase...
Found: WordPress Block Theme, 13 custom blocks, WooCommerce integration

[Shared Phase 2: Problem Research]
Researching WordPress Interactivity API issues (2026)...
Researching WooCommerce performance optimization...

[Shared Phase 3: Ecosystem Analysis]
Found wordpress-specialist agent matches your needs...

PLANER-PROGRESS: Here's your continuation roadmap:
- Phase 1 (Critical): Fix 2 bugs
- Phase 2 (High Priority): Optimize performance
- Phase 3 (Medium): Add 3 new features
- Phase 4 (Polish): Documentation
```

---

## Testing Strategy

### Unit Tests (Conceptual)

1. **Parent Detection Logic**
   - Empty dir → routes to PLANER-ZERO ✓
   - Dir with git + code → routes to PLANER-PROGRESS ✓
   - Ambiguous → asks user ✓

2. **Shared Phase Execution**
   - Phase 2 produces valid problems.json ✓
   - Phase 3 produces valid tool_inventory.json ✓
   - Phase 4 creates valid specialist agents ✓

3. **Child Independence**
   - PLANER-ZERO completes full workflow ✓
   - PLANER-PROGRESS completes full workflow ✓
   - Both produce expected outputs ✓

### Integration Test

- Run `/planer` on real projects:
  - New Next.js project (empty dir)
  - Existing Pawshaus WordPress theme
  - Existing FastAPI backend
- Verify outputs match expected formats
- Verify context stays under 50%

---

## Decision Matrix: When to Use Each

| Situation | Parent Routes To | Why |
|-----------|------------------|-----|
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

## Next Steps

1. **Review this architecture** - Does it make sense?
2. **Approve refactor plan** - Ready to implement?
3. **Test on Pawshaus** - Validate PLANER-PROGRESS workflow
4. **Refine based on results** - Iterate as needed

---

**Document Status:** ✅ Design Complete - Awaiting Approval
**Estimated Implementation:** 3-4 hours (with testing)
**Complexity:** Medium (refactoring existing + new child)
**Risk:** Low (shared logic is well-defined, isolated phases)

---

**Created:** 2026-01-17
**Author:** PLANER Architecture Team
