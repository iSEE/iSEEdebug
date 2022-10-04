## Issue: https://github.com/iSEE/iSEE/issues/600
## YouTube video: n/a
## Script written by: Kevin Rue-Albrecht

## For each DotPlot panel
## Add a slot that contains the character vector of rowData/colData columns
## to display in tooltip:
## - RowDotPlot: slot=TooltipRowData
## - ColumnDotPlot: slot=TooltipColumnData

## Use panelDefaults() to set global defaults.

## This script demonstrates a combination of global defaults
## overriden by panel-specific settings.

## Identical to script 6,
## except for demonstrating that invalid colData/rowData names are dropped with a warning.

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

rowData(sce)[["dummy_numeric"]] <- rnorm(nrow(sce))
rowData(sce)[["dummy_character"]] <- sample(LETTERS, nrow(sce), replace = TRUE)
rowData(sce)[["dummy_factor"]] <- factor(sample(letters, nrow(sce), replace = TRUE))
rowData(sce)[["dummy_integer"]] <- round(runif(nrow(sce), 0, 10))

colData(sce)[["Mutation_Status"]] <- factor(colData(sce)[["Mutation_Status"]])
colData(sce)[["dummy_integer"]] <- round(runif(ncol(sce), 0, 10))

## App ----

panelDefaults(
    TooltipRowData = c("dummy_numeric", "dummy_character", "dummy_factor", "dummy_integer"),
    TooltipColumnData = c("Treatment", "sizeFactor", "Mutation_Status", "dummy_integer")
)

sce <- registerAppOptions(sce, tooltip.signif = 3)

initial <- list(
    ColumnDataPlot(PanelWidth = 6L),
    RowDataPlot(PanelWidth = 6L)
)

app <- iSEE(sce, initial=initial)
shiny::runApp(app, launch.browser = TRUE)
