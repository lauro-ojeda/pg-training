---- Examples of Execution Plans in PostgreSQL
-- sequential scan
explain analyze 
select * from customer;


-- aggregation
explain analyze
select count(*) from customer;


-- index scan
explain analyze
select * from customer where c_id=1000;


-- join
explain (buffers, analyze)
select c.c_first||' '||c.c_last customer, c.c_balance, h.h_date, h.h_amount, h.h_data
from customer c join history h on (c.c_id=h.h_c_id and c.c_d_id=h.h_c_d_id and c.c_w_id=h.h_c_w_id) 
where c.c_id=1000 and c.c_d_id=6 and c.c_w_id=66;



----------------------------- Real case test 1
explain (buffers, analyze)
select c.c_first||' '||c.c_last customer, c.c_balance, h.h_date, h.h_amount, h.h_data
from customer c join history h on (c.c_id=h.h_c_id and c.c_d_id=h.h_c_d_id and c.c_w_id=h.h_c_w_id) 
where c.c_id=1000 and c.c_d_id=6 and c.c_w_id=66;

-- No index on history, create one to fix the problem
create index history_i1 on history (h_c_w_id, h_c_d_id, h_c_id);

----------------------------- Real case test 2
EXPLAIN (ANALYZE, BUFFERS, SETTINGS)
SELECT c.C_ID, c.C_LAST, ol.OL_I_ID, ol.OL_AMOUNT, ol.OL_DIST_INFO, c.C_DATA
FROM 
  ORDER_LINE ol
    JOIN CUSTOMER c ON (ol.OL_W_ID = c.C_W_ID AND ol.OL_D_ID = c.C_D_ID) 
WHERE 
  ol.OL_W_ID = 1 AND ol.OL_D_ID = 1 AND c.C_ID <= 5
ORDER BY c.C_LAST desc;

-- See the sorting to disk, increase work_mem to avoid it
set work_mem='80MB';

------------------------------ Real case test 3
EXPLAIN (ANALYZE, BUFFERS, SETTINGS)
SELECT o_id, o_c_id, o_d_id, o_w_id, o_entry_d
FROM orders
WHERE o_c_id = 3000
  AND o_w_id::text = '1'
  AND o_d_id = 1
ORDER BY o_id; 


-- remove the cast to text
EXPLAIN (ANALYZE, BUFFERS, SETTINGS)
SELECT o_id, o_c_id, o_d_id, o_w_id, o_entry_d
FROM orders
WHERE o_c_id = 3000
  AND o_w_id = 1
  AND o_d_id = 1
ORDER BY o_id; 
