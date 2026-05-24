SELECT
	e.equipment_id,
	SUM(u.hours_used) AS total_used,
	SUM(u.idle_hours) AS total_idle,
	ROUND(SUM(u.hours_used+u.idle_hours),2) AS total_time,
	ROUND((SUM(u.idle_hours))/(SUM(u.hours_used+u.idle_hours)),2) AS idle_ratio
FROM equipment e
LEFT JOIN equipment_usage_logs u
	ON e.equipment_id = u.equipment_ID
GROUP BY e.equipment_id
ORDER BY idle_ratio DESC;
