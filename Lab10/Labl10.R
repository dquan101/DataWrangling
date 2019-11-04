library(dplyr)
library(readr)
library(DataExplorer)
library(plotly)
library(skimr)
library(robustHD)
library(ggpubr)
library(formattable)

df_movies <- read_csv('movies.csv')
df_ratings <- read_csv('ratings.csv')
new_ratings <- df_ratings %>% na.omit()
new_movies <- df_movies %>% na.omit()

agg_ratings <- aggregate(rating~movieId, new_ratings, FUN=mean)
names(agg_ratings)[1] <- 'id'
app_movies <- merge(new_movies, agg_ratings[, c("id", "rating")], by="id")

skim(app_movies)

plot_histogram(app_movies)
plot_boxplot(app_movies, by = "budget")
plot_boxplot(app_movies, by = "popularity")
plot_scatterplot(app_movies, by = "popularity", sampled_rows = 500L)
plot_scatterplot(app_movies, by = "budget", sampled_rows = 500L)
plot_correlation(na.omit(app_movies), maxcat = 8L)

ggscatter(app_movies, x = "rating", y = "popularity", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "rating", ylab = "popularity")

ggscatter(app_movies, x = "vote_count", y = "revenue", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "vote_count", ylab = "revenue")

ggscatter(app_movies, x = "revenue", y = "popularity", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "revenue", ylab = "popularity")

