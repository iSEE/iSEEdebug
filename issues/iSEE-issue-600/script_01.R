## Issue: https://github.com/iSEE/iSEE/issues/580
## YouTube video: n/a
## Script written by Kevin Rue-Albrecht

## Right now, the tooltip displays only the rownames/colnames.

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

rowData(sce)[["dummy_numeric"]] <- rnorm(nrow(sce))

## App ----

initial <- list(
    ColumnDataPlot(),
    RowDataPlot()
)

app <- iSEE(sce, initial = initial)
shiny::runApp(app, launch.browser = TRUE)
