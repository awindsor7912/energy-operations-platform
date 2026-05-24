SELECT 
    e.equipment_id,
    ROUND(AVG(u.hours_used), 2) AS avg_usage,
    ROUND(SUM(mi.total_invoice_amount), 2) AS total_cost
FROM equipment e
LEFT JOIN equipment_usage_logs u
    ON e.equipment_id = u.equipment_id
LEFT JOIN maintenance_logs ml
    ON e.equipment_id = ml.equipment_id
LEFT JOIN maintenance_invoices mi
    ON ml.maintenance_id = mi.maintenance_id
GROUP BY e.equipment_id
ORDER BY total_cost DESC;
