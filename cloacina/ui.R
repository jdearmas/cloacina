library(shiny)



# Query Commands
prefix <- 'select * from';

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Explore Database"),
  
  sidebarLayout(
    sidebarPanel("Inputs",

      # Databases                 
      textInput("database",
                "Databases",
                value = "test_cloacina_db"),

      # Tables
      #db_char <- reactive({input$database}),
      selectInput("tables",
                  "Tables",
                  choices = c("test",
                              "anything")
      ),
      
      
      # Tables
      selectInput("tables",
        "Tables",
        choices = c("test","dev","prod")
      )
    ),
  
    mainPanel("Results",
    plotOutput("coolplot"),
    tableOutput("results")
              
    )
  )  
))

server <- function(input,output) {}


