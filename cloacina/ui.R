# Libraries
library(shiny)

# Query Commands
prefix <- 'select * from';

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  navbarPage('',
    titlePanel("Cloacina"),
      tabPanel("0. Login to PostgreSQL"),
      tabPanel("1. Explore Database",
        fluidPage(
          sidebarLayout(
            sidebarPanel(
              actionButton("save_inputs","Save Inputs"),
              titlePanel("Inputs"),

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
           
            mainPanel(
              actionButton("save_results","Save Results"),
              titlePanel("Data Viewer"),
              lapply(1:2,
                     function(i){
                       h4(paste(i))
                       DT::dataTableOutput(paste0("datatable_",i)) 
                     }
                    )
            )
          )  
        )
      ),
     
      tabPanel("2. Format Data"),
      tabPanel("3. Process Data")
    )
  )
)
server <- function(input,output) {}


