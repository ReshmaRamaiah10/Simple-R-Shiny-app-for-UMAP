# https://satijalab.org/seurat/articles/integration_introduction
devtools::install_github('satijalab/seurat-data')
library(Seurat)
library(SeuratData)
library(patchwork)
library(shiny)
library(shinydashboard)
library(ggplot2)

# Install both pbmck and ifnb dataset from SeuratData
InstallData("pbmc3k")
pbmc3k <- LoadData("pbmc3k")
pbmc3k <- NormalizeData(pbmc3k)
pbmc3k <- FindVariableFeatures(pbmc3k)
pbmc3k <- ScaleData(pbmc3k)

InstallData("ifnb")
ifnb <- LoadData("ifnb")
ifnb <- NormalizeData(ifnb)
ifnb <- FindVariableFeatures(ifnb)
ifnb <- ScaleData(ifnb)

dataset_options <- c("pbmc3k","ifnb")
ui <- dashboardPage(
  dashboardHeader(title = "scRNA-seq UMAP Visualization"),
  dashboardSidebar(
    selectInput("dataset", "Select Dataset:", choices = dataset_options),
    numericInput("npcs", "No. of PCs:", value = 50),
    numericInput("k_param", "K.param (Enter a number):", value = 20),
    numericInput("dim_reduction", "Dimensionality Reduction (Enter a number):", value = 10),
    radioButtons("annotation", "Annotation:", choices = c("True", "False"), selected = "False"),
    radioButtons("labeled", "Labeled:", choices = c("True", "False"), selected = "False"),
    actionButton("submit_button", "Submit")),
  dashboardBody(
    fluidRow(
      box(
        title = "scRNA-seq UMAP Visualization",
        status = "info",
        width = 8,
        height = 1000,
        plotOutput("umapPlot")
      )
    )
  )
)

server <- function(input, output) {
  observeEvent(input$submit_button, {
    dataset <- input$dataset
    npcs <- input$npcs
    dim_reduction <- input$dim_reduction
    k_param <- input$k_param
    annotation <- input$annotation
    labeled <- input$labeled
    
    if (dataset == "pbmc3k") {
      data <- pbmc3k
    } else {
      data <- ifnb
    }
    data <- RunPCA(data, npcs = npcs)
    data <- FindNeighbors(data, dims = 1:30, k.param = k_param, reduction = "pca")
    data <- FindClusters(data, resolution = 2, cluster.name = "clusters")
    data <- RunUMAP(data, dims = 1:dim_reduction, reduction = "pca", reduction.name = "umap")
    
    output$umapPlot <- renderPlot({
      if (annotation == "True") {
        # Use seurat_annotations as group.by
        DimPlot(data, reduction = "umap", group.by = c("seurat_annotations"), label = labeled)
      } else {
        # Use seurat_clusters as group.by
        DimPlot(data, reduction = "umap", group.by = c("seurat_clusters"), label = labeled)
      }
    })
  })
}

shinyApp(ui, server)
