-- 03: 12-month price change by property type for each region (August 2026), in long format.
SELECT r.region, 'Detached' AS property_type, 1 AS type_order, h.detached_change_12m_pct AS price_change_12m_pct
FROM regions r JOIN hpi h ON h.area_code = r.area_code AND h.date = '2026-08-01'
UNION ALL
SELECT r.region, 'Semi-detached', 2, h.semi_detached_change_12m_pct
FROM regions r JOIN hpi h ON h.area_code = r.area_code AND h.date = '2026-08-01'
UNION ALL
SELECT r.region, 'Terraced', 3, h.terraced_change_12m_pct
FROM regions r JOIN hpi h ON h.area_code = r.area_code AND h.date = '2026-08-01'
UNION ALL
SELECT r.region, 'Flat', 4, h.flat_change_12m_pct
FROM regions r JOIN hpi h ON h.area_code = r.area_code AND h.date = '2026-08-01'
ORDER BY region, type_order;
