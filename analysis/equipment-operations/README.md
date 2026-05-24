# Equipment Operations Analysis
This analysis demonstrates how SQL can be used to evaluate operational efficiency, cost drivers, and asset performance within a simulated enterprise environment.
> Note: Detailed observations and recommendations will be added following data review. Current focus is on data modeling and query development.

## Objective

Evaluate equipment performance across utilization, maintenance cost, and operational efficiency to identify high-risk, high-cost, and underperforming assets.

---

## Analytical Scope

This analysis covers:

- Equipment utilization patterns  
- Maintenance cost and frequency  
- Idle time and operational inefficiency  
- Cost relative to usage  

All data is derived from a simulated enterprise dataset.

---

## Analyses Included

### 1. Idle Equipment Risk Detection

**Objective:**  
Identify equipment with a high proportion of idle time relative to total recorded usage.

**Key Metric:**  
- Idle Ratio = idle_hours / total_time  

**Output:**  
`outputs/idle_equipment_risk_detection.csv`

**Insight Focus:**  
- Detect underutilized or over-allocated assets  
- Highlight equipment that is active but not productive  

---

### 2. Maintenance Cost by Equipment

**Objective:**  
Determine total maintenance cost and frequency of maintenance events per asset.

**Key Metrics:**  
- Total Maintenance Cost  
- Maintenance Event Count  

**Output:**  
`outputs/maintenance_cost_by_equipment.csv`

**Insight Focus:**  
- Identify high-cost assets  
- Understand maintenance burden distribution  

---

### 3. High Cost vs Low Utilization

**Objective:**  
Identify equipment that incurs significant maintenance cost but shows low usage.

**Key Metrics:**  
- Total Maintenance Cost  
- Average Usage Hours  

**Output:**  
`outputs/high_cost_low_use_equipment.csv`

**Insight Focus:**  
- Highlight inefficient assets  
- Support reassignment or replacement decisions  

---

### 4. Asset Cost vs Utilization (Total Cost Focus)

**Objective:**  
Rank equipment by total maintenance cost while incorporating usage metrics.

**Key Metrics:**  
- Total Maintenance Cost  
- Average Usage Hours  
- Total Usage Hours  

**Output:**  
`outputs/equip_cost_v_actual_use_most_exp_assets.csv`

**Insight Focus:**  
- Identify major cost drivers  
- Distinguish between high-cost necessary assets and potential outliers  

---

### 5. Asset Cost vs Utilization (Efficiency Focus)

**Objective:**  
Evaluate equipment efficiency by normalizing maintenance cost against usage.

**Key Metrics:**  
- Maintenance Cost per Hour Used  
- Cost Relative to Average Usage  

**Output:**  
`outputs/equip_cost_v_actual_use_least_efficient_assets.csv`

**Insight Focus:**  
- Identify assets with disproportionate cost relative to usage  
- Detect inefficiencies not visible in total cost alone  

---

## Query Files

All SQL queries used for this analysis are available in:
/queries

Each query is structured to:
- Aggregate data at the equipment level  
- Combine operational and financial datasets  
- Derive metrics for comparative analysis  

---

## Key Findings

- A subset of equipment exhibits high idle ratios, indicating potential over-allocation or scheduling inefficiencies.  
- High total maintenance cost does not necessarily indicate inefficiency; several high-cost assets are also heavily utilized.  
- Cost per hour used provides a more accurate measure of asset performance than total cost alone.  
- Certain assets show both low utilization and high normalized maintenance cost, making them strong candidates for operational review.  

---

## Notes

- All data is synthetic and created for demonstration purposes  
- Results should be interpreted in context; low utilization can inflate normalized cost metrics  
- This analysis is designed to demonstrate SQL-based analytical workflows and data modeling  

---
