###########################################################################################################################
#                                                                                                                         #
#                                             LOAD PACKAGES/FUNCTIONS/DATA                                                #
#                                                                                                                         #
###########################################################################################################################

library(shiny)
library(shinydashboard)
library(markdown)
library(DT)

# Load functions
source("R/Load_Data.R")

# Load data
clusters = Load_Data(TRUE)
cluster_list = sort(unique(clusters$cluster))
#vendornames = c("Test", "Test2")


###########################################################################################################################
#                                                                                                                         #
#                                                    USER INTERFACE                                                       #
#                                                                                                                         #
###########################################################################################################################

ui <- dashboardPage(
  dashboardHeader(title = "Similar Government Contractors", titleWidth = 400),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      selectInput(inputId = 'cluster', 
                  label = "Choose cluster:", 
                  choices = cluster_list,
                  selected = 1
                  )
      ),
    actionButton("update","Update")
  ),
  dashboardBody(
    
    tags$head(includeScript("google-analytics.js")),
    
    tabItems(
      tabItem(tabName = "home",
              includeMarkdown("intro.md")
      ),
      tabItem(tabName = "dashboard",
              fluidRow(
                box(DT::dataTableOutput("contractor_table"), width = 5, title = "All Contractors"),
                box(DT::dataTableOutput("contractor_per_cluster_table"), width = 2, title = "Contractors per Cluster"),
                box(DT::dataTableOutput("cluster_table"), width = 5, title = "Contractor Cluster")
              )
      )
    )
  )
)