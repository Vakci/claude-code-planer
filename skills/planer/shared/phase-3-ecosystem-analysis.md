# Phase 3: Ecosystem Analysis

**Goal:** Identify existing tools (agents, skills, commands) and gaps

**Approach:** Use Task tool with general-purpose agent for ecosystem analysis

**Input:**
- PLANER-ZERO: `project_spec.json` + `problems.json`
- PLANER-PROGRESS: `project_structure.json` + `feature_inventory.json` + `problems.json`

**Implementation:**

```javascript
Task({
  description: "Analyze tool ecosystem",
  prompt: `Read the project specification/structure and problems.json files.

  Based on the tech stack and researched problems:
  1. Identify existing Claude Code agents/skills/commands that match project needs
  2. Identify gaps - missing specialists for key technologies
  3. Recommend which agents to use for each project phase
  4. Suggest custom tools to create (if gaps found) that embed problem awareness

  Output the results to a file named: tool_inventory.json

  Use the tool_inventory.json template format.`,
  subagent_type: "general-purpose",
  model: "sonnet"
})
```

## Tool Inventory Format

Write to `tool_inventory.json`:

```json
{
  "existing_tools": {
    "agents": [
      {
        "name": "backend-development::backend-architect",
        "use_for": "Overall API architecture, service design",
        "relevance": "high | medium | low"
      }
    ],
    "skills": [
      {
        "name": "backend-development:api-design-principles",
        "use_for": "REST API design patterns",
        "relevance": "high | medium | low"
      }
    ],
    "commands": [
      {
        "name": "/commit",
        "use_for": "Git commits after each phase"
      }
    ]
  },
  "gaps": [
    {
      "technology": "Technology Name",
      "gap_type": "specialist_agent | skill | command",
      "reason": "Why this gap exists",
      "impact": "What problems this causes",
      "recommendation": "Suggested tool to create"
    }
  ],
  "recommendations": {
    "create_tools": true,
    "tools_to_create": [
      {
        "type": "agent | skill",
        "name": "tool-name",
        "location": "~/.claude/agents/tool-name.md or ~/.claude/skills/tool-name/SKILL.md",
        "embed_problems": ["List of problems from problems.json to embed"],
        "justification": "Why this tool prevents common mistakes"
      }
    ]
  }
}
```

**Output:** `tool_inventory.json` (4k tokens)

---

## Usage Notes for Child Skills

**PLANER-ZERO:**
- Focuses on tools needed for greenfield implementation
- Identifies agents for building from scratch

**PLANER-PROGRESS:**
- Focuses on tools needed for code analysis, refactoring, testing
- May identify different agents than PLANER-ZERO (e.g., code-review agents)
