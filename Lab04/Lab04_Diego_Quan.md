Lab04
================
Diego Quan
1/9/2019

``` r
library(tidyr)
library(reshape2)
library(dplyr)
library(stringr)

places <- read.csv("raw.csv")
places$mu <- NULL
places$fu <- NULL
places$X <- NULL
molten_places <- melt(places, id = c("country", "year"))
head(molten_places)
```

    ##   country year variable value
    ## 1      AD 2000     m014     0
    ## 2      AE 2000     m014     2
    ## 3      AF 2000     m014    52
    ## 4      AG 2000     m014     0
    ## 5      AL 2000     m014     2
    ## 6      AM 2000     m014     2

``` r
sep_places <- separate(molten_places, "variable", c("sex", "age"), sep=1)
sep_places$age <- sub("(..)$", "-\\1", sep_places$age)
head(sep_places)
```

    ##   country year sex  age value
    ## 1      AD 2000   m 0-14     0
    ## 2      AE 2000   m 0-14     2
    ## 3      AF 2000   m 0-14    52
    ## 4      AG 2000   m 0-14     0
    ## 5      AL 2000   m 0-14     2
    ## 6      AM 2000   m 0-14     2

``` r
load(file = 'wide_religion.Rda')
molten_religion <- melt(wide_religion, id = c('religion'))
head(molten_religion)
```

    ##             religion variable value
    ## 1           Agnostic    <$10k    27
    ## 2            Atheist    <$10k    12
    ## 3           Buddhist    <$10k    27
    ## 4           Catholic    <$10k   418
    ## 5 Don’t know/refused    <$10k    15
    ## 6   Evangelical Prot    <$10k   575
