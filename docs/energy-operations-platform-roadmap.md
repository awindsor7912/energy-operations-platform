# Energy Operations Platform — Roadmap

## 1. Roadmap Purpose

This roadmap defines the phased development path for the **Energy Operations Platform**, a developing enterprise operations system concept for energy-sector work management, production tracking, billing/revenue support, operational analytics, and lifecycle visibility.

The roadmap is intended to guide development in a practical sequence. It prioritizes documentation, database structure, workflow modeling, reporting, and one focused operational prototype before expanding into a full application interface, advanced automation, cloud deployment, or commercial product structure.

The platform will be developed incrementally. Each phase will produce artifacts that can stand alone as portfolio evidence, technical documentation, and future implementation reference.

---

## 2. Development Principles

The roadmap will follow these principles:

- Build the foundation before building the interface.
- Treat documentation as part of the product.
- Use synthetic/sample data only.
- Keep workflows configurable instead of hardcoded.
- Build one operational workflow well before expanding.
- Separate operational data, business logic, reporting, and user interface concerns.
- Preserve source-of-truth data in the database layer.
- Keep future hosting options open, including cloud, hybrid, and self-hosted models.
- Maintain clear version history through GitHub.
- Prioritize evidence of systems thinking, architecture, and execution.

---

## 3. Roadmap Overview

High-level development sequence:

```text
Phase 0 — Repository and Documentation Foundation
Phase 1 — Local Database Foundation
Phase 2 — Data Model and Workflow Expansion
Phase 3 — Analytics and Reporting Foundation
Phase 4 — Backend/API Prototype
Phase 5 — User Interface Prototype
Phase 6 — Workflow Logic and Validation
Phase 7 — Files, Notifications, and Auditability
Phase 8 — Cloud-Ready / Deployment Architecture
Phase 9 — Productization and Commercial Readiness
```

The early phases focus on documentation, database design, and reporting. Later phases expand into application development, automation, cloud deployment, and potential commercial models.

---

# Phase 0 — Repository and Documentation Foundation

## Objective

Establish the repository as the central workspace for the Energy Operations Platform. This phase defines the concept, organizes documentation, and creates a professional project structure before major development begins.

## Primary Outputs

- Updated root `README.md`
- Concept notes document
- Architecture notes document
- Roadmap document
- Initial folder structure
- Initial project positioning
- GitHub commit history showing project evolution

## Suggested Repository Structure

```text
energy-operations-platform/
│
├── README.md
│
├── docs/
│   ├── concept-notes/
│   ├── architecture/
│   ├── workflows/
│   ├── requirements/
│   └── roadmap/
│
├── database/
│   ├── README.md
    ├── schema/
│   ├── seed/
│   ├── queries/
│   └── diagrams/
│
├── analysis/
│   ├── equipment-operations/
│   ├── billing-revenue-assurance/
│   ├── production-tracking/
│   └── work-order-lifecycle/
│
├── app/
│   ├── api/
│   └── ui/
│
├── reporting/
│   ├── power-bi/
│   └── screenshots/
│
├── assets/
│   ├── images/
│   ├── screenshots/
│   └── mockups/
│
└── notes/
```

## Tasks

- [x] Reorganize repository folders.
- [x] Update root README to reflect the Energy Operations Platform direction.
- [x] Add concept notes to `docs/energy-operations-platform-concept-notes/`.
- [x] Add architecture notes to `docs/energy-operations-platform-architecture-notes/`.
- [x] Add this roadmap to `docs/energy-operations-platform-roadmap/`.
- [ ] Add workflow notes to `docs/energy-operations-platform-workflows/`.
- [x] Reframe existing analytics work as platform foundation modules.
- [ ] Create GitHub Issues for each major roadmap phase.
- [ ] Create a GitHub Project board with columns such as Backlog, In Progress, Blocked, and Complete.

## Completion Criteria

Phase 0 is complete when the repository clearly communicates:

- what the platform is,
- why it exists,
- what it will eventually support,
- how the project is structured,
- and what development will happen next.

---

# Phase 1 — Local Database Foundation

## Objective

Build the local database foundation using SQL Server Developer Edition. This phase establishes the first source-of-truth database structure for the platform.

## Primary Outputs

- Local SQL Server database
- Database creation scripts
- Core schema scripts
- Seed/sample data
- Data dictionary draft
- Initial relationship documentation
- Initial entity relationship diagram

## Local Development Tools

- SQL Server Developer Edition
- SQL Server Management Studio
- VS Code
- GitHub Desktop
- Optional: diagrams.net for ERD documentation

## Initial Database Focus

The first database version will focus on the foundational operational entities:

- Customers
- Contracts
- Work orders/projects
- Assignments
- Users/roles
- Status history
- Rate items
- Estimated production
- Actual production
- Labor entries
- Equipment entries
- Material entries
- Approval requirements
- Audit/history records

## Tasks

- [x] Create local SQL Server database.
- [x] Decide on the first database name.
- [x] Create database setup script.
- [x] Define naming conventions for tables, columns, primary keys, and foreign keys.
- [x] Draft initial schema in markdown before creating tables.
- [x] Create core tables in SQL Server.
- [x] Add primary keys and foreign keys.
- [x] Add required constraints where appropriate.
- [ ] Add sample/synthetic data.
- [ ] Create initial database diagram.
- [x] Store schema notes and scripts in `database/schema/`.
- [ ] Store sample data in `database/seed/`.

## Example Milestone

```text
Milestone 1.0 — Local SQL Server database created and core tables scripted.
```

## Completion Criteria

Phase 1 is complete when:

- a local database exists,
- core tables can be queried successfully,
- scripts are committed to GitHub,
- relationships are documented,
- and sample data supports basic testing.

---

# Phase 2 — Data Model and Workflow Expansion

## Objective

Expand the database model to support configurable workflows, multiple billing models, production tracking, approval logic, and operational lifecycle visibility.

## Primary Outputs

- Expanded schema
- Workflow state documentation
- Status lifecycle model
- Contract configuration notes
- Billing model notes
- Approval logic notes
- Data dictionary improvements

## Key Design Areas

### Customer and Contract Configuration

The platform will support multiple customers and multiple contracts per customer. Contracts will define:

- billing model,
- rate structure,
- required documentation,
- approval rules,
- status workflow,
- production-entry requirements,
- and reporting categories.

### Work Lifecycle

The system will support configurable lifecycle stages such as:

```text
Scheduled
→ Assigned
→ In Progress
→ Field Complete
→ Administrative Review
→ Invoice Ready
→ Invoiced
→ Closed
```

### Billing Model Support

The data model will support:

- unit-based billing,
- time and equipment billing,
- hybrid billing,
- milestone/project billing,
- and nonbillable/informational tracking.

## Tasks

- [ ] Define configurable status model.
- [ ] Define contract billing model structure.
- [ ] Define rate item structure.
- [ ] Define approval-required item structure.
- [ ] Define estimated production tables.
- [ ] Define actual production tables.
- [ ] Define labor/equipment/material entry tables.
- [ ] Define invoice/billing review structure.
- [ ] Add audit/history tables.
- [ ] Document lifecycle transitions.
- [ ] Create SQL views for common operational queries.
- [ ] Update ERD and data dictionary.

## Completion Criteria

Phase 2 is complete when the database structure can represent:

- assigned work,
- estimated production,
- actual production,
- labor/equipment/material entries,
- approval-required items,
- billing/revenue tracking,
- and lifecycle statuses.

---

# Phase 3 — Analytics and Reporting Foundation

## Objective

Build the first reporting layer using SQL Server and Power BI Desktop. This phase demonstrates how structured operational data produces actionable reporting and lifecycle visibility.

## Primary Outputs

- Power BI report file
- SQL reporting views
- Dashboard screenshots
- Reporting documentation
- Initial KPI definitions

## Initial Reporting Themes

- Work order lifecycle status
- Estimated vs actual production
- Estimated vs actual revenue
- Actual vs invoiced revenue
- Completed not invoiced
- Approval-required items pending
- Invoice cutoff risk
- Work aging
- Crew productivity
- Equipment utilization
- Labor utilization
- Regional/workload comparisons

## Tasks

- [ ] Create SQL views for reporting.
- [ ] Connect Power BI Desktop to local SQL Server.
- [ ] Build initial data model in Power BI.
- [ ] Create basic KPI measures.
- [ ] Build first operational dashboard.
- [ ] Build first revenue visibility dashboard.
- [ ] Build first work lifecycle dashboard.
- [ ] Export screenshots to `reporting/screenshots/`.
- [ ] Document dashboard purpose and data sources.
- [ ] Add README notes for the reporting module.

## Example Milestone

```text
Milestone 3.0 — Power BI report connected to local SQL Server with first dashboard completed.
```

## Completion Criteria

Phase 3 is complete when:

- Power BI connects to the local SQL Server database,
- at least one dashboard demonstrates operational visibility,
- screenshots are committed to GitHub,
- and reporting logic is documented.

---

# Phase 4 — Backend/API Prototype

## Objective

Create the first backend/API layer to separate the application interface from direct database access. This phase introduces the business logic layer.

## Primary Outputs

- ASP.NET Core Web API project
- SQL Server connection
- Entity Framework Core setup, if used
- Basic API endpoints
- Service layer structure
- Initial validation logic
- API documentation or Swagger screenshots

## Backend Responsibilities

The backend/API will handle:

- secure database access,
- business logic,
- validation,
- workflow transitions,
- revenue calculations,
- approval checks,
- audit logging,
- and controlled data updates.

## Initial Endpoints

Possible first endpoints:

```text
GET    /api/workorders
GET    /api/workorders/{id}
GET    /api/workorders/status/{status}
POST   /api/workorders
PATCH  /api/workorders/{id}/status
GET    /api/production/estimated/{workOrderId}
GET    /api/production/actual/{workOrderId}
POST   /api/production/actual
POST   /api/billing/validate/{workOrderId}
```

## Tasks

- [ ] Create ASP.NET Core Web API project in `app/api/`.
- [ ] Connect API to local SQL Server.
- [ ] Add configuration file for connection string.
- [ ] Add initial models/entities.
- [ ] Add database context.
- [ ] Create first controller.
- [ ] Create first service class.
- [ ] Build read-only endpoints first.
- [ ] Add simple write/update endpoints.
- [ ] Add initial validation logic.
- [ ] Test endpoints with Swagger or Postman.
- [ ] Commit API scaffold and documentation.

## Completion Criteria

Phase 4 is complete when:

- the API runs locally,
- it can retrieve data from SQL Server,
- it can update at least one controlled record,
- and core endpoint behavior is documented.

---

# Phase 5 — User Interface Prototype

## Objective

Create the first user-facing interface that interacts with the backend/API. This phase validates the operational workflow from the user’s perspective.

## Primary Outputs

- Blazor UI project
- Basic navigation
- Work order list screen
- Work order detail screen
- Production entry screen
- Admin review queue concept
- Initial UI screenshots

## UI Direction

The interface will be:

- operational,
- queue-driven,
- role-aware,
- responsive,
- and workflow-oriented.

It will not be designed as a generic table viewer. It will guide users toward the next operational action.

## Initial Screens

Suggested first screens:

- Home/dashboard shell
- Work order list
- Work order detail
- Estimated production view
- Actual production entry
- Completion validation prompt/mockup
- Administrative review queue
- Basic reporting links/screenshots

## Tasks

- [ ] Create Blazor project in `app/ui/`.
- [ ] Create basic layout/navigation.
- [ ] Connect UI to API.
- [ ] Display work order list.
- [ ] Display work order detail page.
- [ ] Display estimated production rows.
- [ ] Add actual production entry form.
- [ ] Add simple validation feedback.
- [ ] Add admin review queue mockup.
- [ ] Capture screenshots and commit to GitHub.

## Completion Criteria

Phase 5 is complete when:

- a local UI runs successfully,
- it retrieves work order data through the backend/API,
- it supports at least one basic update workflow,
- and screenshots demonstrate the first operational interface.

---

# Phase 6 — Workflow Logic and Validation

## Objective

Add meaningful operational business logic to the system. This phase turns the prototype from a data viewer into a workflow tool.

## Primary Outputs

- Completion validation logic
- Approval-required item logic
- Estimated vs actual comparison logic
- Revenue calculation logic
- Status transition rules
- Exception/discrepancy logic
- Audit event capture

## Core Workflow Logic

### Completion Validation

When a user marks work complete, the system will check for unresolved estimated items and prompt for confirmation or zeroing.

### Approval-Required Items

When a user adds or completes an approval-required item, the system will prompt for approval confirmation, documentation, or pending status.

### Revenue Calculation

The system will calculate:

```text
Estimated Revenue
Actual Revenue
In-Progress Revenue
Job Complete Revenue
Invoiced Revenue
```

### Discrepancy Review

The system will flag meaningful differences between estimates and actuals.

## Tasks

- [ ] Define validation rules in documentation.
- [ ] Build completion validation service.
- [ ] Build approval-required item service.
- [ ] Build estimated vs actual comparison query/service.
- [ ] Add revenue calculation logic.
- [ ] Add controlled status transition rules.
- [ ] Add audit logging for key actions.
- [ ] Update UI to display validation feedback.
- [ ] Add exception/discrepancy queue concept.

## Completion Criteria

Phase 6 is complete when:

- the system enforces at least one workflow rule,
- approval-required logic exists in prototype form,
- revenue calculations are visible,
- and audit/history records capture meaningful changes.

---

# Phase 7 — Files, Notifications, and Auditability

## Objective

Add supporting enterprise features that improve operational usability, traceability, and coordination.

## Primary Outputs

- File metadata structure
- Local file upload prototype
- Notification/event model
- Audit log expansion
- Event-trigger documentation

## File Management

Initial local version:

```text
File itself → Local project/storage folder
File metadata → SQL Server
```

Future hosted version may use:

- Azure Blob Storage,
- AWS S3,
- Google Cloud Storage,
- private network storage,
- or another object/file storage service.

## Notifications

Initial notification model may be database-driven and in-app only.

Potential notification triggers:

- new assignment,
- high-priority designation,
- target finish approaching,
- work overdue,
- field completion submitted,
- approval item added,
- invoice cutoff approaching,
- missing documentation,
- work needing correction.

## Tasks

- [ ] Add file metadata table.
- [ ] Add local file upload concept.
- [ ] Link files to work orders/production entries/approvals.
- [ ] Define notification table/model.
- [ ] Create notification generation logic.
- [ ] Add in-app notification concept.
- [ ] Expand audit logging.
- [ ] Document event triggers.

## Completion Criteria

Phase 7 is complete when:

- files can be conceptually linked to operational records,
- notification events are represented in the data model,
- and audit/history logic is documented and partially implemented.

---

# Phase 8 — Cloud-Ready / Deployment Architecture

## Objective

Prepare the platform concept for hosted deployment without locking into one cloud provider too early.

## Primary Outputs

- Deployment architecture notes
- Environment configuration strategy
- Hosting option comparison
- Database migration considerations
- Authentication strategy
- Storage strategy
- Monitoring strategy

## Deployment Options

Potential deployment paths include:

### Microsoft Azure

Possible services:

- Azure SQL Database
- Azure App Service
- Azure Blob Storage
- Microsoft Entra ID
- Azure Functions
- Azure Monitor/Application Insights
- Power BI Service

### AWS

Possible services:

- Amazon RDS for SQL Server or PostgreSQL
- Elastic Beanstalk / ECS / App Runner
- Amazon S3
- IAM / Cognito
- Lambda
- CloudWatch
- QuickSight or Power BI integration

### Google Cloud

Possible services:

- Cloud SQL
- Cloud Run / App Engine
- Cloud Storage
- Identity Platform
- Cloud Functions
- Cloud Monitoring
- Looker Studio / Power BI integration

### Self-Hosted / Hybrid

Possible options:

- SQL Server on internal infrastructure
- On-premises application server
- Private network file storage
- VPN access
- Hybrid reporting model
- Company-managed authentication

## Tasks

- [ ] Document current local architecture.
- [ ] Document target hosted architecture options.
- [ ] Create environment variable/configuration strategy.
- [ ] Separate connection strings from committed source code.
- [ ] Plan database migration from local SQL Server to hosted database.
- [ ] Compare Azure, AWS, Google Cloud, self-hosted, and hybrid paths.
- [ ] Plan authentication options.
- [ ] Plan file storage options.
- [ ] Plan monitoring/logging options.

## Completion Criteria

Phase 8 is complete when:

- the platform can be clearly explained as cloud-ready,
- deployment options are documented,
- the code/configuration structure supports future hosting,
- and the project does not depend on one deployment provider prematurely.

---

# Phase 9 — Productization and Commercial Readiness

## Objective

Explore whether the platform can evolve beyond a portfolio/prototype project into a consulting framework, internal implementation model, or commercial product.

## Primary Outputs

- Productization notes
- Implementation model options
- Target user/customer definitions
- Licensing/support considerations
- Security/compliance considerations
- Commercial roadmap draft

## Possible Commercial Models

### Consulting / Custom Implementation

The platform functions as a framework for assessing and improving operational workflows for individual companies.

### Framework + Handoff

The platform is configured for a company, documented, and handed off to internal IT or operations technology teams.

### Managed Platform

The platform is hosted and maintained by the creator/team as a managed service.

### SaaS Product

The platform becomes a multi-tenant or single-tenant subscription software product.

### Internal Product Owner Career Asset

The platform serves as evidence of capability for roles in business systems, operational technology, product ownership, enterprise applications, or solutions architecture.

## Tasks

- [ ] Identify likely target users.
- [ ] Define implementation models.
- [ ] Identify which features are product-ready vs concept-only.
- [ ] Document support and maintenance considerations.
- [ ] Define security expectations.
- [ ] Define data ownership assumptions.
- [ ] Identify legal/IP considerations for future commercialization.
- [ ] Draft business model options.
- [ ] Create portfolio-facing summary.

## Completion Criteria

Phase 9 is complete when:

- the platform has a clear path beyond personal learning,
- potential business models are documented,
- and the project can be explained professionally as a portfolio asset, consulting concept, or future product candidate.

---

## 4. Version Milestones

Suggested milestone labels:

```text
v0.1 — Concept and Repository Foundation
v0.2 — Local SQL Server Database Foundation
v0.3 — Core Workflow Schema
v0.4 — Initial Power BI Reporting
v0.5 — API Prototype
v0.6 — Blazor UI Prototype
v0.7 — Workflow Validation Logic
v0.8 — Files, Notifications, and Audit Trail
v0.9 — Cloud-Ready Architecture
v1.0 — End-to-End Local Prototype
```

---

## 5. Immediate Next Steps

Recommended immediate actions:

1. Add this roadmap to the repository.
2. Create GitHub Issues for Phase 0 and Phase 1 tasks.
3. Create the initial folder structure.
4. Update the root README.
5. Create the local SQL Server database.
6. Begin schema planning for the database foundation.
7. Add first SQL scripts to GitHub.
8. Document decisions as they are made.

---

## 6. First Practical Build Target

The first practical build target will be:

```text
End-to-end local workflow proof of concept:
Work Order
→ Estimated Production
→ Rate Matching
→ Actual Production Entry
→ Revenue Comparison
→ Administrative Review
→ Basic Reporting
```

This target proves the central value loop without requiring a production-grade system.

---

## 7. Success Criteria for the Early Prototype

The early prototype will be considered successful when it can demonstrate:

- structured operational data in SQL Server,
- relationship between customer, contract, and work order,
- estimated production tracking,
- actual production tracking,
- simple rate matching,
- estimated vs actual revenue comparison,
- administrative review queue concept,
- and Power BI reporting from the structured data.

The prototype does not need to include production authentication, cloud hosting, full automation, mobile app functionality, external portals, or every possible energy-sector workflow.

---

## 8. Portfolio Value

Even before full application development, this roadmap will support professional positioning by showing:

- systems thinking,
- database planning,
- operational workflow modeling,
- technology stack awareness,
- documentation discipline,
- enterprise architecture awareness,
- and phased execution planning.

The roadmap will also help keep the project manageable by converting a large platform vision into smaller deliverables.

---

## 9. Roadmap Maintenance

This document will be updated as the platform evolves.

Future updates may include:

- completed phase notes,
- revised technology choices,
- added modules,
- revised MVP scope,
- screenshots,
- architecture updates,
- lessons learned,
- and implementation decisions.
