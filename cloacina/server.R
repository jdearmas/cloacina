# some libs for shinyapps to deploy correctly
library(shiny)
library(DT)
library(data.table)

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

humanTime <- function() format(Sys.time(), "%Y%m%d-%H%M%OS")


getwd()
conn <- connect_to_db();
queryy <- "dbGetQuery(con,'select * from test_cloacina_table_1')"

output <- import_data(con=conn,query=queryy)

# some libs for interactive shiny logic
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  observeEvent(input$save_inputs, {
    saveData(formData())
  })
  
  output$database <- renderText({
    input$database
  })
 
  dbTables <- reactiveValues()
  
  # List of all tables inside PostgreSQL database
  dbTables$listAll <- import_data(conn,query = "dbListTables(con)")
  output$listAllDbTables <- renderText(dbTables$listAll)
  
   
  # HTML of List of tables from the PostgreSQl database the user wants to use
  dbTables$htmlSelectedDbTables <- checkboxGroupInput("selected_db_tables",
                                                    "Tabels",
                                                    as.list(import_data(conn,
                                                      paste(
                                                      "dbListTables(con)"))),
                                                      "NULL")
  
  
  # Char of List of tables from the PostgreSQL database the user wants to use
  dbTables$charSelectedDbTables <- reactive(input$selected_db_tables)
  

  # Display all the tabes in the PostgreSQL database 
  output$all_db_tables <- renderText ( dbTables$listAll )
  
   
  # Indices of the complete list of tables that the user wants to use 
  expr_q <- quote({ charmatch( input$selected_db_tables, dbTables$listAll ) })
  dbTables$indexSelectedDbTables<- reactive( expr_q, quoted = TRUE)

  
  # Display the indices of the complete list of tables that the user wants to use
  output$indexSelectedDbTables <- renderText(dbTables$indexSelectedDbTables()) 
  #output$indexSelectedDbTables <- renderPrint(dbTables$indexSelectedDbTables()) 
  
 
  # Display of list of tables from the PostgreSQL database the user wants to use
  output$selected_db_tables <- renderUI({
    dbTables$htmlSelectedDbTables
  })

  
  # Display the number of tables from the database selected by user
  output$number_of_tables <- renderText({
    paste("Number of Tables Selected: ", length(input$selected_db_tables))
    
  })
 
  # List of the queries of all the tables selected by the user
  dbTables$listOfQueries <- reactive ( {lapply(X = 1:2, #dbTables$indexSelectedDbTables(), #<1:2,
           FUN = function(i)
           {
             textInput(inputId = paste0("query",i),
                       label = paste("Query for table: ",
                                     input$selected_db_tables[ i ]
                                     ),
                       value = paste0("select * from ",
                                      input$selected_db_tables[ i ],
                                      " limit 1")
             
          )
        }
      )
    })
  
   
  # Display list of the queries of all the tables selected by the user
  output$list_of_queries <- renderUI({
    dbTables$listOfQueries()
  })
 

  # Reactive Raw Tables 
  # react_var <- reactive(render(command))
 
    # MVP
    #dbTables$rawTable <- reactive(import_data(conn,query = paste0("dbGetQuery(con,'select * from test_cloacina_table_1 limit 1')")))
    #output$rawTable <- renderDataTable( dbTables$rawTable() )
  
    # input$query1 test
    #dbTables$rawTable <- reactive(import_data(conn,query = paste0("dbGetQuery(con,'",input$query1,"')")))
    #output$rawTable <- renderDataTable( dbTables$rawTable() )

    # lapply test 
    #observe( lapply(X = 1, FUN = function(i){ dbTables[[paste0("rawTable",i)]] <- reactive(import_data(conn,query = paste0("dbGetQuery(con,'",input$query1,"')")))}))
    #output$rawTable <- renderDataTable( dbTables$rawTable1() )
  
    # reactive input query
    #observe( lapply(X = 1, FUN = function(i){ dbTables[[paste0("rawTable",i)]] <- reactive(import_data(conn,query = paste0("dbGetQuery(con,'",input[[paste0("query",i)]],"')")))}))
    #output$rawTable <- renderDataTable( dbTables$rawTable1() )
 
    # multiple datatables 
    #observe( lapply(X = 1:2, FUN = function(i){ dbTables[[paste0("rawTable",i)]] <- reactive(import_data(conn,query = paste0("dbGetQuery(con,'",input[[paste0("query",i)]],"')")))}))
    #observe( lapply(X = 1:2, FUN = function(i){ output[[paste0("rawTable",i)]] <- renderDataTable( dbTables[[paste0("rawTable",i)]]())} ))
 
    # variable datatables 
    observe( lapply(X = dbTables$indexSelectedDbTables(), FUN = function(i){ dbTables[[paste0("rawTable",i)]] <- reactive(import_data(conn,query = paste0("dbGetQuery(con,'",input[[paste0("query",i)]],"')")))}))
    observe( lapply(X = dbTables$indexSelectedDbTables(), FUN = function(i){ output[[paste0("rawTable",i)]] <- renderDataTable( dbTables[[paste0("rawTable",i)]]())} ))
    
#observe(
#    lapply
#        (
#          X = dbTables$indexSelectedDbTables(), #1:2,
#          FUN = function(i){
#          output[[paste0("rawTables",i)]] <- dbTables[[paste0("rawTables",i)]]
#        }
#      )
#    )
#observe( output$rawTables <- renderDataTable( dbTables$rawTables() ) )
  
  # Reactive Raw Tables 
#  dbTables$rawTables <- reactive(
#    lapply
#    (
#      X = 1:2, #dbTables$indexSelectedDbTables(), #1:2,
#      FUN = function(i){
#      output[[paste0("raw_dt_",i)]] <-DT::renderDataTable
#      (
#        import_data
#        (
#          conn,
#          query = paste0
#          (
#            "dbGetQuery(",
#            "con,'",
#            eval(parse(text=paste0("input$query",i))), 
#            "')"
#            )
#          )
#        )
#      }
#    )
#  )

  
  

  
   
#  observe(
#    lapply(X = 2,
#           function(i){
#           output[[paste0("raw_dt_",i)]] <-
#             DT::renderDataTable(
#               import_data(conn,
#                           query = paste0("dbGetQuery(",
#                                          "con,'",
#                                           eval(parse(text=paste0("input$query",i))),
#                                          "')")
#          )
#        )
#      }
#    )
#  )
# 
# ======================== 01. EXPLORE DATA END ========================
  
   
# ======================== 02. FORMAT DATA START ========================
  output$dt_names <- renderUI({
    lapply(X = 1:input$ndatatables,
           FUN = function(i)
           {
             textAreaInput(inputId = paste0("dt_names_",i),
                           label = paste0("Name of data.table_",i),
                           value = "Bob"
             )
           })
  }) 
  
  # A function that recieves a string of text that 
  # describes what data is going to be added 
  # to the formatted data.table
  # from the raw data.table
#  output$fm_dt_raw_data_query <- renderUI({
#    lapply(X = 1:input$ndatatables,
#           FUN = function(i)
#           {
#             textAreaInput(inputId = paste0("dt_",i,"_col_names"),
#                           label = paste0("Raw Data to Import",
#                                          "\n into ",
#                                          eval(parse(text=paste0("input$dt_names_",i)))),
#                           value = paste0(eval(parse(text=paste0("input$query",i))))
#             )
#           })
#  }) 
   
  output$dt_col_names <- renderUI({
            lapply(X = 1:input$ndatatables,
                   FUN = function(i)
                   {
                     textAreaInput(inputId = paste0("dt_",i,"_col_names"),
                               label = paste0("Column names",
                                              "\n of data.table_",
                                             i),
                               value = "col_name_1,\ncol_name_2"
                               )
                   })
  }) 
  
  output$dt_col_name <- renderText({
    input$dt_1_col_names[1];
  })
  
  observe(
    lapply(1:input$ndatatables,
           function(i){
           output[[paste0("formatted_dt_",i)]] <-
             DT::renderDataTable(
               datatable(
                 data.table(
                   variable1 = integer(),
                   variable2 = character(),
                   variable3 = numeric()
                 ),
                 #colnames = eval( parse( paste0( text="input$","dt_",i,"_col_names" ) ) )
                 colnames = input$dt_1_col_names
                )
               )
            }
          )
  )
  

  
# ======================== 02. FORMAT DATA END ========================

  
# ======================== 03. TRANSFER DATA START ========================
    
  datasetInput <- reactive({
   # datatable(iris)
    datatable(iris)
  })
  
# Converting an output to a reactive value to see if it will allow be to use in on the server-side
   
# Raw Data.Tables queried from Database
  # reactive allows the value of the output to change over time
    output$raw_dts <- renderDataTable(
#    iris
#      raw_dts()
      datasetInput()
      #datatable(datasetInput())
      #caption = "Raw data from database"
    )

    # reactive allows the value of the output to change over time
    output$raw_dts2 <- renderDataTable(
      #    iris
      #      raw_dts()
      reactive_raw_dts()
      #datatable(datasetInput())
      #caption = "Raw data from database"
    )
    
  
# Formatted Data.Tables with Selected Raw Data  
  output$fm_dts <- renderDataTable(
    datatable(raw_dts(), #dts$test_dt# `datatable(dts$test_dt,
      caption = paste0("Formatted data.table:") #,
#                       eval( parse( paste0( "input$dt_names_",
#                                            1) ) ) )
    )
  )
  
# ======================== 03. TRANSFER DATA END ========================
  
  
  
  
    
})