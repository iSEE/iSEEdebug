## Issue: https://github.com/iSEE/iSEE/issues/580
## YouTube video: https://youtu.be/3vce4QucXAM
## Script written by Kevin Rue-Albrecht

library(iSEE)

# Data ----

library(scater)
sce <- mockSCE()
sce <- logNormCounts(sce)


rowData(sce)[["dummy_numeric"]] <- rnorm(nrow(sce))

# Throw some randomness in the rownames
# For more diverse search options in the app

set.seed(1)
rowname_format <- sprintf("%%0%id_gene", nchar(nrow(sce)))
rownames(sce) <- paste0(
    sample(LETTERS, nrow(sce), replace = TRUE),
    sprintf(rowname_format, seq_len(nrow(sce)))
)
colname_format <- sprintf("%%0%id_cell", nchar(ncol(sce)))
colnames(sce) <- paste0(
    sample(LETTERS, ncol(sce), replace = TRUE),
    sprintf(colname_format, seq_len(ncol(sce)))
)

## Example 1 ----

initial <- list(
    RowDataTable(
        PanelWidth = 4L,
        Selected = "Gene_0001",
        SelectionBoxOpen = TRUE,
        RowSelectionSource = "RowDataPlot1"
        ),
    ColumnDataTable(
        PanelWidth = 4L,
        SelectionBoxOpen = TRUE,
        ColumnSelectionSource = "ColumnDataPlot1"
    ),
    ComplexHeatmapPlot(
        PanelWidth = 4L,
        DataBoxOpen = TRUE,
        CustomRows = FALSE,
        VisualBoxOpen = TRUE,
        ColumnData = "Mutation_Status",
        SelectionBoxOpen = TRUE,
        RowSelectionSource = "RowDataTable1",
        ColumnSelectionSource = "ColumnDataTable1",
        ColumnSelectionRestrict = TRUE
        ),
    RowDataPlot(
        PanelWidth = 4L
    ),
    ColumnDataPlot(
        PanelWidth = 4L,
        YAxis = "sizeFactor"
    )
)

app <- iSEE(sce, initial = initial)
shiny::runApp(app, launch.browser = TRUE)
