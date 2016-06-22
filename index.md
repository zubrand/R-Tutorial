# R Tutorial
Andriy Zhubryd  
21 června 2016  

# Start with R
## Introduction

R is one of the most popular languages of statistical programming. It means that it cannot be used for development of end-to-end standalone applications (unlike python) and it's focused on statistical computations. This computational aspect can be seen everywhere: from data types to main functions and variables. After all, R console is designed to receive commands one-by-one, not the code of whole application in the beginning.

## Data types

To understant how R works, we should start with the main data types available:

* Elementary: numeric, character, date, boolean. Those are the basic one-element data types, available with the same qualities in every programming language.

* Vector: vectors of elementary variables. Widely used in R, a lot of functions are vector-oriented, meaning that they process vector as a whole, not an element separately.

* Factor: factor is the special case of vector, implemented in R. It's used for character vectors and idea behind is to extract distinct value from vector (so-called `levels`) store character vactor as vector of integers (number of level of this value) and levels. Factors are very suitable for grouping/regrouping both categorical and numerical variables and for usage in modelling.

* Matrix, array: matrix and n-dimensional arrays are the extensions of vector in multiple dimensions.

* Data Frame: usual table of data, where rows are cases and attributes. Analog of table of relative databases. Probably the main variable in R, used in storing, processing, import & export operations.

* List: collection of other variables. Is suitable for grouping related variables or complex objects (e.g. model). Elements of list can be of different type (e.g. data frame, elementary, vector).

## Simple operations

Now that we know the data types, we can look at the simple operations in R. They will be provided with comments so that you can better understand their function:

1. Elementary variables


```r
# Numeric
a <- 5 # or a = 5
a
```

```
## [1] 5
```

```r
class(a) # type - numeric
```

```
## [1] "numeric"
```

```r
# Character
string <- "You are a good strudent"
string
```

```
## [1] "You are a good strudent"
```

```r
class(string)
```

```
## [1] "character"
```

```r
# Boolean
b <- 1 == 2
b
```

```
## [1] FALSE
```

```r
class(b)
```

```
## [1] "logical"
```

```r
# Date
d <- Sys.Date()
d
```

```
## [1] "2016-06-22"
```

```r
class(d)
```

```
## [1] "Date"
```

2. Vector


```r
v <- c(1,2,3,4,5)
v
```

```
## [1] 1 2 3 4 5
```

```r
class(v) # class of elements
```

```
## [1] "numeric"
```

```r
is.vector(v)
```

```
## [1] TRUE
```

```r
v2 <- c(TRUE, FALSE, 5, 10)
v2 # numeric can fit boolean, but boolean cannot fit numeric like 5. Therefore, it will be saved as numeric - maximum of individual complexities.
```

```
## [1]  1  0  5 10
```

```r
class(v2)
```

```
## [1] "numeric"
```

```r
v3 <- c(TRUE, 5, "R")
v3
```

```
## [1] "TRUE" "5"    "R"
```

```r
class(v3) # character "R" has the highest complexity
```

```
## [1] "character"
```

```r
# Subsetting elements from vector
v[1] # first element
```

```
## [1] 1
```

```r
v[-2] # whole vector except element #2
```

```
## [1] 1 3 4 5
```

```r
v[c(1,3,5)] # elements #1,3,5
```

```
## [1] 1 3 5
```

```r
# Sorting vector
sort(v2) # sorted vector
```

```
## [1]  0  1  5 10
```

```r
order(v2) # which order (ascending) have elements in current sequence
```

```
## [1] 2 1 3 4
```

3. Factor


```r
f <- factor(c("M","M","M","F","F","F"))
str(f) # How is stored: levels and numeric vector
```

```
##  Factor w/ 2 levels "F","M": 2 2 2 1 1 1
```

```r
levels(f) # levels of factor
```

```
## [1] "F" "M"
```

```r
as.numeric(f) # numeric vector of factor
```

```
## [1] 2 2 2 1 1 1
```

```r
f
```

```
## [1] M M M F F F
## Levels: F M
```

```r
# Checking data type
class(f)
```

```
## [1] "factor"
```

```r
is.factor(f)
```

```
## [1] TRUE
```

4. Matrix, array


```r
# Matrix
M <- matrix(1:16, nrow = 4, ncol = 4)
M
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    5    9   13
## [2,]    2    6   10   14
## [3,]    3    7   11   15
## [4,]    4    8   12   16
```

```r
# Checking data type
is.vector(M)
```

```
## [1] FALSE
```

```r
is.matrix(M)
```

```
## [1] TRUE
```

```r
is.array(M) # Matrix is subtype of array with 2 dimensions
```

```
## [1] TRUE
```

```r
class(M)
```

```
## [1] "matrix"
```

```r
M[1,3] # Extracting exact element
```

```
## [1] 9
```

```r
# array
A <- array(1:120, dim = 5:2)
A # 4-dimensional array
```

```
## , , 1, 1
## 
##      [,1] [,2] [,3] [,4]
## [1,]    1    6   11   16
## [2,]    2    7   12   17
## [3,]    3    8   13   18
## [4,]    4    9   14   19
## [5,]    5   10   15   20
## 
## , , 2, 1
## 
##      [,1] [,2] [,3] [,4]
## [1,]   21   26   31   36
## [2,]   22   27   32   37
## [3,]   23   28   33   38
## [4,]   24   29   34   39
## [5,]   25   30   35   40
## 
## , , 3, 1
## 
##      [,1] [,2] [,3] [,4]
## [1,]   41   46   51   56
## [2,]   42   47   52   57
## [3,]   43   48   53   58
## [4,]   44   49   54   59
## [5,]   45   50   55   60
## 
## , , 1, 2
## 
##      [,1] [,2] [,3] [,4]
## [1,]   61   66   71   76
## [2,]   62   67   72   77
## [3,]   63   68   73   78
## [4,]   64   69   74   79
## [5,]   65   70   75   80
## 
## , , 2, 2
## 
##      [,1] [,2] [,3] [,4]
## [1,]   81   86   91   96
## [2,]   82   87   92   97
## [3,]   83   88   93   98
## [4,]   84   89   94   99
## [5,]   85   90   95  100
## 
## , , 3, 2
## 
##      [,1] [,2] [,3] [,4]
## [1,]  101  106  111  116
## [2,]  102  107  112  117
## [3,]  103  108  113  118
## [4,]  104  109  114  119
## [5,]  105  110  115  120
```

```r
class(A)
```

```
## [1] "array"
```

```r
is.vector(A)
```

```
## [1] FALSE
```

```r
is.matrix(A)
```

```
## [1] FALSE
```

```r
is.array(A)
```

```
## [1] TRUE
```

```r
dim(A) # size of A (instances in each dimension)
```

```
## [1] 5 4 3 2
```

```r
length(dim(A)) # number of dimensions
```

```
## [1] 4
```

```r
A[2,1,2,1] # Extracting exact element
```

```
## [1] 22
```

5. Data frame


```r
df <- data.frame(size = c(1,4,7,3), price = c(2,6,4,2), type = factor(c("New", "Old", "New", "New")))
df
```

```
##   size price type
## 1    1     2  New
## 2    4     6  Old
## 3    7     4  New
## 4    3     2  New
```

```r
str(df) # structure of data.frame
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ size : num  1 4 7 3
##  $ price: num  2 6 4 2
##  $ type : Factor w/ 2 levels "New","Old": 1 2 1 1
```

```r
# Check data type
class(df)
```

```
## [1] "data.frame"
```

```r
is.matrix(df)
```

```
## [1] FALSE
```

```r
is.data.frame(df)
```

```
## [1] TRUE
```

```r
df$type # Extracting column
```

```
## [1] New Old New New
## Levels: New Old
```

```r
df$type[2] # Extracting exact element
```

```
## [1] Old
## Levels: New Old
```

```r
names(df) # names of columns
```

```
## [1] "size"  "price" "type"
```

6. List


```r
l <- list(f = f, df = df, v2 = v2, b = b)
l
```

```
## $f
## [1] M M M F F F
## Levels: F M
## 
## $df
##   size price type
## 1    1     2  New
## 2    4     6  Old
## 3    7     4  New
## 4    3     2  New
## 
## $v2
## [1]  1  0  5 10
## 
## $b
## [1] FALSE
```

```r
str(l)
```

```
## List of 4
##  $ f : Factor w/ 2 levels "F","M": 2 2 2 1 1 1
##  $ df:'data.frame':	4 obs. of  3 variables:
##   ..$ size : num [1:4] 1 4 7 3
##   ..$ price: num [1:4] 2 6 4 2
##   ..$ type : Factor w/ 2 levels "New","Old": 1 2 1 1
##  $ v2: num [1:4] 1 0 5 10
##  $ b : logi FALSE
```

```r
# Checking data type
class(l)
```

```
## [1] "list"
```

```r
is.list(l)
```

```
## [1] TRUE
```

```r
names(l) # names of elements
```

```
## [1] "f"  "df" "v2" "b"
```

```r
l$f # extracting element of list
```

```
## [1] M M M F F F
## Levels: F M
```

```r
l$df$price # column of element of list
```

```
## [1] 2 6 4 2
```

```r
l[[1]] # first element of list
```

```
## [1] M M M F F F
## Levels: F M
```

## Import

As usual, first step of data processing in R is importing the data. Data can be in various forms and locations, but the most basic one is a text file (usually `*.csv`) on the local hard drive:


```r
dt_total <- read.csv("D:/OneDrive/VSE/II/Economic Demography I/R Tutorial/Data/dt_total.csv")
dt_pyramid <- read.csv("D:/OneDrive/VSE/II/Economic Demography I/R Tutorial/Data/dt_pyramid.csv", header = T, sep = ",", quote = '"', stringsAsFactors = T)

class(dt_total)
```

```
## [1] "data.frame"
```

```r
str(dt_total)
```

```
## 'data.frame':	9744 obs. of  6 variables:
##  $ X         : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Age       : Factor w/ 1 level "TOTAL": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Sex       : Factor w/ 3 levels "F","M","T": 1 1 1 1 1 1 1 1 1 1 ...
##  $ Geo       : Factor w/ 58 levels "AD","AL","AM",..: 1 2 3 4 5 6 7 8 9 31 ...
##  $ Year      : int  2015 2015 2015 2015 2015 2015 2015 2015 2015 2015 ...
##  $ Population: num  NA 1431000 NA 4381296 NA ...
```

```r
head(dt_total, 10)
```

```
##     X   Age Sex Geo Year Population
## 1   1 TOTAL   F  AD 2015         NA
## 2   2 TOTAL   F  AL 2015    1431000
## 3   3 TOTAL   F  AM 2015         NA
## 4   4 TOTAL   F  AT 2015    4381296
## 5   5 TOTAL   F  AZ 2015         NA
## 6   6 TOTAL   F  BA 2015         NA
## 7   7 TOTAL   F  BE 2015    5722178
## 8   8 TOTAL   F  BG 2015    3700183
## 9   9 TOTAL   F  BY 2015         NA
## 10 10 TOTAL   F  CH 2015    4163786
```

Also, you may face the problem to upload data in some specific format: matlab, fortran, JSON, Excel sheet, ODBC, etc. For these cases exist special libraries, which you can find [here](http://cran.r-project.org/web/packages/available_packages_by_name.html).

## Chain operator

One of very useful operators in R, which I use quite ofter, is element `%>%`. It is called chaining operator and is a part of *dplyr* package. This operator is handing element on the left to the function on the right as the first argument. It helps to make complicated nested formulas easier to comprehend:


```r
# Simple example
    filter(dataset, field == "value") 
        # is equal to
    dataset %>% filter(field == "value")

# More complex example
    summarize(group_by(filter(dataset, field == "value"), group_field), function(value_field))
        # is equal to
    dataset %>% filter(field == "value") %>% group_by(group_field) %>% summarize(function(value_field))
```

As you can see from the second example, chaining operator makes your code much more easier to read. That's why it's used throughout the paper.

# Data transformation

After mastering the basics, you should switch to serious step: data transformation and analysis. This section will review main points on how to work with data in R.

## Binding

Binding is the simplest way how to unite few datasets, add a row, etc.:

```r
rbind(c(1,2,3,4), c(10,9,8,7)) # binding 2 rows
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    3    4
## [2,]   10    9    8    7
```

```r
cbind(c(1,2,3,4), c(2,4,1,1)) # binding 2 columns
```

```
##      [,1] [,2]
## [1,]    1    2
## [2,]    2    4
## [3,]    3    1
## [4,]    4    1
```

## dplyr

*dplyr* is a special package (one of few), dedicated to data transformation. Operatios, available in dplyr can be compared with SQL: select, group_by, etc.:


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
dt_total %>% filter(Geo == "DE_TOT" & Year == 2013) # Filtering
```

```
##     X   Age Sex    Geo Year Population
## 1 362 TOTAL   F DE_TOT 2013   41673725
## 2 420 TOTAL   M DE_TOT 2013   40346853
## 3 478 TOTAL   T DE_TOT 2013   82020578
```

```r
dt_total %>% group_by(Year) %>% summarize(Total_Population = sum(Population, na.rm = T)) %>% head() # Grouping
```

```
## Source: local data frame [6 x 2]
## 
##    Year Total_Population
##   (int)            (dbl)
## 1  1960       2877397993
## 2  1961        970707037
## 3  1962        961960168
## 4  1963        973081739
## 5  1964        982880840
## 6  1965       3014277242
```

```r
dt_total %>% mutate(Pop_mln = Population/10^6) %>% head() # Changing columns
```

```
##   X   Age Sex Geo Year Population  Pop_mln
## 1 1 TOTAL   F  AD 2015         NA       NA
## 2 2 TOTAL   F  AL 2015    1431000 1.431000
## 3 3 TOTAL   F  AM 2015         NA       NA
## 4 4 TOTAL   F  AT 2015    4381296 4.381296
## 5 5 TOTAL   F  AZ 2015         NA       NA
## 6 6 TOTAL   F  BA 2015         NA       NA
```

## Merging

Merging is another analogy from the SQL and it corresponds to JOIN (INNER, LEFT) command:


```r
df
```

```
##   size price type
## 1    1     2  New
## 2    4     6  Old
## 3    7     4  New
## 4    3     2  New
```

```r
sizes <- data.frame(size = c(1, 4, 7, 10),  description = c("small", "medium", "big", "huge"))
sizes
```

```
##   size description
## 1    1       small
## 2    4      medium
## 3    7         big
## 4   10        huge
```

```r
# Merge df and sizes to add column description to the df
merge(df, sizes, by = "size") # INNER JOIN
```

```
##   size price type description
## 1    1     2  New       small
## 2    4     6  Old      medium
## 3    7     4  New         big
```

```r
merge(df, sizes, by = "size", all = T) # FULL JOIN
```

```
##   size price type description
## 1    1     2  New       small
## 2    3     2  New        <NA>
## 3    4     6  Old      medium
## 4    7     4  New         big
## 5   10    NA <NA>        huge
```

```r
merge(df, sizes, by = "size", all.x = T) # LEFT JOIN
```

```
##   size price type description
## 1    1     2  New       small
## 2    3     2  New        <NA>
## 3    4     6  Old      medium
## 4    7     4  New         big
```

```r
merge(df, sizes, by = "size", all.y = T) # RIGHT JOIN
```

```
##   size price type description
## 1    1     2  New       small
## 2    4     6  Old      medium
## 3    7     4  New         big
## 4   10    NA <NA>        huge
```

Merge is quite important during various transformations of data. For example, to calculate age distribution of population:

```r
tmp_age <- dt_pyramid %>% filter(Year >= 2010 & Geo == "CZ") %>% 
  mutate(Population = F + M) %>% select(Age, Year,Population) %>%
  filter(!is.na(Population))
tmp_age %>% head()
```

```
##   Age Year Population
## 1   0 2010     119687
## 2   0 2011     119110
## 3   0 2012     108753
## 4   0 2013     108692
## 5   0 2014     106829
## 6   0 2015     109943
```

```r
total_population <- tmp_age %>% group_by(Year) %>% summarize(Total = sum(Population, na.rm = T))
total_population %>% head()
```

```
## Source: local data frame [6 x 2]
## 
##    Year    Total
##   (int)    (dbl)
## 1  2010 10462088
## 2  2011 10486731
## 3  2012 10505445
## 4  2013 10516125
## 5  2014 10512419
## 6  2015 10538275
```

```r
merge(tmp_age, total_population, by = "Year") %>% mutate(Share = Population/Total) %>% 
  arrange(Year, Age) %>% head()
```

```
##   Year Age Population    Total       Share
## 1 2010   0     119687 10462088 0.011440068
## 2 2010   1     121706 10462088 0.011633051
## 3 2010   2     117283 10462088 0.011210286
## 4 2010   3     108146 10462088 0.010336942
## 5 2010   4     102788 10462088 0.009824807
## 6 2010   5      98005 10462088 0.009367633
```

## Reproducibility

Advantage of R against, for instance, Excel is that user has to describe all hist actions with data in code and this code can be run on the other continent and still has same results in case of same imputs. This is reproducibility.

Reproducibility is very important for scientific data analyses and reseatch papers because it allows your opponent to make sure that your calculations are correct. Otherwise, credibility of your paper/research will fall immediately.

To gain reproducibility, you have to follow few main steps:

1. Do all data transformation in R. In case you do some quick and obvious data cleaning in Excel, it won't be in R code and you R code would yield different results from raw input data. Ideally, you shouldn't even download the file manually, but use direct links to the data sources in your R code.

2. Set seed: this is a randomizator setting. Setting seed will ensure you receive identically same results of random generation during the next run. Let's see it on the example:


```r
set.seed(1234)
r1 <- rnorm(10)
r2 <- rnorm(10)

set.seed(1235)
r3 <- rnorm(10)

set.seed(1234)
r4 <- rnorm(10)

cbind(r1, r2, r3, r4) # You can easily see that columns #1 and #4 appear similar
```

```
##               r1          r2          r3         r4
##  [1,] -1.2070657 -0.47719270 -0.69798794 -1.2070657
##  [2,]  0.2774292 -0.99838644 -1.28485386  0.2774292
##  [3,]  1.0844412 -0.77625389  0.98995901  1.0844412
##  [4,] -2.3456977  0.06445882  0.11177583 -2.3456977
##  [5,]  0.4291247  0.95949406  0.11420767  0.4291247
##  [6,]  0.5060559 -0.11028549  1.69819652  0.5060559
##  [7,] -0.5747400 -0.51100951  0.04784562 -0.5747400
##  [8,] -0.5466319 -0.91119542  0.65486241 -0.5466319
##  [9,] -0.5644520 -0.83717168  1.36528367 -0.5644520
## [10,] -0.8900378  2.41583518  0.40257296 -0.8900378
```

```r
# Detailed check
r1 == r4 # this means that columns are the same
```

```
##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

```r
r1 == r3 # all pairs of values are different
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
r1 == r2 # different
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
all.equal(r1, r4) # another way to check
```

```
## [1] TRUE
```

## Functions

Next important step for user in R is to create his/her own functions. Functions are easy and they allow to make your code more efficient and ogranized by coding into functions repeating chunks of code.

One of good examples of function would be to calculate some index. Let's take as an example index of masculinity:


```r
Masculinity_elementary <- function(M, F) M/F # Very easy form of function

Masculinity_elementary(100, 103) # Easy
```

```
## [1] 0.9708738
```

```r
Masculinity_elementary(c(100, 89, 103), c(103, 180, 50)) 
```

```
## [1] 0.9708738 0.4944444 2.0600000
```

As we see, if we apply it on the vectors, it will be calculated on each pair of `M` and `F` separately and output will be vector. Let's build another function that will calculated total index of masculinity for vector input:


```r
Masculinity_vector <- function(M, F) sum(M)/sum(F)

Masculinity_vector(100, 103) # Still works nice
```

```
## [1] 0.9708738
```

```r
Masculinity_vector(c(100, 89, 103), c(103, 180, 50)) # Now it works
```

```
## [1] 0.8768769
```

Now it works fine with both vectors and elementary values. What about situation when you have dataframe with 2 columns: Sex and Population. In this case you would have to split it somehow before applying our function. Also, you can use your previously created functions in the new ones:


```r
df <- data.frame(Sex = factor(c("M","M","M","F","F","F")), Population = c(100, 89, 103, 103, 180, 50))
df
```

```
##   Sex Population
## 1   M        100
## 2   M         89
## 3   M        103
## 4   F        103
## 5   F        180
## 6   F         50
```

```r
Masculinity_dataframe <- function(data) Masculinity_vector(df$Population[df$Sex == "M"], df$Population[df$Sex == "F"])

Masculinity_dataframe(df)
```

```
## [1] 0.8768769
```

## Apply

There is so-called `apply` family of functions in R. Their point is to take some iterable object (e.g. vector, matrix, list, dataframe) and apply some function on each separated element (can be non-elementary element, e.g. vector). There are following functions in the family:

1. sapply: target is vector, applying function for each element of vector

2. lapply: target is list, applying function for each element of vector

3. apply: target is array (matrix, dataframe), applying for each cut (row or column)

4. mapply: targets are vectors, which are the arguments of one function

Let's see them in action:

```r
# sapply
v
```

```
## [1] 1 2 3 4 5
```

```r
sapply(v, sqrt) # Take square root of each element
```

```
## [1] 1.000000 1.414214 1.732051 2.000000 2.236068
```

```r
sqrt(v) # Luckily, function `sqrt` is adapted for usage on vectors
```

```
## [1] 1.000000 1.414214 1.732051 2.000000 2.236068
```

```r
# lapply
str(l)
```

```
## List of 4
##  $ f : Factor w/ 2 levels "F","M": 2 2 2 1 1 1
##  $ df:'data.frame':	4 obs. of  3 variables:
##   ..$ size : num [1:4] 1 4 7 3
##   ..$ price: num [1:4] 2 6 4 2
##   ..$ type : Factor w/ 2 levels "New","Old": 1 2 1 1
##  $ v2: num [1:4] 1 0 5 10
##  $ b : logi FALSE
```

```r
lapply(l, class) # type of each object in the list
```

```
## $f
## [1] "factor"
## 
## $df
## [1] "data.frame"
## 
## $v2
## [1] "numeric"
## 
## $b
## [1] "logical"
```

```r
lapply(l, dim) # dimensions of each element of the list
```

```
## $f
## NULL
## 
## $df
## [1] 4 3
## 
## $v2
## NULL
## 
## $b
## NULL
```

```r
lapply(l, names) # names of columns of elements of the list
```

```
## $f
## NULL
## 
## $df
## [1] "size"  "price" "type" 
## 
## $v2
## NULL
## 
## $b
## NULL
```

```r
# apply
M
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    5    9   13
## [2,]    2    6   10   14
## [3,]    3    7   11   15
## [4,]    4    8   12   16
```

```r
apply(M, MARGIN = 1, mean) # means of custs by 1-st dimensions (average of each row)
```

```
## [1]  7  8  9 10
```

```r
rowMeans(M) # same as our `apply` formula
```

```
## [1]  7  8  9 10
```

```r
apply(M, MARGIN = 2, mean) # means by 2nd dimension (average of each column)
```

```
## [1]  2.5  6.5 10.5 14.5
```

```r
colMeans(M) # same
```

```
## [1]  2.5  6.5 10.5 14.5
```

```r
# mapply
mapply(FUN = function(x,y) x*y, x = 1:4, y = 2:-1) # mutliplying corresponding elements: 1*2, 2*1, 3*0, 4*(-1)
```

```
## [1]  2  2  0 -4
```


# Data visualization

## Base

After data analysis and transformation comes data visualization to really see what your numbers are. The most elementary graphics is provided in the package `base`, but it's not very flexible and estetic. It's super-easy and intuitive, but it won't satisfy you for long:


```r
set.seed(20)
x <- rnorm(10)
y <- runif(10)

plot(x, y, main = "Simple plot")
```

![](index_files/figure-html/base_graphics-1.png)<!-- -->

```r
plot(x, y, type = "b", main = "Plot with both lines and point")
abline(h = .5, col = "red")
abline(v = 0, col = "red")
```

![](index_files/figure-html/base_graphics-2.png)<!-- -->

R has 2 advanced widely used graphic libraries: `ggplot2` and `lattice`. My personal favourite is `ggplot2`, so we'll look in more detail at it in the following section.

## ggplot2

Library `ggplot2` was created based on book 'Grammar of Graphics' and is supposed to make your chart building like creating a sentence. It's very powerful and flexible, but sometimes not easy to find solution on your own. Luckily, internet is full of documentation, tutorials and examples of ggplot and, from my own experience, you can always find an answer to your question.

So let's start with examples of ggplot's possibilities:


```r
library(ggplot2)
df <- data.frame(size = sample(1:10, 20, T), price = runif(20, min = 2, max = 15), type = factor(sample(c("New","Old"), 20, T)))
df
```

```
##    size     price type
## 1     4  2.916525  New
## 2     5  8.297699  New
## 3     9  5.581946  New
## 4     2 14.387417  Old
## 5     6  3.634786  Old
## 6     5  8.637587  New
## 7     5  2.086692  Old
## 8    10  7.985130  New
## 9     7  5.507011  Old
## 10    3  2.289286  New
## 11    6  7.386842  New
## 12    1  3.401431  Old
## 13    5 14.273287  New
## 14    5  2.628523  Old
## 15    8 14.222119  Old
## 16    5  2.515293  New
## 17    7 13.260164  New
## 18    8  9.667367  Old
## 19    5  3.771198  New
## 20    7  9.453297  New
```

```r
ggplot(data = df, mapping = aes(x = size, y = price)) + geom_point() + 
  ggtitle("Simple basic graph")
```

![](index_files/figure-html/ggplot2-1.png)<!-- -->

As you can see, simple basic graph looks much better in `ggplot2`. Let's assume we need more details on the graph:


```r
# Adding 'type' on the plot
df %>% ggplot(aes(x = size, y = price, color = type)) + geom_point() # differentiation by type
```

![](index_files/figure-html/ggplot2_2-1.png)<!-- -->

```r
df %>% ggplot(aes(x = size, y = price)) + geom_point() + facet_wrap(~type)  # differentiation by type | version 2
```

![](index_files/figure-html/ggplot2_2-2.png)<!-- -->

```r
# Quick fitting of prediction models
df %>% ggplot(aes(x = size, y = price)) + geom_point() +
  stat_smooth(method = "lm") + ggtitle("Linear regression fit with confidence interval")
```

![](index_files/figure-html/ggplot2_2-3.png)<!-- -->

```r
df %>% ggplot(aes(x = size, y = price)) + geom_point() +
  stat_smooth(method = "loess", se = F) + ggtitle("Loess fit")
```

![](index_files/figure-html/ggplot2_2-4.png)<!-- -->

```r
df %>% ggplot(aes(x = size, y = price, color = type)) + geom_point() +
  stat_smooth(method = "lm", se = F) + 
ggtitle("Linear regression fit\ndifferentiation by type")
```

![](index_files/figure-html/ggplot2_2-5.png)<!-- -->

You can see how quickly and nicely we can graphically fit different models or create mutliple graphs. Further, let's look what other could be done in ggplot with examples on real demographic data:


```r
# Adding generation columns to the dataset
dt_pyramid <- dt_pyramid %>% 
  mutate(Gen_bio = cut(Age, include.lowest = T, breaks = c(0, 15, 50, 100), right = F),
         Gen_eco = cut(Age, include.lowest = T, breaks = c(0, 20, 65, 100), right = F))
```

```
## Warning in if (right) "(" else "[": the condition has length > 1 and only
## the first element will be used
```

```
## Warning in if (right) "]" else ")": the condition has length > 1 and only
## the first element will be used
```

```
## Warning in if (right) substr(labels[1L], 1L, 1L) <- "[" else
## substring(labels[nb - : the condition has length > 1 and only the first
## element will be used
```

```
## Warning in if (right) "(" else "[": the condition has length > 1 and only
## the first element will be used
```

```
## Warning in if (right) "]" else ")": the condition has length > 1 and only
## the first element will be used
```

```
## Warning in if (right) substr(labels[1L], 1L, 1L) <- "[" else
## substring(labels[nb - : the condition has length > 1 and only the first
## element will be used
```

```r
tmp <- dt_pyramid %>% filter(Geo %in% c("CZ", "ES") & between(Year, 2000, 2010)) %>% 
  group_by(Gen_eco, Year, Geo) %>% summarize(Population = sum(F+M))
g <- tmp %>% group_by(Year, Geo) %>% summarize(Tot = sum(Population)) %>% merge(tmp) %>%
         mutate(Share = Population/Tot * 100) %>% arrange(Gen_eco) %>%
         ggplot(aes(x = Year, y = Share, color = Gen_eco, fill = Gen_eco)) + geom_area() +
         facet_wrap(~Geo) + ggtitle("Comparison of countries by economical generations")
g
```

![](index_files/figure-html/ggplot_dem-1.png)<!-- -->

Our example is quite complex because it's, also, calculating distribution of population by economical generations in Czech Republic and Spain for period of 2000-2010. Further examples of `ggplot2` in Economic Demography will the in section 'Demography in R'.

## Interactive charts

Interactive plots are so much nicer and more interesting for us because we can find out more from them. R has few libraries for interactive plotting and the idea behind is that those plots are based on JavaScript and can be used in HTML reports and presentation. Let's have a quick look at each of the plotting libraries:

1. googleVis


```r
library(googleVis)
```

```
## 
## Welcome to googleVis version 0.5.10
## 
## Please read the Google API Terms of Use
## before you start using the package:
## https://developers.google.com/terms/
## 
## Note, the plot method of googleVis will by default use
## the standard browser to display its output.
## 
## See the googleVis package vignettes for more details,
## or visit http://github.com/mages/googleVis.
## 
## To suppress this message use:
## suppressPackageStartupMessages(library(googleVis))
```

```r
# Preparation of data: different ratios
library(reshape2) # for some data manipulation
Ratios <- dt_pyramid %>% 
       filter(Geo %in% c("CZ","ES","NO","SE","DE_TOT") & between(Year, 2000, 2010)) %>%
       group_by(Year, Geo) %>% summarize(Masculinity = sum(M)/sum(F))
     
     Ratios <- dt_pyramid %>% mutate(Tot = M + F) %>% group_by(Year, Geo, Gen_bio) %>% 
       summarize(Tot = sum(Tot)) %>% 
       dcast(Year + Geo ~ Gen_bio, value.var = "Tot", fun.aggregate = sum, na.rm = T) %>%
       setNames(c("Year", "Geo", "I", "II", "III")) %>% mutate(Sauvy = III/I) %>%
       select(Year, Geo, Sauvy) %>% merge(Ratios)
     
     Ratios <- dt_pyramid %>% mutate(Tot = M + F) %>% group_by(Year, Geo, Gen_eco) %>% 
       summarize(Tot = sum(Tot)) %>% 
       dcast(Year + Geo ~ Gen_eco, value.var = "Tot", fun.aggregate = sum, na.rm = T) %>%
       setNames(c("Year", "Geo", "I", "II", "III")) %>% 
       mutate(TDR = (I+III)/II, OADR = III/II, JADR = I/II, Seniority = III/I) %>% 
       select(-I,-II,-III) %>% merge(Ratios)

head(Ratios)
```

```
##   Year    Geo       TDR      OADR      JADR Seniority    Sauvy Masculinity
## 1 2000     CZ 0.5926929 0.2197452 0.3729477 0.5892119 1.922285   0.9477028
## 2 2000 DE_TOT 0.6021861 0.2603491 0.3418370 0.7616179 2.242479   0.9528929
## 3 2000     ES 0.6208032 0.2713746 0.3494286 0.7766238 2.197109   0.9590972
## 4 2000     NO 0.6993885 0.2591800 0.4402085 0.5887664 1.571069   0.9804467
## 5 2000     SE 0.7092224 0.2956045 0.4136179 0.7146801 1.935546   0.9774195
## 6 2001     CZ 0.5805136 0.2178981 0.3626155 0.6009066 2.002396   0.9490812
```


```r
M <- gvisMotionChart(Ratios, idvar = "Geo", timevar = "Year", options = list(width = 550, height = 450))
#print(M, 'chart')
plot(M)
```

```
## starting httpd help server ...
```

```
##  done
```

2. rCharts


```r
library(rCharts)
```

# Demography in R
## Pyramid

First need of specific packages for demography comes with plotting the pyramid chart. There is a special package called `pyramid` for that kind of a plot. Here's how it can be applied:


```r
# Special package
library(pyramid)
dt_pyramid %>% filter(Geo == "CZ" & Year == 2000) %>% select(M, F, Age) %>%
  pyramid(Csize = 1, Cstep = 5, AxisFM = 'd', Cgap = .1, Laxis = 0:4*25000,
          main = "Pyramid of Czech population in 2000")
```

![](index_files/figure-html/pyramid-1.png)<!-- -->

```r
# Usual ggplot
library(scales) # library for numeric formatting
tmp_pyr <- dt_pyramid %>% filter(Geo %in% c("CZ","BE") & Year %in% c(2000, 2010)) %>%
  select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
  mutate(Sex = variable, Population = value)
ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
  geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
  geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
  scale_y_continuous(labels = function(x) comma(abs(x))) + 
  coord_flip() + ggtitle("Pyramid graphs of selected years and countries") +
  scale_fill_brewer(palette = "Set1") +
  facet_grid(Geo ~ Year) + theme_bw()
```

```
## Warning: Stacking not well defined when ymin != 0
```

![](index_files/figure-html/pyramid-2.png)<!-- -->

```r
# ggplot with 5-year grouping
tmp_pyr <- dt_pyramid %>% filter(Geo %in% c("CZ","BE") & Year %in% c(2000, 2010)) %>%
  select(-X, -Gen_bio, -Gen_eco) %>% melt(id = c("Age", "Geo", "Year")) %>%
  mutate(Sex = variable, Population = value, Age = Age - Age %% 5) %>% group_by(Age, Geo, Year, Sex) %>% summarize(Population = sum(Population))
ggplot(data = tmp_pyr, aes(x = Age, y = Population, fill = Sex)) + 
  geom_bar(data = subset(tmp_pyr, Sex == "F"), stat = "identity") + 
  geom_bar(data = subset(tmp_pyr, Sex == "M"), aes(y=-Population), stat = "identity") + 
  scale_y_continuous(labels = function(x) comma(abs(x))) + 
  coord_flip() + ggtitle("Pyramid graphs of selected years and countries\n5-year grouping") +
  scale_fill_brewer(palette = "Set1") +
  facet_grid(Geo ~ Year) + theme_bw()
```

```
## Warning: Stacking not well defined when ymin != 0
```

![](index_files/figure-html/pyramid-3.png)<!-- -->

As you can see, special package `pyramid` makes it easy and comfortable to build 1 pyramid. On the other hand, `ggplot2` solution is more complex, but at the same time more powerful, providing possibility to easily compare numerous years and/or countries.

## Indeces
## Life tables
## Projections

# Presentation of results

Of course, any good analysis or research should end with some conclusion, supported by numbers. This conclusion and final numbers has to be readable and easy to digest for user. R has available some main methods of presenting the results (presentation slides and report), but it also has few quite unusual ones: ShinyApp, yhat. In this section we will briefly go through all the the mentioned.

## Report

The document you are currently reading is R report, made in the form of `RMarkdown`. This markdown combines pure R code with formatted text, allowing easy presentation of the results in the form of a report. Formatting of the main text is performed the same way as for the usual markdown documents (`*.md`). The main advantages of rmarkdown reports are:

* Reproducibility: during each generation of the report from markdown code, all chunks of R code are executed, therefore, someone can reproduce and verify your research using rmarkdown code. Also, if you change some code in your analysis, your calculations and final results (including graphs) will be immediately recalculated.

* Fast preparation: rmarkdown report is much faster to prepare in case you are using a lot of graphs and numbers, tables. Exporting tables and figures will take a lot of time, which can be saved by using R report.

* Easy to understand: writing R scripts with comments is good, but if you really need to quickly dive into the problem and understand it from A to Z, R scripts will not do it. With report you see the whole flow of your analysis in one place (text, code and graphs).

* Interactive: you can make you report interact with the user and show different results (numbers, tables, charts). Basically, you can integrate shinyapp inside your report. This feature is available only for html reports. 

* Multiple formats: report can be saved in html, doc or pdf format. Moreover, it can utilize formatting of languages such as LaTeX.

* Easy to share: report can be published in the matter of minutes on RPubs or GitHub.

* Customizable: HTML version of report can be easily customized by using existing themes or your own `css`.

## Presentation

R presentation slides are just a specialized type of usual report.It is made in `rmarkdown` as well, which is conventional: your presentation can be just brief of your report in terms of not only content behind, but, also, r code and formatting. 

Presentations are developed in HTML format and, similarly to reports, can have interactive elements: from quizes to interactive charts.

Regarding the main advantages, they are the same as for the report. As in the case of usual (PowerPoint) presentation, you can add effects and animations to the slides.



## ShinyApp

ShinyApp is unusual way of sharing the R results. It is full website (web application), which interacts with the user by taking his inputs, processing them with R code and then providing the results back to the user on the website. The service is provided by RStudio (most popular IDE for R). 

Special example of ShinyApp for Economic Demography is located [here](https://azhubryd.shinyapps.io/Economic_Demography/) and source code is [here](https://github.com/zubrand/R-Tutorial/Shiny/). This plot is processing some population data from Eurostat and returning basic analyses and figures. User can change the list of analyses, countries and time period and receive results for what he/she selected.

## Yhat

Another quite similar thing is called `yhat`, provided on [this website](http://yhathq.com). It allows you to give your code API: your code receives some input data, processes it and returns some output. The point is that you can used it from other products and programming languages without connection to R (you won't need to adapt your code or migrate it to other language). `yhat` receives input data in the JSON format and sends you back output in JSON format.

## Git

`Git` concept is widely used for programmers to keep track of code. This is especially valuable when working in teams. So same applies to researchers, data scientists: they work with code, they work in teams. Therefore, `git` is useful for them as well.

Git is used not only to develop or solve something, but to share results, knowledge. Quite often there are specified tools to better visualize your research immediately on git provider's website. For example, GitHub provides an option of so called github-pages, where you can integrate you html presentation or report. 

[Here](https://github.com/zubrand/R-Tutorial) is an example of specialized git repository for this tutorial. You can see the list of files and forlders, explore and download them, but the files aren't immediately visualized (e.g. html report is opened as a source code). To 'beautify' git, github-pages were applied and on [this link](https://zubrand.github.io/R-Tutorial/) you can explore the `index.html` file from the git repository mentioned above.

Now you know how to prepare and share your results in R.
