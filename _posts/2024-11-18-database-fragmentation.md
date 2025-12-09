---
layout: post
title: "Database Fragmentation"
date: 2024-11-18 12:00:00 +0100
categories: databases performance optimization
medium_url: https://medium.com/@abhinavr8/database-fragmentation-8e0835de2029
---

Fragmentation might seem like a topic reserved for database administrators, but understanding it can help any developer write more efficient applications and troubleshoot performance issues.

## What is Database Fragmentation?

Over time, as rows are inserted, updated, or deleted, tables can become **fragmented**, leading to scattered data blocks. This fragmentation can slow down query performance, as the database has to work harder to retrieve the data.

Think of it like a filing cabinet where documents are scattered across random drawers instead of being organized sequentially. Finding what you need takes much longer.

## Types of Fragmentation

### Internal Fragmentation
Occurs when data pages are not fully utilized. For example, if rows are deleted, the space they occupied might not be immediately reused, leaving gaps within pages.

### External Fragmentation
Occurs when data that should be stored sequentially is scattered across non-contiguous pages on disk. This forces the database to perform more I/O operations to retrieve related data.

## Impact on Performance

Fragmentation affects performance in several ways:

- **Increased I/O operations** - More disk reads required to fetch scattered data
- **Slower sequential scans** - Full table scans become inefficient
- **Wasted storage space** - Unused gaps consume disk space
- **Index degradation** - Index pages become less efficient over time

## Solutions for Database Table Fragmentation

### OPTIMIZE TABLE (MySQL/MariaDB)

Running the `OPTIMIZE TABLE` command rebuilds the table and defragments it:

```sql
OPTIMIZE TABLE your_table_name;
```

This command:
- Reclaims unused space
- Defragments the data file
- Rebuilds indexes

### VACUUM (PostgreSQL)

In PostgreSQL, `VACUUM` reclaims storage by removing dead tuples:

```sql
-- Regular vacuum
VACUUM your_table_name;

-- Full vacuum (also defragments)
VACUUM FULL your_table_name;
```

`VACUUM FULL` rewrites the entire table and reclaims more space, but requires an exclusive lock.

### Rebuilding Tables

Creating a new table with the same schema and copying data over can effectively defragment it:

```sql
-- Create new table
CREATE TABLE new_table LIKE original_table;

-- Copy data
INSERT INTO new_table SELECT * FROM original_table;

-- Swap tables
RENAME TABLE original_table TO old_table, new_table TO original_table;

-- Drop old table
DROP TABLE old_table;
```

### Partition Maintenance

For partitioned tables, dropping and recreating partitions can defragment them:

```sql
ALTER TABLE partitioned_table REORGANIZE PARTITION partition_name INTO (...);
```

## Recommendations for Large Tables

For tables with **billions of rows**, it might be best to go with the approach of **rebuilding tables on a regular basis**. Other approaches also work completely fine but could affect table performance during the operation.

### Best Practices

1. **Monitor fragmentation levels** - Set up monitoring to track fragmentation metrics
2. **Schedule maintenance windows** - Perform defragmentation during low-traffic periods
3. **Use cron jobs** - Set up automated jobs to trigger rebuilding when high fragmentation is spotted
4. **Consider online operations** - Use tools like `pt-online-schema-change` for MySQL to minimize downtime

### Example Monitoring Query (MySQL)

```sql
SELECT
    TABLE_NAME,
    DATA_FREE / (DATA_LENGTH + INDEX_LENGTH) * 100 as fragmentation_percent
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'your_database'
AND DATA_FREE > 0
ORDER BY fragmentation_percent DESC;
```

## Conclusion

Database fragmentation is an inevitable consequence of normal database operations. By understanding its causes and implementing regular maintenance routines, you can ensure your database continues to perform optimally even as it grows.

Regular monitoring and proactive maintenance are key to preventing fragmentation from becoming a performance bottleneck.
