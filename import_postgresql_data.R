# Libraries
require("RPostgreSQL")
library(RpostgreSQL)

#PostgreSQL Driver
drv <- dbDriver("PostgreSQL")

# PostgreSQL Database Characteristics  ( User-dependent )
host <- "localhost"
user <- "openpg"
port <- "5432"
dbname <- "cloacina_test"   # database name
pw <- {"testing"}           # password

# Connect to PostgreSQL Database
con <- dbConnect(drv, 
                 dbname = dbname, 
                 host = host, 
                 port = port, 
                 user = user, 
                 password = pw)