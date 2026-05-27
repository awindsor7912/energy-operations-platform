# Energy Operations Platform — Architecture Notes

## 1. Purpose

These architecture notes define the intended technical direction for the **Energy Operations Platform**. The platform will be developed as a modular enterprise operations system for energy-sector work management, production tracking, billing/revenue support, operational analytics, document management, and lifecycle visibility.

This document is intentionally high-level. It will guide early development decisions, local prototyping, future cloud planning, and portfolio documentation. The architecture will remain flexible enough to support multiple implementation paths, including Microsoft Azure, other cloud providers, hybrid hosting, and local/self-hosted environments.

---

## 2. Architecture Goals

The platform architecture will support the following goals:

- Centralized operational data management
- Configurable customer and contract workflows
- Role-based user experiences
- Field-to-office workflow visibility
- Estimated vs. actual production tracking
- Revenue and cost visibility
- Billing and invoice-readiness support
- Labor, equipment, material, and activity tracking
- Document and attachment management
- Auditability and change history
- Reporting and analytics
- Future scalability across multiple energy-sector operating models

The system will be designed around a clear separation between:

```text
User Interface
→ Backend / Business Logic
→ Database / Source of Truth
→ Reporting / Analytics
→ File Storage
→ Automation / Events
→ Monitoring / Support
```

This separation will make the system easier to maintain, test, document, scale, and eventually deploy.

---

## 3. Core Architecture Pattern

The intended architecture follows a standard enterprise application pattern.

```text
Users
  ↓
Web Application / Operational Interface
  ↓
Backend API / Business Logic Layer
  ↓
Relational Database
```

Supporting layers include:

```text
File Storage
Reporting / Analytics
Authentication / Authorization
Automation / Background Processing
Monitoring / Logging
Source Control / Documentation
```

The database will act as the source of truth. The user interface will not directly own business logic. Reporting will not replace the operational application. Automation will assist workflows but will not become the primary system of record.

---

## 4. Local Development Architecture

Initial development will occur locally before any cloud deployment.

```text
Local Browser
  ↓
Blazor UI or Web Front End
  ↓
ASP.NET Core Web API
  ↓
SQL Server Developer Edition
  ↓
Power BI Desktop
```

### Local Development Components

| Layer | Local Tool |
|---|---|
| Database | SQL Server Developer Edition |
| Database Management | SQL Server Management Studio |
| Backend/API | ASP.NET Core Web API |
| Front End | Blazor initially; other UI options possible later |
| Reporting | Power BI Desktop |
| Source Control | GitHub / GitHub Desktop |
| Documentation | Markdown in GitHub / VS Code |
| Diagrams | diagrams.net / draw.io |
| File Storage | Local folders initially |
| Monitoring | Console logs, debug logs, local application logging |

The local environment will allow the platform to be designed, tested, documented, and demonstrated without requiring paid cloud infrastructure at the earliest stage.

---

## 5. Future Deployment Options

The architecture will remain cloud-flexible. Microsoft Azure is a strong long-term option because of its alignment with SQL Server, Power BI, Microsoft identity, and enterprise application hosting. However, the project will not be designed so narrowly that Azure becomes the only viable path.

### Option A — Microsoft Azure Architecture

```text
Users
  ↓
Azure App Service / Hosted Web App
  ↓
ASP.NET Core Web API
  ↓
Azure SQL Database

Supporting Services:
- Azure Blob Storage
- Microsoft Entra ID
- Power BI Service
- Azure Functions
- Logic Apps / Power Automate
- Azure Monitor / Application Insights
```

This option provides strong alignment with Microsoft-centric organizations and supports enterprise deployment patterns.

### Option B — AWS Architecture

```text
Users
  ↓
AWS Elastic Beanstalk / ECS / App Runner
  ↓
Backend API
  ↓
Amazon RDS for SQL Server or PostgreSQL

Supporting Services:
- Amazon S3
- Amazon Cognito or external identity provider
- Amazon CloudWatch
- AWS Lambda
- QuickSight or Power BI connected to the database
```

This option may be useful for organizations already standardized on AWS or preferring broader cloud infrastructure flexibility.

### Option C — Google Cloud Architecture

```text
Users
  ↓
Cloud Run / App Engine
  ↓
Backend API
  ↓
Cloud SQL

Supporting Services:
- Cloud Storage
- Identity Platform / external identity provider
- Cloud Logging / Monitoring
- Cloud Functions
- Looker / Power BI / external BI tool
```

This option may be useful for teams already using Google Cloud infrastructure.

### Option D — Self-Hosted / Private Infrastructure

```text
Users
  ↓
Internal Web Server
  ↓
Backend API
  ↓
SQL Server / PostgreSQL / Other Relational Database

Supporting Services:
- Internal file storage
- Active Directory or identity provider
- Internal monitoring/logging
- Local reporting server or BI tool
```

This option may be appropriate for organizations that require full control over infrastructure, have strict data-governance requirements, or prefer private hosting.

### Option E — Hybrid Architecture

A hybrid model may combine on-premises systems with cloud services.

Examples:

```text
On-premises database
→ Cloud-hosted reporting

Cloud-hosted app
→ On-premises identity provider

Local file storage
→ Cloud analytics layer
```

Hybrid architecture may become relevant when integrating with legacy operational systems or organizations with existing infrastructure constraints.

---

## 6. Recommended Initial Architecture Direction

The initial build will use a Microsoft-friendly local architecture:

```text
SQL Server Developer Edition
→ ASP.NET Core Web API
→ Blazor UI
→ Power BI Desktop
```

This path is recommended because it aligns with:

- SQL Server / Azure SQL concepts
- Power BI reporting
- C# and ASP.NET Core application development
- Blazor-based web interfaces
- Future Azure deployment options
- Enterprise operations environments

This does not prevent later evaluation of PostgreSQL, React, Node.js, Python, AWS, Google Cloud, or other technology stacks.

---

## 7. Layered Architecture

The platform will be organized into major layers.

```text
Presentation Layer
Application / API Layer
Business Logic Layer
Data Access Layer
Database Layer
Reporting Layer
File Storage Layer
Automation Layer
Monitoring Layer
```

Each layer has a distinct responsibility.

---

## 8. Presentation Layer

The presentation layer is the user-facing interface.

It will provide:

- Role-based dashboards
- Work queues
- Work order / project detail screens
- Field production entry screens
- Administrative review screens
- Reporting links or embedded analytics
- Search and filtering
- Responsive layouts for desktop, tablet, and selected mobile use cases

### Initial UI Direction

Blazor will be the preferred initial UI direction because it aligns with the Microsoft development stack and allows C# to be used across more of the application.

Potential future UI options include:

- React
- Angular
- Vue
- Razor Pages
- Mobile app framework
- Low-code companion interface

The UI will be designed around workflows, not raw database tables.

---

## 9. Backend / API Layer

The backend/API layer will sit between the UI and the database.

The backend will:

- Receive requests from the UI
- Validate user actions
- Apply business rules
- Read from and write to the database
- Trigger audit records
- Return structured responses to the UI
- Handle status transitions
- Support future integrations
- Protect the database from direct uncontrolled access

Example API flow:

```text
User clicks "Mark Work Order Complete"
  ↓
UI sends request to API
  ↓
API validates unresolved estimated items
  ↓
API checks required fields and approvals
  ↓
API updates work order status
  ↓
API writes audit/history records
  ↓
API returns success or validation errors
```

### Initial Backend Direction

The initial backend will likely use:

- ASP.NET Core Web API
- C#
- Entity Framework Core where appropriate
- Service classes for business logic
- DTOs for request/response shaping
- SQL Server as the database

---

## 10. Business Logic Layer

Business logic will be separated from controllers and UI components.

This layer will contain rules such as:

- Whether a work order can move to the next status
- Whether required fields are complete
- Whether unresolved estimated items must be confirmed
- Whether a billing/rate item is valid under a contract
- Whether an approval-required item can proceed
- Whether a production entry affects estimated, actual, or invoice-ready revenue
- Whether a user can perform a specific action
- Whether an item should enter an exception queue
- Whether invoice readiness is blocked

Example service areas:

```text
WorkOrderService
ProductionEntryService
BillingValidationService
RevenueCalculationService
ApprovalWorkflowService
NotificationService
AuditService
DocumentService
```

This structure will make the platform easier to maintain as logic becomes more complex.

---

## 11. Data Access Layer

The data access layer will manage communication between the backend and the relational database.

Initial options:

- Entity Framework Core
- Direct SQL queries where appropriate
- Stored procedures for specific complex operations if needed
- Views for reporting and simplified read models

The architecture will avoid placing all logic directly in SQL or directly in the UI. Complex operational rules will primarily live in the backend service layer, while the database will enforce data integrity through keys, constraints, relationships, and transactional structure.

---

## 12. Database Layer

The database will be the source of truth for operational records.

The database will store:

- Customers
- Contracts
- Work orders / projects
- Activities / tasks
- Estimated production
- Actual production
- Labor entries
- Equipment entries
- Material entries
- Rate items / billing codes
- Approval requirements
- Notifications
- Documents metadata
- Status history
- Audit logs
- Invoice or billing review records
- Reference data

### Database Design Principles

The database will follow relational design principles:

- Use primary keys for entity identity
- Use foreign keys for relationships
- Use constraints to preserve data integrity
- Use normalized structures where practical
- Use views for reporting/read models
- Use indexes for performance where needed
- Use audit/history tables for meaningful changes
- Track effective dates for rates and contract rules where needed

### Source-of-Truth Principle

The database will own operational state. The UI will display and submit changes. The backend will validate and process changes. Reports will read from curated tables/views.

---

## 13. Reporting / Analytics Layer

The reporting layer will provide operational and management visibility.

Initial reporting will use:

- Power BI Desktop connected to local SQL Server

Future reporting options may include:

- Power BI Service
- Fabric / OneLake
- SQL reporting views
- Embedded dashboards
- Looker
- Tableau
- QuickSight
- Custom web dashboards

The reporting layer will support:

- Estimated vs actual revenue
- Actual vs invoiced revenue
- Work order cycle time
- Field complete not invoiced
- Invoice cutoff risk
- Approval-required items
- Missing documentation
- Crew productivity
- Equipment utilization
- Labor utilization
- Regional comparisons
- Contract performance
- Workload distribution
- Operational bottlenecks

Reporting will not become the operational system itself. It will visualize and analyze data created by the operational application.

---

## 14. File Storage Layer

The platform will support documents and attachments.

Potential document types:

- Job packets
- Maps
- Drawings
- Material lists
- Engineering packages
- Approval forms
- Field photos
- Inspection documents
- Invoice support documents
- Compliance documentation

### Storage Pattern

The preferred pattern:

```text
File itself
→ File storage service or local folder

File metadata
→ Relational database
```

The database will store metadata such as:

- File ID
- Related entity type
- Related entity ID
- File name
- File type
- Storage path or URI
- Uploaded by
- Uploaded date
- Document category

Future file storage options:

- Azure Blob Storage
- Amazon S3
- Google Cloud Storage
- SharePoint document library
- Internal network storage
- Local development folder

---

## 15. Authentication and Authorization Layer

Authentication answers:

```text
Who is the user?
```

Authorization answers:

```text
What is the user allowed to do?
```

The platform will eventually require role-based access.

Potential roles:

- Field User
- Foreman / Crew Lead
- Supervisor
- General Foreman
- Administrative / Billing User
- Manager
- Corporate User
- System Administrator
- Read-Only User

### Initial Authentication Approach

Early local development may use:

- Mock users
- Local test roles
- Simplified login
- Hardcoded development roles for testing workflows

### Future Authentication Options

Future production-ready options may include:

- Microsoft Entra ID
- Active Directory
- Auth0
- Okta
- AWS Cognito
- Google Identity Platform
- Custom identity provider if required

Authorization will control:

- Which records users can view
- Which actions users can perform
- Which fields users can edit
- Which dashboards users can access
- Which configuration tables users can manage

---

## 16. Automation and Event Handling Layer

The platform will eventually support workflow events and automation.

Potential event triggers:

- New work created
- Work assigned
- Work marked high priority
- Target finish date approaching
- Work overdue
- Field completion submitted
- Approval-required item added
- Approval missing
- Admin review required
- Invoice cutoff approaching
- Work rejected
- Invoice processed

Automation options may include:

- In-app notification creation
- Email notification
- Microsoft Teams notification
- Background scheduled jobs
- Cloud functions
- Queue-based processing
- Workflow tools

Technology options:

- Azure Functions
- Azure Logic Apps
- Power Automate
- AWS Lambda
- Google Cloud Functions
- Hangfire for .NET background jobs
- Quartz.NET scheduled jobs
- Message queues such as Azure Service Bus, RabbitMQ, or Amazon SQS

Early development will likely start with simple in-app notifications and local service logic before moving to complex event-driven architecture.

---

## 17. Monitoring and Logging Layer

The platform will require monitoring as it matures.

Monitoring will help answer:

- Did an error occur?
- Which user encountered the error?
- Which API call failed?
- Did an import fail?
- Are pages or queries slow?
- Are background jobs running?
- Are users encountering permission issues?
- Are integrations failing?

Initial local monitoring may include:

- Console logs
- Debug logs
- Application logs
- Error messages
- Manual testing notes

Future monitoring options:

- Application Insights
- Azure Monitor
- AWS CloudWatch
- Google Cloud Logging
- Serilog
- Seq
- Grafana
- Prometheus
- Sentry

Logging will avoid storing sensitive data unnecessarily and will support troubleshooting, maintainability, and operational support.

---

## 18. Source Control and Documentation Architecture

GitHub will serve as the project’s source control and documentation hub.

The repository will store:

- Markdown documentation
- Architecture notes
- Workflow notes
- Database scripts
- SQL files
- Sample data
- Diagrams
- API code
- UI code
- Reporting screenshots
- Roadmap notes

Recommended repository structure:

```text
enterprise-data-analytics/
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
│   ├── schema/
│   ├── scripts/
│   ├── seed-data/
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

Commit messages will describe meaningful changes, such as:

```text
Added architecture notes for local development stack
Created initial SQL Server schema planning document
Added work order lifecycle workflow documentation
Added production tracking data model notes
```

---

## 19. Data Flow Concepts

### Work Order Import / Creation Flow

```text
Work order details entered or imported
  ↓
Backend validates required fields
  ↓
Database stores work order/project record
  ↓
Assignments and status history are created
  ↓
Notifications are generated
  ↓
Dashboard queues update
```

### Estimated Production Flow

```text
Estimated/design data imported or entered
  ↓
Backend validates customer/contract/rate relationships
  ↓
Estimated production records are stored
  ↓
Estimated revenue/cost is calculated or made available through reporting views
  ↓
Work order estimate summary becomes visible to users
```

### Actual Production Flow

```text
Field user opens assigned work
  ↓
User selects activity/location/point/span
  ↓
User checks completed estimated items or adds new actual items
  ↓
Backend validates rate, approval, and contract rules
  ↓
Actual production records are stored
  ↓
Revenue/cost calculations update
  ↓
Dashboards and review queues reflect progress
```

### Completion Validation Flow

```text
Field user marks work complete
  ↓
Backend checks unresolved estimated items
  ↓
User confirms completed/zeroed/missing items
  ↓
Backend validates required approvals and documentation
  ↓
Work order status changes to Field Complete or equivalent
  ↓
Administrative review notification is created
```

### Administrative Review Flow

```text
Admin opens field-complete work
  ↓
System displays estimated vs actual production
  ↓
System displays labor/equipment/material entries
  ↓
System displays approvals and missing documentation
  ↓
Admin approves for billing, returns for correction, or places on hold
  ↓
Status and audit history update
```

---

## 20. Integration Concepts

The platform will be designed with future integrations in mind.

Potential integration categories:

- Spreadsheet imports
- CSV imports
- API integrations
- External work management systems
- Accounting systems
- ERP systems
- GIS systems
- Fleet/equipment systems
- Payroll/timekeeping systems
- Document management systems
- Notification platforms
- BI/reporting tools

Initial development will focus on controlled imports and manual entry rather than live enterprise integrations.

---

## 21. Security and Data Governance Concepts

The platform will be designed to avoid exposing sensitive operational or customer data.

Initial development will use:

- Synthetic data
- Fake customer names
- Fake work orders
- Fake rates
- Fake crews/employees
- Generalized workflows

Future production planning will need:

- Role-based security
- Secure authentication
- Encrypted connections
- Database backups
- Access logging
- Data retention policies
- Audit trails
- Environment separation
- Least-privilege permissions
- Sensitive data handling rules

Security will be considered part of the architecture, not an afterthought.

---

## 22. Environment Strategy

The project will eventually support multiple environments.

### Local

Used for learning, prototyping, experimentation, and documentation.

### Development

Used for active application development.

### Test / QA

Used for validating workflows and regression testing before production deployment.

### Production

Used for real business operation if the platform eventually reaches deployment readiness.

Potential environment flow:

```text
Local
→ Development
→ Test / QA
→ Production
```

Early development may only use local and GitHub, but the documentation will preserve future environment planning.

---

## 23. Scalability Strategy

The platform will be designed to scale in stages.

### Early Stage

- Local database
- Local API
- Local UI
- Synthetic data
- Small workflow prototype

### Prototype Stage

- Larger sample datasets
- More refined schema
- Power BI dashboards
- Working UI for one operational workflow
- Initial API endpoints

### Pilot Stage

- Hosted database
- Hosted application
- User authentication
- Role-based access
- Document storage
- Basic monitoring
- User testing

### Production Stage

- Hardened security
- Backup/recovery
- Performance tuning
- Monitoring/alerting
- Support process
- Deployment pipeline
- Data governance
- Documentation and training

---

## 24. Design Principles

The architecture will follow these principles:

- Build modularly
- Keep the database as the source of truth
- Keep business logic out of the UI
- Use services for business rules
- Use APIs as controlled access points
- Use reporting for analysis, not transaction processing
- Use file storage for files and SQL for metadata
- Preserve audit history
- Design for role-based workflows
- Avoid customer-specific hardcoding
- Use synthetic data for public development
- Document decisions clearly
- Build one workflow well before expanding broadly

---

## 25. Initial Architecture Milestones

### Milestone 1 — Documentation Foundation

- Add concept notes
- Add architecture notes
- Add workflow notes
- Add roadmap
- Reframe existing analytics work under the Energy Operations Platform direction

### Milestone 2 — Local Database Foundation

- Create SQL Server database
- Define initial schema
- Add sample data
- Add schema scripts to GitHub
- Document relationships

### Milestone 3 — Reporting Foundation

- Connect Power BI Desktop to local SQL Server
- Build initial dashboard/reporting views
- Document metrics and reporting logic

### Milestone 4 — Backend Prototype

- Create ASP.NET Core Web API
- Connect API to SQL Server
- Create basic endpoints
- Add service layer
- Add validation logic

### Milestone 5 — UI Prototype

- Create Blazor UI
- Display work order/project data
- Add basic production-entry workflow
- Add admin review queue concept

### Milestone 6 — Expanded Workflow Logic

- Add estimated vs actual comparison logic
- Add completion validation
- Add approval-required item flow
- Add audit/history tracking
- Add notifications

---

## 26. Architecture Summary

The Energy Operations Platform will use a modular enterprise architecture centered on a relational database, backend business logic, role-based web interface, file storage, reporting, automation, and monitoring.

The first version will be built locally using SQL Server, ASP.NET Core, Blazor, and Power BI Desktop. Future deployment may use Azure, AWS, Google Cloud, self-hosted infrastructure, or a hybrid architecture depending on business needs, customer requirements, and implementation constraints.

The architecture will prioritize configurable workflows, operational visibility, auditability, reporting quality, and energy-sector adaptability.
