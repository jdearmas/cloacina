-- Set variables
\set t_group test_cloacina_group
\set t_user test_cloacina_user 
\set t_db test_cloacina_db
\set t_table test_cloacina_table

-- Delete everything

-- Delete Test Group
drop role :t_group;

-- Drop Test Table
drop table :t_table; 

-- Drop Test Database 
drop database :t_db;

-- Delete Test User
drop user :t_user;



