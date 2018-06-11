# Libraries
library(shiny)

# Query Commands
prefix <- 'select * from';

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  navbarPage('',
    titlePanel("Cloacina"),
      tabPanel("0. Explore Database",
        fluidPage(
          sidebarLayout(
            sidebarPanel("Inputs",

            # Databases                 
            textInput("database",
                      "Databases",
                      value = "test_cloacina_db"),
            # Tables
            uiOutput("tables"),
            
            # List of Queries
            textOutput("number_of_tables"),
            uiOutput("list_of_queries")
            
            ),
           
            mainPanel("Results",
            uiOutput("database"),
            uiOutput("data")
            )
          )  
        )
      ),
     
      tabPanel("1. Format Data")
    )
  )
)
server <- function(input,output) {}


