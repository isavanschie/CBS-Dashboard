library(readr)
library(tidyverse)
library(dplyr)
library(shiny)
library(plotly)

economic_indicators <- read_csv("downloads/economic-indicators.csv", 
                                col_types = cols(Perioden = col_character(), 
                                                 Totalen = col_integer()))

employment <- economic_indicators %>% filter(Onderwerp == "Werkzame personen totaal x 1000") %>% 
  filter(`Regio's` != "Nederland")





ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(),
    mainPanel(width = 11,
              plotlyOutput("plot10")
    )
  )
)



server <- function(input, output) {
  
  
  employment$`Regio's` <- recode (employment$`Regio's`,
                                               "Groningen (PV)" = "Groningen",
                                               "Drenthe (PV)" = "Drenthe",
                                               "Fryslân (PV)" =  "Fryslân")
  employment <- employment %>% 
    rename(
      Region = `Regio's`,
      Total = Totalen,
      Period = Perioden
    )
  
  groningen <- employment %>% filter(Region == "Groningen")
  drenthe <- employment %>% filter(Region == "Drenthe")
  friesland <- employment %>% filter(Region == "Fryslân")
  
  
  output$plot10 <- renderPlotly(ggplot(data = employment, aes(x = Period, y = Total, color = Region), group = 1) +
                              geom_line(data = groningen, aes(x = Period, y = Total, group = 1)) +
                                 geom_line(data = drenthe, aes(x = Period, y = Total, group = 1)) +
                                 geom_line(data = friesland, aes(x = Period, y = Total, group = 1)) +
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
                                   x = "Years", y = "Number of employed persons (x1000)",
                                   title = "Labor force of the northern Netherlands",
                                   color = "Region"
                                 )
  )
}  

  
shinyApp(ui = ui, server = server)





