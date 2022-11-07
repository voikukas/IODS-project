# Saara Kaskivuo 07/11/22
# Reads learning2014 data 

data <- read_tsv("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt")

# The dataset is a 183 x 60 matrix of a questionnaire study. The rows (n = 183) represent the answers of one respondent and the columns are answers (probably a 1-5 Likert scale + background variables such as age and gender)