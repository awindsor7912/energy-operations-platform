CREATE DATABASE EnergyOperationsPlatform;
GO
USE EnergyOperationsPlatform;
GO

CREATE TABLE customer_types (
    customer_type_id BIGINT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE customer_statuses (
    customer_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE industries (
    industry_id BIGINT PRIMARY KEY,
    industry_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE contract_statuses (
    contract_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE contract_types (
    contract_type_id BIGINT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE invoice_statuses (
    invoice_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(75) NOT NULL UNIQUE,
    status_description VARCHAR(255),
    active_flag BIT NOT NULL DEFAULT 1
);

CREATE TABLE work_order_statuses (
    work_order_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    status_description VARCHAR(255),
    active_flag BIT NOT NULL DEFAULT 1
);

CREATE TABLE billable_charge_statuses (
    billable_charge_status_id BIGINT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    status_description VARCHAR(255),
    active_flag BIT NOT NULL DEFAULT 1
);

CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    customer_number VARCHAR(50) NOT NULL UNIQUE,
    customer_name VARCHAR(255) NOT NULL,
    customer_short_name VARCHAR(100),
    customer_type_id BIGINT NOT NULL,
    customer_status_id BIGINT NOT NULL,
    industry_id BIGINT NULL,
    parent_customer_id BIGINT NULL,
    tax_id VARCHAR(50),
    website VARCHAR(255),
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    job_title VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(50),
    region_id INT,
    is_active BIT CHECK (is_active IN (0,1)),
    employment_status VARCHAR(100),
    hire_date DATE,
    created_on DATETIME,
    updated_on DATETIME
);

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255),
    customer_id BIGINT NULL,
    state VARCHAR(100),
    supervisor_employee_id INT,
    active_flag BIT NOT NULL DEFAULT 0,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME
);

CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(255),
    contact_name VARCHAR(255),
    phone_number VARCHAR(50),
    email VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    service_category VARCHAR(100),
    active_status VARCHAR(50),
    created_on DATETIME,
    updated_on DATETIME
);

CREATE TABLE equipment (
    equipment_id VARCHAR(20) PRIMARY KEY,
    equipment_description VARCHAR(255),
    acquisition_date DATE,
    acquisition_cost DECIMAL(18,2),
    status VARCHAR(100),
    region_id INT,
    equipment_type VARCHAR(100),
    manufacturer VARCHAR(255),
    make_model VARCHAR(255),
    useful_life_years INT,
    salvage_value DECIMAL(18,2),
    current_value DECIMAL(18,2),
    last_service_date DATE,
    is_critical BIT CHECK (is_critical IN (0,1)),
    is_leased BIT CHECK (is_leased IN (0,1)),
    gps_tracking_enabled BIT CHECK (gps_tracking_enabled IN (0,1)),
    created_on DATETIME,
    updated_on DATETIME
);

CREATE TABLE maintenance_logs (
    maintenance_id INT PRIMARY KEY,
    equipment_id VARCHAR(20),
    maintenance_date DATE,
    maintenance_type VARCHAR(100),
    downtime_hours REAL,
    vendor_id INT,
    service_status VARCHAR(100),
    notes VARCHAR(MAX),
    technician_employee_id INT,
    created_on DATETIME,
    updated_on DATETIME
);

CREATE TABLE maintenance_invoices (
    invoice_id INT PRIMARY KEY,
    maintenance_id INT,
    vendor_id INT,
    invoice_number VARCHAR(100),
    invoice_date DATE,
    po_number VARCHAR(100),
    labor_cost DECIMAL(18,2),
    parts_cost DECIMAL(18,2),
    tax_amount DECIMAL(18,2),
    total_invoice_amount DECIMAL(18,2),
    payment_status VARCHAR(50),
    payment_date DATE
);

CREATE TABLE contracts (
    contract_id BIGINT PRIMARY KEY,
    contract_number VARCHAR(50) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    contract_type_id BIGINT NOT NULL,
    contract_status_id BIGINT NOT NULL,
    contract_name VARCHAR(255) NOT NULL,
    description VARCHAR(MAX),
    effective_date DATE NOT NULL,
    expiration_date DATE NULL,
    renewal_date DATE NULL,
    termination_date DATE NULL,
    billing_account_id BIGINT NULL,
    primary_contact_id BIGINT NULL,
    total_contract_value DECIMAL(18,2) NULL,
    currency_code CHAR(3) NOT NULL DEFAULT 'USD',
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
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
    uploaded_by VARCHAR(100)
);

CREATE TABLE contract_billable_items (
    contract_billable_item_id BIGINT PRIMARY KEY,
    contract_id BIGINT NOT NULL,
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
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    CONSTRAINT uq_contract_customer_item_effective UNIQUE (contract_id, customer_item_code, effective_date)
);

CREATE TABLE billing_approval_policies (
    billing_approval_policy_id BIGINT PRIMARY KEY,
    policy_name VARCHAR(255) NOT NULL,
    customer_id BIGINT NULL,
    contract_id BIGINT NULL,
    program_id BIGINT NULL,
    contract_billing_item_id BIGINT NULL,
    description VARCHAR(MAX),
    threshold_type VARCHAR(100) NULL,
    approval_threshold DECIMAL(18,2) NOT NULL,
    priority_rank INT NOT NULL DEFAULT 100,
    active_flag BIT NOT NULL DEFAULT 1,
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

CREATE TABLE crews (
    crew_id BIGINT PRIMARY KEY,
    crew_code VARCHAR(50) NOT NULL UNIQUE,
    crew_name VARCHAR(255) NOT NULL,
    region_id INT NULL,
    supervisor_employee_id INT,
    active_flag BIT NOT NULL DEFAULT 1,
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

CREATE TABLE work_orders (
    work_order_id BIGINT PRIMARY KEY,
    work_order_number VARCHAR(50) NOT NULL UNIQUE,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    region_id INT NOT NULL,
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
    work_description VARCHAR(MAX),
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

CREATE TABLE billable_charges (
    billable_charge_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    contract_billing_item_id BIGINT NOT NULL,
    work_order_id BIGINT NOT NULL,
    region_id INT NOT NULL,
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
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
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
    adjustment_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    paid_amount DECIMAL(18,2) NOT NULL DEFAULT 0,
    balance_due DECIMAL(18,2) NOT NULL DEFAULT 0,
    currency_code CHAR(3) NOT NULL DEFAULT 'USD',
    customer_reference_number VARCHAR(100) NULL,
    external_invoice_number VARCHAR(100) NULL,
    submitted_on DATETIME NULL,
    paid_on DATETIME NULL,
    voided_on DATETIME NULL,
    notes VARCHAR(MAX),
    created_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on DATETIME,
    created_by VARCHAR(100),
    updated_by VARCHAR(100)
);

CREATE TABLE invoice_line_items (
    invoice_line_id BIGINT PRIMARY KEY,
    invoice_id BIGINT NOT NULL,
    billable_charge_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    contract_id BIGINT NOT NULL,
    contract_billing_item_id BIGINT NOT NULL,
    work_order_id BIGINT NOT NULL,
    region_id INT NOT NULL,
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
    CONSTRAINT uq_invoice_line_items_invoice_line_number UNIQUE (invoice_id, line_number),
    CONSTRAINT uq_invoice_line_items_billable_charge UNIQUE (billable_charge_id)
);

CREATE TABLE equipment_usage_logs (
    usage_id INT PRIMARY KEY,
    equipment_id VARCHAR(20),
    usage_date DATE,
    start_time VARCHAR(50),
    end_time VARCHAR(50),
    hours_used REAL,
    usage_type VARCHAR(100),
    operator_employee_id INT,
    region_id INT,
    project_code VARCHAR(100),
    start_meter_reading REAL,
    end_meter_reading REAL,
    fuel_type VARCHAR(50),
    idle_hours REAL,
    usage_status VARCHAR(100),
    notes VARCHAR(MAX),
    created_on DATETIME,
    updated_on DATETIME
);

-- Add foreign key constraints after table creation.
ALTER TABLE customers ADD CONSTRAINT fk_customers_customer_type FOREIGN KEY (customer_type_id) REFERENCES customer_types(customer_type_id);
ALTER TABLE customers ADD CONSTRAINT fk_customers_customer_status FOREIGN KEY (customer_status_id) REFERENCES customer_statuses(customer_status_id);
ALTER TABLE customers ADD CONSTRAINT fk_customers_industry FOREIGN KEY (industry_id) REFERENCES industries(industry_id);
ALTER TABLE customers ADD CONSTRAINT fk_customers_parent_customer FOREIGN KEY (parent_customer_id) REFERENCES customers(customer_id);

ALTER TABLE employees ADD CONSTRAINT fk_employees_region FOREIGN KEY (region_id) REFERENCES regions(region_id);

ALTER TABLE regions ADD CONSTRAINT fk_regions_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE regions ADD CONSTRAINT fk_regions_supervisor FOREIGN KEY (supervisor_employee_id) REFERENCES employees(employee_id);

ALTER TABLE equipment ADD CONSTRAINT fk_equipment_region FOREIGN KEY (region_id) REFERENCES regions(region_id);

ALTER TABLE maintenance_logs ADD CONSTRAINT fk_maintenance_logs_equipment FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id);
ALTER TABLE maintenance_logs ADD CONSTRAINT fk_maintenance_logs_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id);
ALTER TABLE maintenance_logs ADD CONSTRAINT fk_maintenance_logs_technician FOREIGN KEY (technician_employee_id) REFERENCES employees(employee_id);

ALTER TABLE maintenance_invoices ADD CONSTRAINT fk_maintenance_invoices_maintenance FOREIGN KEY (maintenance_id) REFERENCES maintenance_logs(maintenance_id);
ALTER TABLE maintenance_invoices ADD CONSTRAINT fk_maintenance_invoices_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id);

ALTER TABLE contracts ADD CONSTRAINT fk_contracts_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_type FOREIGN KEY (contract_type_id) REFERENCES contract_types(contract_type_id);
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_status FOREIGN KEY (contract_status_id) REFERENCES contract_statuses(contract_status_id);

ALTER TABLE contract_documents ADD CONSTRAINT fk_contract_documents_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);
ALTER TABLE contract_billable_items ADD CONSTRAINT fk_contract_billable_items_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);

ALTER TABLE billing_approval_policies ADD CONSTRAINT fk_billing_approval_policies_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE billing_approval_policies ADD CONSTRAINT fk_billing_approval_policies_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);
ALTER TABLE billing_approval_policies ADD CONSTRAINT fk_billing_approval_policies_contract_billing_item FOREIGN KEY (contract_billing_item_id) REFERENCES contract_billable_items(contract_billable_item_id);

ALTER TABLE crews ADD CONSTRAINT fk_crews_region FOREIGN KEY (region_id) REFERENCES regions(region_id);
ALTER TABLE crews ADD CONSTRAINT fk_crews_supervisor FOREIGN KEY (supervisor_employee_id) REFERENCES employees(employee_id);

ALTER TABLE work_orders ADD CONSTRAINT fk_work_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE work_orders ADD CONSTRAINT fk_work_orders_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);
ALTER TABLE work_orders ADD CONSTRAINT fk_work_orders_region FOREIGN KEY (region_id) REFERENCES regions(region_id);
ALTER TABLE work_orders ADD CONSTRAINT fk_work_orders_crew FOREIGN KEY (crew_id) REFERENCES crews(crew_id);
ALTER TABLE work_orders ADD CONSTRAINT fk_work_orders_status FOREIGN KEY (work_order_status_id) REFERENCES work_order_statuses(work_order_status_id);

ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_contract_billing_item FOREIGN KEY (contract_billing_item_id) REFERENCES contract_billable_items(contract_billable_item_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_work_order FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_region FOREIGN KEY (region_id) REFERENCES regions(region_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_crew FOREIGN KEY (crew_id) REFERENCES crews(crew_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_invoice FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id);
ALTER TABLE billable_charges ADD CONSTRAINT fk_billable_charges_status FOREIGN KEY (billable_charge_status_id) REFERENCES billable_charge_statuses(billable_charge_status_id);

ALTER TABLE invoices ADD CONSTRAINT fk_invoices_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE invoices ADD CONSTRAINT fk_invoices_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);
ALTER TABLE invoices ADD CONSTRAINT fk_invoices_status FOREIGN KEY (invoice_status_id) REFERENCES invoice_statuses(invoice_status_id);

ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_invoice FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_billable_charge FOREIGN KEY (billable_charge_id) REFERENCES billable_charges(billable_charge_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_contract FOREIGN KEY (contract_id) REFERENCES contracts(contract_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_contract_billing_item FOREIGN KEY (contract_billing_item_id) REFERENCES contract_billable_items(contract_billing_item_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_work_order FOREIGN KEY (work_order_id) REFERENCES work_orders(work_order_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_region FOREIGN KEY (region_id) REFERENCES regions(region_id);
ALTER TABLE invoice_line_items ADD CONSTRAINT fk_invoice_line_items_crew FOREIGN KEY (crew_id) REFERENCES crews(crew_id);

ALTER TABLE equipment_usage_logs ADD CONSTRAINT fk_equipment_usage_logs_equipment FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id);
ALTER TABLE equipment_usage_logs ADD CONSTRAINT fk_equipment_usage_logs_operator FOREIGN KEY (operator_employee_id) REFERENCES employees(employee_id);
ALTER TABLE equipment_usage_logs ADD CONSTRAINT fk_equipment_usage_logs_region FOREIGN KEY (region_id) REFERENCES regions(region_id);
