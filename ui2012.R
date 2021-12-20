#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(shinydashboard)
library(plotly)
library(dashboardthemes)
dashboardPage(
    dashboardHeader(
        title = "Economic Nothern Netherlands", titleWidth = 300),
    dashboardSidebar(
        sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                          label = "Search..."),
        sidebarMenu(
            id = "tabs",
            menuItem("Home", tabName = "tab1", icon = icon("home")),
            menuItem("On a map", icon = icon("map-marker-alt"), tabName = "tab2"),
            menuItem("Demographics", icon = icon("address-card"), tabName = "tab3", 
                     menuSubItem("Population size & density", 
                                 tabName = "subitem1"),
                     menuSubItem("Age",
                                 tabName = "subitem2"),
                     menuSubItem("Gender",
                                 tabName = "subitem3"),
                     menuSubItem("Life expectancy", 
                                 tabName = "subitem4"),
                     menuSubItem("Mortality & birth rate",  
                                 tabName = "subitem5"),
                     menuSubItem("Educationan",  
                                 tabName = "subitem6"),
                     menuSubItem("Income",  
                                 tabName = "subitem7"),
                     menuSubItem("Unemployment",  
                                 tabName = "subitem8")),
            menuItem("Economic trends", icon = icon("hand-holding-usd"),
                     tabName = "tab4", 
                     menuSubItem("GDP per capita", tabName = "subitem9"),
                     menuSubItem("Employment", tabName = "subitem10"),
                     menuSubItem("Consumption", tabName = "subitem11"),
                     menuSubItem("Consumer trust", tabName = "subitem12"),
                     menuSubItem("Producer trust", tabName = "subitem13"),
                     menuSubItem("Businesses", tabName = "subitem14"),
                     menuSubItem("Added value", tabName = "subitem15"),
                     menuSubItem("??", tabName = "subitem16")
            ),
            menuItem("Earthquakes", icon = icon("globe-europe"),
                     tabName = "tab5")
        ),
        textOutput("res")
    ),
    dashboardBody(
        #we can actually create our own theme by adjusting the CSS via\nshinyDashboardThemeDiy
        dashboardthemes::shinyDashboardThemes(
            theme = "poor_mans_flatly" #I also like the theme: "blue_gradient"
        ),
        tabItems(
            tabItem(tabName = "tab1",
                    h2("Home content")
            ),
            tabItem(tabName = "tab2",
                    h2("On a map content")
            ),
            tabItem(tabName = "tab3",
                    h2("Demographics content")
            ),
            tabItem(tabName = "tab4",
                    h2("Economic trends content")
            ),
            tabItem(tabName = "tab5",
                    h2("Earthquakes in the Northern Netherlands"),
                    fluidPage(
                        mainPanel( 
                            #this will create a space for us to display our map
                            sliderInput(inputId = "date", "Date:", min = 
                                            as.Date("1986-12-26"), max = as.Date("2021-11-24"), 
                                        value = as.Date("1986-12-26"), width = "600px"),
                            leafletOutput("mymap", width = 600), 
                            #this allows me to put the checkmarks ontop of the map to allow people to view earthquake depth or overlay a heatmap
                            absolutePanel(top = 170, left = 20, 
                                          checkboxInput("markers", "Depth", FALSE),
                                          checkboxInput("heat", "Heatmap", FALSE)
                            )
                        ))
            ),
            tabItem(tabName = "subitem1",
                    h2("Population size & density"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot1"),
                                    title = "title plot 1",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem2",
                    h2("Age content"),
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(
                                radioButtons(
                                    inputId = "peak",
                                    label = "Region:",
                                    choices = c("Groningen", "Drenthe", "Fryslân")),
                                selectInput(
                                    inputId =  "date_from", 
                                    label = "Select time period:", 
                                    choices = 1995:2021)),
                            mainPanel(width = 11,
                                      plotOutput("Age")
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem3",
                    h2("Gender content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot3"),
                                    title = "title plot 3",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem4",
                    h2("Life expectancy content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot4"),
                                    title = "title plot 4",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem5",
                    h2("Mortality & birth rate content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot5"),
                                    title = "title plot 5",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem6",
                    h2("Education content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot6"),
                                    title = "title plot 6",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem7",
                    h2("Income content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot7"),
                                    title = "title plot 7",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem8",
                    h2("Unemployment content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot8"),
                                    title = "title plot 8",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem9",
                    h2("GDP per capita content"),
                    fluidPage(
                        sidebarLayout(
                            sidebarPanel(),
                            mainPanel(width = 12,
                                      plotlyOutput("plotBBP")
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem10",
                    h2("Employment content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot10"),
                                    title = "title plot 10",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem11",
                    h2("Consumption content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot11"),
                                    title = "title plot 11",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem12",
                    h2("Consumer trust content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot12"),
                                    title = "title plot 12",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem13",
                    h2("Producer trust content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot13"),
                                    title = "title plot 13",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem14",
                    h2("Business trust content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot14"),
                                    title = "title plot 14",
                                    width = NULL)
                            )
                        )
                    )
            ),
            tabItem(tabName = "subitem15",
                    h2( "Added value trust content"),
                    fluidPage(
                        fluidRow(
                            column(
                                width = 12,
                                box(plotOutput("plot15"),
                                    title = "title plot 15",
                                    width = NULL)
                            )
                        )
                    )
            )
        )
    )
)
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
