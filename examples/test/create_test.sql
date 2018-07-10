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

-- Create Test Admin
create user :t_admin with password 'password' superuser createdb;


-- Create Test Admin Database
create database :t_admin_db with owner :t_admin;


-- Switch role to admin
set role :t_admin;


-- Enter admin database
\c :t_admin_db :t_admin;


-- Create Test Admin Login Username Table
create table :t_admin_user_table (
	user_id 	integer PRIMARY KEY,
	user_name	varchar(40)	
);


-- Create Test Admin Login Password Table
create table :t_admin_pass_table (
	user_id 	integer references :t_admin_user_table(user_id),
	pass_word	varchar(40)	
);


-- Create Test User Group
create role :t_group with login inherit createdb;

-- Create Test User
CREATE user :t_user with password 'cloacina' in group :t_group;

-- Grant :t_group permissions to :t_user
grant :t_group to :t_user;

-- Create Test Database
create database :t_user_db with owner :t_user;

-- Switch to Test User
set role :t_user;

-- Enter Database
\c :t_user_db :t_user;

-- Create 1st Test Table
create table :t_user_table_1 (
	test_id 	integer,
	test_note	varchar(40)	
);

-- Create 2nd Test Table
create table :t_user_table_2 (
	test_id 	integer,
	test_note	varchar(40)	
);


-- Insert Dummy Data
insert into :t_user_table_1 values (1,'test');
insert into :t_user_table_2 values (2,'test_2');


