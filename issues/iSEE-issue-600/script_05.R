## Issue: https://github.com/iSEE/iSEE/issues/600
## YouTube video: n/a
## Script written by Kevin Rue-Albrecht

## For each DotPlot panel
## Add a slot that contains the list of rowData/colData columns
## to display in tooltip.
## Use panelDefaults.

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

rowData(sce)[["dummy_numeric"]] <- rnorm(nrow(sce))
rowData(sce)[["dummy_character"]] <- sample(LETTERS, nrow(sce), replace = TRUE)
rowData(sce)[["dummy_factor"]] <- factor(sample(letters, nrow(sce), replace = TRUE))

colData(sce)[["Mutation_Status"]] <- factor(colData(sce)[["Mutation_Status"]])

## App ----

panelDefaults(
    TooltipRowData = c("dummy_numeric", "dummy_character", "dummy_factor"),
    TooltipColumnData = c("Treatment", "sizeFactor", "Mutation_Status")
)

app <- iSEE(sce, initial=initial)
shiny::runApp(app, launch.browser = TRUE)
