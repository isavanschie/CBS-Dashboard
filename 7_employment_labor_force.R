library(readr)
library(tidyverse)
library(dplyr)
library(shiny)


economic_indicators <- read_csv("/downloads/economic-indicators.csv", 
                                col_types = cols(Perioden = col_character(), 
                                                 Totalen = col_integer()))

employment <- economic_indicators %>% filter(Onderwerp == "Werkzame personen totaal x 1000") %>% 
  filter(`Regio's` != "Nederland")

groningen <- employment %>% filter(`Regio's` == "Groningen (PV)")
drenthe <- employment %>% filter(`Regio's` == "Drenthe (PV)")
friesland <- employment %>% filter(`Regio's` == "Fryslân (PV)")



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "region", 
                  label = "Select region",
                  choices = unique(employment$"Regio's"), 
                  selected = "Groningen (PV)")
    ),
    mainPanel(width = 11,
              plotOutput("plot", click = "plot_click"),
              verbatimTextOutput("info")
    )
  )
)


server <- function(input, output) {
  
  employment1 <- reactive(
    employment %>% 
      filter(`Regio's`== input$region)
  )
  
  output$plot <- renderPlot(height = 400,
                            ggplot(data = employment1(), aes(x = Perioden, y = Totalen, group = 1)) +
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
                                   x = "Years", y = "Number of employed persons (x1000)",
                                   title = "Labor force of the northern Netherlands",
                                   subtitle = "Groningen, Fryslând, Drenthe"
                                 )
  )
}  

  
shinyApp(ui = ui, server = server)





