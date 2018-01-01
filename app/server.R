###########################################################################################################################
#                                                                                                                         #
#                                             LOAD PACKAGES/FUNCTIONS/DATA                                                #
#                                                                                                                         #
###########################################################################################################################

# Load packages
library(shiny)
library(shinydashboard)
library(dplyr)
library(DT)

# Load functions
source("R/Load_Data.R")

# Load data
Data = Load_Data(TRUE)

###########################################################################################################################
#                                                                                                                         #
#                                                         SERVER                                                          #
#                                                                                                                         #
###########################################################################################################################

server <- function(input, output){
  
  #################################################################
  #                                                               #
  #                      REACTIVE VALUES                          #
  #                                                               #
  #################################################################
  
  v <- reactiveValues(doPlot = FALSE)
  
  # Check to see if update button was clicked
  observeEvent(input$update, {
    v$doPlot <- input$update
  })
  
  #################################################################
  #                                                               #
  #                       REACTIVE DATA                           #
  #                                                               #
  #################################################################
  
  # If update button was clicked get cluster designation data
  cluster_data <- eventReactive(input$update, {
    
    colnames(Data) = c("DUNS", "Vendor Name", "Cluster")
    Data
  })
  
  #################################################################
  #                                                               #
  #                         OUTPUTS                               #
  #                                                               #
  #################################################################

  
  output$contractor_table <- renderDataTable({
    if (v$doPlot == FALSE) return()
    
    isolate({
      
      datatable(cluster_data(), 
                options = list("pageLength" = 20),
                caption = "All Contractors: This is a list of all the companies in the data. Use this table to search for a company
                to find what cluster it belongs to.",
                rownames = FALSE)
    })
    
  }) # End contractor_table
  

  output$contractor_per_cluster_table <- renderDataTable({
    if (v$doPlot == FALSE) return()
    
    isolate({
      
      temp_data = cluster_data() %>% group_by(Cluster) %>% summarise(ct = n())
      colnames(temp_data) = c("Cluster", "Number of Companies")
      
      datatable(temp_data, 
                options = list("pageLength" = 20),
                caption = "Contractors per Cluster: Most contractors are in one cluster.",
                rownames = FALSE)
    })
    
    }) # End contractor_per_cluster_table
    
  output$cluster_table <- renderDataTable({
    if (v$doPlot == FALSE) return()

    isolate({
      
      temp_cluster = input$cluster
      datatable(cluster_data()[cluster_data()$Cluster == temp_cluster,], 
                options = list("pageLength" = 20),
                caption = 'Contractor Cluster: This is a list of companies in the chosen cluster.',
                rownames = FALSE)
    })

  }) # End cluster_table
  
  
  
} # End server


















