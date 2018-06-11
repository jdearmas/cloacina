# some libs for shinyapps to deploy correctly
library(shiny)

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
queryy <- "dbGetQuery(con,'select * from test_cloacina_table')"

output <- import_data(con=conn,query=queryy)

# some libs for interactive shiny logic
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$tables <- renderUI({
    checkboxGroupInput("table",
                       "Tabels",
                       as.list(import_data(conn,
                                             paste(
                                               "dbListTables(con)"))),
                                "NULL")
  })


  output$number_of_tables <- renderText({
    paste("Number of Tables Selected: ", length(input$table))
    
  })
  
  output$list_of_queries <- renderUI({
    lapply(input$table,
      function(table)
        {
          textInput(inputId = "list_of_queries",
                    label = paste("Query for table: ",
                                  table),
                    value = paste0("select * from ",
                                  table,
                                  " limit 1")
                    )
        }
       )
  })

  output$data <- renderUI({
    lapply(1:length(input$table), 
           function(n){
             renderUI({
               import_data(conn,
                           query = paste("dbGetQuery",
                                         "(con,'",
                                         input$list_of_queries[n],
                                         "')"
                                 )
                           )
              })
            }
    )
  })
})

#  output$data <- renderTable({
#    import_data(conn,
#                paste("dbGetQuery",
#                      "(con,'",
#                      input$list_of_queries,
#                      "')"))
#  })
