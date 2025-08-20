# 📌 What is CRON in Snowflake?

## **Definition**
- In **Snowflake Tasks**, `CRON` is a **time-based scheduling expression** that tells Snowflake **when to run a task**.  
- It follows the **standard UNIX CRON format**, with some Snowflake-specific rules.

A **CRON expression** is a **string with 5 fields** (in Snowflake’s case, plus timezone):  

```
<minute> <hour> <day_of_month> <month> <day_of_week> [timezone]
```

---

## **CRON Fields Explained**

| Field            | Allowed Values                | Example   | Meaning                                    |
|------------------|-------------------------------|-----------|--------------------------------------------|
| **Minute**       | `0–59`, `*`, `,`, `-`         | `0`       | At the start of the hour                   |
| **Hour**         | `0–23`, `*`, `,`, `-`         | `7`       | At 07:00 (7 AM) UTC                        |
| **Day of Month** | `1–31`, `*`, `,`, `-`, `L`    | `15`      | On the 15th of the month                   |
| **Month**        | `1–12`, `*`, month names      | `1,7`     | In January and July                        |
| **Day of Week**  | `0–6` (Sun=0), `*`, names, `L`| `5L`      | On the **last Friday** of the month        |
| **Timezone**     | Optional (`UTC` default)      | `UTC`     | Coordinated Universal Time (default zone)  |

---

## **Special Characters**

- `*` → Any value (every minute, every hour, etc.)
- `,` → List (e.g., `7,10` = at 7 AM and 10 AM)
- `-` → Range (e.g., `1-5` = Mon–Fri)
- `/` → Step (e.g., `*/15` = every 15 minutes)
- `L` → Last (e.g., `5L` = last Friday of the month)

---

## **Examples in Snowflake**

1. **Daily at midnight UTC**
   ```sql
   SCHEDULE = 'USING CRON 0 0 * * * UTC'
   ```
   👉 Runs **00:00 every day**.

2. **Every 15 minutes**
   ```sql
   SCHEDULE = 'USING CRON */15 * * * * UTC'
   ```
   👉 Runs at **00, 15, 30, 45 minutes of every hour**.

3. **On the last Friday at 07:00**
   ```sql
   SCHEDULE = 'USING CRON 0 7 * * 5L UTC'
   ```
   👉 Runs once at **07:00 UTC on the last Friday of the month**.

---

## **Why CRON in Snowflake?**

✅ Automates data pipelines (ETL/ELT)  
✅ Ensures tasks run at precise times (e.g., load daily sales at midnight)  
✅ Useful for **batch jobs, incremental loads, report refreshes**  

---

⚡ **In short:**  
CRON in Snowflake = **scheduling language** that defines **when a task should execute**, based on time rules.
