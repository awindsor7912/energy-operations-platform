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
state TEXT,
supervisor_employee_id INTEGER,
region_status TEXT,
created_on DATE,
updated_on DATE,
FOREIGN KEY (supervisor_employee_id) REFERENCES employees(employee_id)
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
