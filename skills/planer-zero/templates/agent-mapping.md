# Agent Mapping Guide

This document maps project types to required tools (agents, skills, commands) for PLANER-ZERO's Phase 3 (Ecosystem Analysis).

---

## Mapping Structure

For each project type, identify:
1. **Required Agents** - Specialized agents needed for implementation
2. **Optional Agents** - Useful but not critical
3. **Skills** - Reusable knowledge patterns
4. **Commands** - Workflow shortcuts
5. **Gap Analysis** - Missing tools that should be created

---

## Web Application Projects

### Next.js SaaS Application

**Required Agents:**
- `nextjs-specialist` (CREATE if missing) - Server/Client component expertise, App Router, Next.js 15
- `backend-development::backend-architect` - Overall architecture, API design
- `data-engineering::database-architect` - PostgreSQL schema design, optimization
- `test-engineer` - Testing strategy, unit + integration tests

**Optional Agents:**
- `backend-development::fastapi-pro` - If using Python backend
- `python-development::python-pro` - Python-specific patterns
- `code-documentation::code-reviewer` - Code quality assurance
- `unit-testing::debugger` - Debugging complex issues

**Skills:**
- `backend-development:api-design-principles` - REST API patterns
- `python-development:async-python-patterns` - If using async Python
- `backend-development:microservices-patterns` - If scaling to microservices

**Commands:**
- `/commit` - Git commits after each task
- `/backend-development:feature-development` - Feature implementation workflow

**Typical Gaps:**
- Next.js 15 specialist (if not created yet)
- Real-time state sync skill (for WebSocket features)
- Authentication patterns skill

---

### E-commerce Platform

**Required Agents:**
- `nextjs-specialist` or `frontend-developer` - Frontend implementation
- `backend-development::backend-architect` - API design, inventory management
- `data-engineering::database-architect` - Product catalog schema, order management
- `test-engineer` - Payment testing, integration testing

**Optional Agents:**
- `backend-api-security::backend-security-coder` - Payment security, PCI compliance
- `data-engineering::data-engineer` - Analytics pipeline for sales data

**Skills:**
- `backend-development:api-design-principles` - REST API for products, orders
- `python-development:fastapi-pro` - FastAPI for backend (if using Python)

**Commands:**
- `/commit`
- `/backend-development:feature-development`

**Typical Gaps:**
- Stripe integration skill
- E-commerce schema patterns
- Payment security specialist

---

### Marketing/Landing Page

**Required Agents:**
- `ui-designer-developer` - Design and frontend implementation
- `nextjs-specialist` - Static site generation, SEO optimization

**Optional Agents:**
- `code-documentation::docs-architect` - Documentation for content team

**Skills:**
- SEO optimization patterns
- Performance optimization (Core Web Vitals)

**Commands:**
- `/commit`
- `/frontend-design` (if available)

**Typical Gaps:**
- SEO specialist
- Landing page conversion patterns

---

## API/Backend Service Projects

### REST API (FastAPI)

**Required Agents:**
- `api-scaffolding::fastapi-pro` or `backend-development::backend-architect`
- `data-engineering::database-architect` - Database schema
- `test-engineer` - API testing
- `backend-api-security::backend-security-coder` - Security validation

**Optional Agents:**
- `python-development::python-pro` - Advanced Python patterns
- `code-documentation::code-reviewer` - Code quality

**Skills:**
- `backend-development:api-design-principles` - REST patterns
- `python-development:async-python-patterns` - Async/await optimization
- `python-development:python-testing-patterns` - pytest patterns

**Commands:**
- `/commit`
- `/backend-development:feature-development`

**Typical Gaps:**
- FastAPI WebSocket specialist (if real-time features)
- Rate limiting patterns
- API versioning strategy

---

### GraphQL API

**Required Agents:**
- `api-scaffolding::graphql-architect` or `backend-development::graphql-architect`
- `backend-development::backend-architect` - Overall architecture
- `data-engineering::database-architect` - Database schema, N+1 prevention
- `test-engineer` - GraphQL query testing

**Optional Agents:**
- `backend-api-security::backend-security-coder` - Query depth limiting, security

**Skills:**
- `backend-development:graphql-architect` - Schema design, federation
- `data-engineering:data-quality-frameworks` - Data validation

**Commands:**
- `/commit`

**Typical Gaps:**
- GraphQL federation patterns
- Subscription (real-time) specialist
- DataLoader patterns skill

---

### Microservices Architecture

**Required Agents:**
- `backend-development::backend-architect` - Service boundaries, communication patterns
- `data-engineering::database-architect` - Per-service database design
- `test-engineer` - Integration testing, contract testing
- `backend-api-security::backend-security-coder` - Service-to-service auth

**Optional Agents:**
- `backend-development::temporal-python-pro` - Workflow orchestration with Temporal
- `data-engineering::airflow-dag-patterns` - If using Airflow for orchestration

**Skills:**
- `backend-development:microservices-patterns` - Service design, communication
- `backend-development:saga-orchestration` - Distributed transactions
- `backend-development:event-sourcing-architect` - Event-driven architecture

**Commands:**
- `/commit`

**Typical Gaps:**
- Service mesh specialist (Istio, Linkerd)
- API Gateway configuration (Kong, Nginx)
- Kubernetes deployment patterns

---

## WordPress Projects

### Block Theme (FSE)

**Required Agents:**
- `wordpress-specialist` (CREATE if missing) - Interactivity API, FSE, hooks
- `wordpress-modern-architect` - Block development, theme.json
- `ui-designer-developer` - Design system, component UI

**Optional Agents:**
- `code-documentation::code-reviewer` - Code quality for PHP/JS
- `test-engineer` - PHPUnit, Jest testing

**Skills:**
- WordPress Interactivity API patterns
- WordPress hooks best practices
- Block development patterns

**Commands:**
- `/wp-block-init` - Initialize custom block
- `/commit`

**Typical Gaps:**
- WordPress Interactivity API specialist (async context handling)
- FSE theme.json patterns
- WordPress performance optimization

---

### Custom Plugin

**Required Agents:**
- `wordpress-specialist` or `wordpress-modern-architect`
- `backend-development::backend-architect` - Plugin architecture

**Optional Agents:**
- `ui-designer-developer` - Admin UI design
- `test-engineer` - PHPUnit testing

**Skills:**
- WordPress hooks (actions, filters)
- WordPress security (nonces, capabilities)
- Custom post types and taxonomies

**Commands:**
- `/commit`

**Typical Gaps:**
- WordPress plugin scaffolding
- Admin UI patterns (React in WordPress admin)
- WordPress REST API extension patterns

---

### Headless WordPress

**Required Agents:**
- `wordpress-specialist` - WordPress backend, WPGraphQL
- `nextjs-specialist` - Frontend (Next.js)
- `backend-development::backend-architect` - API strategy

**Optional Agents:**
- `test-engineer` - API testing, preview mode testing

**Skills:**
- WPGraphQL schema design
- Next.js ISR/SSG strategies
- WordPress authentication (JWT, Application Passwords)

**Commands:**
- `/wp-block-init` (if custom blocks needed)
- `/commit`

**Typical Gaps:**
- WPGraphQL specialist
- WordPress JWT authentication
- Next.js preview mode with WordPress

---

## Data Pipeline Projects

### ETL Pipeline (Airflow + dbt)

**Required Agents:**
- `data-engineering::data-engineer` - Pipeline design, ETL logic
- `data-engineering::database-architect` - Data warehouse schema
- `test-engineer` - Data quality testing

**Optional Agents:**
- `python-development::python-pro` - Advanced Python patterns
- `backend-development::backend-architect` - API integrations

**Skills:**
- `data-engineering:airflow-dag-patterns` - DAG design, operators
- `data-engineering:dbt-transformation-patterns` - dbt models, tests
- `data-engineering:data-quality-frameworks` - Great Expectations, dbt tests
- `python-development:python-testing-patterns` - pytest for data pipelines

**Commands:**
- `/commit`

**Typical Gaps:**
- Airflow best practices (2026)
- dbt incremental model patterns
- Data quality monitoring specialist

---

### Real-time Streaming (Kafka + Flink)

**Required Agents:**
- `data-engineering::data-engineer` - Stream processing, Kafka topics
- `backend-development::backend-architect` - Event schema design
- `test-engineer` - Stream processing testing

**Optional Agents:**
- `backend-development::event-sourcing-architect` - Event sourcing patterns

**Skills:**
- `backend-development:event-sourcing-architect` - Event-driven architecture
- `data-engineering:spark-optimization` - If using Spark Streaming

**Commands:**
- `/commit`

**Typical Gaps:**
- Kafka Streams specialist
- Apache Flink patterns
- Stream schema evolution (Avro, Protobuf)

---

### Analytics/BI Platform (dbt + Looker)

**Required Agents:**
- `data-engineering::data-engineer` - dbt models, data transformations
- `data-engineering::database-architect` - Data warehouse schema (star/snowflake)

**Optional Agents:**
- `code-documentation::docs-architect` - Data catalog, documentation

**Skills:**
- `data-engineering:dbt-transformation-patterns` - dbt models, macros, tests
- `data-engineering:data-quality-frameworks` - Data validation

**Commands:**
- `/commit`

**Typical Gaps:**
- dbt advanced patterns (snapshots, incremental models)
- Looker LookML specialist
- Data modeling specialist (Kimball, Data Vault)

---

## Mobile Application Projects

### React Native App

**Required Agents:**
- `frontend-mobile-development::frontend-developer` - React Native implementation
- `backend-development::backend-architect` - API design for mobile
- `test-engineer` - Mobile testing (Jest, Detox)

**Optional Agents:**
- `ui-designer-developer` - Mobile UI/UX design

**Skills:**
- React Native navigation patterns
- React Native state management
- Mobile API optimization (offline support)

**Commands:**
- `/commit`

**Typical Gaps:**
- React Native specialist (Expo vs bare)
- Push notification patterns
- Offline-first architecture

---

### Flutter App

**Required Agents:**
- `frontend-mobile-development::frontend-developer` - Flutter implementation (if supports Dart)
- `backend-development::backend-architect` - API design

**Optional Agents:**
- `ui-designer-developer` - Material/Cupertino design

**Skills:**
- Flutter state management (Provider, Riverpod, Bloc)
- Flutter navigation
- Dart async patterns

**Commands:**
- `/commit`

**Typical Gaps:**
- Flutter specialist
- Dart language expert
- Flutter platform channels (native integration)

---

## Desktop Application Projects

### Electron App

**Required Agents:**
- `frontend-mobile-development::frontend-developer` - Frontend (React, Vue, etc.)
- `backend-development::backend-architect` - Electron main process, IPC

**Optional Agents:**
- `ui-designer-developer` - Desktop UI design
- `test-engineer` - Electron testing

**Skills:**
- Electron IPC patterns
- Auto-updater patterns
- Native menu/tray integration

**Commands:**
- `/commit`

**Typical Gaps:**
- Electron specialist
- Desktop app security (code signing, sandboxing)
- Cross-platform packaging

---

### Tauri App

**Required Agents:**
- `frontend-mobile-development::frontend-developer` - Frontend (React, Vue, etc.)
- Rust specialist (CREATE if missing) - Tauri backend commands

**Optional Agents:**
- `ui-designer-developer` - Desktop UI design

**Skills:**
- Tauri command patterns
- Rust async patterns
- Frontend-to-Rust communication

**Commands:**
- `/commit`

**Typical Gaps:**
- Tauri specialist
- Rust language expert
- Desktop app packaging (Tauri)

---

## Blockchain/Web3 Projects

### DeFi Protocol

**Required Agents:**
- `blockchain-web3::blockchain-developer` - Solidity, smart contracts
- `frontend-mobile-development::frontend-developer` - Web3 frontend
- `test-engineer` - Smart contract testing (Hardhat, Foundry)

**Optional Agents:**
- `backend-api-security::backend-security-coder` - Smart contract security auditing

**Skills:**
- `blockchain-web3:solidity-security` - Security best practices
- `blockchain-web3:defi-protocol-templates` - Staking, AMM, governance patterns
- `blockchain-web3:web3-testing` - Hardhat, Foundry testing

**Commands:**
- `/commit`

**Typical Gaps:**
- Gas optimization specialist
- DeFi security auditor
- The Graph (subgraph) specialist

---

### NFT Platform

**Required Agents:**
- `blockchain-web3::blockchain-developer` - ERC-721/ERC-1155 contracts
- `frontend-mobile-development::frontend-developer` - NFT marketplace frontend
- `test-engineer` - NFT contract testing

**Optional Agents:**
- `ui-designer-developer` - NFT gallery UI

**Skills:**
- `blockchain-web3:nft-standards` - ERC-721, ERC-1155, metadata
- `blockchain-web3:solidity-security` - NFT security patterns

**Commands:**
- `/commit`

**Typical Gaps:**
- IPFS integration specialist
- NFT royalty standards (EIP-2981)
- OpenSea metadata compatibility

---

## Cross-Cutting Concerns

### Testing (All Projects)

**Required Agents:**
- `test-engineer` - Testing strategy, implementation

**Optional Agents:**
- `unit-testing::test-automator` - Test automation, CI/CD integration
- `unit-testing::debugger` - Debugging test failures

**Skills:**
- `python-development:python-testing-patterns` - pytest (for Python projects)
- `blockchain-web3:web3-testing` - Smart contract testing (for Web3 projects)

---

### Security (All Projects)

**Required Agents:**
- `backend-api-security::backend-security-coder` - Security validation, penetration testing

**Optional Agents:**
- `code-documentation::code-reviewer` - Security code review
- `blockchain-web3::blockchain-developer` - Smart contract auditing (for Web3 projects)

**Skills:**
- `blockchain-web3:solidity-security` - Smart contract security (for Web3 projects)

---

### Documentation (All Projects)

**Optional Agents:**
- `code-documentation::docs-architect` - Technical documentation, architecture docs
- `code-documentation::tutorial-engineer` - Tutorial creation, onboarding guides

---

## Gap Identification Algorithm

### Phase 3 Logic

For each project type:

1. **Load required agents from mapping above**
2. **Check which agents exist** in Claude Code
3. **Identify gaps:**
   - Technology-specific specialist missing (e.g., `nextjs-specialist`, `wordpress-specialist`)
   - Skill missing for common pattern (e.g., `realtime-state-sync`)
   - Command missing for workflow (e.g., `/wp-theme-setup`)

4. **Cross-reference with problems.json:**
   - If researched problems exist for a technology WITHOUT a specialist agent → CREATE specialist
   - Example: WordPress + Interactivity API problems → Create `wordpress-specialist`

5. **Recommend tool creation:**
   - **Agent** if role-based expertise needed (e.g., `nextjs-specialist`)
   - **Skill** if reusable knowledge pattern (e.g., `realtime-state-sync`)
   - **Command** if workflow shortcut (e.g., `/deploy-to-vercel`)

---

## Example Gap Analysis

### Project: Next.js SaaS with Real-Time Features

**Identified Needs:**
- Next.js 15 expertise
- FastAPI WebSocket implementation
- Real-time state synchronization
- PostgreSQL schema design
- Authentication (Supabase)

**Existing Tools:**
- ✅ `backend-development::backend-architect` - API architecture
- ✅ `data-engineering::database-architect` - PostgreSQL
- ✅ `test-engineer` - Testing

**Gaps:**
- ❌ No `nextjs-specialist` → Developers likely to make Server/Client Component mistakes
- ❌ No `fastapi-websocket-specialist` → Connection management issues, memory leaks
- ❌ No `realtime-state-sync` skill → Inconsistent state, race conditions

**Recommendation:**
CREATE 3 tools:
1. `~/.claude/agents/nextjs-specialist.md` (agent)
2. `~/.claude/agents/fastapi-websocket-specialist.md` (agent)
3. `~/.claude/skills/realtime-state-sync/SKILL.md` (skill)

---

## Adding New Mappings

To add a new project type mapping:

1. **Identify project characteristics** (from project-types.md)
2. **List required agents** based on tech stack
3. **List optional agents** for enhancements
4. **Identify typical gaps** (patterns you've seen)
5. **Add to this document** following format above
6. **Update gap identification algorithm** if needed

---

**Last Updated:** 2026-01-17
**Version:** 1.0
