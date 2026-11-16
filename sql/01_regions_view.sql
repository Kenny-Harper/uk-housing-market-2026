-- 01: The 12 regions and nations used in the analysis, with short display names.
DROP VIEW IF EXISTS regions;
CREATE VIEW regions AS
SELECT area_code,
       CASE region_name
           WHEN 'West Midlands Region' THEN 'West Midlands'
           WHEN 'Yorkshire and The Humber' THEN 'Yorkshire & Humber'
           ELSE region_name
       END AS region
FROM (SELECT DISTINCT area_code, region_name FROM hpi)
WHERE area_code IN ('E12000001','E12000002','E12000003','E12000004','E12000005',
                    'E12000006','E12000007','E12000008','E12000009',
                    'W92000004','S92000003','N92000002');
