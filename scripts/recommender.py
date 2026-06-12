import pandas as pd

# Load performance dataset
perf_df = pd.read_csv(r"C:\Users\Shruti Singhania\mutual_fund_project\data\processed\clean_performance.xls")

# Remove extra spaces from column names
perf_df.columns = perf_df.columns.str.strip()

print("Available columns:")
print(perf_df.columns.tolist())


def recommend_funds(risk_appetite):
    """
    Recommend top 3 funds based on risk appetite
    """

    filtered = perf_df[
        perf_df["risk_grade"].str.lower() == risk_appetite.lower()
    ]

    recommendations = (
        filtered
        .sort_values(by="sharpe_ratio", ascending=False)
        .head(3)
    )

    return recommendations[
        [
            "amfi_code",
            "scheme_name",
            "risk_grade",
            "sharpe_ratio"
        ]
    ]


# User Input
risk = input("Enter Risk Appetite (Low/Moderate/High): ").strip()

try:
    result = recommend_funds(risk)

    if result.empty:
        print(f"\nNo funds found for risk appetite: {risk}")
    else:
        print("\nTop 3 Recommended Funds:\n")
        print(result.to_string(index=False))

except Exception as e:
    print("\nERROR:")
    print(e)