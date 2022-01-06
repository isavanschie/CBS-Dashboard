library(shiny)
library(leaflet)
library(leaflet.extras)
library(tidyverse)
library(data.table)
library(cbsodataR)
library(tigris)
library(geojsonR)
library(sf)

#region codes = "LD01  "(Nothern Netherlands), "PV20  "(Groningen), "PV21  "(Fryslan), "PV22  "(Drenthe)
#color codes = "#FF0000" (red), "#52E74B" (green), "#6854D8"(purple), "#FFC0CB"(pink), "#0000FF"(blue), "#FFA500"(orange)

#gets meta data of dataset

regionalkeyfigures_meta <- cbs_get_meta("70072NED")

#gets dataset

regionalkeyfigures <- cbs_get_data(id = "70072NED", 
                                   RegioS = c("LD01  ", "PV20  ", "PV21  ", "PV22  "),
                                   select = c("RegioS", "Perioden", "TotaleBevolking_1", "Mannen_2", "Vrouwen_3"),
                                   typed = TRUE)

#converts annoying yyyyXXmm fomart to numeric and removes unwated columns

regionalkeyfigures <- cbs_add_date_column(regionalkeyfigures, date_type = "numeric") %>%
  select(-c(2, 4))

#filtering table to single regions

NothernNLkeyfigures <- regionalkeyfigures %>%
  filter(RegioS == "LD01  ")

Groningenkeyfigures <- regionalkeyfigures %>%
  filter(RegioS == "PV20  ")

Fryslankeyfigures <- regionalkeyfigures %>%
  filter(RegioS == "PV21  ")

Drenthekeyfigures <- regionalkeyfigures %>%
  filter(RegioS == "PV22  ")

#adding geodata

Groningen <- geojsonR::shiny_from_JSON("Groningen.geojson")
Fryslan <- geojsonR::shiny_from_JSON("Frysland.geojson")
Drenthe <- geojsonR::shiny_from_JSON("Drenthe.geojson")

# joining datasets and geodata 



#creating ui page

ui <- fluidPage(
  
  titlePanel("Population in Nothern Regions of the Netherlands"),
  
  mainPanel(
    
    sliderInput(inputId = "PopuSlider", label = "Year:", 
                min = min(regionalkeyfigures$Perioden_numeric), max = max(regionalkeyfigures$Perioden_numeric), value = max(regionalkeyfigures$Perioden_numeric), 
                step = 1, ticks = TRUE, width = "600px", dragRange = FALSE, sep = ""),
  
    leafletOutput("population_NNLRegions"), 
    
    leafletOutput("popugenders_NNLRegions")
    
  ) 
)

#creating server function

server <- function(input, output, session) {

  #creating map population development by region
  
    output$population_NNLRegions <- renderLeaflet(
      
      leaflet(width = 650, height = 400) %>%
      setView(lng = 6, lat = 53.1, zoom = 8) %>%
      addTiles() %>%
      addGeoJSON(geojson = Groningen, weight = 1, fillColor = "#FF0000", fillOpacity = 0.1)%>%
      addGeoJSON(geojson = Fryslan, weight = 1, fillColor = "#52E74B", fillOpacity = 0.1)%>%
      addGeoJSON(geojson = Drenthe, weight = 1, fillColor = "#6854D8", fillOpacity = 0.1)%>%
      addCircleMarkers(data = Fryslankeyfigures, lng = 5.7, lat = 53.2, radius = ~TotaleBevolking_1[Perioden_numeric == input$PopuSlider]/20000, color = "#FFA500", opacity = 1, fill = TRUE, fillOpacity = 1, label =  ~TotaleBevolking_1[Perioden_numeric == input$PopuSlider], labelOptions = labelOptions(noHide = F, direction = "top", textsize = 20))%>%
      addCircleMarkers(data = Groningenkeyfigures, lng = 6.7, lat = 53.3, radius =  ~TotaleBevolking_1[Perioden_numeric == input$PopuSlider]/20000, color = "#FFA500", opacity = 1, fill = TRUE, fillOpacity = 1, label =  ~TotaleBevolking_1[Perioden_numeric == input$PopuSlider], labelOptions = labelOptions(noHide = F, direction = "top", textsize = 20))%>%
      addCircleMarkers(data = Drenthekeyfigures, lng = 6.6, lat = 52.8, radius =  ~TotaleBevolking_1[Perioden_numeric == input$PopuSlider]/20000, color = "#FFA500", opacity = 1, fill = TRUE, fillOpacity = 1, label =  ~TotaleBevolking_1[Perioden_numeric == input$PopuSlider], labelOptions = labelOptions(noHide = F, direction = "top", textsize = 20))%>%
      addLegend(position = "topright", colors = c("#FF0000", "#52E74B", "#6854D8"),  labels = c("Groningen", "Fryslân", "Drenthe"), title = "Regions(Regio's):")%>%
      addLegend(position = "bottomright", colors = "#FFA500",  labels = "Population")
      
      )
    
    output$popugenders_NNLRegions <- renderLeaflet(
      
      leaflet(width = 650, height = 400) %>%
        setView(lng = 6, lat = 53.1, zoom = 8) %>%
        addTiles() %>%
        addGeoJSON(geojson = Groningen, weight = 1, fillColor = "#FF0000", fillOpacity = 0.1)%>%
        addGeoJSON(geojson = Fryslan, weight = 1, fillColor = "#52E74B", fillOpacity = 0.1)%>%
        addGeoJSON(geojson = Drenthe, weight = 1, fillColor = "#6854D8", fillOpacity = 0.1)%>%
        addCircleMarkers(data = Fryslankeyfigures, lng = c(5.5, 5.9), lat = c(53.2, 53.2), radius = c(~Mannen_2[Perioden_numeric == input$PopuSlider]/20000, ~Vrouwen_3[Perioden_numeric == input$PopuSlider]/20000), color = c("#0000FF", "#FF0000"), opacity = 1, fill = TRUE, fillOpacity = 1, label = c(~Mannen_2[Perioden_numeric == input$PopuSlider], ~Vrouwen_3[Perioden_numeric == input$PopuSlider]), labelOptions = labelOptions(noHide = F, direction = "top", textsize = 20))%>%
        addCircleMarkers(data = Groningenkeyfigures, lng = c(6.5, 6.9), lat = c(53.3, 53.3), radius = c(~Mannen_2[Perioden_numeric == input$PopuSlider]/20000, ~Vrouwen_3[Perioden_numeric == input$PopuSlider]/20000), color = c("#0000FF", "#FF0000"), opacity = 1, fill = TRUE, fillOpacity = 1, label = c(~Mannen_2[Perioden_numeric == input$PopuSlider], ~Vrouwen_3[Perioden_numeric == input$PopuSlider]), labelOptions = labelOptions(noHide = F, direction = "top", textsize = 20))%>%
        addCircleMarkers(data = Drenthekeyfigures, lng = c(6.4, 6.8), lat = c(52.8, 52.8), radius = c(~Mannen_2[Perioden_numeric == input$PopuSlider]/20000, ~Vrouwen_3[Perioden_numeric == input$PopuSlider]/20000), color = c("#0000FF", "#FF0000"), opacity = 1, fill = TRUE, fillOpacity = 1, label = c(~Mannen_2[Perioden_numeric == input$PopuSlider], ~Vrouwen_3[Perioden_numeric == input$PopuSlider]), labelOptions = labelOptions(noHide = F, direction = "top", textsize = 20))%>%
        addLegend(position = "topright", colors = c("#FF0000", "#52E74B", "#6854D8"),  labels = c("Groningen", "Fryslân", "Drenthe"), title = "Regions(Regio's):")%>%
        addLegend(position = "bottomright", colors = c("#0000FF", "#FF0000"),  labels = c("Males", "Females"), title = "Gender:")
      
    )
}

#calling ui & server for page to run
shinyApp(ui = ui, server = server)
