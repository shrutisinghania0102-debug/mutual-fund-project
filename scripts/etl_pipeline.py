import pandas as pd
import requests
from pathlib import Path
from datetime import datetime

# Project root
project_root = Path(__file__).resolve().parent.parent

# Input file
nav_path = project_root / "data" / "processed" / "clean_nav.xls"

# Read file
nav_df = pd.read_csv(nav_path)

# Get unique AMFI codes
amfi_codes = (
    nav_df["amfi_code"]
    .dropna()
    .astype(int)
    .unique()
)

all_data = []

for code in amfi_codes:

    url = f"https://api.mfapi.in/mf/{code}"

    try:
        response = requests.get(url, timeout=30)

        if response.status_code != 200:
            print(f"Failed for {code}")
            continue

        data = response.json()

        if "data" not in data:
            print(f"No data key for {code}")
            continue

        if len(data["data"]) == 0:
            print(f"Empty NAV history for {code}")
            continue

        latest_nav = data["data"][0]

        all_data.append({
            "amfi_code": code,
            "date": latest_nav["date"],
            "nav": latest_nav["nav"],
            "fetch_time": datetime.now()
        })

        print(f"Fetched {code}")

    except Exception as e:
        print(f"Error for {code}: {e}")

# Save results
result_df = pd.DataFrame(all_data)

output_path = project_root / "data" / "processed" / "daily_nav.csv"

result_df.to_csv(output_path, index=False)

print("\nFinished")
print(f"Records fetched: {len(result_df)}")
print(f"Saved to: {output_path}")