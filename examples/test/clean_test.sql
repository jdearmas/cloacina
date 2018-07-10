-- Set variables
\set t_group 						test_cloacina_group
\set t_admin 						test_admin
\set t_admin_db 				test_admin_db
\set t_admin_user_table	test_admin_login_table
\set t_admin_pass_table	test_admin_login_table
\set t_user 						test_cloacina_user 
\set t_user_db 					test_cloacina_db
\set t_user_table_1 		test_cloacina_table_1
\set t_user_table_2 		test_cloacina_table_2

-- Delete everything


-- Delete Test Group
drop role :t_group;


-- Drop all tables
drop table :t_user_table_1; 
drop table :t_user_table_2; 
drop table :t_admin_user_table; 
drop table :t_admin_pass_table; 


-- Drop all database 
drop database :t_user_db;
drop database :t_admin_db;

-- Delete all users
drop user :t_user;
drop user :t_admin;



