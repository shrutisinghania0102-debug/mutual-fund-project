# live_nav_fetch.py
import requests # type: ignore
import pandas as pd # type: ignore

schemes = {
    "SBI_Bluechip":       119551,
    "ICICI_Bluechip":     120503,
    "Nippon_Large_Cap":   118632,
    "Axis_Bluechip":      119092,
    "Kotak_Bluechip":     120841
}

for scheme_name, code in schemes.items():
    url = f"https://api.mfapi.in/mf/{code}"
    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
        df = pd.DataFrame(data['data'])
        df['scheme_name'] = data['meta']['scheme_name']
        df['scheme_code'] = code
        
        filename = f"data/raw/nav_{scheme_name}_{code}.csv"
        df.to_csv(filename, index=False)
        print(f"Saved: {filename} | Records: {len(df)}")
    else:
        print(f"Failed for {scheme_name}: {response.status_code}")