---
title       : R Basics II
subtitle    : A Data Workshop presented by Data Community DC
author      : Abhijit Dasgupta
job         : Data Community DC
github:
  user: araastat
  repo : RBasic2
  branch: "gh-pages"
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme : solarized-light
widgets     : [mathjax, bootstrap]      # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
logo : Rlogo-1.png
license : by-nc-nd
--- 
## About me

+ PhD biostatistician with over 10 years bioinformatics experience
+ Data Science / Data Engineering consultant
  + NIH, local startups, Brown University
+ 20 years experience in R, S+
+ Organizer of Statistical Programming DC meetup
+ Board member of Data Community DC



<!-- html table generated in R 3.0.1 by xtable 1.7-1 package -->
<!-- Sat Oct 19 13:05:40 2013 -->
<TABLE border=0>
  <TR> <TD> E-mail </TD> <TD> abhijit@datacommunitydc.org </TD> </TR>
  <TR> <TD> Twitter </TD> <TD> @webbedfeet </TD> </TR>
   </TABLE>



---

## Assumptions

> + You have R installed
> + You know some basics of R 
    + Creating variables
    + Creating basic graphs
    + Running some analyses
> + You may or may not have programming experience
> + You love playing with data

--- 
## Objective

### To get you started using R for a data analysis workflow

![](Workflow.svg)

--- 
## Objective

### To get you started using R for a data analysis workflow

![](Workflow2.svg)

---
## Expectations

### What to expect
+ Overview of R and how to get started with analytics using R
+ Hands-on examples
+ A launching pad for your adoption and use of R

### What <u>not</u> to expect
+ A comprehensive, all-encompassing description of R
+ Covering everything R can do

--- 
## The way forward from here
### Use R for as many projects as possible
### Work through the "steep" learning curve
### Use available resources both within R and online

---.segue .dark
## Background

---
## Some background knowledge

+ R as a calculator
+ Ingesting data
  + `read.table`, `read.csv`
+ Types of data
  + numeric, integer, character, Date
  + vector, matrix, array, list, **data.frame**
+ Base graphics
  + plot, points, lines
  + xlab, ylab
  + par (col, cex, ...)
  + mfrow

---
## Some background knowledge

+ Export graphs
  + png, svg, pdf, jpeg
+ Some statistics
  + `mean`, `median`, `summary`
  + `t.test`, `wilcox.text`, `lm`

---

## Where are we?

+ The first thing you want to do is contain all your project-related scripts in a folder
+ All the R data files will be in this folder

```r
getwd() # What is the current working directory?
setwd() # Set the working directory
```

### What's here?

```r
dir()       # shows files in current directory
file.path() # creates a file path string
ls()        # Shows objects in the current session
```
<div style="background-color:lightgrey;">
<p>
RStudio allows you to create "Projects" which hold everything nicely
together along with Git functionality, if desired</p>
</div>

---
## Banging head on wall???

### Within R

+ `help` or `?`
  + `help(data.frame)` or `?data.frame`

### Online
+ Stack Overflow: r tag
+ Twitter: #rstats
+ R-Bloggers.com

---

## Some tips on R coding

+ The R Style Guide by Google
+ Comment character `#` can be placed at the beginning or at the right of code
+ Statements are ended with return or semicolon (;)
+ Names in R are quite liberal but it is recommended that you use common naming conventions
  + First character letter, followed by letters, digits, underscores or periods
  + Note that the period has some special meaning and is used often in R naming to separate object names (e.g. customer.name)
  + It is recommended that variable names use underscores instead of dots especially when combining with databases


---

## Launching pad

We will take off from here:

+ More functionality of R
+ Introduction to the R package ecosystem
+ "Best" practices (or rather, my practices)
+ Tips and Tricks
+ Resources

--- .quote .nobackground .segue .dark

<q> The question is not if R can do it, but how</q>
<p style="text-align:right;"> -- Douglas Bates </p>

--- .segue .dark
## ETL (Extract, Transform, Load)

--- .segue .dark
## Extract

---

## Reading data into R

The workhorse for reading _tabular_ data is `read.table`

```r
args(read.table)
```

```
## function (file, header = FALSE, sep = "", quote = "\"'", dec = ".", 
##     row.names, col.names, as.is = !stringsAsFactors, na.strings = "NA", 
##     colClasses = NA, nrows = -1, skip = 0, check.names = TRUE, 
##     fill = !blank.lines.skip, strip.white = FALSE, blank.lines.skip = TRUE, 
##     comment.char = "#", allowEscapes = FALSE, flush = FALSE, 
##     stringsAsFactors = default.stringsAsFactors(), fileEncoding = "", 
##     encoding = "unknown", text) 
## NULL
```


### Too much information!!!

You can find explanations for all the arguments by using `?read.table`

*** pnotes

This is an example of a `function` in R. Functions have _arguments_, and you
can set default values for several of the arguments

The help system can be accessed using `?read.table` or `help(read.table)`

---

## Reading data into R


```r
BP <- read.table("data/bpdata.csv", header = T, sep = ",")
head(BP)
```

```
##   X X.1    sex sbp dbp snp1 snp2 snp3 snp4 snp5 snp6 snp7 snp8 snp9 snp10
## 1 1   1 FEMALE 171  89   CC   TT   TT   TT   CC   GG   AA   TT   TT    CC
## 2 2   2   MALE 160  99   TT   TT   CC <NA>   CC   AG   AT   CC   CT    CC
## 3 3   3 FEMALE 142  83   CT   TT   TC   CT   CC   AG   TT   CC   TT    CT
## 4 4   4   MALE 126  71   CT   TT   CC <NA>   CC   AA   TT   CC   TT    CT
## 5 5   5 FEMALE 126  82   CT   TT   CC   CC   CC   AA   TT   CC   TT    CT
## 6 6   6 FEMALE 132  89   CT   TT   CC   CC   CC <NA>   TT   CC   TT    TT
##   snp11 bmi
## 1    TT  25
## 2    CT  35
## 3    TT  34
## 4    CT  32
## 5    CT  34
## 6    CT  25
```


---
## Reading data into R


```r
BP <- read.table("data/bpdata.csv", header = T, sep = ",")
head(BP)
```



```r
BP <- read.csv("data/bpdata.csv")
```


These functions are for tabular data stored in text files (even on the web!)

Let's get monthly S&P data between April 1, 1999 and April 1, 2009


```r
sp500 <- read.csv(paste("http://ichart.finance.yahoo.com/table.csv?s=%5EGSPC&a=03&b=1&c=1999&d=03&e=1&f=2009&g=m&ignore=.csv"))
head(sp500, n = 3)
```

```
##         Date  Open  High   Low Close    Volume Adj.Close
## 1 2009-04-01 793.6 813.6 783.3 811.1 1.207e+10     811.1
## 2 2009-03-02 729.6 833.0 666.8 797.9 7.633e+09     797.9
## 3 2009-02-02 823.1 875.0 734.5 735.1 7.022e+09     735.1
```


---
## Reading from databases


```r
library(RODBC)  # Calling a package names RODBC
con <- odbcConnect("MCT4")
sqlTables(con)
```

```
##   TABLE_CAT TABLE_SCHEM TABLE_NAME TABLE_TYPE REMARKS
## 1      <NA>        <NA>     Sheet1      TABLE    <NA>
```

```r
dat <- sqlFetch(con, "Sheet1")
head(dat[, 1:4])
```

```
##   patid         Spec No  Age             Race
## 1    NA            <NA> <NA>             <NA>
## 2     1        s03-6643   62 african american
## 3     2       S98-16845   70            white
## 4     3 S00-10987 re-ex   43 african american
## 5    NA     S00-07663 p   43 african american
## 6     4       S99-22161   54            white
```

```r
odbcClose(con)
```


---
## Reading from databases

On Windows, you can directly read from Excel files (often the quickest, most accurate method)

```r
library(RODBC)
con <- odbcConnectExcel(xls.file="C:/folder/data/myfile.xls")
dat1 <- sqlFetch(con, 'Sheet1')
odbcClose(con)
```

You can also connect to MySQL (`RMySQL`), SQLite (`RSQLite`), PostgreSQL (`RPostgreSQL`)

Connections are also now available to Oracle, SAP, Teradata (use `Google`)

> `RMySQL` under Windows is not straightforward. Use the advice available 
  [here](http://stackoverflow.com/questions/9441527/rmysql-windows-7-home-installation-error)

---
## Reading irregular or messy data

How often is your data _nice_?

You can read most data files using the function `readLines`.

```r
BP <- readLines("data/bpdata.csv")
head(BP)
```

```
## [1] "\"\",\"X\",\"sex\",\"sbp\",\"dbp\",\"snp1\",\"snp2\",\"snp3\",\"snp4\",\"snp5\",\"snp6\",\"snp7\",\"snp8\",\"snp9\",\"snp10\",\"snp11\",\"bmi\""
## [2] "\"1\",1,\"FEMALE\",171,89,\"CC\",\"TT\",\"TT\",\"TT\",\"CC\",\"GG\",\"AA\",\"TT\",\"TT\",\"CC\",\"TT\",25"                                      
## [3] "\"2\",2,\"MALE\",160,99,\"TT\",\"TT\",\"CC\",NA,\"CC\",\"AG\",\"AT\",\"CC\",\"CT\",\"CC\",\"CT\",35"                                            
## [4] "\"3\",3,\"FEMALE\",142,83,\"CT\",\"TT\",\"TC\",\"CT\",\"CC\",\"AG\",\"TT\",\"CC\",\"TT\",\"CT\",\"TT\",34"                                      
## [5] "\"4\",4,\"MALE\",126,71,\"CT\",\"TT\",\"CC\",NA,\"CC\",\"AA\",\"TT\",\"CC\",\"TT\",\"CT\",\"CT\",32"                                            
## [6] "\"5\",5,\"FEMALE\",126,82,\"CT\",\"TT\",\"CC\",\"CC\",\"CC\",\"AA\",\"TT\",\"CC\",\"TT\",\"CT\",\"CT\",34"
```


---
## The `data.frame` object

+ The `data.frame` is the workhorse of R
+ A `data.frame` is essentially a list of vectors of the same length
  + Each vector may be of a different type
+ A `data.frame` is represented as a table, with columns being the vectors
+ Think of a `data.frame` as a collection of variables
+ You can manipulate a `data.frame` like a matrix
  + `D[1,]` or `D[,1:2]`
  + It is <u>not</u> a matrix
+ You can extract variables 
  + `D$index` or `D[,'index']` (recall data frames have columnar representation)
+ Data frames act like SQL tables
  + You can join them (`merge`) and append to them (`cbind`, `rbind`)

---

## The `factor` type

+ Factors are R's representation of categorical variables
+ Factors look like vectors of characters, but they are not!!

```r
gender = factor(c('M','M','F','M','F','F','F'))
levels(gender)
is.factor(gender)
is.character(gender)
as.numeric(gender)
```
+ Internally, factors are represented as integers, with each 
integer corresponding to a level of the categorical variable

---
## Functions

Functions in R have the syntax

```r
functionname <- function(inp1, inp2=3, ...){

  statements
  
  return(list of output objects)

}
```

+ If the `return` statement is absent, the function returns the last 
object created.
+ `...` signifies optional parameters
+ You would use this as `results <- functionname(inp1=x, inp2=4, inp3=9)`
+ Functions are objects

--- .segue .dark

## Common errors

---
## Common errors


```r
library(ada)
```

```
## Error: there is no package called 'ada'
```


> + Usually means that R package is not installed. Install it using `install.packages('ada')`

---
## Common errors


```r
data(mtcars)
sumary(mtcars)
```

```
## Error: could not find function "sumary"
```


> + Check the spelling of your function. Here it should be `summary`, i.e., you missed a `m`

---
## Common errors


```r
asfactor(1:10, ecxlud = NA)
```

```
## Error: could not find function "asfactor"
```


> + Missing a `.`. The function is `as.factor`
> + Most 2-word function names in R are separated by `.`

--- .segue .dark

## Transformation

---
## Data cleaning

### Missing values
+ Missing values are coded as `NA`
+ R can test for missing values using `is.na`
+ Rows of data frames with complete data can be identified using 
`complete.cases(D)`

### Duplication
+ You can get a set of non-duplicate rows of a data frame using 
`D[!duplicated(D),]`.

---
---

## transform

The `transform` function works on data.frames and allows you to quickly generate transformations of your data

```r
data(mtcars)
mtcars <- transform(mtcars, kmpg = mpg*1.6)
```

---

## Subsetting

The `subset` function can be used to easily subset data frames by rows and columns

```r
cars2 <- subset(mtcars, subset=(cyl==4 & mpg > 25) )
```

This is similar to using `sqldf`

```r
sqldf('select * from mtcars where cyl=4 and mpg > 25')
```

--- .segue .dark

## "Apply"ing yourself

---

## apply

`apply` works with matrices and applies a function along rows or columns

```r
X = matrix(rnorm(100), ncol=5)
apply(X, 1, mean) # mean by rows
apply(X, 2, max) # maximum within columns
```

---

## lapply

`lapply` applies the same function over elements of a list

```r
x <- list()
x[[1]] <- rnorm(10)
x[[2]] <- rnorm(25)
x[[3]] <- c('a','c','x','g')

lapply(x, sort)
```

Recall that a `data.frame` is really a `list`, with the columns as elements of the list
```r
lapply(mtcars, sort)
```

--- .segue .dark

## Wickham's duo: reshaping and split-apply-combine

---

## reshape2

`reshape2` has functions to allow you to take a data frame from wide to long

```r
R.df2 <- melt(R.df, id='ID')
```

---

## Split-apply-combine

The basic idea of split-apply-combine is to

+ split the data by some criterion
+ apply a function to the split data
+ combine the results of the function

---

## plyr

plyr provides functions of the form (x)(y)ply, where

+ (x) is the data type of the input
+ (y) is the data type of the output

For example, ddply, dlply, ldply, etc.


```r
library(plyr)
```

```
## Attaching package: 'plyr'
```

```
## The following object is masked from 'package:Hmisc':
## 
## is.discrete, summarize
```

```r
summ <- ddply(mtcars, ~cyl, summarise, mean.mpg = mean(mpg))
print(summ)
```

```
##   cyl mean.mpg
## 1   4    26.66
## 2   6    19.74
## 3   8    15.10
```


---
## data.table


```r
library(data.table)
DT <- data.table(mtcars)
print(DT[, mean(mpg), by = cyl])
```

```
## Warning: argument is not numeric or logical: returning NA
```

```
## Error: undefined columns selected
```


---
## sqldf

This allows you to treat `data.frame` objects as SQL tables and use SQL statements

```r
library(sqldf)
sqldf("select cyl, avg(mpg) from mtcars group by cyl")
```

```
##   cyl avg(mpg)
## 1   4    26.66
## 2   6    19.74
## 3   8    15.10
```

