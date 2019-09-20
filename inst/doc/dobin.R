## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width=8, fig.height=6
)
library("dobin")
library("OutliersO3")
library("mbgraphic")
library("ggplot2")

## ----install_dobin, eval=FALSE-------------------------------------------
#   install.packages("devtools")
#   devtools::install_github("sevvandi/dobin")

## ----ex1_dobin-----------------------------------------------------------
data <- Election2005[, c(6, 10, 17, 28)]
names(data) <- c("Area", "Population_density", "Birthrate", "Car_ownership")
out <- dobin(data, frac=0.9, norm=3)

labs <- rep("norm", dim(out$coords)[1])
inds <- which(out$coords[, 1] > 5)
labs[inds] <- "out"
df <- as.data.frame(out$coords[, 1:2])
colnames(df) <- c("DC1", "DC2")
df2 <- df[inds, ]
ggplot(df, aes(x=DC1,y=DC2)) + geom_point(aes(shape=labs, color=labs), size=2 ) + geom_text(data=df2, aes(DC1, DC2, label = inds), nudge_x = 0.5) + theme_bw()

## ----ex2_dobin-----------------------------------------------------------
out$vec[ ,1]

## ----ex1_o3--------------------------------------------------------------
data <- Election2005[, c(6, 10, 17, 28)]
names(data) <- c("Area", "Population_density", "Birthrate", "Car_ownership")
O3y <- O3prep(data, method=c("HDo", "PCS", "BAC", "adjOut", "DDC", "MCD"))
O3y1 <- O3plotM(O3y)
O3y1$gO3

