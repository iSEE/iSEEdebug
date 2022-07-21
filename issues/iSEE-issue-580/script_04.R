## Issue: https://github.com/iSEE/iSEE/issues/580
## YouTube video: https://youtu.be/3vce4QucXAM
## Script written by Kevin Rue-Albrecht

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)

# Throw some randomness in the rownames
# For more diverse search options in the app

set.seed(1)
rowname_format <- sprintf("%%0%id", nchar(nrow(sce)))
rownames(sce) <- paste0(
    sample(LETTERS, nrow(sce), replace = TRUE),
    sprintf(rowname_format, seq_len(nrow(sce)))
)

## Example 1 ----

initial <- list(
    RowDataTable(
        PanelWidth = 4L,
        Selected = "Gene_0001"
        ),
    ColumnDataTable(
        PanelWidth = 4L
    ),
    ComplexHeatmapPlot(
        PanelWidth = 4L,
        DataBoxOpen = TRUE,
        CustomRows = FALSE,
        SelectionBoxOpen = TRUE,
        RowSelectionSource = "RowDataTable1",
        ColumnSelectionSource = "ColumnDataTable1",
        ColumnSelectionRestrict = TRUE
        )
)

tour <- rbind(
    data.frame(
        element = NA_character_,
        intro = "This app explores the behaviour reported in issue <a href='https://github.com/iSEE/iSEE/issues/580'>#580</a>"
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_RowSelectionSource + .selectize-control",
        intro = "This <b>Complex heatmap 1</b> panel is listening to the <b>Row data table 1</b>.<br/><br/>Updates to the selection made in the <b>Row data table 1</b> panel can be expected to trigger re-rendering on this panel."),
    data.frame(
        element = "#ComplexHeatmapPlot1_CustomRows",
        intro = "Furthermore, custom rows are inactive.<br/><br/>Now, it is clear that <b>Complex heatmap 1</b> should update when the selection in the <b>Row data table 1</b> panel changes, as it doesn't override incoming row selections with custom rows."),
    data.frame(
        element = "#ComplexHeatmapPlot1_ColumnSelectionSource + .selectize-control",
        intro = "This <b>Complex heatmap 1</b> panel is also listening to the <b>Column data table 1</b>.<br/><br/>Updates to the selection made in the <b>Column data table 1</b> panel can also be expected to trigger re-rendering on this panel."),
    data.frame(
        element = "#ComplexHeatmapPlot1_ColumnSelectionRestrict",
        intro = "Furthermore, the <b>Complex heatmap 1</b> is set to restrict visible columns to those present in the incoming selection.<br/><br/>Now, it is clear that <b>Complex heatmap 1</b> should update when the selection in the <b>Column data table 1</b> panel changes."),
    data.frame(
        element = "#RowDataTable1",
        intro = "Let's change the set of rows displayed in this table... <br/><br/>(Type something in the search bar)."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1",
        intro = "... and indeed we see that the <b>Complex heatmap 1</b> updates to display those rows."
    ),
    data.frame(
        element = "#ColumnDataTable1",
        intro = "Similarly, let's change the set of rows displayed in this table... <br/><br/>(Type something in one of the search bars)."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1",
        intro = "... and indeed we see that the <b>Complex heatmap 1</b> updates to display those columns."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_CustomRows",
        intro = "Now let's come back here and enable the custom rows."),
    data.frame(
        element = "#ComplexHeatmapPlot1",
        intro = "Naturally, the <b>Complex heatmap 1</b> updates to display the custom row(s)."
    ),
    data.frame(
        element = "#RowDataTable1",
        intro = "Now that the custom rows are enabled in the heatmap, changing the rows displayed in this table should not trigger any re-rendering in the <b>Complex heatmap 1</b> panel anymore."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_ColumnSelectionRestrict",
        intro = "Similarly, let's come back here and disable the restriction effect on incoming column selections."),
    data.frame(
        element = "#ColumnDataTable1",
        intro = "Now that the restriction effect is disabled on the columns of the heatmap, changing the rows displayed in this table should not trigger any re-rendering in the <b>Complex heatmap 1</b> panel anymore.<br/><br/>...Or is it?!"
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_VisualBoxOpen",
        intro = "Open this collapsible box..."
    ),
    data.frame(
        element = "#ComplexHeatmapPlot1_ShowColumnSelection",
        intro = "Unselect this checkbox, to prevent the <b>Complex heatmap 1</b> panel from displaying the incoming column selection, as this naturally forces it to re-render when the incoming column section updates."
    ),
    data.frame(
        element = "#ColumnDataTable1",
        intro = "Now that we disabled all uses of incoming column selections in the <b>Complex heatmap 1</b> panel, changing the rows displayed in this table should really not trigger any re-rendering in the <b>Complex heatmap 1</b> panel anymore."
    ),
    data.frame(
        element = NA_character_,
        intro = "Thank you for taking this tour and reporting issue <a href='https://github.com/iSEE/iSEE/issues/580'>#580</a>!"
    )
)

app <- iSEE(sce, initial = initial, tour = tour)
shiny::runApp(app, launch.browser = TRUE)
