# Changelog

All notable changes to PLANER will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-01-17

### 🎉 Initial Release

**PLANER v1.0** - Master Project Orchestration for Claude Code

### Added

#### Core Features
- **PLANER (Parent)** - Auto-detection router for greenfield vs in-progress projects
- **PLANER-ZERO** - Greenfield project planning workflow (6 phases)
- **PLANER-PROGRESS** - In-progress project continuation roadmap (7 phases)

#### Shared Phases (DRY Principle)
- **Phase 2: Problem Research** - WebSearch for 2025-2026 tech stack issues
- **Phase 3: Ecosystem Analysis** - Identify existing tools and gaps
- **Phase 4: Specialist Generation** - Create problem-aware reusable agents

#### Context Management
- File-based handoffs via JSON outputs
- Sub-agent delegation for heavy processing (Explore, WebSearch)
- Main context usage <30% (58k of 200k tokens)
- Isolated sub-agent contexts (145k tokens)

#### Problem-Aware Development
- WebSearch queries for recent common mistakes (2025-2026)
- Problem classification (frequency, severity, detectability)
- Bad/good code examples
- Red flags for code review
- Specialist agents with embedded knowledge

#### Task Management
- Task categorization (FIX, IMPROVE, ADD, TEST, DOCUMENT, REFACTOR, DEPLOY)
- Priority matrix (P0-P3)
- Dependency tracking
- Parallel execution recommendations

#### Templates
- **PLANER-ZERO:**
  - `project_spec.md` - Project specification from questions
  - `implementation_plan.md` - 8-15 task breakdown with commands

- **PLANER-PROGRESS:**
  - `project_structure.json` - Codebase analysis
  - `feature_inventory.json` - Feature catalog
  - `quality_report.json` - Code quality scan
  - `gap_analysis.json` - Missing features and technical debt
  - `task_roadmap.json` - Categorized and prioritized tasks
  - `continuation_roadmap.md` - Actionable continuation plan

- **Shared Templates:**
  - `problems.json` - Tech stack problem research
  - `tool_inventory.json` - Ecosystem analysis
  - `specialist-agent-template.md` - Agent generation template

### Fixed
- Updated all Task tool references to use correct Claude Code API (removed outdated `agent-orchestration::context-manager`)
- Added documentation for proper Task tool syntax (removed `/task --agent=name` format)
- Fixed shared phase references to use parent-child inheritance

### Documentation
- Comprehensive README with quick start, examples, and architecture
- Installation guide
- Contributing guidelines
- MIT License
- This CHANGELOG

### Technical Details
- **Supported Tech Stacks:** WordPress, Next.js, FastAPI, PostgreSQL, Supabase, Python, TypeScript, JavaScript
- **Minimum Claude Code Version:** 1.0
- **Context Budget:** <30% main agent, up to 145k isolated sub-agents
- **Output Files:** 8-10 JSON/MD files per run

---

## [Unreleased]

### Planned for v1.1.0 (Q2 2026)

#### Features
- **PLANER-MIGRATE** - Tech stack migration planning
  - Phase 1: Analyze current stack
  - Phase 2-5: Shared phases (problem research, ecosystem, specialists)
  - Phase 6: Migration roadmap with step-by-step guide

- **Git History Analysis**
  - Change pattern detection
  - Contributor activity
  - Hot spot identification (files with most changes)
  - Blame analysis for bug-prone areas

- **Enhanced Problem Research**
  - Stack Overflow integration (not just GitHub)
  - Official documentation scraping
  - Version-specific breaking changes detection
  - Deprecation warnings

#### Improvements
- Faster problem research (parallel WebSearch queries)
- Better auto-detection (more heuristics)
- Improved specialist agent templates
- More comprehensive examples

#### Bug Fixes
- TBD based on user feedback

---

## [Unreleased] v1.2.0 (Q3 2026)

### Planned Features

#### Team Collaboration
- Multi-developer project support
- Contributor analysis (who worked on what)
- Responsibility mapping
- Knowledge gaps identification

#### Security Scanning
- Automated dependency vulnerability scanning
- Secret detection (API keys, passwords in code)
- Security best practice validation
- CVE database integration

#### Performance Benchmarking
- Lighthouse score tracking
- Bundle size analysis
- Database query performance
- API response time monitoring

---

## [Unreleased] v2.0.0 (Q4 2026)

### Planned Major Changes

#### Multi-Language Support
- Documentation translation (Spanish, German, French, etc.)
- Localized problem research
- i18n best practices integration

#### CI/CD Integration
- GitHub Actions templates
- GitLab CI templates
- Automated plan validation
- Deployment readiness checks

#### Real-Time Monitoring
- Project health dashboard
- Progress tracking
- Metric visualization
- Alert system for regressions

#### Breaking Changes
- TBD (will maintain backward compatibility where possible)

---

## Version History Summary

| Version | Release Date | Major Changes |
|---------|--------------|---------------|
| 1.0.0   | 2026-01-17  | Initial release with PLANER-ZERO and PLANER-PROGRESS |
| 1.1.0   | Q2 2026     | PLANER-MIGRATE, git history analysis |
| 1.2.0   | Q3 2026     | Team collaboration, security scanning |
| 2.0.0   | Q4 2026     | Multi-language, CI/CD, real-time monitoring |

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on proposing changes and submitting pull requests.

---

## Links

- **GitHub Repository:** https://github.com/Vakci/claude-code-planer
- **Documentation:** [docs/](docs/)
- **Issues:** https://github.com/Vakci/claude-code-planer/issues
- **Discussions:** https://github.com/Vakci/claude-code-planer/discussions

---

**Maintained by:** [Your Name]
**License:** MIT
