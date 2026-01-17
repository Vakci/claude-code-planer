# Project Type Templates

This document defines common project types and their associated question flows for PLANER-ZERO's Phase 1 (Project Discovery).

---

## Web Application Projects

### SaaS Application

**Characteristics:**
- Multi-tenant architecture
- User accounts and authentication
- Subscription/payment processing
- Real-time features (often)
- Database-driven
- API backend + frontend

**Typical Stack:**
- Frontend: Next.js, React, Vue, Svelte
- Backend: Node.js, Python (FastAPI/Django), Go
- Database: PostgreSQL, MongoDB
- Auth: Supabase, Auth0, Clerk, custom JWT
- Payments: Stripe, Paddle
- Deployment: Vercel, AWS, Docker

**Key Questions:**
1. Frontend framework?
2. Backend technology?
3. Database system?
4. Real-time features needed? (WebSockets, SSE)
5. Authentication method?
6. Payment processing? (Stripe, Paddle, etc.)
7. Deployment platform?

**Common Features:**
- User registration/login
- Dashboard/admin panel
- Data CRUD operations
- Real-time updates
- File uploads
- Email notifications
- Subscription management

---

### E-commerce Platform

**Characteristics:**
- Product catalog
- Shopping cart
- Payment processing
- Inventory management
- Order fulfillment
- Customer accounts

**Typical Stack:**
- Frontend: Next.js, React, Vue
- Backend: Node.js, Python, Shopify API
- Database: PostgreSQL, MongoDB
- Payment: Stripe, PayPal, Square
- Search: Elasticsearch, Algolia
- Deployment: Vercel, AWS, Shopify

**Key Questions:**
1. Build custom or use platform? (Shopify, WooCommerce, custom)
2. Frontend framework?
3. Payment gateway?
4. Inventory management needs?
5. Search functionality? (Algolia, Elasticsearch)
6. Multi-currency support?
7. Shipping integration?

**Common Features:**
- Product browsing and search
- Cart and checkout
- Payment processing
- Order tracking
- Customer reviews
- Admin dashboard for products/orders

---

### Marketing/Landing Page

**Characteristics:**
- Mostly static content
- SEO-focused
- Fast performance
- Contact forms
- Analytics integration

**Typical Stack:**
- Frontend: Next.js (SSG), Astro, Hugo, Gatsby
- CMS: Contentful, Sanity, WordPress headless
- Forms: Formspree, Netlify Forms
- Analytics: Google Analytics, Plausible
- Deployment: Vercel, Netlify, Cloudflare Pages

**Key Questions:**
1. Static site generator or framework?
2. Need CMS for content management?
3. Form handling?
4. Analytics requirements?
5. SEO importance? (high = static generation)

**Common Features:**
- Hero section
- Features/benefits
- Pricing tables
- Contact forms
- Blog
- Testimonials

---

### Content Management System (Blog, News)

**Characteristics:**
- Content creation and editing
- User roles (authors, editors, admins)
- Rich text editing
- Media management
- SEO optimization

**Typical Stack:**
- Frontend: Next.js, Nuxt, Astro
- CMS: WordPress, Contentful, Sanity, Strapi
- Backend: WordPress API, Headless CMS API
- Database: PostgreSQL, MySQL
- Deployment: Vercel, WordPress hosting

**Key Questions:**
1. Headless CMS or traditional? (WordPress, Contentful, custom)
2. Frontend framework? (Next.js for headless, traditional for WordPress)
3. User roles needed?
4. Media handling? (images, videos)
5. Comment system?
6. Multi-language support?

**Common Features:**
- Article creation/editing
- Media library
- Categories and tags
- User management
- Comments
- SEO metadata

---

## API/Backend Service Projects

### REST API

**Characteristics:**
- HTTP-based CRUD operations
- JSON responses
- Stateless
- Authentication (JWT, API keys)
- Database integration

**Typical Stack:**
- Backend: Node.js (Express/Fastify), Python (FastAPI), Go, Rust
- Database: PostgreSQL, MongoDB, MySQL
- Auth: JWT, OAuth 2.0
- Documentation: Swagger/OpenAPI
- Deployment: AWS, Docker, Heroku

**Key Questions:**
1. Backend language/framework?
2. Database system?
3. Authentication strategy? (JWT, OAuth, API keys)
4. Rate limiting needed?
5. API versioning?
6. Documentation tool? (Swagger, Postman)

**Common Endpoints:**
- User authentication
- CRUD operations for resources
- Search and filtering
- File uploads
- Webhook handling

---

### GraphQL API

**Characteristics:**
- Single endpoint
- Client-defined queries
- Type system
- Real-time subscriptions (optional)

**Typical Stack:**
- Backend: Node.js (Apollo Server), Python (Strawberry), Go (gqlgen)
- Database: PostgreSQL, MongoDB
- Client: Apollo Client, urql
- Deployment: AWS, Docker

**Key Questions:**
1. Backend language?
2. Database system?
3. Need subscriptions? (real-time)
4. Federation? (multiple GraphQL services)
5. Caching strategy?

**Common Features:**
- Type-safe queries
- Nested data fetching
- Subscriptions for real-time
- Query batching

---

### Microservices

**Characteristics:**
- Multiple independent services
- Inter-service communication (REST, gRPC, message queues)
- Service discovery
- Distributed architecture

**Typical Stack:**
- Services: Node.js, Go, Python, Java
- Communication: REST, gRPC, RabbitMQ, Kafka
- Database: Per-service (PostgreSQL, MongoDB, Redis)
- Orchestration: Kubernetes, Docker Compose
- API Gateway: Kong, Nginx

**Key Questions:**
1. Number of services?
2. Communication pattern? (REST, gRPC, event-driven)
3. Service discovery? (Consul, Kubernetes)
4. API Gateway?
5. Message queue? (RabbitMQ, Kafka)
6. Deployment platform? (Kubernetes, Docker Swarm)

**Common Services:**
- Auth service
- User service
- Payment service
- Notification service
- API Gateway

---

## WordPress Projects

### Block Theme (FSE)

**Characteristics:**
- Full Site Editing
- theme.json configuration
- Block-based templates
- No PHP template files
- Modern WordPress 6.8+

**Typical Stack:**
- WordPress: 6.8+
- Build tool: @wordpress/scripts
- Blocks: Custom with Interactivity API
- Styling: theme.json, CSS
- Deployment: WordPress hosting

**Key Questions:**
1. Interactive features? (Interactivity API vs server-side)
2. Custom blocks needed?
3. Build tool? (@wordpress/scripts vs Vite)
4. Global styles approach? (theme.json variations)

**Common Components:**
- Header/footer patterns
- Custom blocks (hero, testimonials, FAQ)
- Template parts
- Style variations

---

### Custom Plugin

**Characteristics:**
- Extends WordPress functionality
- Hooks and filters
- Admin UI
- Settings management

**Typical Stack:**
- WordPress: 6.0+
- Build tool: @wordpress/scripts, Vite
- Admin UI: React, WordPress components
- Database: Custom tables or post meta
- Deployment: WordPress plugin repository, private

**Key Questions:**
1. Plugin functionality?
2. Admin interface? (React vs traditional PHP)
3. Custom database tables?
4. Public-facing UI?
5. Integration with other plugins?

**Common Features:**
- Settings page
- Custom post types
- REST API endpoints
- Shortcodes
- Admin dashboard widgets

---

### Headless WordPress

**Characteristics:**
- WordPress as CMS only
- Frontend decoupled (Next.js, React, etc.)
- REST API or GraphQL (WPGraphQL)

**Typical Stack:**
- Backend: WordPress 6.0+
- API: REST API or WPGraphQL
- Frontend: Next.js, Nuxt, Gatsby
- Auth: JWT, Application Passwords
- Deployment: WordPress backend (any host), frontend (Vercel)

**Key Questions:**
1. REST API or GraphQL?
2. Frontend framework?
3. Authentication method?
4. Preview functionality needed?
5. ISR/SSG strategy?

**Common Features:**
- Content fetching from WordPress
- Post/page rendering
- Media handling
- SEO metadata
- Preview mode

---

## Data Pipeline Projects

### ETL Pipeline

**Characteristics:**
- Extract data from sources
- Transform data
- Load into data warehouse
- Batch processing
- Scheduled jobs

**Typical Stack:**
- Orchestration: Apache Airflow, Prefect, Dagster
- Processing: Python (Pandas, PySpark), Apache Spark
- Data Warehouse: Snowflake, BigQuery, Redshift
- Storage: S3, GCS
- Deployment: Kubernetes, cloud VMs

**Key Questions:**
1. Data sources? (databases, APIs, files)
2. Orchestration tool? (Airflow, Prefect, Dagster)
3. Processing framework? (Pandas, Spark, Dask)
4. Data warehouse? (Snowflake, BigQuery, Redshift)
5. Schedule frequency? (hourly, daily, real-time)

**Common Tasks:**
- Data extraction from APIs/databases
- Data cleaning and validation
- Data transformation (joins, aggregations)
- Loading to warehouse
- Data quality checks

---

### Real-time Streaming

**Characteristics:**
- Continuous data processing
- Low latency
- Event-driven architecture

**Typical Stack:**
- Stream processing: Kafka Streams, Apache Flink, Spark Streaming
- Message queue: Apache Kafka, AWS Kinesis
- Storage: Kafka, S3, Elasticsearch
- Processing: Python, Java, Scala
- Deployment: Kubernetes, cloud streaming services

**Key Questions:**
1. Streaming platform? (Kafka, Kinesis, Pulsar)
2. Processing framework? (Kafka Streams, Flink, Spark Streaming)
3. Data volume? (MB/s, GB/s)
4. Latency requirements? (<1s, <100ms)
5. Sink destinations? (databases, data lakes, dashboards)

**Common Components:**
- Event producers
- Stream processors
- Consumers/sinks
- State management
- Schema registry

---

### Analytics/BI Platform

**Characteristics:**
- Data modeling
- SQL-based transformations
- Dashboards and reporting
- Business metrics

**Typical Stack:**
- Transformation: dbt (data build tool)
- Warehouse: Snowflake, BigQuery, Redshift
- BI Tool: Tableau, Looker, Metabase, Superset
- Orchestration: Airflow, dbt Cloud
- Deployment: Cloud-based

**Key Questions:**
1. Data warehouse? (Snowflake, BigQuery, Redshift)
2. Transformation tool? (dbt, SQL stored procedures)
3. BI/visualization tool? (Tableau, Looker, Metabase)
4. Data modeling approach? (Kimball, Data Vault, normalized)
5. User access control?

**Common Components:**
- dbt models (staging, intermediate, mart)
- Dashboards
- Data quality tests
- Documentation
- Access control policies

---

## Mobile Application Projects

### React Native App

**Characteristics:**
- Cross-platform (iOS + Android)
- JavaScript/TypeScript
- Native modules when needed

**Typical Stack:**
- Framework: React Native, Expo
- Navigation: React Navigation
- State: Redux, Zustand, React Query
- Backend: REST API, GraphQL, Firebase
- Deployment: App Store, Google Play

**Key Questions:**
1. Expo or bare React Native?
2. Navigation library?
3. State management?
4. Backend integration?
5. Native modules needed?
6. Push notifications?

**Common Features:**
- Authentication screens
- Tab navigation
- Push notifications
- Camera/photo access
- Offline support
- In-app purchases

---

### Flutter App

**Characteristics:**
- Cross-platform (iOS + Android + Web)
- Dart language
- High performance UI

**Typical Stack:**
- Framework: Flutter
- State: Provider, Riverpod, Bloc
- Backend: REST API, GraphQL, Firebase
- Deployment: App Store, Google Play, Web

**Key Questions:**
1. State management? (Provider, Riverpod, Bloc)
2. Backend integration?
3. Target platforms? (iOS, Android, Web, Desktop)
4. Offline support?
5. Push notifications?

**Common Features:**
- Material/Cupertino design
- Navigation
- Authentication
- API integration
- Local storage (SQLite, Hive)

---

## Desktop Application Projects

### Electron App

**Characteristics:**
- Cross-platform desktop (Windows, macOS, Linux)
- Web technologies (HTML, CSS, JS)
- Native OS integration

**Typical Stack:**
- Framework: Electron
- Frontend: React, Vue, Svelte
- Bundler: Webpack, Vite
- Updates: electron-updater
- Deployment: DMG, MSI, AppImage

**Key Questions:**
1. Frontend framework?
2. Auto-updates needed?
3. Native features? (file system, system tray, notifications)
4. Distribution method? (website, app stores)

**Common Features:**
- Menu bar
- System tray integration
- File system access
- Auto-updates
- Native dialogs

---

### Tauri App

**Characteristics:**
- Cross-platform desktop
- Web frontend + Rust backend
- Smaller bundle size than Electron

**Typical Stack:**
- Framework: Tauri
- Frontend: React, Vue, Svelte
- Backend: Rust
- Bundler: Vite
- Deployment: Native installers

**Key Questions:**
1. Frontend framework?
2. Rust backend functionality needed?
3. System integrations?
4. Distribution method?

**Common Features:**
- Lightweight native wrapper
- System tray
- File system access
- Auto-updates
- Native notifications

---

## Blockchain/Web3 Projects

### DeFi Protocol

**Characteristics:**
- Smart contracts (Solidity)
- Token operations
- Liquidity pools
- Blockchain integration

**Typical Stack:**
- Smart Contracts: Solidity, Hardhat/Foundry
- Blockchain: Ethereum, Polygon, BSC
- Frontend: React, Next.js, ethers.js/web3.js
- Testing: Hardhat, Foundry
- Deployment: Mainnet, Testnet

**Key Questions:**
1. Blockchain network? (Ethereum, Polygon, BSC, Arbitrum)
2. Protocol type? (DEX, lending, staking, governance)
3. Token standards? (ERC-20, ERC-721, ERC-1155)
4. Testing framework? (Hardhat, Foundry)
5. Audit requirements?

**Common Components:**
- Smart contracts (ERC-20 tokens, staking, governance)
- Web3 frontend
- Wallet integration (MetaMask, WalletConnect)
- Subgraph (The Graph) for indexing

---

### NFT Platform

**Characteristics:**
- NFT minting
- Marketplace
- Metadata storage
- Blockchain integration

**Typical Stack:**
- Smart Contracts: Solidity (ERC-721, ERC-1155)
- Frontend: React, Next.js, ethers.js
- Metadata: IPFS, Arweave
- Blockchain: Ethereum, Polygon
- Deployment: Mainnet, Testnet

**Key Questions:**
1. NFT standard? (ERC-721, ERC-1155)
2. Metadata storage? (IPFS, Arweave, centralized)
3. Marketplace features? (auctions, fixed price, offers)
4. Royalties? (EIP-2981)
5. Blockchain network?

**Common Features:**
- NFT minting
- Marketplace (buy, sell, auction)
- Wallet connection
- NFT gallery
- Metadata display

---

## Project Type Selection Logic

### How PLANER-ZERO Chooses Questions

1. **First question:** "What type of project are you building?"
   - Options: Web App, API/Backend, WordPress, Data Pipeline, Mobile, Desktop, Blockchain, Other

2. **Based on selection, load project type template:**
   - Web App → Ask: SaaS, E-commerce, Landing Page, CMS
   - API/Backend → Ask: REST, GraphQL, Microservices
   - WordPress → Ask: Block Theme, Plugin, Headless
   - Data Pipeline → Ask: ETL, Real-time Streaming, Analytics
   - Mobile → Ask: React Native, Flutter
   - Desktop → Ask: Electron, Tauri
   - Blockchain → Ask: DeFi, NFT, DAO

3. **Load template-specific questions** (3-7 follow-up questions)

4. **Capture additional context:**
   - Team size
   - Timeline constraints
   - Performance requirements
   - Scalability needs

---

## Adding New Project Types

To add a new project type:

1. **Define characteristics:**
   - Core functionality
   - Typical tech stack
   - Common features

2. **Create question template:**
   - 3-7 key questions
   - Options with descriptions
   - Tradeoffs explained

3. **Add to selection logic:**
   - Update first question options
   - Map to question flow

4. **Document in this file:**
   - Follow format above
   - Include examples
   - Explain tradeoffs

---

**Last Updated:** 2026-01-17
**Version:** 1.0
