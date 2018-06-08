-- Set variables
\set t_group test_cloacina_group
\set t_user test_cloacina_user 
\set t_db test_cloacina_db
\set t_table test_cloacina_table

-- Create Test Group
create role :t_group with login inherit createdb;

-- Create Test User
CREATE user :t_user with password 'cloacina' in group :t_group;

-- Grant :t_group permissions to :t_user
grant :t_group to :t_user;

-- Create Test Database
create database :t_db with owner :t_user;

-- Switch to Test User
set role :t_user;

-- Enter Database
\c :t_db :t_user;

-- Create Test Table
create table :t_table (
	test_id 	integer,
	test_note	varchar(40)	
);

-- Insert Dummy Data
insert into :t_table values (1,'test');


