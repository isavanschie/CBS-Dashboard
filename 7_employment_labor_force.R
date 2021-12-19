library(readr)
library(tidyverse)
library(dplyr)
library(shiny)
library(plotly)

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
    sidebarPanel(),
    mainPanel(width = 11,
              plotlyOutput("plot")
    )
  )
)


server <- function(input, output) {
  
  Region <- c("Drenthe" = "blue", "Groningen" = "red", "Fryslând" = "orange")
  
  
  output$plot <- renderPlotly(ggplot(data = employment, aes(x = Perioden, y = Totalen)) +
                              geom_line(data = groningen, aes(x = Perioden, y = Totalen, group = 1,
                                           color = "Groningen")) +
                                 geom_line(data = drenthe, aes(x = Perioden, y = Totalen, group = 1,
                                           color = "Drenthe")) +
                                 geom_line(data = friesland, aes(x = Perioden, y = Totalen, group = 1,
                                           color = "Fryslând")) +
                                scale_color_manual(values = Region) +
                                theme_bw() + 
                                theme(
                                  plot.title = element_text(size = 15, family = "sans", face = "bold"),
                                  axis.title = element_text(size = 11, face = "bold"),
                                  axis.text.x = element_text(angle = 40)
                                 ) +
                                 labs(
                                   x = "Years", y = "Number of employed persons (x1000)",
                                   title = "Labor force of the northern Netherlands",
                                   color = "Region"
                                 )
  )
}  

  
shinyApp(ui = ui, server = server)





