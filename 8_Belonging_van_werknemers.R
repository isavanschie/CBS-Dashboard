library(readr)
library(tidyverse)
library(dplyr)
library(shiny)

economic_indicators <- read_csv("/downloads/economic-indicators.csv", 
                                col_types = cols(Perioden = col_character(), 
                                                 Totalen = col_integer()))

Belonging_van_werknemers <- economic_indicators %>% filter(Onderwerp == "Beloning van werknemers in mln euro") %>% 
  filter(`Regio's` != "Nederland") %>%
  filter(!is.na(Totalen))

groningen <- Belonging_van_werknemers %>% filter(`Regio's` == "Groningen (PV)")
drenthe <- Belonging_van_werknemers %>% filter(`Regio's` == "Drenthe (PV)")
friesland <- Belonging_van_werknemers %>% filter(`Regio's` == "Fryslân (PV)")



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "region", 
                  label = "Select region",
                  choices = unique(Belonging_van_werknemers$"Regio's"), 
                  selected = "Groningen (PV)")
    ),
    mainPanel(width = 11,
              plotOutput("plot", click = "plot_click"),
              verbatimTextOutput("info")
    )
  )
)


server <- function(input, output) {
  
  Belonging_van_werknemers1 <- reactive(
    Belonging_van_werknemers %>% 
      filter(`Regio's`== input$region)
  )
  
  output$plot <- renderPlot(height = 400,
                            ggplot(data = Belonging_van_werknemers1(), aes(x = Perioden, y = Totalen, group = 1)) +
                              geom_line(colour = "red", size = 1.5) +
                              geom_line(data = groningen, aes(x = Perioden, y = Totalen, group = 1),
                                        colour = "lightgrey") +
                              geom_line(data = drenthe, aes(x = Perioden, y = Totalen, group = 1),
                                        colour = "lightgrey") +
                              geom_line(data = friesland, aes(x = Perioden, y = Totalen, group = 1),
                                        colour = "lightgrey") +
                              theme_bw() + 
                              theme(
                                plot.title = element_text(size = 15, family = "sans", face = "bold"),
                                plot.subtitle = element_text(size = 13, family = "sans",
                                                             face = "italic"),
                                axis.title = element_text(size = 12, face = "bold")
                              ) +
                              labs(
                                x = "Years", y = "Compensation of employees in million euros",
                                title = "Compensation of employees of the northern Netherlands",
                                subtitle = "Groningen, Fryslând, Drenthe"
                              )
  )
}  


shinyApp(ui = ui, server = server)
