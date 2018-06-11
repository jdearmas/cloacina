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
            uiOutput("query_ids"),
            lapply(1:2,
                                function(i){
                                 DT::dataTableOutput(paste0("datatable_",i)) 
                                }
                              ),
            textOutput("query"),
            dataTableOutput("dt")
            )
          )  
        )
      ),
     
      tabPanel("1. Format Data")
    )
  )
)
server <- function(input,output) {}


