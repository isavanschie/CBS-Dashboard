library(readr)
#a)i)
population1 <- read_delim("Downloads/Inkomen_van_personen__persoonskenmerken__regio__indeling_2021__25112021_175657.csv", 
                                                                                         delim = ";", escape_double = FALSE, trim_ws = TRUE, skip = 4)

colnames(population1)[5] <- "Total"
as.numeric(population1$Total)
population1[,"Subsubject"] <- NA
population1 <- subset(population1, select = c("Regions","Periods","Subject","Subsubject","Total"))
View(population1)
#a)ii)
population2 <- read_delim("Downloads/Bevolkingsontwikkeling__regio_per_maand_25112021_180040.csv", 
                                                                     delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                     skip = 3)
colnames(population2)[5] <- "Total"
population2[,"Subsubject"] <- NA
population2 <- subset(population2, select = c("Regions","Periods","Subject","Subsubject","Total"))
View(population2)
#b)-groningen 
density1 <- read_delim("Downloads/Regionale_kerncijfers_Nederland_25112021_174337.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE, skip = 3)

colnames(density1)[5] <- "Total"
density1[,"Subsubject"] <- NA
density1 <- subset(density1, select = c("Regions","Periods","Subject","Subsubject","Total"))
View(density1)
#b)-friesland
density2 <- read_delim("Downloads/Regionale_kerncijfers_Nederland_25112021_175018.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE, skip = 3)

density2[,"Subsubject"] <- NA
colnames(density2)[5] <- "Total"
density2 <- subset(density2, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(density2)
#b)-drenthe
density3 <- read_delim("Downloads/Regionale_kerncijfers_Nederland_25112021_175313.csv", 
                                                              delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                              skip = 3)
density3[,"Subsubject"] <- NA
colnames(density3)[5] <- "Total"
density3 <- subset(density3, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(density3)

#c)-2000/'01-2005/'06
education1 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_193356.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)

colnames(education1)[6] <- "Total"
colnames(education1)[4] <- "Subsubject" #was 'education type'
education1 <- subset(education1, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(education1)
#c)-2006/'07-2011/'12
education2 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_193752.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
colnames(education2)[6] <- "Total"
colnames(education2)[4] <- "Subsubject" #was 'education type'
education2 <- subset(education2, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(education2)
#c)-2012/'13-2017/'18
education3 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_194037.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)

colnames(education3)[6] <- "Total"
colnames(education3)[4] <- "Subsubject" #was 'education type'
education3 <- subset(education3, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(education3)
#c)-2018/'19-2020/'21
education4 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_194338.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, skip = 5)
colnames(education4)[1] <- "Periods"
colnames(education4)[2] <- "Subject"
colnames(education4)[3] <- "Regions"
colnames(education4)[6] <- "Total"
colnames(education4)[4] <- "Subsubject" #was 'education type'
education4 <- subset(education4, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(education4)

#c)-netherlands& northern netherlands - all years 
education5 <- read_delim("Downloads/Leerlingen__deelnemers_en_studenten__onderwijssoort__woonregio_25112021_200226.csv", 
                                                                                          delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                          skip = 5)
colnames(education5)[6] <- "Total"
colnames(education5)[4] <- "Subsubject" #was 'education type'
education5 <- subset(education5, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(education5)
#d)
age <- read_delim("Downloads/Bevolking__geslacht__leeftijd__nationaliteit_en_regio__1_januari_25112021_202452.csv", 
                                                                                           delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                           skip = 5)
colnames(age)[1] <- "Subsubject"
colnames(age)[4] <- "Total"
age[,"Subject"] <- "age"
age <- subset(age, select = c("Regions","Periods","Subject","Subsubject","Total"))
View(age)

#e
gender <- read_delim("Downloads/Bevolking__geslacht__leeftijd__nationaliteit_en_regio__1_januari_25112021_202659.csv", 
                                                                                           delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                           skip = 5)
colnames(gender)[1] <- "Subsubject"
colnames(gender)[4] <- "Total"
gender[,"Subject"] <- "gender"
gender <- subset(gender, select = c("Regions","Periods","Subject","Subsubject","Total"))
View(gender)

#f
income <- read_delim("Downloads/Inkomen_van_personen__persoonskenmerken__regio__indeling_2021__25112021_203146.csv", 
                                                                                         delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                         skip = 4)
income["Subject"] <- "income"
income[,"Subsubject"] <- NA
colnames(income)[5] <- "Total"
income <- subset(income, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(income)

#g ONLY NATIONALLY AVAILABLE
life_expectancy <- read_delim("Downloads/Gezondheid__leefstijl__zorggebruik_en__aanbod__doodsoorzaken__kerncijfers_25112021_203523.csv", 
                                                                                                   delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                                   skip = 3)
life_expectancy[,"Subsubject"] <- NA
life_expectancy[,"Regions"] <- NA
colnames(life_expectancy)[4] <- "Total"
life_expectancy <- subset(life_expectancy, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(life_expectancy)

#h
mortality_birth <- read_delim("Downloads/Bevolkingsontwikkeling__regio_per_maand_25112021_204317.csv", 
                                                                     delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                     skip = 3)
mortality_birth[,"Subsubject"] <- NA
colnames(mortality_birth)[5] <- "Total"
mortality_birth <- subset(mortality_birth, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(mortality_birth)

#i- netherlands& northern netherlands & groningen
unemployment1 <- read_delim("Downloads/Personen_met_een_uitkering__uitkeringsontvangers_per_regio_25112021_205121.csv", 
                                                                                        delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                        skip = 3)
unemployment1[,"Subsubject"] <- NA
colnames(unemployment1)[5] <- "Total"
unemployment1 <- subset(unemployment1, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(unemployment1)
#i- friesland& drenthe 
unemployment2 <- read_delim("Downloads/Personen_met_een_uitkering__uitkeringsontvangers_per_regio_25112021_205328.csv", 
                                                                                        delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                                                                        skip = 3)
unemployment2[,"Subsubject"] <- NA
colnames(unemployment2)[5] <- "Total"
unemployment2 <- subset(unemployment2, select = c("Regions","Periods","Subject","Subsubject","Total"))

View(unemployment2)


#merge everything

demographics<- rbind(population1,population2,density1,density2,density3,
                     education1,education2,education3,education4,education5,
                     age,gender,income,life_expectancy,
                     mortality_birth,unemployment1,unemployment2)
View(demographics)