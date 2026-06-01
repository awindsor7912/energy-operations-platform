# Table Schema
The enterprise operations database is a relational schema designed to simulate core business systems, including asset management, workforce structure, maintenance activity, and financial transactions.

Tables were created using standard SQL DDL statements with defined primary and foreign key relationships to enforce data integrity and support multi-table analysis. Sample data was generated synthetically and structured using Microsoft Excel prior to import into SQLite via DB Browser.

While simplified in scale, the schema reflects common patterns found in enterprise environments, enabling realistic querying, aggregation, and analytical workflows. The structure is designed to support analysis across operational efficiency, cost drivers, and resource utilization.

> Note: This schema is a work in progress and is designed for extensibility. Future iterations will introduce additional entities and relationships to support broader operational domains and more complex analytical workflows. Planned additions include human resources, billing and accounting, work management (WIP), and other enterprise data structures to enable deeper cross-functional analysis.

---

## Employees Table
```sql
CREATE TABLE employees (
employee_id INTEGER PRIMARY KEY,
employee_name TEXT,
job_title TEXT,
email TEXT,
phone_number TEXT,
region_id INTEGER,
is_active INTEGER CHECK (is_active IN (0,1)),
employment_status TEXT,
hire_date DATE,
created_on DATE,
updated_on DATE
)
```
---

## Equipment Table
```sql
CREATE TABLE equipment (
    equipment_id VARCHAR(20) PRIMARY KEY,
    equipment_description VARCHAR(50),
    acquisition_date DATE,
    acquisition_cost DECIMAL(10,2),
    status TEXT,
    region_id INTEGER,
    equipment_type TEXT,
    manufacturer TEXT,
    make_model TEXT,
    useful_life_years INTEGER,
    salvage_value REAL,
    current_value REAL,
    last_service_date DATE,
    is_critical INTEGER,
    is_leased INTEGER,
    created_on DATE,
    updated_on DATE
, gps_tracking_enabled INTEGER CHECK (gps_tracking_enabled IN (0,1)))
```
---

## Equipment Usage Logs Table
```sql
CREATE TABLE equipment_usage_logs (
usage_id INTEGER PRIMARY KEY,
equipment_ID VARCHAR(20), 
usage_date DATE,
start_time TEXT,
end_time TEXT,
hours_used REAL,
usage_type TEXT,
operator_employee_id INTEGER,
region_id INTEGER,
project_code TEXT,
start_meter_reading REAL,
end_meter_reading REAL,
fuel_type REAL,
idle_hours REAL,
usage_status TEXT,
notes TEXT,
created_on DATE,
updated_on DATE,
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_ID),
FOREIGN KEY (operator_employee_id) REFERENCES employees(employee_id),
FOREIGN KEY (region_id) REFERENCES regions(region_id)
)
```

---

## Maintenance Invoices Table
```sql
CREATE TABLE maintenance_invoices (
invoice_id INTEGER PRIMARY KEY,
maintenance_id INTEGER,
vendor_id INTEGER,
invoice_number TEXT,
invoice_date DATE,
po_number TEXT,
labor_cost REAL,
parts_cost REAL,
tax_amount REAL,
total_invoice_amount REAL,
payment_status TEXT,
payment_date DATE,
FOREIGN KEY (maintenance_id) REFERENCES maintenance_logs(maintenance_id),
FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
)
```

---

## Maintenance Logs Table
```sql
CREATE TABLE maintenance_logs (
maintenance_id INTEGER PRIMARY KEY,
equipment_id VARCHAR(20),
maintenance_date DATE,
maintenance_type TEXT,
downtime_hours REAL,
vendor_id INTEGER,
service_status TEXT,
notes TEXT, technician_employee_id INTEGER, created_on DATE, updated_on DATE,
FOREIGN KEY (equipment_ID) REFERENCES equipment(equipment_id)
)
```

---

## Regions Table
```sql
CREATE TABLE regions (
region_id INTEGER PRIMARY KEY,
region_name TEXT,
customer_id BIGINT NULL
state TEXT,
supervisor_employee_id INTEGER,
active_flag BIT NOT NULL DEFAULT 0,
created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_on DATE,
FOREIGN KEY (supervisor_employee_id) REFERENCES employees(employee_id)
FOREIGN KEY (customer_id) REFERENCES customers(customer_id
)
```

---

## Vendors Table
```sql
CREATE TABLE vendors (
vendor_id INTEGER PRIMARY KEY,
vendor_name TEXT,
contact_name TEXT,
phone_number TEXT,
email TEXT,
city TEXT,
state TEXT,
service_category TEXT,
active_status TEXT,
created_on DATE,
updated_on DATE
)
```

---

## Customers Tables
```sql
CREATE TABLE customer_types (
    customer_type_id BIGINT PRIMARY KEY,
    type_name VARCHAR (50) NOT NULL UNIQUE
);
CREATE TABLE customer_statuses (
    customer_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR (50) NOT NULL UNIQUE
);
CREATE TABLE industries (
    industry_id BIGINT PRIMARY KEY,
    industry_name VARCHAR (100) NOT NULL UNIQUE
);
CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    customer_number VARCHAR(50) NOT NULL UNIQUE,
    customer_name VARCHAR(255) NOT NULL,
    customer_short_name VARCHAR(100),,
    customer_type_id BIGINT NOT NULL,
    customer_status_id BIGINT NOT NULL,
    industry_id BIGINT NULL,
    parent_customer_id BIGINT NULL,
    tax_id VARCHAR(50),
    website VARCHAR(255),
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100)
    updated_by VARCHAR(100),
    CONSTRAINT fk_customer_type FOREIGN KEY (customer_type_id) REFERENCES customer_types(customer_type_id),
    CONSTRAINT fk_customer_status FOREIGN KEY (customer_status_id) REFERENCES customer_statuses(customer_status_id),
    CONSTRAINT fk_industry FOREIGN KEY (industry_id) REFERENCES industries(industry_id),
    CONSTRAINT fk_parent_customer FOREIGN KEY (parent_customer_id) REFERENCES customers(customer_id)
);

---

##Contract Tables
```sql
CREATE TABLE contract_statuses (
    contract_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE contract_types (
    contract_type_id BIGINT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE contracts (
    contract_id BIGINT PRIMARY KEY,
    contract_number VARCHAR(50) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    contract_type_id BIGINT NOT NULL,
    contract_status_id BIGINT NOT NULL,
    contract_name VARCHAR(255) NOT NULL,
    description TEXT,
    effective_date DATE NOT NULL
    expiration_date DATE NULL,
    renewal_date DATE NULL,
    termination_date DATE NULL,
    billing_account_id BIGINT NULL,
    primary_contact_id BIGINT NULL,
    total_contract_value DECIMAL(18,2) NULL,
    currency_code CHAR(3) NOT NULL DEFAULT 'USD',
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_contract_type FOREIGN KEY (contract_type_id) REFERENCES contract_types(contract_type_id),
    CONSTRAINT fk_contract_status FOREIGN KEY (contract_status_id) REFERENCES contract_statuses(contract_status_id)
);
CREATE TABLE contract_documents (
    contract_document_id BIGINT PRIMARY KEY,
    contract_id BIGINT NOT NULL,
    document_name VARCHAR(255) NOT NULL,
    document_type VARCHAR(100) NOT NULL,
    file_url VARCHAR(500) NOT NULL,
    version_number VARCHAR(50) NULL,
    effective_date DATE,
    uploaded_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    uploaded_by VARCHAR(100),
    CONSTRAINT fk_contract_documents_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
);
```

---

##Billing and Invoicing Tables
```sql
CREATE TABLE contract_billable_items (
    contract_billable_item_id BIGINT PRIMARY KEY,
    contract_id NOT NULL,
    customer_item_code VARCHAR(100) NOT NULL,
    customer_item_description VARCHAR(255) NOT NULL,
    internal_item_code VARCHAR(100) NOT NULL,
    internal_item_description VARCHAR(255) NOT NULL,
    billing_category VARCHAR(100) NOT NULL,
    unit_of_measure VARCHAR(50) NOT NULL,
    unit_rate DECIMAL(18,2) NOT NULL,
    currency_code CHAR(3) NOT NULL DEFAULT 'USD',
    effective_date DATE NOT NULL,
    expiration_date DATE NULL,
    active_flag BIT NOT NULL DEFAULT 1,
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_contract_billable_items_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
    CONSTRAINT uq_contract_customer_item_effective UNIQUE (contract_id, customer_item_code, effective_date)
);
CREATE TABLE billing_approval_policies (
    billing_approval_policy_id BIGINT PRIMARY KEY,
    policy_name VARCHAR(255) NOT NULL,
    customer_id BIGINT NULL,
    contract_id BIGINT NULL,
    program_id BIGINT NULL,
    contract_billing_item_id BIGINT NULL,
    description TEXT,
    threshold_type VARCHAR(100) NULL,
    approval_threshold DECIMAL(18,2) NOT NULL,
    priority_rank INT NOT NULL DEFAULT 100,
    active_flag BIT NOT NULL DEFAULT 1,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
    CONSTRAINT fk_billing_approval_policies_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_billing_approval_policies_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT fk_billing_approval_policies_contract_billable_item FOREIGN KEY (contract_billing_item_id) REFERENCES contract_billable_items(contract_billable_item_id)
);
CREATE TABLE billable_charges (
    billable_charge_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    contract_billing_item_id BIGINT NOT NULL,
    work_order_id BIGINT NOT NULL,
    region_id BIGINT NOT NULL,
    crew_id BIGINT NULL,
    invoice_id BIGINT NULL,
    invoice_line_id BIGINT NULL,
    billable_charge_status_id BIGINT NOT NULL,
    charge_date DATE NOT NULL,
    service_date DATE NULL,
    quantity DECIMAL(18,4) NOT NULL,
    unit_of_measure VARCHAR(50) NOT NULL,
    unit_rate DECIMAL(18,4) NOT NULL,
    charge_subtotal DECIMAL(18,2) NOT NULL,
    tax_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    charge_total DECIMAL(18,2) NOT NULL,
    adjustment_flag BIT NOT NULL DEFAULT 0,
    invoiced_flag BIT NOT NULL DEFAULT 0,
    invoiced_date DATETIME NULL,
    approval_required BIT NOT NULL DEFAULT 0,
    approval_status VARCHAR(50) NULL,
    source_system VARCHAR(100) NOT NULL,
    source_reference_id VARCHAR(100) NOT NULL,
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_billable_charges_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_billable_charges_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT fk_billable_charges_contract_billing_item FOREIGN KEY (contract_billing_item_id) REFERENCES contract_billable_items(contract_billable_item_id),
    CONSTRAINT fk_billable_charges_work_order FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id),
    CONSTRAINT fk_billable_charges_region FOREIGN KEY (region_id) REFERENCES regions(region_id),
    CONSTRAINT fk_billable_charges_crew FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
    CONSTRAINT fk_billable_charges_invoice FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
    CONSTRAINT fk_billable_charges_billable_charge_status FOREIGN KEY (billable_charge_status_id) REFERENCES billable_charge_statuses(billable_charge_status_id)
);
CREATE TABLE billable_charge_statuses (
    billable_charge_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
    status_description VARCHAR(255),
    active_flag BIT NOT NULL DEFAULT 1
);
CREATE TABLE invoice_statuses (
    invoice_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(75) NOT NULL UNIQUE,
    status_description VARCHAR(255),
    active_flag BIT NOT NULL DEFAULT 1
);
CREATE TABLE invoices (
    invoice_id BIGINT PRIMARY KEY,
    invoice_number VARCHAR(75) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    invoice_status_id BIGINT NOT NULL,
    invoice_date DATE NOT NULL,
    billing_period_start DATE NULL,
    billing_period_end DATE NULL,
    due_date DATE NULL,
    subtotal_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    tax_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    adjutment_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    paid_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    balance_due DECIMAL(18,2) NOT NULL DEFAULT 0,
    currency_code CHAR(3) NOT NULL DEFAULT 'USD',
    customer_reference_number VARCHAR(100) NULL,
    external_invoice_number VARCHAR(100) NULL,
    submitted_on DATETIME NULL,
    paid_on DATETIME NULL,
    voided_on DATETIME NULL,
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_invoices_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_invoices_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT fk_invoices_invoice_status FOREIGN KEY (invoice_status_id) REFERENCES invoice_statuses(invoice_status_id)
);
CREATE TABLE invoice_line_items (
    invoice_line_id BIGINT PRIMARY KEY,
    invoice_id BIGINT NOT NULL,
    billable_charge_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    contract_billing_item_id BIGINT NOT NULL,
    work_order_id BIGINT NOT NULL,
    region_id BIGINT NOT NULL,
    crew_id BIGINT NULL,
    line_number INT NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity DECIMAL(18,4) NOT NULL,
    unit_of_measure VARCHAR(50) NOT NULL,
    unit_rate DECIMAL(18,4) NOT NULL,
    line_subtotal DECIMAL(18,2) NOT NULL,
    tax_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    adjustment_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    line_total DECIMAL(18,2) NOT NULL,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_invoice_line_items_invoice FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
    CONSTRAINT fk_invoice_line_items_billable_charge FOREIGN KEY (billable_charge_id) REFERENCES billable_charges(billable_charge_id),
    CONSTRAINT fk_invoice_line_items_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_invoice_line_items_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT fk_invoice_line_items_contract_billing_item FOREIGN KEY (contract_billing_item_id) REFERENCES contract_billable_items(contract_billable_item_id),
    CONSTRAINT fk_invoice_line_items_work_order FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id),
    CONSTRAINT fk_invoice_line_items_region FOREIGN KEY (region_id) REFERENCES regions(region_id),
    CONSTRAINT fk_invoice_line_items_crew FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
    CONSTRAINT uq_invoice_line_items_invoice_line_number UNIQUE (invoice_id, line_number)
    CONSTRAINT uq_invoice_line_items_billable_charge UNIQUE (billable_charge_id)
);
```

---

##Crew Table
```sql
CREATE TABLE crews (
    crew_id BIGINT PRIMARY KEY,
    crew_code VARCHAR(50) NOT NULL UNIQUE,
    crew_name VARCHAR(255) NOT NULL,
    region_id BIGINT NULL,
    supervisor_employee_id INTEGER,
    active_flag BIT NOT NULL DEFAULT 1,
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_crews_region FOREIGN KEY (region_id) REFERENCES regions(region_id),
    CONSTRAINT fk_crews_supervisor FOREIGN KEY (supervisor_employee_id) REFERENCES employees(employee_id)
);
```

---

##Work Orders Tables
```sql
CREATE TABLE work_order_statuses (
    work_order_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    status_description VARCHAR(255),
    active_flag BIT NOT NULL DEFAULT 1
);
CREATE TABLE work_orders (
    work_order_id BIGINT PRIMARY KEY,
    work_order_number VARCHAR(50) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    region_id BIGINT NOT NULL,
    crew_id BIGINT NULL,
    work_order_status_id BIGINT NOT NULL,
    customer_work_order_ref VARCHAR(100) NULL,
    external_system_ref VARCHAR(100) NULL,
    work_order_type VARCHAR(100) NULL,
    scheduled_start_date DATE NULL,
    scheduled_end_date DATE NULL,
    actual_start_date DATE NULL,
    actual_end_date DATE NULL,
    service_address_line_1 VARCHAR(255) NULL,
    service_address_line_2 VARCHAR(255) NULL,
    service_city VARCHAR(100) NULL,
    service_state VARCHAR(50) NULL,
    service_postal_code VARCHAR(20) NULL,
    latitude DECIMAL(10,7) NULL,
    longitude DECIMAL(10,7) NULL,
    work_description TEXT,
    notes TEXT,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT fk_work_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_work_orders_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT fk_work_orders_region FOREIGN KEY (region_id) REFERENCES regions(region_id),
    CONSTRAINT fk_work_orders_crew FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
    CONSTRAINT fk_work_orders_status FOREIGN KEY (work_order_status_id) REFERENCES work_order_statuses(work_order_status_id)
);
