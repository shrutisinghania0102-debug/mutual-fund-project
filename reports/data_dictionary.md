# Data Dictionary — Bluestock MF

## fact_nav
| Column       | Type  | Description                        |
|--------------|-------|------------------------------------|
| amfi_code    | TEXT  | Unique fund identifier (AMFI)      |
| nav_date     | DATE  | Date of NAV                        |
| nav          | REAL  | Net Asset Value in ₹               |
| daily_return | REAL  | % change from previous day's NAV   |

## fact_transactions
| Column           | Type  | Description                     |
|------------------|-------|---------------------------------|
| transaction_type | TEXT  | SIP / LUMPSUM / REDEMPTION      |
| amount_inr       | REAL  | Transaction amount in ₹         |
| kyc_status       | TEXT  | VERIFIED / PENDING / REJECTED   |
