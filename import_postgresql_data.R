# Libraries
require("RPostgreSQL")
library(RPostgreSQL)

#PostgreSQL Driver
drv <- dbDriver("PostgreSQL")

# PostgreSQL Database Characteristics  ( User-dependent )
host    <- "localhost"
port    <- "5432"
pw      <- {"cloacina"}           # password
user    <- "test_cloacina_user"
dbname  <- "test_cloacina_db"   # database name
table   <- "test_cloacina_table" 

# Connect to PostgreSQL Database
con <- dbConnect(drv, 
                 dbname = dbname, 
                 host = host, 
                 port = port, 
                 user = user, 
                 password = pw)


# Check connection
dbExistsTable(con, "test_cloacina_table" )
# TRUE

# Create Database Table into Dataframe 
df <- dbReadTable(con,"test_cloacina_table")
