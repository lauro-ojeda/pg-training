--- PREREQS
-- 1) Install the library postgres-contrib or postgres-client to have access to psql and pgbench
-- 2) You have to have access to your PostgreSQL instance

-- In your prompt shell, issue the below command
-- This will use pgbench to create the table pgbench_accounts and load 1M rows on it
pgbench -i -F 10 -s 10 -U <master-user> -h <endpoint> postgres

-- Connect to your database instance using psql
psql "postgres://<master-user>@<endpoint>:5432/postgres" 

-- Confirm the table is in place and has data
SELECT count(*) FROM pgbench_accounts; -- Expect 1M rows
  
-- Add a new column to the accounts table and populate with random data
ALTER TABLE pgbench_accounts ADD COLUMN atype VARCHAR;

UPDATE pgbench_accounts 
SET atype = (
    CASE FLOOR(RANDOM() * 4)
        WHEN 0 THEN 'Savings'
        WHEN 1 THEN 'Current'
        WHEN 2 THEN 'Business'
        WHEN 3 THEN 'Investment'
    END
);

-- Check details of the table
\d+ pgbench_accounts
\dt+ pgbench_accounts
