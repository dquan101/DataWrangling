Lab06
================
Diego Quan
9/15/2019

``` r
str_detect(
  string =  c("P243CNJ", "P214HNS", "P345FVJ", "A344SDF", "P2314ASD", "P245ABC"),
  pattern = "^P([0-9]){3}[A-Z&&[^AEIOU]]{3}"
)
```

    ## [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE

``` r
str_detect(
  string =  c("Ejemplo1.pdf", "prueba2.PDF", "respuestas_del_examen.jpg", "amor.JPG", "hola.hpq"),
  pattern = "(.)*\\.(pdf|jpg|PDF|JPG)$"
)
```

    ## [1]  TRUE  TRUE  TRUE  TRUE FALSE

``` r
str_detect(
  string =  c("Hola123!", "$H123488", "$H123488Nu", "AERFSdnf", "12345678", "asdfghjk", "ASDFGHJK", "adfd!!1L", "Datawrangling2019!"),
  pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
)
```

    ## [1]  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE

``` r
str_detect(
  string =  c("19002324", "31001564", "14011110", "11008921", "2003421"),
  pattern = "^([1-9]|[12][0-9]|30)(00)(11[1-8][0-9]|119[0-9]|1[2-9][0-9]{2}|[2-7][0-9]{3}|8[0-8][0-9]{2}|89[0-6][0-9]|8970)"
)
```

    ## [1]  TRUE FALSE FALSE  TRUE  TRUE

``` r
str_detect(
  string =  c("pit", "spot", "spate", "slap two", "respite", "pt", "Pot", "peat", "part"),
  pattern = "p(.)t"
)
```

    ## [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE

``` r
str_detect(
  string =  c("+50254821151", "4210-7640", "52018150", "2434 6854", "11234569", "50211234578"),
  pattern = "^(\\+502|502)?(4|5|2|6)(\\d){3}(\\s|-)?(\\d){4}"
)
```

    ## [1]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE

``` r
str_detect(
  string =  c("dquan@ufm.edu", "prueba1@ufm.edu", "prueba_1@ufm.edu", "dquan@ufm", "dquan@gmail.edu", "dquan@@"),
  pattern = "^[a-z0-9]+@(ufm)\\.(edu)$"
)
```

    ## [1]  TRUE  TRUE FALSE FALSE FALSE FALSE

``` r
str_detect(
  string =  c("abc012333ABCDEEEE", "ufm69UFM", "prueba_1@ufm.edu", "gtu012345678ANCSD", "dquan@gmail.edu", "dquan@@"),
  pattern = "([a-z]{0,3})?([0-9]{2,9})([A-Z]{3,})"
)
```

    ## [1]  TRUE  TRUE FALSE  TRUE FALSE FALSE
