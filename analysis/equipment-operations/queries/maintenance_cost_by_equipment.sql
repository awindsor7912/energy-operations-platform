SELECT 
    e.equipment_id,
    COUNT(ml.maintenance_id) AS maintenance_events,
    SUM(mi.total_invoice_amount) AS total_cost
FROM equipment e
LEFT JOIN maintenance_logs ml
    ON e.equipment_id = ml.equipment_id
LEFT JOIN maintenance_invoices mi
    ON ml.maintenance_id = mi.maintenance_id
GROUP BY e.equipment_id
ORDER BY total_cost DESC;
