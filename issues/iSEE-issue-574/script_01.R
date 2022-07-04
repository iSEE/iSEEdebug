## Issue: https://github.com/iSEE/iSEE/issues/574
## Script reported by issue author

library(iSEE)

# Data ----

se1 <- SummarizedExperiment(assays = list(count=matrix(rnorm(1000,mean = 10,sd=2), ncol = 10)))
colnames(se1) <- paste("Sample",c(rep("A",5),rep("B",5)))
rownames(se1) <- paste("Gene",1:100)
colData(se1) <- DataFrame(Treatment=c(rep("A",5),rep("B",5)))

## Panel code ----

setClass("EasyGeneSearch",
         contains = "Panel",
         slots = c(GeneNames = "character")) ## GeneNames for displaying gene names

setMethod("initialize", "EasyGeneSearch",
          function(.Object, GeneNames="", ...)
          {
              callNextMethod(.Object, GeneNames=GeneNames, ...)
          })

EasyGeneSearch <- function(GeneNames=character(),...){
    new("EasyGeneSearch",GeneNames,...)
}

setMethod(".fullName", "EasyGeneSearch", function(x) "Easy Gene Search")

setMethod(".panelColor", "EasyGeneSearch", function(x) "#BB00FF")

setMethod(".defineInterface", "EasyGeneSearch", function(x, se, select_info) {
    return(shinyjs::hidden(callNextMethod()))
})

setMethod(".defineOutput", "EasyGeneSearch", function(x,...) {
    # cmds <- callNextMethod()
    plot_name <- .getEncodedName(x)
    a <- tagList(selectizeInput(paste0(plot_name, "_", "GeneNames"),label= "Select a gene",
                                choices=list()))
    return(a)
})

setMethod(".createObservers", "EasyGeneSearch", function(x, se, input, session, pObjects, rObjects) {
    callNextMethod()
    panel_name <- .getEncodedName(x)
    .createUnprotectedParameterObservers(panel_name,
                                         fields=c("GeneNames"),
                                         input=input, pObjects=pObjects, rObjects=rObjects)
    geneNameParam <- paste0(panel_name, "_", "GeneNames")
    updateSelectizeInput(session, geneNameParam, server=TRUE,
                         choices=x[["GeneNames"]],selected = x[["GeneNames"]][1] )
    
    observeEvent(input[[geneNameParam]], {
        pObjects$memory[[panel_name]][["GeneNames"]] <- input[[geneNameParam]]
        .requestActiveSelectionUpdate(panel_name, session, pObjects, rObjects, update_output=FALSE)
    }, ignoreInit=TRUE, ignoreNULL=FALSE)
    invisible(NULL)
})

setMethod(".singleSelectionDimension", "EasyGeneSearch", function(x) "feature")

setMethod(".singleSelectionValue", "EasyGeneSearch", function(x) { #, contents
    slot(x, "GeneNames")
})


# setMethod(".singleSelectionSlots", "EasyGeneSearch", function(x) {
#     c(callNextMethod(),
#       list(
#           list(
#               parameter="GeneNames",
#               source="GeneNames",
#               dimension="feature",
#               use_mode="GeneNames",
#               use_value="GeneNames",
#               # dynamic=.colorByFeatDynamic,
#               protected=TRUE
#           )
#       )
#     )
# })

# App ----

geneData <- rowData(se1 )
geneNames <- rownames(geneData)
names(geneNames) <- geneNames

rex <- EasyGeneSearch( GeneNames = geneNames)

fex <-FeatureAssayPlot(VisualChoices=c("Other"),PanelWidth=6L)
fex[["ColorByColumnData"]] = "Treatment"
fex[["XAxisColumnData"]] = "Treatment"
fex[["XAxis"]] = "Column data"
fex[["ColorBy"]] = "Column data"
fex[["YAxisFeatureSource"]] = "EasyGeneSearch1"


app <- iSEE(se1, initial=list(rex, fex))

shiny::runApp(app, launch.browser = TRUE)
