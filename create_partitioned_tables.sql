-- Create and verify a RANGE partitioned table
--- Parent table
CREATE TABLE pgbench_accounts_range (
	aid integer not null,
	bid integer,
	abalance integer,
	filler varchar,
	atype varchar,
	PRIMARY KEY(aid)
) PARTITION BY RANGE (aid);

--- Create the partitions
CREATE TABLE pgbench_accounts_range_1 PARTITION OF pgbench_accounts_range FOR VALUES FROM (MINVALUE) TO (200001);
CREATE TABLE pgbench_accounts_range_2 PARTITION OF pgbench_accounts_range FOR VALUES FROM (200001) TO (400001);
CREATE TABLE pgbench_accounts_range_3 PARTITION OF pgbench_accounts_range FOR VALUES FROM (400001) TO (600001);
CREATE TABLE pgbench_accounts_range_4 PARTITION OF pgbench_accounts_range FOR VALUES FROM (600001) TO (800001);
CREATE TABLE pgbench_accounts_range_5 PARTITION OF pgbench_accounts_range FOR VALUES FROM (800001) TO (MAXVALUE);

--- Load data from the heap table to the partitioned table
INSERT INTO pgbench_accounts_range
	SELECT * FROM pgbench_accounts;

--- Check details of the table
\d+ pgbench_accounts_range
\dt+ pgbench_accounts_range*



-- Create and verify a HASH partitioned table
--- Parent table
CREATE TABLE pgbench_accounts_hash (
	aid integer not null,
	bid integer,
	abalance integer,
	filler varchar,
	atype varchar,
	PRIMARY KEY(aid)
) PARTITION BY HASH (aid);

--- Create the partitions
CREATE TABLE pgbench_accounts_hash_1 PARTITION OF pgbench_accounts_hash FOR VALUES WITH (modulus 5, remainder 0);
CREATE TABLE pgbench_accounts_hash_2 PARTITION OF pgbench_accounts_hash FOR VALUES WITH (modulus 5, remainder 1);
CREATE TABLE pgbench_accounts_hash_3 PARTITION OF pgbench_accounts_hash FOR VALUES WITH (modulus 5, remainder 2);
CREATE TABLE pgbench_accounts_hash_4 PARTITION OF pgbench_accounts_hash FOR VALUES WITH (modulus 5, remainder 3);
CREATE TABLE pgbench_accounts_hash_5 PARTITION OF pgbench_accounts_hash FOR VALUES WITH (modulus 5, remainder 4);

--- Load data from the heap table to the partitioned table
INSERT INTO pgbench_accounts_hash
	SELECT * FROM pgbench_accounts;

-- Check details of the table
\d+ pgbench_accounts_hash
\dt+ pgbench_accounts_hash*



-- Create and verify a LIST partitioned table
--- Parent table
CREATE TABLE pgbench_accounts_list (
	aid integer not null,
	bid integer,
	abalance integer,
	filler varchar,
	atype varchar,
	PRIMARY KEY(atype, aid)
) PARTITION BY LIST (atype);

--- Create the partitions
CREATE TABLE pgbench_accounts_list_1 PARTITION OF pgbench_accounts_list FOR VALUES IN ('Savings');
CREATE TABLE pgbench_accounts_list_2 PARTITION OF pgbench_accounts_list FOR VALUES IN ('Current');
CREATE TABLE pgbench_accounts_list_3 PARTITION OF pgbench_accounts_list FOR VALUES IN ('Business');
CREATE TABLE pgbench_accounts_list_4 PARTITION OF pgbench_accounts_list FOR VALUES IN ('Investment');

--- Load data from the heap table to the partitioned table
INSERT INTO pgbench_accounts_list
	SELECT * FROM pgbench_accounts;

-- Check details of the table
\d+ pgbench_accounts_list
\dt+ pgbench_accounts_list*
