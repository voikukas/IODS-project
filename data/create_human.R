# Saara Kaskivuo 28/11/22
# Data wrangling, assignment 4 & 5

#library(tidyverse)
#library(dplyr)
#library(boot)
#library(readr)

### Data wrangling 2 & 3.
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")
str(hd)
str(gii)

# HD contains the data for calculating the Human Development Index by country.
# 195 observations (countries) and 8 variables

# GII contains the data for calculating Gender Inequality Index by country. 
# 195 observations (countries) and 10 variables

# Details about the data: https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf

summary(hd)
summary(gii)


### Data wrangling 4.
colnames(hd) <- c("hdi.rank","country","hdi","life.exp","edu.exp","edu.mean","gni","gni.hdi.rank.diff")
colnames(gii) <- c("gii.rank","country","gii","mat.mor","ado.birth","parli.f","edu2.f","edu2.m","labo.f","labo.m")

### Data wrangling 5.
gii <- mutate(gii, "edu2.fm" = edu2.f/edu2.m)
gii <- mutate(gii, "labo.fm" = labo.f/labo.m)

### Data wrangling 6.
human <- inner_join(gii, hd, by = "country")

glimpse(human)
# ok

#write.csv(human, file = "data/human.csv", row.names = TRUE)

### End assignment 4
### Begin assignment 5

# Data wrangling (no number)
human <- read.csv("data/human.csv")
# The data set is a combined set of variables describing human development indices. 
# Our version will (after wrangling) include the following variables:
# country as row name
# edu2.fm | avg of female and male population with at least secondary education (%)
# labo.fm | avg of labour market index (labour force participation rate, %)
# edu.exp | expected years of schooling (years)
# life.exp | life expectancy (years)
# gni | gross national income per capita ($)
# mat.mor | maternal mortality ratio (deaths per 100,000 live births)
# ado.birth | adolescent birth rate (births per 1,000 girls/women aged 15-19)
# parli.f | female shares of parliamentary seats (%)

# Data wrangling 1.
human$gni <- as.numeric(human$gni)

# Data wrangling 2.
keep_cols <- tolower(c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"))
human <- human %>% select(all_of(keep_cols))

# Data wrangling 3 & 4
human <- filter(human, complete.cases(human))
human <- human[1:155,] # solution from ex. 5

# Data wrangling 5 
rownames(human) <- human$country
human <- select(human, -country)

write.csv(human, file = "data/human.csv", row.names = TRUE)





