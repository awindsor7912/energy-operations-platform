# Database

This folder contains the SQL Server schema, seed scripts, and analytical queries for the Energy Operations Platform.

## Folder Structure

- `schema/` — database creation and table definitions
- `seed/` — synthetic seed data
- `queries/` — validation and analytical SQL queries

## Current Build Order

1. Run `schema/00_create_database_and_schema.sql`
2. Run `seed/01_seed_reference_tables.sql`
3. Run `queries/00_verify_reference_seed_counts.sql`

## Data Policy

All data and entities in this project are fictional and created solely for demonstration, development, and portfolio purposes. This includes, but is not limited to, customers, vendors, employees, contracts, invoices, billing items, work orders, regions, crews, identifiers, transaction records, and operational scenarios. Any resemblance to actual persons, companies, customers, vendors, contracts, invoices, work orders, systems, or operational records is purely coincidental. No real customer, employer, vendor, employee, billing, invoice, contract, or work order data is intentionally used or represented.