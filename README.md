# Simple-R-Shiny-app-for-UMAP
Simple R shiny app to visualize UMAP plot generated from Seurat-Data scRNA=seq datasets

## Dataset
[SeuratData](https://github.com/satijalab/seurat-data) is a mechanism for distributing datasets in the form of Seurat objects using R's internal package and data management systems. It represents an easy way for users to get access to datasets that are used in the Seurat vignettes.

Installation of SeuratData can be accomplished through devtools
```R
devtools::install_github('satijalab/seurat-data')
```
They have multiple datasets from which `pbmc3k` and `ifnb datasets are choosen.
```R
                     Dataset Version                                                        Summary species            system ncells                                                            tech         notes Installed InstalledVersion
ifnb.SeuratData         ifnb   3.0.0                              IFNB-Stimulated and Control PBMCs   human              PBMC  13999                                                          10x v1          <NA>      TRUE            3.0.0
pbmc3k.SeuratData     pbmc3k   3.0.0                                     3k PBMCs from 10X Genomics   human              PBMC   2700                                                          10x v1          <NA>      TRUE            3.0.0
```
