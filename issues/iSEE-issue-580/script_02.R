## Issue: https://github.com/iSEE/iSEE/issues/580
## Comment: https://github.com/iSEE/iSEE/issues/580#issuecomment-1172580704
## YouTube video: n/a
## Script adapted by Kevin Rue-Albrecht

#' In this example, we increase the number of cells and genes in the dataset.
#' This sufficient to cause the issue reported:
#' Use the search box in the RowDataTable panel while the heatmap is receiving
#' a row selection from that panel and uses custom rows;
#' The heatmap refreshes (without actually changing changing its contents)
#' every time that the set of rows visible in the RowDataTable changes.
#' That should not happen.

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE(ncells = 50000, ngenes = 20000)
sce <- logNormCounts(sce)

## Example 1 ----

initial <- list(
    RowDataTable(
        PanelWidth = 6L,
        Selected = "Gene_0001"
        ),
    ComplexHeatmapPlot(
        PanelWidth = 6L,
        DataBoxOpen = TRUE,
        CustomRows = TRUE,
        SelectionBoxOpen = TRUE,
        RowSelectionSource = "RowDataTable1"
        )
)

app <- iSEE(sce, initial = initial)
shiny::runApp(app, launch.browser = TRUE)
