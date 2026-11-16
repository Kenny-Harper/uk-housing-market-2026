-- 04: The 10 fastest-rising and 10 fastest-falling local areas (12-month price change, August 2026).
-- Only local authorities with at least 1,000 sales in 2025, so small markets don't distort the ranking.
-- Northern Ireland figures are published quarterly, so its local areas show the latest quarter.
WITH local_areas AS (
    SELECT h.region_name AS area, h.area_code, h.average_price, h.change_12m_pct,
           (SELECT SUM(s.sales_volume) FROM hpi s
             WHERE s.area_code = h.area_code AND s.date BETWEEN '2025-01-01' AND '2025-12-01') AS sales_2025
    FROM hpi h
    WHERE h.date = '2026-08-01'
      AND substr(h.area_code, 1, 3) IN ('E06','E07','E08','E09','W06','S12','N09')
),
ranked AS (
    SELECT *,
           RANK() OVER (ORDER BY change_12m_pct DESC) AS rank_rising,
           RANK() OVER (ORDER BY change_12m_pct ASC)  AS rank_falling
    FROM local_areas
    WHERE sales_2025 >= 1000
)
SELECT area, area_code, average_price, change_12m_pct AS price_change_12m_pct,
       CAST(sales_2025 AS INTEGER) AS sales_2025,
       CASE WHEN rank_rising <= 10 THEN 'Fastest rising' ELSE 'Fastest falling' END AS grp
FROM ranked
WHERE rank_rising <= 10 OR rank_falling <= 10
ORDER BY price_change_12m_pct DESC;
