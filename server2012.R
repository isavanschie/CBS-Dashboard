#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet.minicharts)
library(cbsodataR)
library(tidyverse)
library(scales)
library(ggplot2)
library(leaflet)
library(dplyr)
library(leaflet.extras)
library(data.table)
library(RColorBrewer)
library(geojsonio)
library(magrittr)
library(htmlwidgets)
library(readr)
library(patchwork)
library(RColorBrewer)
library(plotly)



# Define server logic required to draw a histogram
function(input, output, session) {
    #define the color of for the mag of the earquakes
    # Define server logic required to draw a histogram
        #define the color of for the mag of the earquakes
        pal <- colorNumeric(
            palette = c('gold', 'orange', 'dark orange', 'orange red', 'red', 'dark red'),
            domain = data$MAG
        )
        
        #define color for the depth of the earthquakes 
        data$depth_type <- ifelse(data$DEPTH <=2, "0-2km",
                                  ifelse(data$DEPTH>2 &data$DEPTH<=3,"2-3km",
                                         ifelse(data$DEPTH>3,"more than 3km","Wrong value, should not be here")))
        
        pal2 <- colorFactor(
            palette = c('red', 'blue', 'yellow'),
            domain = data$depth_type
        )
        #create the map
        output$mymap <- renderLeaflet({
            
            leaflet(data= Groningen_municipality) %>% 
                setView(lng = 5.7, lat = 53, zoom = 8) %>%
                addTiles() %>%
                addPolygons(data = Groningen_municipality, stroke = FALSE, color = "green", weight = 6) %>%
                addPolygons(data = Drenthe_municipality, stroke = FALSE, color = "green", weight = 6) %>%
                addPolygons(data = Frysland_municipality, stroke = FALSE, color = "green",  weight = 6) %>%
                addCircles(data = df(), lat = ~ LAT, lng = ~ LON, weight = 1, radius = ~MAG*250,
                           popup = ~as.character(MAG), label = ~as.character(paste0("Magnitude: ", sep = " ", MAG, "\nLocation: ", sep = " ", LOCATION)), color = ~pal(MAG), fillOpacity = 0.3)
            
        })
        
        
        
        # Rosanne Make dataset reactive on slider bar
        df <- reactive({
            
            # First, I make a new variable that gives the value of the slider in the same format as the YYMMDD format.
            # Then I filter the data based on that new variable
            dat <- data %>%
                mutate(slider = paste0(substr(as.character(input$date),1,4),substr(as.character(input$date),6,7),substr(as.character(input$date),9,10))) %>%
                filter(YYMMDD <= slider)
            
            dat
            
            # browser()
        })
        
        observe({
            proxy <- leafletProxy("mymap", data = df()) # Rosanne: here you call the data. As the data is in a function, use () behind the name of the function.I don't know exactly what this part does, so check whether you want to load data (all data) or d f (part of the data based on slider)
            # browser() Rosanne: the browser function stops your code as this point. Then you can see how the proxy element (in which your data is) looks like at this moment. Is this how you want it? No, then you know something is not going good.
            proxy %>% clearMarkers()
            if (input$markers) {
                proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal2(depth_type), fillOpacity = 0.1, label = ~as.character(paste0("Magnitude: ", sep = " ", MAG,    "\nLocation: ", sep = " ", LOCATION))) %>%
                    addLegend("bottomright", pal = pal2, values = df()$depth_type, # Rosanne: same here
                              title = "Depth Type",
                              opacity = 1)}
            else {
                proxy %>% clearMarkers() %>% clearControls()
            }
        })
        
        observe({
            proxy <- leafletProxy("mymap", data = df())
            proxy %>% clearMarkers()
            if (input$heat) {
                proxy %>%  addHeatmap(lng=~LON, lat=~LAT, intensity =~MAG, blur =  10, max = 0.05, radius = 15) 
            }
            else{
                proxy %>% clearHeatmap()
            }
            
            
        })
        
        Age <- demographics2 %>% filter(Subject == "age") %>% 
            filter(Subsubject != "Total") %>% 
            filter(Regions == "Groningen (PV)" | Regions == "Drenthe (PV)" | Regions == "Fryslân (PV)")
        
        Age$Regions <- recode (Age$Regions,
                               "Groningen (PV)" = "Groningen",
                               "Drenthe (PV)" = "Drenthe",
                               "Fryslân (PV)" =  "Fryslân")
        
        dataInput <- reactive({
            Age <- switch(input$peak,  
                          "Drenthe" = Age %>% filter(Regions == "Drenthe"),
                          "Groningen" = Age %>% filter(Regions == "Groningen"),
                          "Fryslân" = Age %>% filter(Regions == "Fryslân"))
            switch(input$date_from,
                   "1995" = Age %>% filter(Periods == "1995"),
                   "1996" = Age %>% filter(Periods == "1996"),
                   "1997" = Age %>% filter(Periods == "1997"),
                   "1998" = Age %>% filter(Periods == "1998"),
                   "1999" = Age %>% filter(Periods == "1999"),
                   "2000" = Age %>% filter(Periods == "2000"),
                   "2001" = Age %>% filter(Periods == "2001"),
                   "2002" = Age %>% filter(Periods == "2002"),
                   "2003" = Age %>% filter(Periods == "2003"),
                   "2004" = Age %>% filter(Periods == "2004"),
                   "2005" = Age %>% filter(Periods == "2005"),
                   "2006" = Age %>% filter(Periods == "2006"),
                   "2007" = Age %>% filter(Periods == "2007"),
                   "2008" = Age %>% filter(Periods == "2008"),
                   "2009" = Age %>% filter(Periods == "2009"),
                   "2010" = Age %>% filter(Periods == "2010"),
                   "2011" = Age %>% filter(Periods == "2011"),
                   "2012" = Age %>% filter(Periods == "2012"),
                   "2013" = Age %>% filter(Periods == "2013"),
                   "2014" = Age %>% filter(Periods == "2014"),
                   "2015" = Age %>% filter(Periods == "2015"),
                   "2016" = Age %>% filter(Periods == "2016"),
                   "2017" = Age %>% filter(Periods == "2017"),
                   "2018" = Age %>% filter(Periods == "2018"),
                   "2019" = Age %>% filter(Periods == "2019"),
                   "2020" = Age %>% filter(Periods == "2020"),
                   "2021" = Age %>% filter(Periods == "2021"))
        })
        
        output$Age <- renderPlot({
            ggplot(dataInput(), aes(x = Subsubject, y = Total)) + 
                geom_bar(stat = "summary", fun = "mean", fill = "blue") +
                coord_flip() +
                scale_y_continuous(
                    breaks = seq(0, 50000, 2500),
                    limits = c(0, 50000)
                ) +
                labs(
                    title = "Number of cases per age category",
                    subtitle = "Data about Groningen, Drenthe and Fryslând",
                    x = "Age categories",
                    y = "Amount of people"
                ) +
                theme_minimal() +
                theme(
                    plot.background = element_rect(fill = "aliceblue"),
                    panel.grid.major.y = element_blank(),
                    panel.grid.minor.y = element_blank(),
                    panel.grid.major.x = element_line(colour = "azure2"),
                    plot.title = element_text(face = "bold", size = 12),
                    plot.subtitle = element_text(face = "italic"),
                    axis.title = element_text(face = "bold"),
                    axis.text.x = element_text(angle = 40)) +
                scale_x_discrete(
                    labels = c(
                        "0 to 5 years" = "0-5 years",
                        "5 tot 10 jaar" = "5-10 years",
                        "10 tot 15 jaar" = "10-15 years",
                        "15 tot 20 jaar" = "15-20 years",
                        "20 tot 25 jaar" = "20-25 years",
                        "25 tot 30 jaar" = "25-30 years",
                        "30 tot 35 jaar" = "30-35 years",
                        "35 tot 40 jaar" = "35-40 years",
                        "40 tot 45 jaar" = "40-45 years",
                        "45 tot 50 jaar" = "45-50 years",
                        "50 tot 55 jaar" = "50-55 years",
                        "55 tot 60 jaar" = "55-60 years",
                        "60 tot 65 jaar" = "60-65 years",
                        "65 tot 70 jaar" = "65-70 years",
                        "55 tot 60 jaar" = "55-60 years",
                        "60 tot 65 jaar" = "60-65 years",
                        "65 tot 70 jaar" = "65-70 years",
                        "70 tot 75 jaar" = "70-75 years",
                        "80 tot 85 jaar" = "80-85 years",
                        "85 tot 90 jaar" = "85-90 years",
                        "90 tot 95 jaar" = "90-95 years",
                        "95 jaar of ouder" = "95+ years")
                ) 
        })
       
        
        Economic_indicatorsBBP1$`Regio's` <- recode (Economic_indicatorsBBP1$`Regio's`,
                                                     "Groningen (PV)" = "Groningen",
                                                     "Drenthe (PV)" = "Drenthe",
                                                     "Fryslân (PV)" =  "Fryslân")
        Economic_indicatorsBPP2 <- Economic_indicatorsBBP1 %>% 
            rename(
                Region = `Regio's`,
                Total = Totalen,
                Period = Perioden
            )
        
        Groningen <- Economic_indicatorsBPP2 %>% filter(Region == "Groningen") %>%
            filter(Onderwerp == "Bbp per inwoner in euro")
        Drenghte <- Economic_indicatorsBPP2 %>% filter(Region == "Drenthe") %>%
            filter(Onderwerp == "Bbp per inwoner in euro")
        Fryslând  <- Economic_indicatorsBPP2 %>% filter(Region == "Fryslân") %>%
            filter(Onderwerp == "Bbp per inwoner in euro")
        Nederland  <- Economic_indicatorsBPP2 %>% filter(Region == "Nederland") %>%
            filter(Onderwerp == "Bbp per inwoner in euro")
        
        BBP <- Economic_indicatorsBPP2 %>% filter(Onderwerp == "Bbp per inwoner in euro")  
        
        
        output$plotBBP <- renderPlotly(
            ggplot(data = BBP, aes(x = Period, y = Total, color = Region, group = 1)) +
                geom_line(data = Nederland, aes(x = Period, y = Total, group = 1), linetype = "dashed") +
                geom_line(data = Drenghte, aes(x = Period, y = Total, group = 1)) +
                geom_line(data = Groningen, aes(x = Period, y = Total, group = 1)) +
                geom_line(data = Fryslând, aes(x = Period, y = Total, group = 1)) +
                scale_y_continuous(
                    breaks = seq(10000, 55000, 5000),
                    limits = c(10000, 55000),
                    labels = c(
                        "10000" = "€10000",
                        "15000" = "€15000",
                        "20000" = "€20000",
                        "25000" = "€25000",
                        "30000" = "€30000",
                        "35000" = "€35000",
                        "40000" = "€40000",
                        "45000" = "€45000",
                        "50000" = "€50000",
                        "55000" = "€55000")
                ) +
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
                    x = "years", y = "GDP per citizen",
                    title = "Gross domestic product with respect to Dutch average",
                    subtitle = "Groningen, Fryslând, Drenthe",
                    color = "Region"
                )
        )
        
}
    


