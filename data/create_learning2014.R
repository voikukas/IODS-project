# Saara Kaskivuo 07/11/22
# Data wrangling for learning2014

#library(tidyverse)
#library(dplyr)

### Data wrangling 2.
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
str(lrn14)

# The dataset is a 183 x 60 matrix of a questionnaire study. The rows (n = 183) represent the answers of one respondent and the columns are answers (probably a 1-5 Likert scale + background variables such as age and gender)

### Data wrangling 3.
# 

# Scaling attitude: divide by 10 because "The column `Attitude` in `lrn14` is a sum of 10 questions related to students' 
# attitude towards statistics, each measured on the [Likert scale](https://en.wikipedia.org/wiki/Likert_scale) (1-5)."

lrn14$attitude <- lrn14$Attitude / 10

# sum and scale deep, stra, and surf, add to table
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# keep gender, age, attitude, deep, stra, surf and points
keep <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

learning_data <- select(lrn14, one_of(keep))