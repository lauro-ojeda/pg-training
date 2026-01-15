-- Here you will be able to see the performance of queries against a heap table and partitioned tables
--- First, run the query against the heap (non-partitioned) table
explain analyze select * from pgbench_accounts where abalance >= 9000;

-- Now, do the same against the RANGE partitioned table and compare the results
explain analyze select * from pgbench_accounts_range where abalance >= 9000;

-- Lastly, run the command against the HASH partitioned table. Compare the results with the other 2 executions
explain analyze select * from pgbench_accounts_hash where abalance >= 9000;
