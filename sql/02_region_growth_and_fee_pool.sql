-- 02: For each region: latest price and 12-month price change (August 2026),
-- plus 2025 sales and an estimated estate agency fee pool.
-- Fee pool = 2025 sales x average 2025 price x 1.2% (an assumed typical agency fee).
WITH sales_2025 AS (
    SELECT area_code,
           SUM(sales_volume)  AS sales_2025,
           AVG(average_price) AS avg_price_2025
    FROM hpi
    WHERE date BETWEEN '2025-01-01' AND '2025-12-01'
    GROUP BY area_code
)
SELECT
    r.region,
    h.average_price                                        AS avg_price_aug_2026,
    h.change_12m_pct                                       AS price_change_12m_pct,
    CAST(s.sales_2025 AS INTEGER)                          AS sales_2025,
    ROUND(s.sales_2025 * s.avg_price_2025 * 0.012 / 1e6)   AS est_fee_pool_2025_gbp_m
FROM regions r
JOIN hpi h        ON h.area_code = r.area_code AND h.date = '2026-08-01'
JOIN sales_2025 s ON s.area_code = r.area_code
ORDER BY price_change_12m_pct DESC;
