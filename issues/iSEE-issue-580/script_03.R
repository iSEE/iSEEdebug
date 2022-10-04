## Issue: https://github.com/iSEE/iSEE/issues/580
## Comment: https://github.com/iSEE/iSEE/issues/580#issuecomment-1172580704
## YouTube video: n/a
## Script adapted by Kevin Rue-Albrecht

#' In this example, we use a publicly available data set with 68k cells.
#' This sufficient to cause the issue reported:
#' Use the search box in the RowDataTable panel while the heatmap is receiving
#' a row selection from that panel and uses custom rows;
#' The heatmap refreshes (without actually changing changing its contents)
#' every time that the set of rows visible in the RowDataTable changes.
#' That should not happen.

library(iSEE)

# Data ----

library(TENxPBMCData)
sce <- TENxPBMCData("pbmc68k")

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

tour <- rbind(
    data.frame(
        element = NA_character_,
        intro = "This app explores the behaviour reported in issue <a href='https://github.com/iSEE/iSEE/issues/580'>#580</a>"
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_RowSelectionSource + .selectize-control",
        intro = "This <b>Complex heatmap 1</b> panel is listening to the <b>Row data table 1</b>. Updates to the selection made in the <b>Row data table 1</b> panel may trigger re-rendering on this panel."),
    data.frame(
        element = "#ComplexHeatmapPlot1_INTERNAL_PanelSelectLinkInfo",
        intro = "This message confirms that the receiving selection link is properly detected."),
    data.frame(
        element = "#ComplexHeatmapPlot1_CustomRows",
        intro = "Custom rows are active. This <b>Complex heatmap 1</b> panel should only refresh when the custom list of rows defined in this panel is edited and applied. This panel should NOT refresh when the selection in the upstream <b>Row data table 1</b> panel is changed.<br/>Let's try..."),
    data.frame(
        element = "#ComplexHeatmapPlot1_ColumnSelectionRestrict",
        intro = "Restriction of columns based on incoming selection is inactive. Moreover, the panel is not receiving any column selection anyway.")
)

app <- iSEE(sce, initial = initial, tour = tour)
shiny::runApp(app, launch.browser = TRUE)
