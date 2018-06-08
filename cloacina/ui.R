# Libraries
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
                value = "test_cloacina_db"
                ),
      # Tables
      uiOutput("tables"
               ),
      
      # Pre-Table Query Command
      textInput("prequery",
                "Pre-Table Query Command",
                value="select * from"
                ),
      
      # Post-Table Query Command
      textInput("postquery",
                "Post-Table Query Command",
                value="limit 1"
                )
      
      
    ),
  
    mainPanel("Results",
    plotOutput("coolplot"),
    uiOutput("database"),
    uiOutput("query"),
    textOutput("data_str"),
    uiOutput("data")
    )
  )  
))

server <- function(input,output) {}


