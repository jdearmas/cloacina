# some libs for shinyapps to deploy correctly
library(shiny)

query <- "dbGetQuery(con,'select * from test_cloacina_table')"
output <- import_data(query)

# some libs for interactive shiny logic
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$coolplot <- renderPlot({
    plot(rnorm(100))
  })

  output$tables_query <- renderUI({
	import_data("dbListTables(con)")
	})

  output$tables <- renderUI({
  	selectInput("tables","Tabels",as.list(c(import_data("dbListTables(con)"),
  	                                        "NULL")))
	})
})


