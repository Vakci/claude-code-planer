# Phase 2: Problem Research & Bottleneck Identification

**Goal:** Research recent common problems, pitfalls, and best practices for the specific tech stack (2025-2026 only)

**Why:** Prevents 80% of common mistakes by embedding problem knowledge into specialist agents

**Approach:** Use `WebSearch` tool with temporal filtering (2025-2026) to find:
1. Common mistakes developers make
2. Recent breaking changes
3. Performance pitfalls
4. Security vulnerabilities
5. Best practices that prevent issues

## WebSearch Query Strategy

For each major technology in the stack, run **8-10 targeted searches**:

### 1. Common Problems

```
"[Technology] common mistakes 2026"
"[Technology] pitfalls 2025 2026"
"[Framework] best practices 2026"
"[Technology] anti-patterns to avoid 2026"
```

**Example:**
```
"Next.js 15 common mistakes 2026"
"FastAPI WebSocket pitfalls 2026"
"PostgreSQL performance optimization 2026"
```

### 2. Recent Issues (GitHub/Stack Overflow)

```
"site:github.com [Technology] issues label:bug 2025 2026"
"site:stackoverflow.com [Technology] 2025 2026"
"site:github.com [Framework] discussions 2025 2026"
```

**Example:**
```
"site:github.com FastAPI issues label:websocket 2025 2026"
"site:stackoverflow.com Next.js Server Components 2025 2026"
```

### 3. Breaking Changes & Updates

```
"[Technology] breaking changes 2025"
"[Technology] migration guide 2026"
"[Technology] v[latest] what's new"
"[Technology] upgrade guide 2025 to 2026"
```

**Example:**
```
"WordPress 6.8 breaking changes"
"Next.js 15 migration guide 2026"
"FastAPI v0.110 what's new"
```

### 4. Official Documentation & Standards

```
"[Technology] official documentation 2026"
"[Technology] security best practices 2026"
"[Framework] performance optimization 2026"
```

**Example:**
```
"WordPress Interactivity API documentation 2026"
"FastAPI security best practices 2026"
```

### 5. Domain-Specific Deep Dives

For WordPress:
```
"WordPress Interactivity API common mistakes 2026"
"WordPress hooks best practices 2026"
"WordPress block development pitfalls 2026"
"WordPress FSE theme.json errors 2026"
```

For Next.js:
```
"Next.js App Router Server Components mistakes 2026"
"Next.js 15 caching behavior changes"
"Next.js middleware performance issues 2026"
```

For FastAPI:
```
"FastAPI async context handling 2026"
"FastAPI dependency injection pitfalls 2026"
"FastAPI WebSocket connection management 2026"
```

## Problem Classification

Classify each discovered problem by **frequency** and **severity**:

```json
{
  "frequency": "very_common | common | occasional | rare",
  "severity": "critical | high | medium | low",
  "detectability": "easy | moderate | hard"
}
```

**Prioritize problems that are:**
- Very common or common (high frequency)
- Critical or high severity
- Hard to detect (requires domain knowledge)

## Output Format (Phase 2)

Write to `problems.json`:

```json
{
  "research_date": "2026-01-17",
  "technologies": [
    {
      "name": "WordPress",
      "version": "6.8+",
      "common_mistakes": [
        {
          "problem": "getContext() returns undefined in async callbacks",
          "why": "Interactivity API context is lost in setTimeout/requestAnimationFrame due to reactive scope limitations",
          "solution": "Capture context before async: const ctx = getContext(); setTimeout(() => { ctx.prop = 'value'; })",
          "bad_code": "requestAnimationFrame(() => { const ctx = getContext(); ctx.isOpen = true; })",
          "good_code": "const context = getContext(); requestAnimationFrame(() => { if (context) { context.isOpen = true; } });",
          "frequency": "very_common",
          "severity": "high",
          "detectability": "hard",
          "red_flags": [
            "getContext() called inside setTimeout",
            "getContext() called inside requestAnimationFrame",
            "getContext() called in .then() or async/await"
          ],
          "when_to_watch": [
            "Animation callbacks",
            "Delayed actions",
            "Promise chains",
            "Event listeners attached to DOM"
          ],
          "source": "GitHub issues #12345, Stack Overflow, official docs"
        },
        {
          "problem": "Block registration timing - hooks registered too late",
          "why": "WordPress loads blocks early in lifecycle. Priority 20+ means blocks register after Block Editor initialization",
          "solution": "Use init hook with priority 5-10: add_action('init', 'register_blocks', 5)",
          "bad_code": "add_action('init', 'register_blocks', 20);",
          "good_code": "add_action('init', 'register_blocks', 5);",
          "frequency": "common",
          "severity": "medium",
          "detectability": "moderate",
          "red_flags": [
            "init hook priority > 15",
            "Block registration in after_theme_setup"
          ],
          "when_to_watch": [
            "Custom block registration",
            "Block theme setup",
            "Plugin initialization"
          ],
          "source": "WordPress Core Trac, developer handbook"
        }
      ],
      "breaking_changes": [
        {
          "version": "6.8",
          "change": "Block API v3 required for FSE themes",
          "why": "Improved performance and new FSE features require updated API surface",
          "impact": "Older blocks (apiVersion: 2) won't work properly in FSE themes",
          "migration": "Update all block.json files: \"apiVersion\": 3",
          "deadline": "WordPress 7.0 will drop Block API v2 support"
        },
        {
          "version": "6.8",
          "change": "Interactivity API store definition changes",
          "why": "Namespacing to prevent store collisions in complex sites",
          "impact": "Global store objects no longer work",
          "migration": "Wrap stores in store('namespace', {...})",
          "example": "store('myPlugin/store', { state: {}, actions: {} })"
        }
      ],
      "best_practices": [
        {
          "practice": "Always escape output in WordPress",
          "why": "Prevents XSS vulnerabilities",
          "how": "Use esc_html(), esc_attr(), esc_url() for all dynamic output",
          "priority": "critical"
        },
        {
          "practice": "Capture Interactivity API context before async operations",
          "why": "Prevents undefined context errors",
          "how": "const ctx = getContext(); before setTimeout/requestAnimationFrame/promises",
          "priority": "high"
        },
        {
          "practice": "Use transients for expensive queries",
          "why": "Reduces database load and improves performance",
          "how": "set_transient('key', $data, 3600); get_transient('key');",
          "priority": "medium"
        }
      ],
      "performance_tips": [
        "Use transients for caching (set_transient/get_transient)",
        "Enqueue scripts conditionally (only when block is used)",
        "Lazy-load images with loading=\"lazy\" attribute",
        "Minimize database queries in block render callbacks",
        "Use WP_Query properly (avoid query_posts, use pre_get_posts filter)"
      ],
      "security_checklist": [
        "Escape all output (esc_html, esc_attr, esc_url)",
        "Sanitize all input (sanitize_text_field, sanitize_email, etc.)",
        "Verify nonces for forms (wp_nonce_field, wp_verify_nonce)",
        "Check capabilities (current_user_can) before privileged operations",
        "Use prepared statements for database queries ($wpdb->prepare)"
      ]
    },
    {
      "name": "Next.js",
      "version": "15",
      "common_mistakes": [
        {
          "problem": "Server Component vs Client Component confusion",
          "why": "Next.js 15 defaults to Server Components, but many developers use client-only features (hooks, event handlers) without 'use client'",
          "solution": "Add 'use client' directive at top of file if using useState, useEffect, event handlers, or browser APIs",
          "bad_code": "export default function Component() { const [state, setState] = useState(0); ... }",
          "good_code": "'use client';\nexport default function Component() { const [state, setState] = useState(0); ... }",
          "frequency": "very_common",
          "severity": "high",
          "detectability": "easy",
          "red_flags": [
            "useState/useEffect in component without 'use client'",
            "onClick handlers without 'use client'",
            "window or document access without 'use client'"
          ],
          "when_to_watch": [
            "Creating new components",
            "Adding interactivity",
            "Using browser APIs"
          ],
          "source": "Next.js GitHub issues, official docs"
        }
      ],
      "breaking_changes": [
        {
          "version": "15",
          "change": "Async Request APIs (cookies, headers, params)",
          "why": "Better support for dynamic rendering and PPR",
          "impact": "cookies(), headers(), params must be awaited",
          "migration": "const cookieStore = await cookies(); instead of const cookieStore = cookies();",
          "deadline": "Next.js 16 will make this required"
        }
      ],
      "best_practices": [
        {
          "practice": "Keep Server Components by default",
          "why": "Better performance, smaller bundle, SEO-friendly",
          "how": "Only add 'use client' when absolutely necessary",
          "priority": "high"
        }
      ]
    },
    {
      "name": "FastAPI",
      "version": "0.110+",
      "common_mistakes": [
        {
          "problem": "WebSocket connection management - connections not cleaned up",
          "why": "Memory leaks and zombie connections if not handled properly",
          "solution": "Use connection manager pattern with try/finally to ensure cleanup",
          "bad_code": "connections.append(websocket); while True: data = await websocket.receive_text()",
          "good_code": "try: connections.append(websocket); while True: data = await websocket.receive_text(); finally: connections.remove(websocket)",
          "frequency": "common",
          "severity": "high",
          "detectability": "moderate",
          "red_flags": [
            "WebSocket connections added to list without removal",
            "No try/finally in WebSocket handler",
            "No connection timeout handling"
          ],
          "when_to_watch": [
            "WebSocket endpoints",
            "Real-time features",
            "Chat implementations"
          ],
          "source": "FastAPI GitHub issues, community best practices"
        }
      ]
    }
  ],
  "cross_cutting_concerns": [
    {
      "concern": "Authentication Security",
      "common_mistakes": [
        "Storing passwords in plain text",
        "Weak JWT secrets",
        "Missing token expiration",
        "No refresh token rotation"
      ],
      "best_practices": [
        "Use bcrypt/argon2 for password hashing",
        "Use strong, random JWT secrets (256+ bits)",
        "Implement token expiration (15min access, 7day refresh)",
        "Rotate refresh tokens on use"
      ]
    }
  ]
}
```

**Tokens:** 6k summary (full research context ~25k stays in sub-agent)

---

## Usage Notes for Child Skills

**PLANER-ZERO:**
- Input: `project_spec.json` (with tech stack identified from Phase 1 questions)
- Output: `problems.json`

**PLANER-PROGRESS:**
- Input: `project_structure.json` + `feature_inventory.json` (with tech stack identified from Phase 1 codebase discovery)
- Output: `problems.json` (enhanced with project-specific problems found in existing code)
- Enhancement: Also search for problems specific to patterns found in quality scan
