---
title: "Economic graph"
output: html_document
---

```{r setup, include=FALSE}
library(readr)
library(tidyverse)
library(dplyr)
library(shiny)
library(scales)
library(ggiraph)
library(plotly)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
economic_indicatorsBBP <- read_csv("economic-indicators.csv", 
                                col_types = cols(Perioden = col_character(), 
                                                 Totalen = col_integer()))
```

```{r}
View(economic_indicatorsBBP)
```

```{r}
Groningen <- economic_indicatorsBBP %>% filter(`Regio's` == "Groningen (PV)") %>%
  filter(Onderwerp == "Bbp per inwoner in euro")
Drenghte <- economic_indicatorsBBP %>% filter(`Regio's` == "Drenthe (PV)") %>%
  filter(Onderwerp == "Bbp per inwoner in euro")
Fryslând  <- economic_indicatorsBBP %>% filter(`Regio's` == "Fryslân (PV)") %>%
  filter(Onderwerp == "Bbp per inwoner in euro")
Nederland  <- economic_indicatorsBBP %>% filter(`Regio's` == "Nederland") %>%
  filter(Onderwerp == "Bbp per inwoner in euro")
```

```{r}
BBP <- economic_indicatorsBBP %>% filter(Onderwerp == "Bbp per inwoner in euro") %>%
 filter(`Regio's`!= "Nederland")  
```

```{r}
BBP1 <- reactive(
  BBP %>% 
    filter(`Regio's`== input$regio)
)

```

```{r}
data_summarized <- BBP %>% group_by(`Regio's`) %>% 
  summarise(avg = mean(Perioden), max(Totalen),
min = min(Totalen))
```


```{r}
ui <- fluidPage(
        sidebarLayout(
              sidebarPanel(
              selectInput(inputId = "regio", # essential! give the input a name that you will need on the server side
                        label = "Select region", # text displayed in your app
                        choices = unique(BBP$`Regio's`), # input to choose from 
                        selected = "Groningen (PV)") # define default
              ),
              mainPanel(width = 11,
                  plotOutput("plotBBP", click = "plot_click"),
                  verbatimTextOutput("info")
              )
          )
      )
  
```

```{r}
server <- function(input, output) {
  
  BBP <- economic_indicatorsBBP %>% filter(Onderwerp == "Bbp per inwoner in euro")  
  
  BBP1 <- reactive(
  BBP %>% 
    filter(`Regio's`== input$regio)
)
  
  output$plotBBP <- renderPlot(height = 400,
        ggplot(data = BBP1(), aes(x = Perioden, y = Totalen, group = 1)) +
          geom_line(colour = "red", size = 1.5) +
          geom_line(data = Nederland, aes(x = Perioden, y = Totalen, group = 1),
                      colour = "blue") +
          geom_line(data = Drenghte, aes(x = Perioden, y = Totalen, group = 1),
                      colour = "lightgrey") +
          geom_line(data = Groningen, aes(x = Perioden, y = Totalen, group = 1),
                      colour = "lightgrey") +
          geom_line(data = Fryslând, aes(x = Perioden, y = Totalen, group = 1),
                      colour = "lightgrey") +
            annotate("label", x = 25, y = 49000, label = "Nederland") +
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
            axis.title = element_text(size = 12, face = "bold")
          ) +
          labs(
            x = "years", y = "GDP per citizen",
            title = "Gross domestic product with respect to Dutch average",
            subtitle = "Groningen, Fryslând, Drenthe"
          )
    )
  output$info <- renderText({
    paste0("year=", as.numeric(input$plot_click$x) + 1994, "\nGDP=", input$plot_click$y)
  })


}
```

##See first option of the BBP Graph
```{r}
shinyApp(ui, server)
```



```{r}
ui2 <- fluidPage(
        sidebarLayout(
           sidebarPanel(),
              mainPanel(width = 11,
                  plotlyOutput("plotBBP")
              )
          )
      )

```

```{r}
Region <- c("Nederland" = "black", "Drenthe" = "red", "Groningen" = "blue", "Frieslând" = "orange")
```



```{r}
 server2 <- function(input, output) {
  
  BBP <- economic_indicatorsBBP %>% filter(Onderwerp == "Bbp per inwoner in euro")  
  
  Region <- c("Nederland" = "black", "Drenthe" = "blue", "Groningen" = "red", "Fryslând" = "orange")
  
  output$plotBBP <- renderPlotly(
        ggplot(data = BBP, aes(x = Perioden, y = Totalen, group = 1), 
               text = ~paste("Region: ", `Regio's`)) +
          geom_line(data = Nederland, aes(x = Perioden, y = Totalen, group = 1,   color = "Nederland"), linetype = "dashed") +
          geom_line(data = Drenghte, aes(x = Perioden, y = Totalen, group = 1, color = "Drenthe")) +
          geom_line(data = Groningen, aes(x = Perioden, y = Totalen, group = 1, color = "Groningen")) +
          geom_line(data = Fryslând, aes(x = Perioden, y = Totalen, group = 1, color = "Fryslând")) +
          scale_color_manual(values = Region) +
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
```



```{r}
shinyApp(ui2, server2)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
