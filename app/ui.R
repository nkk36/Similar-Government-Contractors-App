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
      # selectInput(inputId = "cluster", 
      #             label = "Choose cluster:", 
      #             choices = cluster_list,
      #             selected = 1
      #             ),
      selectizeInput(inputId = "names",
                     label = "Choose company:",
                     choices = NULL
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
                #box(DT::dataTableOutput("contractor_table"), width = 5, title = "All Contractors"),
                box(DT::dataTableOutput("contractor_per_cluster_table"), width = 4, title = "Contractors per Cluster"),
                box(DT::dataTableOutput("cluster_table"), width = 8, title = "Contractor Cluster")
              )
      )
    )
  )
)