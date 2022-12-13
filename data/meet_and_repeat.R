# Saara Kaskivuo 8/12/22
# Data wrangling, assignment 6

library(tidyverse)
library(dplyr)
library(boot)
library(readr)
library(lme4)

### Data wrangling 1.
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')
str(bprs)
str(rats)
# bprs contains weekly BPRS (brief psychiatric rating scale) measures of 40 subjects over 9 weeks. 
# The subjects are split into treatment and non-treatment groups (binary variable "treatment").

# rats contains the body weights of 16 rats recorded over a 9-week period (each column represents a day of measurements).
# The rats in the study were split into 3 groups which were given different diets.

summary(bprs)
summary(rats)

# From the summary, we can glance at the min, max & means of the measure points. Of course, it's not informative on the categorical variables.


### Data wrangling 2.
bprs$treatment <- factor(bprs$treatment)
bprs$subject <- factor(bprs$subject)
rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)

### Data wrangling 3.
bprsl <- pivot_longer(bprs, cols = -c(treatment, subject), names_to = "weeks", values_to="bprs") %>% arrange(weeks)
bprsl <- bprsl %>% mutate(weeks = as.integer(substr(weeks, 5,5)))
ratsl <- pivot_longer(rats, cols = -c(Group, ID), names_to = "Time", values_to="Weight") %>% arrange(Time) %>% mutate(Time = as.integer(substr(Time, 3, nchar(Time))))

### Data wrangling 4.
tibble(bprsl)
tibble(bprs)
tibble(rats)
tibble(ratsl)
# In the wide format, all measurements for one subject are on the same row.
# In the long format, one row holds a single data point. This way, data can be grouped or investigated by e.g., week, subject, or treatment group. 

write.csv(bprs, file = "data/bprs.csv", row.names = TRUE)
write.csv(bprsl, file = "data/bprsl.csv", row.names = TRUE)
write.csv(rats, file = "data/rats.csv", row.names = TRUE)
write.csv(ratsl, file = "data/ratsl.csv", row.names = TRUE)