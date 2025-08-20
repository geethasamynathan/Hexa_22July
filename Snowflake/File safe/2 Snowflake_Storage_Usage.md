
# ❄️ Snowflake Storage Usage — Queries + Diagram

This note explains how to read Snowflake storage usage at both **account** and **table** level, and includes a **diagram** of how the metrics relate.

---

## 1) Account-level storage usage (raw)

```sql
SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE
ORDER BY USAGE_DATE DESC;
```

**What it shows:** One row per day for your account. Important columns:
- `USAGE_DATE` — date of measurement.
- `STORAGE_BYTES` — active data stored across the account.
- `STAGE_BYTES` — bytes stored in *internal stages*.
- `FAILSAFE_BYTES` — data currently in **Fail-safe** (7‑day recovery window after Time Travel expires).

> Values are in **bytes**; use the formatted query below for GB.

---

## 2) Account-level storage usage (formatted to GB)

```sql
SELECT
  USAGE_DATE,
  STORAGE_BYTES / (1024*1024*1024) AS STORAGE_GB,
  STAGE_BYTES   / (1024*1024*1024) AS STAGE_GB,
  FAILSAFE_BYTES / (1024*1024*1024) AS FAILSAFE_GB
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE
ORDER BY USAGE_DATE DESC;
```

**Why this helps:** Easier readability and **trend analysis** over time (daily granularity).

---

## 3) Table-level storage usage (raw)

```sql
SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS;
```

**What it shows:** Per‑table breakdown:
- `ACTIVE_BYTES` — current/active table data.
- `TIME_TRAVEL_BYTES` — historical data retained for **Time Travel**.
- `FAILSAFE_BYTES` — data in **Fail-safe** for disaster recovery.

---

## 4) Table-level storage usage (formatted + sortable)

```sql
SELECT
  ID,
  TABLE_NAME,
  TABLE_SCHEMA,
  ACTIVE_BYTES        / (1024*1024*1024) AS STORAGE_USED_GB,
  TIME_TRAVEL_BYTES   / (1024*1024*1024) AS TIME_TRAVEL_STORAGE_USED_GB,
  FAILSAFE_BYTES      / (1024*1024*1024) AS FAILSAFE_STORAGE_USED_GB
FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
ORDER BY FAILSAFE_STORAGE_USED_GB DESC;
```

**Why this helps:** Quickly finds **which tables** drive storage cost—especially from **Time Travel** and **Fail-safe**. This informs retention tuning and housekeeping (avoiding unnecessary drops/recreates).

---

## 📊 Diagram — How the metrics relate



**Reading the diagram:**
- At the **Account** level (viewed via `ACCOUNT_USAGE.STORAGE_USAGE`), Snowflake reports aggregate **STORAGE_BYTES**, **STAGE_BYTES**, and **FAILSAFE_BYTES** per day.
- At the **Table** level (viewed via `ACCOUNT_USAGE.TABLE_STORAGE_METRICS`), each table contributes:
  - **ACTIVE_BYTES** → part of account **STORAGE_BYTES**
  - **TIME_TRAVEL_BYTES** → historical retention; contributes to account storage
  - **FAILSAFE_BYTES** → contributes to account **FAILSAFE_BYTES**
- **Internal Stages** contribute specifically to **STAGE_BYTES**.

---

## 🔎 Practical tips

- If account **FAILSAFE_BYTES** spikes, sort `TABLE_STORAGE_METRICS` by `FAILSAFE_BYTES` to find which tables were recently dropped/modified heavily.
- To reduce storage cost:
  - Right-size **Time Travel** retention per table.
  - Avoid unnecessary **drop/recreate** cycles (they create Fail-safe storage).
  - Purge unused files from **internal stages**.

