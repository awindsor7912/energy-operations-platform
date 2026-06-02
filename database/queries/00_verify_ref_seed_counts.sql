USE EnergyOperationsPlatform;
GO

SELECT 'customer_types' AS table_name, COUNT(*) AS row_count FROM customer_types
UNION ALL
SELECT 'customer_statuses', COUNT(*) FROM customer_statuses
UNION ALL
SELECT 'industries', COUNT(*) FROM industries
UNION ALL
SELECT 'contract_statuses', COUNT(*) FROM contract_statuses
UNION ALL
SELECT 'contract_types', COUNT(*) FROM contract_types
UNION ALL
SELECT 'invoice_statuses', COUNT(*) FROM invoice_statuses
UNION ALL
SELECT 'work_order_statuses', COUNT(*) FROM work_order_statuses
UNION ALL
SELECT 'billable_charge_statuses', COUNT(*) FROM billable_charge_statuses;
GO