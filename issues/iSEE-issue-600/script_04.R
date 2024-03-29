## Issue: https://github.com/iSEE/iSEE/issues/600
## YouTube video: n/a
## Script written by Kevin Rue-Albrecht

## For each DotPlot panel
## Add a slot that contains the list of rowData/colData columns
## to display in tooltip.
## Individual panels can display distinct tooltip contents.
## In this demo, do not define an initial state: show all panels.

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

rowData(sce)[["dummy_numeric"]] <- rnorm(nrow(sce))
rowData(sce)[["dummy_character"]] <- sample(LETTERS, nrow(sce), replace = TRUE)

## App ----

sce <- registerAppOptions(sce, tooltip.rowdata = c("dummy_numeric", "dummy_character"), tooltip.coldata = c("Treatment", "sizeFactor"))

app <- iSEE(sce)
shiny::runApp(app, launch.browser = TRUE)
