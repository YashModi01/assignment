require(jpeg)
require(RCurl)
url <-"https://raw.githubusercontent.com/mages/diesunddas/"
url <- paste(url, "master/Blog/LloydsBuilding.jpg", sep="")
readImage <- readJPEG(getURLContent(url, binary=TRUE))
dm <- dim(readImage)
rgbImage <- data.frame(
  x=rep(1:dm[2], each=dm[1]),
  y=rep(dm[1]:1, dm[2]),
  r.value=as.vector(readImage[,,1]),
  g.value=as.vector(readImage[,,2]),
  b.value=as.vector(readImage[,,3]))

plot(y ~ x, data=rgbImage, main="Lloyd building",
     col = rgb(rgbImage[c("r.value", "g.value", "b.value")]), 
     asp = 1, pch = ".")




## ---- message= FALSE, echo=FALSE, eval=TRUE, message = FALSE, warning=FALSE----
kColors <- 5  
kMeans <- kmeans(rgbImage[, c("r.value", "g.value", "b.value")], 
                 centers = kColors)
clusterColour <- rgb(kMeans$centers[kMeans$cluster, ])

plot(y ~ x, data=rgbImage, main="Lloyd building",
     col = clusterColour, asp = 1, pch = ".",
     axes=FALSE, ylab="", 
     xlab="k-means cluster analysis of 5 colours")

