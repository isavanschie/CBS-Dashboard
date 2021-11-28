#Practice for CBS(Dashboard)

library(shiny)
library(shinythemes)
library(cbsodataR)
library(shinydashboard)
library(shinydashboardPlus)
library(dashboardthemes)
library(tidyverse)
library(ggplot2)
library(plotly)

ui <- 
  
header <- dashboardHeader(title = "Practice for CBS(Dashboard)")
  
sidebar <- dashboardSidebar(
  
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
                )
                  )
  
body <- dashboardBody(
  
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                   )
                      )
             )
            )
               )

dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
  
  
}

shinyApp(ui = ui, server = server)
