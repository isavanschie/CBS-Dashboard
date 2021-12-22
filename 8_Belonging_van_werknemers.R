library(readr)
library(tidyverse)
library(dplyr)
library(shiny)
library(plotly)

economic_indicators <- read_csv("downloads/economic-indicators.csv", 
                                col_types = cols(Perioden = col_character(), 
                                                 Totalen = col_integer()))

Belonging_van_werknemers <- economic_indicators %>% filter(Onderwerp == "Beloning van werknemers in mln euro") %>% 
  filter(`Regio's` != "Nederland") %>%
  filter(!is.na(Totalen))



ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(),
    mainPanel(width = 11,
              plotlyOutput("plotBvw")
    )
  )
)


server <- function(input, output) {
  
  Belonging_van_werknemers$`Regio's` <- recode (Belonging_van_werknemers$`Regio's`,
                                  "Groningen (PV)" = "Groningen",
                                  "Drenthe (PV)" = "Drenthe",
                                  "Fryslân (PV)" =  "Fryslân")
  Belonging_van_werknemers <- Belonging_van_werknemers %>% 
    rename(
      Region = `Regio's`,
      Total = Totalen,
      Period = Perioden
    )
  
  groningen <- Belonging_van_werknemers %>% filter(Region == "Groningen")
  drenthe <- Belonging_van_werknemers %>% filter(Region == "Drenthe")
  friesland <- Belonging_van_werknemers %>% filter(Region == "Fryslân")  
  
  output$plotBvw <- renderPlotly(
    ggplot(data = Belonging_van_werknemers, aes(x = Period, y = Total, color = Region), group = 1) +
    geom_line(data = groningen, aes(x = Period, y = Total, group = 1,
                                    color = "Groningen")) +
    geom_line(data = drenthe, aes(x = Period, y = Total, group = 1,
                                  color = "Drenthe")) +
    geom_line(data = friesland, aes(x = Period, y = Total, group = 1,
                                    color = "Fryslând")) +
    theme_bw() + 
    theme(
      plot.title = element_text(size = 15, family = "Times", face = "bold"),
      plot.subtitle = element_text(size = 13, family = "Times",
                                   face = "italic"),
      plot.background = element_rect(fill = "aliceblue"),
      panel.grid.major.y = element_line(colour = "azure2"),
      panel.grid.minor.y = element_line(colour = "azure2"),
      panel.grid.major.x = element_blank(),
      axis.title = element_text(size = 12, face = "bold"),
      axis.text.x = element_text(angle = 40)
    ) +
    labs(
      x = "Years", y = "Compensation of employees in million euros",
      title = "Compensation of employees of the northern Netherlands",
      color = "Region")
  )
}  


shinyApp(ui = ui, server = server)
