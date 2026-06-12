-- ==========================
-- DIMENSION TABLES
-- ==========================

CREATE TABLE dim_fund (
    amfi_code TEXT PRIMARY KEY,
    fund_house TEXT,
    scheme_name TEXT,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date DATE,
    benchmark TEXT,
    expense_ratio_pct REAL,
    exit_load_pct REAL,
    min_sip_amount REAL,
    min_lumpsum_amount REAL,
    fund_manager TEXT,
    risk_category TEXT,
    sebi_category_code TEXT
);

CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    day INTEGER
);

-- ==========================
-- FACT TABLES
-- ==========================

CREATE TABLE fact_nav (
    amfi_code TEXT,
    nav_date DATE,
    nav REAL,

    PRIMARY KEY (amfi_code, nav_date),

    FOREIGN KEY (amfi_code)
        REFERENCES dim_fund(amfi_code),

    FOREIGN KEY (nav_date)
        REFERENCES dim_date(date_key)
);

CREATE TABLE fact_transactions (
    investor_id TEXT,
    transaction_date DATE,
    amfi_code TEXT,
    transaction_type TEXT,
    amount_inr REAL,
    state TEXT,
    city TEXT,
    city_tier TEXT,
    age_group TEXT,
    gender TEXT,
    annual_income_lakh REAL,
    payment_mode TEXT,
    kyc_status TEXT,

    PRIMARY KEY (
        investor_id,
        transaction_date,
        amfi_code
    ),

    FOREIGN KEY (amfi_code)
        REFERENCES dim_fund(amfi_code),

    FOREIGN KEY (transaction_date)
        REFERENCES dim_date(date_key)
);

CREATE TABLE fact_performance (
    amfi_code TEXT PRIMARY KEY,

    return_1yr_pct REAL,
    return_3yr_pct REAL,
    return_5yr_pct REAL,
    benchmark_3yr_pct REAL,

    alpha REAL,
    beta REAL,
    sharpe_ratio REAL,
    sortino_ratio REAL,

    std_dev_ann_pct REAL,
    max_drawdown_pct REAL,

    aum_crore REAL,
    expense_ratio_pct REAL,

    morningstar_rating INTEGER,
    risk_grade TEXT,
    negative_sharpe_flag BOOLEAN,

    FOREIGN KEY (amfi_code)
        REFERENCES dim_fund(amfi_code)
);

CREATE TABLE fact_aum (
    aum_date DATE,
    fund_house TEXT,
    aum_lakh_crore REAL,
    aum_crore REAL,
    num_schemes INTEGER,

    PRIMARY KEY (aum_date, fund_house),

    FOREIGN KEY (aum_date)
        REFERENCES dim_date(date_key)
);
