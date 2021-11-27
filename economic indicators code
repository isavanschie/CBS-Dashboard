ls()
getwd()
setwd("/Users/isavanschie/Documents/Minor Data Wise")


library(tidyverse)
library(dplyr)


# economische indicatoren 
economic_region <- read_delim("CBS /Regionale_kerncijfers__nationale_rekeningen_18112021_145259.csv",
                              ";", escape_double = FALSE, trim_ws = TRUE)

region_eco <- as.data.frame(economic_region)

view(region_eco)

region_eco <- region_eco %>% rename(regio = `regio's`)


# economische groei 

economic_growth <- read_delim("CBS /Economische_groei__bbp_en_toegevoegde_waarde_volumemutaties__nr_18112021_150301.csv", 
                              ";", escape_double = FALSE, trim_ws = TRUE)

growth_eco <- as.data.frame(economic_growth)

view(growth_eco)


# een nieuw kolom toevoegen? 
growth_eco <- growth_eco$indicators



# bedrijfsvestiging 

bedrijfsvestiging <- read_delim("CBS /bedrijfsvestigingen .csv", 
                                ";", escape_double = FALSE, col_types = cols(X3 = col_number(), 
                                                                             X4 = col_skip(), X5 = col_number(), 
                                                                             Perioden = col_number()), trim_ws = TRUE, 
                                skip = 3)
bedrijfsvestiging <- as.data.frame(bedrijfsvestiging)
rename(bedrijfsvestiging, Aantal = )

names(bedrijfsvestiging) [4] <- 'Aantal' 


view(bedrijfsvestiging)


# consumptie nationaal 

bestedingen <- read_delim("CBS /Bestedingen__consumptie_huishoudens_1995_2019_27112021_182824.csv", 
                          ";", escape_double = FALSE, col_types = cols( 
                                                                       Perioden = col_number()), trim_ws = TRUE, 
                          skip = 3)
bestedingen <- as.data.frame(bestedingen)
view(bestedingen)
# primair inkomen 2015-2018 

inkomen_nl <-  read_delim("CBS /primair inkomen per hoofd : bevolking. 2015-2018.csv", 
                                                                          ";", escape_double = FALSE, col_types = cols(X4 = col_skip(), 
                                                                                                                       X5 = col_number(), Perioden = col_number()), 
                                                                          trim_ws = TRUE, skip = 3)
view(inkomen_nl)

inkomen_nl <- as.data.frame(inkomen_nl)


# uitkeringen en werkloosheid 

uitkeringen <- read_delim("CBS /uitkeringen en werkloosheid .csv", 
                          ";", escape_double = FALSE, col_types = cols(Perioden = col_number(), 
                                                                       X4 = col_skip(), X5 = col_number()), 
                          trim_ws = TRUE, skip = 3)
uitkeringen <- as.data.frame(uitkeringen)
view(uitkeringen)


# consumer trust 

consumer_trust <- read_delim("CBS /Consumentenvertrouwen__regionale_kenmerken_27112021_182407.csv", 
                             ";", escape_double = FALSE, col_types = cols(Perioden = col_number(), 
                                                                          X5 = col_number()), trim_ws = TRUE, 
                             skip = 3)
consumer_trust <- as.data.frame(consumer_trust)
view(consumer_trust)




full_join(region_eco, growth_eco)
