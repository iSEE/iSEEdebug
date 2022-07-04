## Issue: https://github.com/iSEE/iSEE/issues/580
## YouTube video: https://youtu.be/3vce4QucXAM
## Script written by Kevin Rue-Albrecht

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
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
        element = "#RowDataTable1",
        intro = "Let's change the selection in this table..."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1",
        intro = "... and indeed we see that the <b>ComplexHeatmapPlot1</b> does not refresh."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_INTERNAL_DimNamesEdit",
        intro = "Instead, the selection can be used to edit the custom features names to display in this panel."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_CustomRows",
        intro = "Now let's come back here and disable the custom rows."),
    data.frame(
        element = "#ComplexHeatmapPlot1_RowSelectionSource + .selectize-control",
        intro = "Remember that this panel is still listening to the other panel..."),
    data.frame(
        element = "#ComplexHeatmapPlot1_INTERNAL_PanelSelectLinkInfo",
        intro = "...as confirmed by this message."),
    data.frame(
        element = "#RowDataTable1",
        intro = "Changing the selection in the table still does not update the heatmap. This is desired as we do not want to have a single-row heatmap. Meanwhile, typing in the Search field dynamically restricts the rows of the table..."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1",
        intro = "... which refreshes the heat map to those rows."
    )
)

app <- iSEE(sce, initial = initial, tour = tour)
shiny::runApp(app, launch.browser = TRUE)
