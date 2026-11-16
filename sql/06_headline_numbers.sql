-- 06: Headline numbers for the dashboard title and findings.
SELECT
    (SELECT average_price  FROM hpi WHERE area_code = 'K02000001' AND date = '2026-08-01') AS uk_avg_price,
    (SELECT change_12m_pct FROM hpi WHERE area_code = 'K02000001' AND date = '2026-08-01') AS uk_change_12m_pct,
    (SELECT COUNT(*) FROM regions r JOIN hpi h ON h.area_code = r.area_code AND h.date = '2026-08-01'
      WHERE h.flat_change_12m_pct < 0)                                                    AS regions_where_flats_fell,
    (SELECT SUM(sales_volume) FROM hpi WHERE area_code = 'E92000001' AND date BETWEEN '2025-01-01' AND '2025-12-01') AS england_sales_2025,
    (SELECT SUM(sales_volume) FROM hpi WHERE area_code = 'E92000001' AND date BETWEEN '2024-01-01' AND '2024-12-01') AS england_sales_2024,
    (SELECT SUM(sales_volume) FROM hpi WHERE area_code = 'E92000001' AND date BETWEEN '2019-01-01' AND '2019-12-01') AS england_sales_2019;
