CREATE TABLE dim_fund (
    amfi_code   TEXT PRIMARY KEY,
    fund_house  TEXT,
    scheme_name TEXT,
    category    TEXT,       -- Equity/Debt/Hybrid
    sub_category TEXT,
    is_active   INTEGER DEFAULT 1
);

CREATE TABLE fact_nav (
    amfi_code    TEXT REFERENCES dim_fund(amfi_code),
    nav_date     DATE,
    nav          REAL,
    daily_return REAL,
    PRIMARY KEY (amfi_code, nav_date)
);

CREATE TABLE fact_transactions (
    txn_id           TEXT PRIMARY KEY,
    amfi_code        TEXT REFERENCES dim_fund(amfi_code),
    investor_id      TEXT,
    transaction_type TEXT,   -- SIP / LUMPSUM / REDEMPTION
    amount           REAL,
    transaction_date DATE,
    state            TEXT,
    kyc_status       TEXT
);

CREATE TABLE fact_performance (
    amfi_code         TEXT REFERENCES dim_fund(amfi_code),
    as_of_date        DATE,
    return_1y         REAL,
    return_3y         REAL,
    return_5y         REAL,
    sharpe_ratio      REAL,
    expense_ratio     REAL,
    negative_sharpe_flag INTEGER,
    PRIMARY KEY (amfi_code, as_of_date)
);