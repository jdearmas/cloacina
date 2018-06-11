# some libs for shinyapps to deploy correctly
library(shiny)
library(DT)

# variables
maxTables <- 5;

# functions
connect_to_db <- function(){
  # Resources
  # https://www.r-bloggers.com/getting-started-with-postgresql-in-r/
  
  
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
  
  dbListTables(con)
  
  return(con)
}


import_data <- function(con,query){
# Resources
# https://www.r-bloggers.com/getting-started-with-postgresql-in-r/

  print(con)
  # Output 
  output <- eval(parse(text=query))
 
  # Return Output
  return(output)
}

getwd()
conn <- connect_to_db();
queryy <- "dbGetQuery(con,'select * from test_cloacina_table_1')"

output <- import_data(con=conn,query=queryy)

# some libs for interactive shiny logic
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$database <- renderText({
    input$database
  })
  
  output$tables <- renderUI({
    checkboxGroupInput("table",
                       "Tabels",
                       as.list(import_data(conn,
                                             paste(
                                               "dbListTables(con)"))),
                                "NULL")
  })


  output$number_of_tables <- renderText({
    paste("Number of Tables Selected: ", input$table[2])
    
  })
  
  output$list_of_queries <- renderUI({
    lapply(X = 1:2,
           FUN = function(i)
           {
             textInput(inputId = paste0("query",i),
                       label = paste("Query for table: ",
                                     input$table[i]),
                       value = paste0("select * from ",
                                      input$table[i],
                                      " limit 1")
             )
           }
    )
  })
   
 
  output$query <- renderText({
    length(input$query1)
  }) 

  observe(
    lapply(1:2,
           function(i){
           output[[paste0("datatable_",i)]] <-
             DT::renderDataTable(
               import_data(conn,
                           query = paste0("dbGetQuery(",
                                          "con,'",
                                           eval(parse(text=paste0("input$query",i))),
                                          "')")
                           )
            )
            }
          )
  )
  
})