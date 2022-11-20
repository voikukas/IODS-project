# Saara Kaskivuo 20/11/22
# Data wrangling, assignment 3
# The goal of this assignment is to join two data sets together.
# Source for data: https://archive.ics.uci.edu/ml/datasets/Student+Performance

#library(tidyverse)
#library(dplyr)
#library(boot)
#library(readr)

### Data wrangling 3.
math <- read.table("data/student-mat.csv", sep=";", header=TRUE)
por <- read.table("data/student-por.csv", sep=";", header=TRUE)
str(math)
str(por)

# Both data sets comprise of student data with background variables on grades, demographic, and other social and school-related features (total: 30 variables). 
# Course subject data describes first, second, and final period grades in either Portuguese (por) or maths (math).
# The por data has 649 observations and the math data has 395 observations.

### Data wrangling 4.
skip <- c("failures", "paid", "absences", "G1", "G2", "G3") # columns to skip
join_v <- setdiff(colnames(por), skip) # get list of columns to keep by set difference of all columns + columns to skip

students <- inner_join(por, math, by = join_v, suffix = c("por", "math"))

### Data wrangling 5.
## (copied from ex. 3.3)
# create a new data frame with only the joined columns
alc <- select(students, all_of(join_v))


# for every column name not used for joining...
for(col_name in skip) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(students, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

### Data wrangling 6. 

# weekday & weekend alcohol consumption: 
# 27 Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
# 28 Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high) 

# avg of Dalc & Walc
alc <- mutate(alc, alc_use = (Dalc + Walc)/2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

### Data wrangling 7.
glimpse(alc)
# saw 370 obs

write.csv(alc, file = "alc.csv", row.names = TRUE)

