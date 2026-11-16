"""
Run every SQL file in sql/ against the database and save each result as a CSV.

Usage: python scripts/run_analysis.py <database_path> <sql_folder> <output_folder>
"""
import sqlite3
import sys
from pathlib import Path

import pandas as pd

DB, SQL, OUT = Path(sys.argv[1]), Path(sys.argv[2]), Path(sys.argv[3])
OUT.mkdir(parents=True, exist_ok=True)

con = sqlite3.connect(DB)
for sql_file in sorted(SQL.glob("*.sql")):
    query = sql_file.read_text()
    if "CREATE VIEW" in query:
        con.executescript(query)            # 01 builds the view the others use
        print(f"{sql_file.name}: view created")
        continue
    df = pd.read_sql(query, con)
    out = OUT / (sql_file.stem.split("_", 1)[1] + ".csv")
    df.to_csv(out, index=False)
    print(f"{sql_file.name}: {len(df)} rows -> {out.name}")
con.close()
