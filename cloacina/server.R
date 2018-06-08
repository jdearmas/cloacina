# some libs for shinyapps to deploy correctly
library(shiny)

query <- "dbGetQuery(con,'select * from test_cloacina_table')"
output <- import_data(query)

# some libs for interactive shiny logic
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


  #output$tables <- renderUI({
  #	selectInput("table","Tabels",as.list(c(import_data("dbListTables(con)"),
  #	                                        "NULL")))
	#})

  output$tables <- renderUI({
    checkboxGroupInput("table","Tabels",as.list(c(import_data("dbListTables(con)"),
                                           "NULL")))
  })
  
    
  output$data_str <- renderText({
    full_query <- paste("dbGetQuery",
                              "(con,'",
                              input$prequery,
                              input$table,
                              input$postquery,
                              "')")
    })
  
  output$data <- renderTable({
    import_data(paste("dbGetQuery",
                      "(con,'",
                      input$prequery,
                      input$table,
                      "')"))
  })
  
})


