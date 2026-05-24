SELECT
	equip_use.equipment_id,
	equip_use.avg_use_hrs,
	equip_use.total_use_hrs,
	equip_cost.maintenance_events,
	equip_cost.total_cost, 
	ROUND(equip_cost.total_cost/NULLIF(equip_use.avg_use_hrs,0),2) AS cost_relative_to_use,
	ROUND(equip_cost.total_cost/NULLIF(equip_use.total_use_hrs,0),2) AS maint_cost_per_hr
FROM (
	SELECT
		e.equipment_id,
		ROUND(AVG(u.hours_used),2) AS avg_use_hrs,
		ROUND(SUM(u.hours_used),2) AS total_use_hrs
	FROM
		equipment e
	LEFT JOIN
		equipment_usage_logs u
		ON e.equipment_id = u.equipment_ID
	GROUP BY e.equipment_id
	) AS equip_use
INNER JOIN (
	SELECT
		ml.equipment_id,
		COUNT(ml.maintenance_id) AS maintenance_events,
		ROUND(COALESCE(SUM(mi.total_invoice_amount),0),2) AS total_cost
	FROM 
		maintenance_logs ml
	LEFT JOIN
		maintenance_invoices mi
		ON ml.maintenance_id = mi.maintenance_id
	GROUP BY ml.equipment_id
	) AS equip_cost
ON equip_use.equipment_id = equip_cost.equipment_id
ORDER BY total_cost DESC;
