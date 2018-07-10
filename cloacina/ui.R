# Libraries
library(shiny)
library(shiny.users)

#User-Defined Functions
# - 


# Query Commands
prefix <- 'select * from';

# Define UI for application 
shinyUI(fluidPage(
  navbarPage('',
    
    # A row below the tabs that will have useful action buttons
    titlePanel("Cloacina"),
    tabPanel("0. Login to PostgreSQL"),
    fluidRow(
      actionButton("save_inputs","Save Inputs"),
      actionButton("save_results","Save Results")
    ),
      tabPanel("1. Explore Database",
        fluidPage(
          sidebarLayout(
            sidebarPanel(
              titlePanel("Inputs"),

              # Database               
              textInput("database",
                      "Databases",
                      value = "test_cloacina_db"),
              
              # Selected Tables from Database
              uiOutput("selected_db_tables"),
            
              # List of Queries
              textOutput("number_of_tables"),
              textOutput("indexSelectedDbTables"),
              uiOutput("list_of_queries")
            
            ),
           
            mainPanel(
              titlePanel("Data Viewer"),
              textOutput("query1"),
              #a = textOutput("query1"),
              
                # MVP
                #DT::dataTableOutput("rawTable1")  
              
                # lapply
                #lapply(X = 1:2, FUN = function(i){ dataTableOutput(paste0("rawTable",i)) } ) 
             
                # multiple tables
                # didn't work : lapply(X = as.numeric(read.table(textConnection(object =textOutput("indexSelectedDbTables")), sep = " ")), FUN = function(i){ dataTableOutput(paste0("rawTable",i)) } ) 
                # didn't work : lapply(X = as.numeric(read.table(textOutput("indexSelectedDbTables")["childern"][[1]][["attribs"]][["id"]])), FUN = function(i){ dataTableOutput(paste0("rawTable",i)) } ) 
                # only showed : lapply(X = as.integer(read.table(text = textOutput("indexSelectedDbTables")[["attribs"]][["id"]],sep=" ")), FUN = function(i){ dataTableOutput(paste0("rawTable",i)) } ) 
                # one table at
                # a time
               
                # multiple tables
                lapply(X = read.table(text = (textOutput("indexSelectedDbTables"))[["attribs"]][["id"]]), FUN = function(i){ dataTableOutput(paste0("rawTable",i)) } ) 
              
#              lapply(1:2,
#                     function(i){
#                       h4(paste(i))
#                       DT::dataTableOutput(paste0("raw_dt_",i)) 
#                     }
#                    )
            )
          )  
        )
      ),
    
    
     
# ======================== 02. FORMAT DATA START ========================
    tabPanel("2. Format Data",
      fluidPage(
        sidebarLayout(
          sidebarPanel(
            
            textInput("ndatatables",
                      "Number of Formatted Data.tables you would like to create",
                      value = "2"),
           
            uiOutput("dt_names"),
          
            uiOutput("fm_dt_raw_data_query"),
             
            uiOutput("dt_col_names"),
            textOutput("dt_col_name")
            
          ),
          
            
          
          mainPanel(
            titlePanel("Data Viewer"),
            lapply(1:2,
                   function(i){
                     h4(paste(i))
                     DT::dataTableOutput(paste0("formatted_dt_",i)) 
                    }
            )
          )
        )
      )
    ),
# ======================== 02. FORMAT DATA END ========================

    
# ======================== 03. TRANSFER DATA START ========================
tabPanel("3. Transfer Data From Raw to Format",
  fluidPage(
    fluidRow(column(width = 4),
             column(width = 2, offset = 3),
             numericInput(inputId = "dt_in_view",
                          label = "Formatted Data Table To Work On",
                          value = 1)
             ), 
    splitLayout(
      cellArgs = list(style = "padding: 100px"),

      fluidPage(  
        "hello",

        headerPanel("Raw data from database"),
#        lapply(1:2,
#          function(i){
#            h4(paste(i))
#            "\n"
#              DT::dataTableOutput(paste0("raw_dt_",i)) 
              dataTableOutput( "raw_dts" ),
              textOutput('all_tables')
#              }
#          )
      ),
        
      dataTableOutput('raw_dts2')
      )
    )
  )
               
               
               


# ======================== 03. TRANSFER DATA END ========================


    )
  )
)
server <- function(input,output) {}


