
## @knitr , echo=FALSE,results='asis'
library(xtable)
X <- matrix("",ncol=2,nrow=2)
X[,1] <- c('E-mail','Twitter')
X[,2] <- c('abhijit@datacommunitydc.org','@webbedfeet')
print(xtable(X),type='html', include.rownames=F, include.colnames=F,
      html.table.attributes=getOption('xtable.html.table.attributes','border=0'))


## @knitr 
args(read.table)


## @knitr 
BP <- read.table('data/bpdata.csv', header=T, sep=',')
head(BP)


## @knitr , results='hide'
BP <- read.table('data/bpdata.csv', header=T, sep=',')
head(BP)


## @knitr ,results='hide'
BP <- read.csv('data/bpdata.csv')


## @knitr 
sp500 <- read.csv(paste("http://ichart.finance.yahoo.com/table.csv?s=%5EGSPC&a=03&b=1&c=1999&d=03&e=1&f=2009&g=m&ignore=.csv"))
head(sp500, n=3)


## @knitr 
library(RODBC) # Calling a package names RODBC
con <- odbcConnect('MCT4')
sqlTables(con)
dat <- sqlFetch(con,'Sheet1')
head(dat[,1:4])
odbcClose(con)


## @knitr 
BP <- readLines('data/bpdata.csv')
head(BP)


## @knitr 
library(ada)


## @knitr 
data(mtcars)
sumary(mtcars)


## @knitr 
asfactor(1:10, ecxlud=NA)


## @knitr 
library(plyr)
summ <- ddply(mtcars, ~cyl, summarise, mean.mpg=mean(mpg))
print(summ)


## @knitr 
library(data.table)
DT <- data.table(mtcars)
print(DT[,mean(mpg), by=cyl])


## @knitr 
library(sqldf)
sqldf('select cyl, avg(mpg) from mtcars group by cyl')


library(rCharts)
names(iris) = gsub("\\.", "", names(iris))
rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')

## Example 2 Facetted Barplot
hair_eye = as.data.frame(HairEyeColor)
rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')

r1 <- rPlot(mpg ~ wt | am + vs, data = mtcars, type = "point", color = "gear")
r1$print("chart1")

hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
n1 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, type = "multiBarChart")
n1$print("chart3")

require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c("category", "year")
x1 <- xPlot(value ~ year, group = "category", data = uspexp, type = "line-dotted")
x1$print("chart4")


# googleVis ---------------------------------------------------------------
library(googleVis)
demo(WorldBank)

library(googleVis)
Motion=gvisMotionChart(Fruits, idvar="Fruit", timevar="Year", options=list(height=350, width=400))
# Display chart
plot(Motion) 

AndrewMap <- gvisMap(Andrew, "LatLong" , "Tip", 
                     options=list(showTip=TRUE, showLine=TRUE, enableScrollWheel=TRUE,
                                  mapType='terrain', useMapTypeControl=TRUE))
# Display chart
plot(AndrewMap) 

# ROC ---------------------------------------------------------------------

require(ROCR)
data(iris)
iris$setosa <- factor(1*(iris$Species == 'setosa'))
iris.rf <- randomForest(setosa ~ ., data=iris[,-5])
summary(predict(iris.rf, iris[,-5]))
summary(iris.preds <- predict(iris.rf, iris[,-5], type = 'prob'))
preds <- iris.preds[,2]
plot(performance(prediction(preds, iris$setosa), 'tpr', 'fpr'))


# word cloud --------------------------------------------------------------

library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)
path <- system.file("xkcd", package = "RXKCD")
datafiles <- list.files(path)
xkcd.df <- read.csv(file.path(path, datafiles))
xkcd.corpus <- Corpus(DataframeSource(data.frame(xkcd.df[, 3])))
xkcd.corpus <- tm_map(xkcd.corpus, removePunctuation)
xkcd.corpus <- tm_map(xkcd.corpus, tolower)
xkcd.corpus <- tm_map(xkcd.corpus, function(x) removeWords(x, stopwords("english")))
tdm <- TermDocumentMatrix(xkcd.corpus)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
pal <- brewer.pal(9, "BuGn")
pal <- pal[-(1:2)]
png("wordcloud.png", width=1280,height=800)
wordcloud(d$word,d$freq, scale=c(8,.3),min.freq=2,max.words=100, random.order=T, rot.per=.15, colors=pal, vfont=c("sans serif","plain"))
dev.off()

require(XML)
require(tm)
require(wordcloud)
require(RColorBrewer)
u = "http://cran.r-project.org/web/packages/available_packages_by_date.html"
t = readHTMLTable(u)[[1]]
ap.corpus <- Corpus(DataframeSource(data.frame(as.character(t[,3]))))
ap.corpus <- tm_map(ap.corpus, removePunctuation)
ap.corpus <- tm_map(ap.corpus, tolower)
ap.corpus <- tm_map(ap.corpus, function(x) removeWords(x, stopwords("english")))
ap.tdm <- TermDocumentMatrix(ap.corpus)
ap.m <- as.matrix(ap.tdm)
ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = names(ap.v),freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png("wordcloud_packages.png", width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=3,
          max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()


