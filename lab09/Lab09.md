Lab09
================
Diego Quan
29/10/2019

``` r
tw <- twitteR::searchTwitter('#Worlds2019', n = 1e4, since = '2019-10-21', retryOnRateLimit = 1e3)

df <- twitteR::twListToDF(tw)
df %>% head() %>% View()


write_csv(df,"tweets.csv")
```
