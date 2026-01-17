# Continuation Roadmap: [Project Name]

**Generated:** [YYYY-MM-DD]
**By:** PLANER-PROGRESS v1.0
**Project Type:** [WordPress Block Theme | Next.js App | FastAPI Backend]
**Current Completion:** [XX]%

---

## Executive Summary

**What Exists:**
- ✅ [Major feature 1 from feature_inventory.json]
- ✅ [Major feature 2]
- ✅ [Integration/tech stack component]
- ✅ [Another completed feature]

**What's Missing:**
- ❌ [Critical gap from gap_analysis.json]
- ❌ [Recommended feature]
- ❌ [Standard feature for this project type]

**Critical Issues Found:**
- 🔴 **P0:** [Critical security/functionality issue]
- 🔴 **P1:** [High-priority bug or performance issue]
- 🟡 **P2:** [Medium-priority improvement]

---

## Priority Roadmap

### 🔥 Phase 1: Critical Fixes (Start Immediately)

**Duration:** [X-Y hours]
**Goal:** Fix breaking issues, prevent runtime errors, patch security vulnerabilities

#### Task: [Task Name from FIX category P0/P1]
- **Priority:** P0 - Critical | P1 - High
- **Category:** Security | Bug Fix | Data Integrity
- **Problem:** [Detailed description of the issue]
- **Files:**
  - `[file path 1]`
  - `[file path 2]`
- **Agent:** [Recommended agent: wordpress-specialist | general-purpose | etc.]
- **Implementation:**
  ```javascript
  Task({
    description: "[3-5 word task description]",
    prompt: `[Detailed task description with context.

    Current Issue: [description]
    Expected Behavior: [description]
    Files to modify: [list]

    Apply fixes from problems.json research:
    - [Key problem to prevent]
    - [Best practice to follow]

    Success criteria: [criteria]`,
    subagent_type: "[agent-name]",
    model: "sonnet"
  })
  ```
- **Success Criteria:**
  - [Criteria 1: e.g., No security vulnerabilities]
  - [Criteria 2: e.g., All tests pass]
  - [Criteria 3: e.g., No console errors]

---

**Repeat for each P0/P1 FIX task**

---

### 🚀 Phase 2: High-Priority Improvements (Parallel Execution)

**Duration:** [X-Y hours]
**Goal:** Optimize performance, improve accessibility, add tests, enhance quality

#### Task 1: [Performance Optimization Task]
- **Priority:** P1 - High
- **Category:** Performance
- **Problem:** [e.g., Large bundle size, slow load times]
- **Current State:** [e.g., 45KB bundle, 5s load on 3G]
- **Target State:** [e.g., <20KB bundle, <2s load]
- **Impact:** [e.g., 3-5s faster mobile load, better Lighthouse score]
- **Agent:** [general-purpose | frontend-design]
- **Implementation:**
  ```javascript
  Task({
    description: "[Optimize performance]",
    prompt: `[Implementation details]`,
    subagent_type: "[agent]",
    model: "sonnet"
  })
  ```

#### Task 2: [Accessibility Improvement]
- **Priority:** P1/P2 - High/Medium
- **Category:** Accessibility
- **Problem:** [e.g., Partial keyboard navigation, missing ARIA labels]
- **WCAG Compliance:** [Current vs Target]
- **Impact:** [e.g., Full keyboard navigation, WCAG 2.1 AA compliance]
- **Agent:** [wordpress-specialist | general-purpose]
- **Implementation:**
  ```javascript
  Task({
    description: "[Add accessibility features]",
    prompt: `[Implementation details]`,
    subagent_type: "[agent]",
    model: "sonnet"
  })
  ```

#### Task 3: [Testing Implementation]
- **Priority:** P1 - High
- **Category:** Quality Assurance
- **Problem:** [e.g., 0% test coverage, no regression protection]
- **Target:** [e.g., 80% coverage with unit + integration tests]
- **Agent:** test-engineer
- **Implementation:**
  ```javascript
  Task({
    description: "[Create test suite]",
    prompt: `[Implementation details]`,
    subagent_type: "test-engineer",
    model: "sonnet"
  })
  ```

**Run Phase 2 tasks in parallel for maximum efficiency:**
```javascript
// Launch all Phase 2 tasks concurrently
Task({ description: "Optimize performance", ... })
Task({ description: "Add accessibility", ... })
Task({ description: "Create tests", ... })
```

---

### 🎨 Phase 3: New Features (Sequential)

**Duration:** [X-Y hours]
**Goal:** Extend functionality with user-requested features

#### Task: [New Feature Name]
- **Priority:** P2 - Medium
- **Category:** New Feature
- **Description:** [What this feature does]
- **User Value:** [Why users want this]
- **Dependencies:** [WooCommerce | Third-party API | etc.]
- **Agent:** [wordpress-specialist | general-purpose]
- **New Files:**
  - `[new directory/file 1]`
  - `[new directory/file 2]`
- **Implementation:**
  ```javascript
  Task({
    description: "[Build feature X]",
    prompt: `[Detailed feature requirements]

    Feature Requirements:
    - [Requirement 1]
    - [Requirement 2]

    Technical Approach:
    - [Approach detail]

    Use [Technology] best practices from problems.json:
    - [Best practice 1]
    - [Best practice 2]`,
    subagent_type: "[agent]",
    model: "sonnet"
  })
  ```
- **Success Criteria:**
  - [Criteria 1]
  - [Criteria 2]

---

### 📚 Phase 4: Documentation & Polish (Parallel)

**Duration:** [X-Y hours]
**Goal:** Developer docs, deployment guides, code documentation

#### Task 1: [Create Developer Documentation]
- **Priority:** P2 - Medium
- **Category:** Documentation
- **Deliverables:**
  - `docs/DEVELOPMENT.md` - Setup and workflow
  - `docs/BLOCKS.md` - Block development patterns
  - `docs/DEPLOYMENT.md` - Production deployment checklist
  - `docs/TESTING.md` - Test guidelines
- **Agent:** code-documentation:docs-architect
- **Implementation:**
  ```javascript
  Task({
    description: "[Create documentation]",
    prompt: `[Documentation requirements]`,
    subagent_type: "code-documentation:docs-architect",
    model: "sonnet"
  })
  ```

#### Task 2: [Add Inline Documentation]
- **Priority:** P3 - Low
- **Category:** Documentation
- **Goal:** Add PHPDoc and JSDoc comments
- **Coverage Target:** All public functions and classes
- **Agent:** general-purpose

**Run Phase 4 tasks in parallel:**
```javascript
Task({ description: "Create developer docs", ... })
Task({ description: "Add inline docs", ... })
```

---

### 🚢 Phase 5: Deployment Setup (Final)

**Duration:** [X-Y hours]
**Goal:** CI/CD, production readiness

#### Task: [Setup CI/CD Pipeline]
- **Priority:** P2 - Medium
- **Category:** DevOps
- **Requirements:**
  - Automated tests on pull requests
  - Linting and code quality checks
  - Deployment to staging/production
- **Dependencies:** [Requires test_001, test_002]
- **Agent:** general-purpose
- **Implementation:**
  ```javascript
  Task({
    description: "[Setup CI/CD]",
    prompt: `[CI/CD requirements]`,
    subagent_type: "general-purpose",
    model: "sonnet"
  })
  ```

---

## Problem-Aware Development

### Specialist Agents Available

Based on your **[WordPress + WooCommerce + Interactivity API]** stack:

1. **wordpress-specialist** (`~/.claude/agents/wordpress-specialist.md`)
   - ✅ Prevents Interactivity API context loss (getContext() in async callbacks)
   - ✅ Ensures proper hook timing and priorities
   - ✅ Enforces output escaping (XSS prevention)
   - ✅ Validates nonce usage and capability checks
   - **Use for:** All WordPress block/theme development, WooCommerce integrations

2. **[technology]-specialist** (`~/.claude/agents/[technology]-specialist.md`) *(if created)*
   - ✅ Prevents [key problem 1]
   - ✅ Prevents [key problem 2]
   - **Use for:** [Use cases]

### Common Pitfalls We'll Prevent

Based on 2026 research + your codebase analysis:

#### WordPress Interactivity API
- ❌ **Context loss in async callbacks** → ✅ Capture context before setTimeout/requestAnimationFrame
  ```javascript
  // Bad
  requestAnimationFrame(() => {
    const ctx = getContext(); // undefined!
  });

  // Good
  const context = getContext();
  requestAnimationFrame(() => {
    if (context) {
      context.isOpen = true;
    }
  });
  ```

- ❌ **Missing error boundaries** → ✅ Add try/catch blocks around async operations
- ❌ **Store namespace collisions** → ✅ Use proper namespacing: `store('myTheme/heroSlider', {...})`

#### Performance
- ❌ **Monolithic bundles** → ✅ Code splitting + lazy loading
- ❌ **Blocking scripts** → ✅ Defer non-critical JavaScript
- ❌ **N+1 database queries** → ✅ Batch queries with WP_Query

#### Accessibility
- ❌ **Missing ARIA labels** → ✅ Semantic HTML + proper ARIA attributes
- ❌ **Keyboard traps** → ✅ Focus management with Tab key support
- ❌ **Low contrast** → ✅ WCAG AA color contrast (4.5:1 minimum)

#### Security
- ❌ **Unescaped output** → ✅ Use esc_html(), esc_attr(), esc_url()
- ❌ **Unsanitized input** → ✅ Use sanitize_text_field(), sanitize_email()
- ❌ **Missing nonces** → ✅ wp_nonce_field() + wp_verify_nonce()

---

## Execution Commands

### Quick Start (Critical Path)

```javascript
// ============================================================
// PHASE 1: CRITICAL FIXES (Run First, Cannot Be Skipped)
// ============================================================

Task({
  description: "Fix critical security issues",
  prompt: "[Details from fix_001, fix_002]",
  subagent_type: "general-purpose",
  model: "sonnet"
})

// Wait for Phase 1 completion before proceeding

// ============================================================
// PHASE 2: HIGH-PRIORITY IMPROVEMENTS (Run in Parallel)
// ============================================================

// Launch all Phase 2 tasks at once for maximum efficiency
Task({
  description: "Optimize bundle size",
  prompt: "[Details from improve_001]",
  subagent_type: "general-purpose",
  model: "sonnet"
})

Task({
  description: "Add keyboard navigation",
  prompt: "[Details from improve_002]",
  subagent_type: "wordpress-specialist",
  model: "sonnet"
})

Task({
  description: "Create test suite",
  prompt: "[Details from test_001]",
  subagent_type: "test-engineer",
  model: "sonnet"
})

// ============================================================
// PHASE 3: NEW FEATURES (Run After Phase 2)
// ============================================================

Task({
  description: "Create wishlist block",
  prompt: "[Details from add_001]",
  subagent_type: "wordpress-specialist",
  model: "sonnet"
})

// ============================================================
// PHASE 4: DOCUMENTATION & POLISH (Run in Parallel)
// ============================================================

Task({
  description: "Create developer docs",
  prompt: "[Details from doc_001]",
  subagent_type: "code-documentation:docs-architect",
  model: "sonnet"
})

Task({
  description: "Add inline documentation",
  prompt: "[Details from doc_002]",
  subagent_type: "general-purpose",
  model: "sonnet"
})

// ============================================================
// PHASE 5: DEPLOYMENT (Run After Tests Pass)
// ============================================================

Task({
  description: "Setup CI/CD pipeline",
  prompt: "[Details from deploy_001]",
  subagent_type: "general-purpose",
  model: "sonnet"
})
```

---

## Success Metrics

### Before PLANER-PROGRESS
- ❌ 0% test coverage
- ❌ 2 high-severity security vulnerabilities
- ❌ 45KB JavaScript bundle (slow mobile performance)
- ❌ Partial accessibility compliance
- ❌ Runtime errors in animation callbacks
- ❌ No developer documentation
- ❌ Manual deployment process

### After PLANER-PROGRESS (Target State)
- ✅ 80% test coverage (Jest + PHPUnit)
- ✅ 0 security vulnerabilities (all inputs sanitized, outputs escaped)
- ✅ <20KB JavaScript bundle (60% size reduction)
- ✅ WCAG 2.1 AA compliant (full keyboard navigation)
- ✅ Zero runtime errors (proper error handling)
- ✅ Comprehensive developer documentation
- ✅ Automated CI/CD with GitHub Actions
- ✅ New wishlist feature implemented

**Overall Improvement:** [XX]% → [YY]% completion

---

## Technical Debt Backlog

Items not in critical path but should be addressed eventually:

### High-Priority Debt
1. **[Item from technical_debt]**
   - **Impact:** [Description]
   - **Effort:** [Low/Medium/High]
   - **Priority:** P2-P3
   - **Recommendation:** [Solution]

### Medium-Priority Debt
1. **Internationalization (i18n)**
   - **Impact:** Cannot reach non-English audiences
   - **Effort:** Low (3-5 hours)
   - **Priority:** P3
   - **Recommendation:** Add i18n support, generate .pot file

2. **Dark Mode Support**
   - **Impact:** Modern UI expectation, accessibility benefit
   - **Effort:** Medium (10-12 hours)
   - **Priority:** P3
   - **Recommendation:** System-preference-aware dark mode

### Low-Priority Debt
1. **Code Duplication** ([X] lines duplicated)
   - **Impact:** Maintenance burden
   - **Effort:** Low (2-3 hours)
   - **Priority:** P3
   - **Recommendation:** Extract to shared utilities

---

## Risk Management

### Potential Blockers
1. **[Blocker 1]** - [Description and mitigation strategy]
2. **[Blocker 2]** - [Description and mitigation strategy]

### Dependencies
- **External:** [Third-party services, APIs, libraries]
- **Internal:** [Team availability, infrastructure]

---

## Context Management

**Main Agent Context:** 58k tokens (29% of 200k budget) ✓
**Sub-Agent Context:** 145k tokens (isolated)
**Total Project Context:** 203k tokens

**Strategy:**
- File-based handoffs via JSON outputs
- Sub-agents handle heavy processing (exploration, research, analysis)
- Main agent only stores summaries and metadata

---

## Next Steps

1. **Review this roadmap** - Ensure alignment with project goals
2. **Execute Phase 1** - Critical fixes cannot be skipped
3. **Parallel execution** - Run Phase 2 tasks concurrently
4. **Iterate** - Complete phases sequentially, adjust based on findings
5. **Re-assess** - After Phase 2, re-evaluate priorities for Phases 3-5

---

**Generated by:** PLANER-PROGRESS v1.0
**Research Date:** [YYYY-MM-DD]
**Next Review:** After Phase 2 completion
**Valid Until:** [YYYY-MM-DD + 30 days] *(re-run PLANER-PROGRESS if priorities change)*

---

**Status:** ✅ Ready for Execution
**Total Estimated Effort:** [XX-YY] hours
**Critical Path Length:** [X] hours
**Parallelization Potential:** [Y]% time savings
