library(dplyr)
library(readr)
library(DataExplorer)
library(plotly)


df <- read.delim(file = "cardio_train.csv",
                 delim = ";") %>%
  mutate(salary = sample(c("Less than 1K",
                           "1K to 5K",
                           "5K to 10K",
                           "More than 10K",
                           NA),
                         size = 70000,
                         replace = T,
                         prob = c(0.2, 0.4, 0.2, 0.05, 0.15)),
         work = ifelse(is.na(salary), 0, 1),
         lang = sample(c(0,1,NA),
                       size = 70000,
                       replace = T,
                       prob = c(0.2, 0.2, 0.6)))
         
glimpse(df)
                           
plot_str(df)

introduce(df)


df <- df %>%
  mutate(age = floor(age/365.25))