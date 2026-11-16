"""
Load the UK House Price Index full file into a SQLite database.

Usage: python scripts/build_database.py <hpi_csv> <database_path>
"""
import sqlite3
import sys
from pathlib import Path

import pandas as pd

CSV, DB = Path(sys.argv[1]), Path(sys.argv[2])

df = pd.read_csv(CSV)
# tidy column names for SQL: "1m%Change" -> "change_1m_pct", "AveragePrice" -> "average_price"
rename = {}
for c in df.columns:
    n = c.replace("1m%Change", "Change1mPct").replace("12m%Change", "Change12mPct")
    n = "".join("_" + ch.lower() if ch.isupper() else ch for ch in n).lstrip("_")
    rename[c] = n.replace("f_t_b", "ftb").replace("f_o_o", "foo").replace("_s_a", "_sa").replace("1m_pct", "_1m_pct").replace("12m_pct", "_12m_pct").replace("__", "_")
df = df.rename(columns=rename)
df["date"] = pd.to_datetime(df["date"], format="%d/%m/%Y").dt.strftime("%Y-%m-%d")

if DB.exists():
    DB.unlink()
con = sqlite3.connect(DB)
df.to_sql("hpi", con, index=False)
con.execute("CREATE INDEX idx_hpi_area_date ON hpi(area_code, date)")
con.close()
print(f"hpi: {len(df):,} rows, {df['region_name'].nunique()} areas, {df['date'].min()} to {df['date'].max()}")
print(", ".join(df.columns))
