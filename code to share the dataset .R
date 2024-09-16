getwd()
setwd() # set you library to your downloads, this is where the dataset file is located. 
  
library(readr)
library(tidyverse)
library(dplyr)

economic_indicators <- read_csv("economic-indicators.csv", 
                                col_types = cols(Perioden = col_character(), 
                                                 Totalen = col_character()))
View(economic_indicators)
