# UK Housing Market 2026: Where Should an Estate Agency Focus?

A SQL analysis of the official UK House Price Index (to August 2026), written as a brief for an estate agency deciding where to focus: which regions, local areas and property types are growing, and where the money is.

**Live dashboard:** [Tableau Public link]

**Tools:** SQL (SQLite), Python (pandas), Tableau Public

## Key findings
1. **Prices are rising in the north and falling in the south.** In the 12 months to August 2026, Northern Ireland rose 9.2% and the North East 3.2%, while the South East fell 0.8% and London fell 2.2%. The UK average rose 0.9% to £273,037.
2. **The biggest markets are the ones losing value.** The South East and London still had the largest estimated agency fee pools in 2025 (about £624m and £602m), but both saw prices fall.
3. **Flats are the weak spot.** Flat prices fell in 8 of the 12 regions. In London, flats fell 5.0% while detached and semi-detached houses rose 1.8%. Semi-detached prices rose in every region.
4. **The hotspots are local.** The fastest-rising areas were in Northern Ireland and northern towns such as Pendle (+9.0%). The sharpest falls were in central London: Westminster (-14.3%) and Kensington and Chelsea (-13.8%).
5. **Activity is recovering but still below 2019.** England had 790,463 sales in 2025, up 10% on 2024 but 3% below 2019. Sales nearly doubled in March 2025 as buyers rushed to complete before stamp duty thresholds fell on 1 April.

## Recommendations
- **Grow in northern England, Scotland and Northern Ireland**, where prices and demand are rising and homes are more affordable.
- **In London and the South East, focus on houses rather than flats**, and set realistic asking prices to keep stock moving.
- **Protect income in the biggest fee pools** (London and the South East) through volume and service, rather than relying on price growth.
- **Plan for a market still below 2019 activity**, and expect a quieter spring 2026 after the stamp duty rush pulled sales forward.

> Caveats: price changes are 12-month figures for one month and can move quickly in small areas. The fee pool is an estimate (sales x average price x an assumed 1.2% fee). Northern Ireland is published quarterly. 2026 sales volumes are left out because recent months are provisional and get revised up.

## Project structure
```
sql/          01-06: the analysis, one question per file
scripts/      build_database.py (CSV -> SQLite), run_analysis.py (runs the SQL, saves CSVs)
data/outputs/ query results used by the Tableau dashboard
```

## How to reproduce
```bash
pip install pandas
# download the UK HPI full file (link below)
python scripts/build_database.py UK-HPI-full-file-2026-08.csv data/hpi.db
python scripts/run_analysis.py data/hpi.db sql data/outputs
```

## Data source
[UK House Price Index: data downloads August 2026](https://www.gov.uk/government/statistical-data-sets/uk-house-price-index-data-downloads-august-2026), HM Land Registry, Registers of Scotland, Land and Property Services Northern Ireland and ONS. Contains public sector information licensed under the Open Government Licence v3.0.
