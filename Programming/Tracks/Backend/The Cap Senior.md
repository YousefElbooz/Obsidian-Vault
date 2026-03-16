---
title: The Tech Lead Simulator (45 Architectural Trials)
tags: [projects, architecture, spring-boot, tech-lead, system-design, hands-on, microservices]
status: In Progress
date-created: {{date}}
---

# The Tech Lead Simulator: 45 Architectural Trials

## Track 1: Productivity SaaS & EdTech (Focus & Habit Tracking)
**Business Model:** B2C Freemium & B2B Enterprise. Students and software engineers use the core focus timer and habit tracker for free. Universities and engineering teams pay a per-seat subscription for aggregated analytics, team leaderboards, and administrative controls.
* **Functional Requirements (FRs):** Track daily habits, execute Pomodoro focus sessions, generate weekly analytics, and manage team workspaces.
* **Non-Functional Requirements (NFRs):** 99.9% uptime, API response < 100ms, seamless sync across web and mobile, and strict isolation of tenant data.

### The Trials:
* [ ] **Trial 1 (JPA Mastery):** Design the relational schema. Write a query to fetch a user's dashboard (User, Habits, Daily Logs) in **exactly one SQL query** using `@EntityGraph` to eliminate N+1.
* [ ] **Trial 2 (The Thundering Herd):** Implement a "Global Focus Event" that starts at exactly 8:00 AM. Use a Token Bucket algorithm via **Bucket4j** and an **Apache Kafka** queue to absorb the massive traffic spike.
* [ ] **Trial 3 (Multi-Tenancy):** Transition to B2B. Implement dynamic database routing (`AbstractRoutingDataSource`) where the incoming JWT dictates which company's database the app connects to.
* [ ] **Trial 4 (Strangler Fig Pattern):** Extract the `Authentication` module from a legacy Node.js monolith into a new Spring Boot microservice. Configure an API Gateway to route `/api/auth` to Spring, and the rest to Node.
* [ ] **Trial 5 (Batch Processing):** Millions of users need streaks calculated at midnight. Use **Spring Batch** to read users in chunks of 1,000, process, and write back without OutOfMemory (OOM) errors.
* [ ] **Trial 6 (Pen & Paper - System Design):** Draw a **C4 Model** (Context, Container, Component) of this SaaS platform.
* [ ] **Trial 7 (Offline Sync Conflicts):** A user's mobile app goes offline. They check off 3 habits and reconnect later. Implement a conflict resolution strategy (e.g., "Last Write Wins" using timestamps) to sync the cached mobile data with the central database safely.
* [ ] **Trial 8 (Gamification Rules Engine):** Achievements unlock dynamically (e.g., "7 days of 4+ hours focus"). Implement the **Observer Pattern** where a `FocusSessionCompletedEvent` triggers a separate rules engine to evaluate and award badges asynchronously.
* [ ] **Trial 9 (GDPR Data Export):** Build an asynchronous background job triggered by a user request that gathers all their data across multiple tables, compresses it into a `.zip` file, saves it to AWS S3/MinIO, and emails them a secure download link.

---

## Track 2: HealthTech (Mental Wellness Platform for Youth)
**Business Model:** B2B2C. Schools and parents pay subscriptions to provide youth with secure, anonymous access to certified counselors, mood tracking, and peer support groups.
* **FRs:** Secure messaging, emergency SOS triggers, appointment booking, mood tracking, and counselor dashboards.
* **NFRs:** Strict HIPAA compliance, absolute data anonymity for peer groups, zero-data-loss for chat logs, and < 50ms latency for SOS alerts.



### The Trials:
* [ ] **Trial 10 (HIPAA-Level Encryption):** Implement an `@PrePersist` and `@PostLoad` Entity Listener to transparently encrypt/decrypt the `therapy_notes` column using **AES-256**.
* [ ] **Trial 11 (Concurrency & Double-Booking):** Implement **Optimistic Locking** (`@Version`) so if two patients try to book the exact same counselor slot simultaneously, one receives a clean `SlotConflictException`.
* [ ] **Trial 12 (Real-Time Sockets):** Build a live chat using **WebSockets and STOMP**. Handle disconnects and connection state tracking.
* [ ] **Trial 13 (Third-Party Failures):** Send SMS reminders via an external API. Wrap this in a **Resilience4j Circuit Breaker** and configure a fallback method to log failures to a Dead Letter Queue (DLQ).
* [ ] **Trial 14 (GDPR Cascade Deletion):** Implement a "Right to be Forgotten" endpoint that permanently anonymizes a user's PII across all relational tables without breaking foreign key constraints on historical analytics.
* [ ] **Trial 15 (Infrastructure as Code):** Write a `docker-compose.yml` that spins up the API, PostgreSQL, Redis, and a local MailHog server.
* [ ] **Trial 16 (Anonymity Proxy):** Build a message routing layer for peer-support groups. Ensure that actual `user_ids` are never exposed to the frontend clients; replace them with ephemeral session aliases before the JSON leaves the server.
* [ ] **Trial 17 (Immutable Audit Logging):** Every time a counselor views a youth's profile, it must be logged. Create an append-only MongoDB or PostgreSQL table. Use Spring AOP (`@AfterReturning`) to automatically generate these logs without cluttering business logic.
* [ ] **Trial 18 (WebRTC Signaling):** Implement the signaling backend (SDP offer/answer and ICE candidates routing) using Spring WebSockets to allow peer-to-peer secure video calls between counselors and patients.

---

## Track 3: E-Commerce & Logistics
**Business Model:** Two-sided Marketplace. The platform takes a percentage cut of transactions between independent sellers and buyers, and charges sellers for premium shipping and analytics tiers.
* **FRs:** Product catalog management, cart lifecycle, payment processing, real-time shipment tracking, and seller dashboards.
* **NFRs:** High availability during flash sales, eventual consistency for inventory across microservices, and PCI-DSS compliance for payment data.

### The Trials:
* [ ] **Trial 19 (Cache-Aside Pattern):** Implement Redis caching for the product catalog. Write logic to invalidate (`@CacheEvict`) specific keys instantly when inventory updates.
* [ ] **Trial 20 (Event-Driven Microservices):** Upon checkout, publish an `OrderCreatedEvent` to Kafka. Build a separate Logistics Service that listens to this topic to initiate shipping.
* [ ] **Trial 21 (Polyglot gRPC Integration):** Implement a **gRPC** client to fetch product recommendations from a Python data science service with zero REST overhead.
* [ ] **Trial 22 (Distributed Tracing):** Integrate **Micrometer and Zipkin** to generate a single Trace ID that flows through the Gateway, Order Service, and Logistics Service.
* [ ] **Trial 23 (Fuzzy Search):** Sync the product database to **Elasticsearch** and implement a fuzzy search endpoint that handles typos.
* [ ] **Trial 24 (Pen & Paper - ADR):** Write an **Architecture Decision Record (ADR)** proposing the shift from synchronous REST to Kafka for order processing.
* [ ] **Trial 25 (Distributed Locks for Inventory):** When an item is added to a cart during a flash sale, reserve it for 15 minutes. Use **Redisson** to implement a distributed lock in Redis to prevent overselling across multiple server instances.
* [ ] **Trial 26 (Dynamic Pricing Engine):** Build a pricing service that adjusts an item's price in real-time based on current web traffic and remaining stock levels.
* [ ] **Trial 27 (GraphQL BFF):** Build a GraphQL "Backend-For-Frontend" using Spring for GraphQL. Allow the mobile app to fetch the User profile, current Cart, and personalized Recommendations in a single network request.

---

## Track 4: FinTech & High-Frequency Transactions
**Business Model:** Transaction fees, cross-border currency conversion spreads, and premium B2B API access for automated trading.
* **FRs:** Peer-to-peer transfers, wallet top-ups, transaction history ledgers, and fraud alerts.
* **NFRs:** Absolute ACID compliance for money movement, p99 latency < 200ms, and strict idempotency for all mutating endpoints.



### The Trials:
* [ ] **Trial 28 (Double-Entry Bookkeeping):** Build a ledger. Never update a "balance" column directly. Every transfer must create two immutable rows (debit/credit) in a single ACID transaction.
* [ ] **Trial 29 (The Saga Pattern):** Implement a cross-service transaction using the **Choreography Saga pattern**. Roll back a wallet deduction if the corresponding ticket booking fails.
* [ ] **Trial 30 (Idempotency Keys):** A mobile client drops connection and retries a $500 payment. Implement a Redis interceptor to ensure the card is charged exactly once, returning the cached success response for retries.
* [ ] **Trial 31 (Webhook Dead Letter Queues):** Route failed Stripe webhook payloads to a Kafka DLQ. Write a cron job to auto-replay the DLQ when the primary database recovers.
* [ ] **Trial 32 (Strategy Pattern & Rules Engine):** Build a Fraud Detection engine using the **Strategy Pattern** (injecting `IpBlacklistStrategy`, `VelocityCheckStrategy`).
* [ ] **Trial 33 (Chaos Engineering):** Use **Spring Boot Chaos Monkey** to randomly inject latency and throw exceptions in your payment pipeline to test resiliency.
* [ ] **Trial 34 (Optimistic Concurrency on Wallets):** Handle the exact scenario where a user initiates two transfers simultaneously from different devices using the exact same wallet balance. Ensure one fails cleanly with a `StaleStateException`.
* [ ] **Trial 35 (Read-Replica Routing):** Configure Spring Boot with multiple DataSources. Route all heavy `GET /transactions/history` requests to a read-only PostgreSQL replica to keep the primary DB fast for writes.
* [ ] **Trial 36 (Circuit Breaker with Fallback Cache):** If the external live currency exchange API goes down, serve the last known rate from a Redis cache, but flag the transaction in the database as "pending final settlement".

---

## Track 5: Next-Gen Systems (AI & IoT Energy Grid)
**Business Model:** B2B SaaS for industrial grid operators. They pay per GB of telemetry data ingested and per AI inference query used for predictive maintenance alerts.
* **FRs:** Device registration, live telemetry dashboard, predictive maintenance alerts, and semantic search through engineering manuals.
* **NFRs:** Massive write throughput (100k TPS), sub-second anomaly alerting, and cost-effective long-term cold storage archiving.

### The Trials:
* [ ] **Trial 37 (Vector Databases & RAG):** Build a RAG pipeline. Chunk PDF manuals, generate embeddings, store them in **pgvector**, and write a Spring service for semantic similarity searches.
* [ ] **Trial 38 (Async AI Inference):** Accept a prompt, return a `202 Accepted` with a `jobId`, process the slow LLM call asynchronously (`@Async`), and notify the user when done.
* [ ] **Trial 39 (Time-Series Telemetry):** Set up **TimescaleDB**. Write a service optimized for massive, high-throughput time-series data ingestion from IoT sensors.
* [ ] **Trial 40 (Server-Sent Events - SSE):** Build a live dashboard using Spring Boot's `SseEmitter` to push real-time energy spikes from the backend to the frontend.
* [ ] **Trial 41 (Pen & Paper - Capacity Planning):** Calculate bandwidth, RAM, and total disk storage required if 10,000 requests/sec hit the system (2KB payload, 30-day retention).
* [ ] **Trial 42 (The Final Boss):** Assemble a massive `docker-compose.yml` that successfully boots the API Gateway, Auth Service, Monolith, PostgreSQL, Redis, Kafka, Zookeeper, and Zipkin.
* [ ] **Trial 43 (Data Partitioning):** Implement table partitioning in PostgreSQL by day/month to manage billions of telemetry rows without degrading query speed.
* [ ] **Trial 44 (WebSocket Backpressure):** IoT devices are sending data faster than the web client can render. Implement backpressure using **Project Reactor (Spring WebFlux)** to drop intermediate frames and only send the latest state.
* [ ] **Trial 45 (Cold Storage Archiving):** Write a **Spring Batch** job that safely moves telemetry data older than 90 days from the hot operational database to AWS S3 / Blob storage as compressed Parquet files.