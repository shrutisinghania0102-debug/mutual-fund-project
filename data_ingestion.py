# data_ingestion.py
import pandas as pd # type: ignore
import os

data_path = r"C:\Users\Shruti Singhania\mutual_fund_project\data\raw"

print("Checking path...")
print(os.path.exists(data_path))

csv_files = [f for f in os.listdir(data_path) if f.endswith('.csv')]

print("CSV Files Found:", csv_files)

for file in csv_files:
    file_path = os.path.join(data_path, file)

    print(f"\nReading {file}...")

    df = pd.read_csv(file_path)

    print(df.head())

print("All datasets loaded")