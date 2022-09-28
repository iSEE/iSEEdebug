## Issue: https://github.com/iSEE/iSEE/issues/600
## YouTube video: n/a
## Script written by Kevin Rue-Albrecht

## For each DotPlot panel
## Add a slot that contains the list of rowData/colData columns
## to display in tooltip.
## Individual panels can display distinct tooltip contents.

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

rowData(sce)[["dummy_numeric"]] <- rnorm(nrow(sce))

## App ----

sce <- registerAppOptions(sce, tooltip.rowdata = c("dummy_numeric"), tooltip.coldata = c("Treatment", "Cell_Cycle"))

initial <- list(
    ColumnDataPlot(TooltipSelection = "Cell_Cycle", PanelWidth = 6L),
    RowDataPlot(TooltipSelection = "dummy_numeric", PanelWidth = 6L),
    ColumnDataPlot(PanelWidth = 6L),
    RowDataPlot(PanelWidth = 6L)
)

app <- iSEE(sce, initial = initial)
shiny::runApp(app, launch.browser = TRUE)
