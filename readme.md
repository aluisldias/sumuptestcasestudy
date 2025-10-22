# 📘 DBT Project Overview

This dbt project follows a simplified **medallion architecture** for data modeling and transformations.

| Layer | Purpose | Typical Materialization |
|--------|----------|-------------------------|
| 🥉 **Bronze (Staging)** | Raw data cleaning and normalization | **Views** |
| 🥈 **Silver (Core / Intermediate)** | Business logic, joins, denormalization | **Incremental tables** |
| 🥇 **Gold (Marts)** | Curated reporting datasets | **Views** or **incremental tables** |

---

## 🧱 Architecture Notes

- **Staging layer (`stg_*`)**
  - Modeled as **views** for flexibility and faster iteration.  
  - Performs light transformations (type casts, cleaning).  
  - Example: `stg_transactions` is **append-only incremental** since events are immutable and never updated.

- **Core layer (`core/*`)**
  - Denormalizes data for intermediate analysis.
  - Re-normalized into domain-specific folders (e.g. `store`, `product`).
  - Uses **incremental materialization** for performance.

- **Marts layer (`marts/*`)**
  - Curated datasets exposed to stakeholders.  
  - Materialized as **views** or **incremental tables** depending on query performance needs.

---

## 🧩 Data Relationships

- `transactions` → `devices`: **many-to-one**  
- `devices` → `stores`: **one-to-many**  
- Devices are treated as **products**, since SumUp earns revenue through them.  
- Most analyses are **store-based**, so `store` and `product` folders were created for clarity.

---

## ⚙️ Modeling Conventions

| Category | Decision | Rationale |
|-----------|-----------|-----------|
| **Fact tables** | Materialized as **tables** | Better query performance |
| **Final reporting tables** | **Views** or **incremental** | Faster builds, easier iteration |
| **Staging models** | **Views** | Flexibility and speed |
| **Seeds** | Used only for static data | Event-based data would normally be ingested via tools like Airbyte |
| **Hashing** | Used **MD5()** | Simplicity; PostgreSQL lacks built-in stronger hash |
| **PII Handling** | Performed in **core layer** | Ensure clean data before stakeholder exposure |

---

## 🧮 Incremental Logic

- **`stg_transaction`** uses **append-only incremental logic**:
  - Event tables are **immutable**
  - No “pending” or updatable states  
  - New records are **added**, not updated

> 📝 Avoided `MERGE` or `INSERT OVERWRITE` because event immutability is preferred.

---

## 🔐 Data Quality & Testing

- Tests are defined in the **YAML files** alongside models.
- Include:
  - Schema and type validations  
  - Relationship and uniqueness checks  
- In production, additional **source freshness** and **PII validation** would be included.

---

## 🧭 Simplified Case Study Setup

- Seeds are used for demonstration, simulating ingestion.  
- In real environments, ingestion would rely on **ELT tools** (e.g., Airbyte, Fivetran).  
- This simplification allows focus on **data modeling** rather than infrastructure.

---

