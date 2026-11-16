-- 05: Monthly house sales in England, 2019-2025, against the 2019 monthly average.
-- 2026 is left out because recent months are provisional and are revised up as registrations catch up.
SELECT
    date                                       AS month,
    CAST(sales_volume AS INTEGER)              AS sales,
    (SELECT ROUND(AVG(sales_volume)) FROM hpi
      WHERE area_code = 'E92000001' AND date BETWEEN '2019-01-01' AND '2019-12-01') AS avg_monthly_sales_2019
FROM hpi
WHERE area_code = 'E92000001'
  AND date BETWEEN '2019-01-01' AND '2025-12-01'
ORDER BY date;
