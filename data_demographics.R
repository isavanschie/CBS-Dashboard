library(readr)
#a)i)
Inkomen_van_personen_persoonskenmerken_regio_indeling_2021_25112021_175657 <- read_delim("Downloads/Inkomen_van_personen__persoonskenmerken__regio__indeling_2021__25112021_175657.csv", 
                                                                                         delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                         skip = 4)
View(Inkomen_van_personen_persoonskenmerken_regio_indeling_2021_25112021_175657)
#a)ii)
Bevolkingsontwikkeling_regio_per_maand_25112021_180040 <- read_delim("Downloads/Bevolkingsontwikkeling__regio_per_maand_25112021_180040.csv", 
                                                                     delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                     skip = 3)
View(Bevolkingsontwikkeling_regio_per_maand_25112021_180040)
#b)-groningen 
Regionale_kerncijfers_Nederland_25112021_174337 <- read_delim("Downloads/Regionale_kerncijfers_Nederland_25112021_174337.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE, skip = 3)
View(Regionale_kerncijfers_Nederland_25112021_174337)
#b)-friesland
Regionale_kerncijfers_Nederland_25112021_175018 <- read_delim("Downloads/Regionale_kerncijfers_Nederland_25112021_175018.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE, skip = 3)
View(Regionale_kerncijfers_Nederland_25112021_175018)
#b)-drenthe
Regionale_kerncijfers_Nederland_25112021_175313 <- read_delim("Downloads/Regionale_kerncijfers_Nederland_25112021_175313.csv", 
                                                              delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                              skip = 3)
View(Regionale_kerncijfers_Nederland_25112021_175313)

#c)-2000/'01-2005/'06
Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_193356 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_193356.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
View(Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_193356)
#c)-2006/'07-2011/'12
Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_193752 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_193752.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
View(Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_193752)
#c)-2012/'13-2017/'18
Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_194037 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_194037.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
View(Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_194037)
#c)-2018/'19-2020/'21
Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_194338 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_194338.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
View(Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_194338)

#c)-netherlands& northern netherlands - all years 
Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_200226 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_200226.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
View(Leerlingen_deelnemers_en_studenten_onderwijssoort_woonregio_25112021_200226)
#d)
Bevolking_geslacht_leeftijd_nationaliteit_en_regio_1_januari_25112021_202452 <- read_delim("Downloads/Bevolking__geslacht__leeftijd__nationaliteit_en_regio__1_januari_25112021_202452.csv", 
                                                                                           delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                           skip = 5)
View(Bevolking_geslacht_leeftijd_nationaliteit_en_regio_1_januari_25112021_202452)

#e
Bevolking_geslacht_leeftijd_nationaliteit_en_regio_1_januari_25112021_202659 <- read_delim("Downloads/Bevolking__geslacht__leeftijd__nationaliteit_en_regio__1_januari_25112021_202659.csv", 
                                                                                           delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                           skip = 5)
View(Bevolking_geslacht_leeftijd_nationaliteit_en_regio_1_januari_25112021_202659)

#f
Inkomen_van_personen_persoonskenmerken_regio_indeling_2021_25112021_203146 <- read_delim("Downloads/Inkomen_van_personen__persoonskenmerken__regio__indeling_2021__25112021_203146.csv", 
                                                                                         delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                         skip = 4)
View(Inkomen_van_personen_persoonskenmerken_regio_indeling_2021_25112021_203146)

#g
Gezondheid_leefstijl_zorggebruik_en_aanbod_doodsoorzaken_kerncijfers_25112021_203523 <- read_delim("Downloads/Gezondheid__leefstijl__zorggebruik_en__aanbod__doodsoorzaken__kerncijfers_25112021_203523.csv", 
                                                                                                   delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                                   skip = 3)
View(Gezondheid_leefstijl_zorggebruik_en_aanbod_doodsoorzaken_kerncijfers_25112021_203523)

#h
Bevolkingsontwikkeling_regio_per_maand_25112021_204317 <- read_delim("Downloads/Bevolkingsontwikkeling__regio_per_maand_25112021_204317.csv", 
                                                                     delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                     skip = 3)
View(Bevolkingsontwikkeling_regio_per_maand_25112021_204317)

#i- netherlands& northern netherlands & groningen
Personen_met_een_uitkering_uitkeringsontvangers_per_regio_25112021_205121 <- read_delim("Downloads/Personen_met_een_uitkering__uitkeringsontvangers_per_regio_25112021_205121.csv", 
                                                                                        delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                        skip = 3)
View(Personen_met_een_uitkering_uitkeringsontvangers_per_regio_25112021_205121)
#i- friesland& drenthe 
Personen_met_een_uitkering_uitkeringsontvangers_per_regio_25112021_205328 <- read_delim("Downloads/Personen_met_een_uitkering__uitkeringsontvangers_per_regio_25112021_205328.csv", 
                                                                                        delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                        skip = 3)
View(Personen_met_een_uitkering_uitkeringsontvangers_per_regio_25112021_205328)


