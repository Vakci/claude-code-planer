# Phase 4: Generate Global Specialist Agents

**Goal:** Create **reusable, problem-aware specialist agents** saved globally in `~/.claude/agents/`

**Why:** Next project using the same technology can immediately benefit from embedded problem knowledge

**Approach:** Use researched problems from `problems.json` to generate agents with:
1. Common mistakes section (with bad/good code examples)
2. Breaking changes awareness
3. Best practices checklist
4. Red flags for code review
5. When to watch for each problem

## Process

1. **Read `problems.json`** from Phase 2
2. **For each gap** identified in Phase 3 `tool_inventory.json`:
   - Extract relevant problems for that technology
   - Generate agent using template below
   - Write agent to `~/.claude/agents/[technology]-specialist.md`
3. **Ask user for approval:**
   ```
   I've created N specialist agents based on 2026 research:

   1. [agent-name] (prevents [key problems])
   2. [agent-name] (prevents [key problems])

   These agents are saved globally in ~/.claude/agents/ and can be reused across all future projects.

   Proceed to next phase?
   ```
4. **Update main context** with just the agent names and high-level capabilities (not full content)

## Global Agent Template Structure

**Location:** `~/.claude/agents/[technology]-specialist.md`

**Template:** See `~/.claude/skills/planer/shared/templates/specialist-agent-template.md`

**Key Sections:**
- Frontmatter (name, description, model)
- Critical Knowledge Base (common mistakes with bad/good code examples)
- Breaking Changes (version-specific changes from problems.json)
- Best Practices Checklist
- Performance Optimization tips
- Security Checklist
- Workflow (how agent operates)
- Integration notes (works alongside which other agents)
- Example Interventions (2-3 concrete examples)

## Context Management

- Full agent content (~15-20k tokens each) written to disk
- Main agent only stores: agent names + key capabilities (2k tokens total)
- **Total main context impact:** ~2k tokens (just metadata)
- **Savings:** ~40-60k tokens kept out of main context

## Output

**Files Created:**
- `~/.claude/agents/[technology]-specialist.md` (one per gap)

**Main Context Update:**
```json
{
  "specialist_agents_created": [
    {
      "name": "wordpress-specialist",
      "location": "~/.claude/agents/wordpress-specialist.md",
      "prevents": ["Interactivity API context loss", "Hook timing issues"],
      "use_for": "All WordPress block/theme development"
    },
    {
      "name": "nextjs-specialist",
      "location": "~/.claude/agents/nextjs-specialist.md",
      "prevents": ["Server/Client Component confusion", "Async API issues"],
      "use_for": "Next.js 15 development"
    }
  ]
}
```

**Tokens:** 2k metadata (main context), 15-20k per agent (disk only)

---

## Usage Notes for Child Skills

**PLANER-ZERO:**
- Creates specialists for technologies in new project stack
- Agents focus on preventing common mistakes in greenfield development

**PLANER-PROGRESS:**
- May create specialists for technologies found in existing codebase
- Can also identify if existing specialists already cover the project's needs
- Agents focus on code review patterns and refactoring guidance
