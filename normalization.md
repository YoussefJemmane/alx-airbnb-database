# Database Normalization Report – AirBnB Clone

## Objective
Ensure the database schema adheres to the Third Normal Form (3NF) by eliminating redundancies and maintaining data integrity.

---

## First Normal Form (1NF)

- All tables contain atomic values.
- No multi-valued or repeating attributes were found.

✅ **1NF satisfied**

---

## Second Normal Form (2NF)

- All non-key attributes are fully functionally dependent on the table's primary key.
- No partial dependencies detected, as all tables use single-column primary keys.

✅ **2NF satisfied**

---

## Third Normal Form (3NF)

- No transitive dependencies exist.
- Every non-key attribute depends only on the primary key.
- Foreign keys (e.g., `user_id`, `property_id`, etc.) are used appropriately to maintain relations.

✅ **3NF satisfied**

---

## Final Assessment

The AirBnB data model is **fully normalized up to 3NF**. No modifications to the current schema are necessary.

---

## Recommendation

Continue enforcing foreign key constraints and consider indexing frequently queried fields (e.g., `email`, `property_id`) for performance optimization.
