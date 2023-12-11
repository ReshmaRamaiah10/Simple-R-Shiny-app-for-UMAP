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

## Analysis

The pre-processed Seurat objects undergo following steps:
1. **Normalizing the data**: By default, it employs a global-scaling normalization method “LogNormalize” that normalizes the feature expression measurements for each cell by the total expression, multiplies this by a scale factor (10,000 by default), and log-transforms the result.
2. **Identification of highly variable features**: Ccalculate a subset of features that exhibit high cell-to-cell variation in the dataset (i.e, they are highly expressed in some cells, and lowly expressed in others) helping to highlight biological signal in single-cell datasets. By default, it returns 2,000 features per dataset.
3. **Scaling the data**: Apply a linear transformation (‘scaling’) that is a standard pre-processing step prior to dimensional reduction techniques like PCA. It shifts the expression of each gene, so that the mean expression across cells is 0.
4. **Perform linear dimensional reduction**: Perform PCA on the scaled data. By default, only the previously determined variable features are used as input.
5. **Cluster the cells**: First construct a KNN graph based on the euclidean distance in PCA space. Next apply modularity optimization techniques such as the Louvain algorithm.
6. **Run non-linear dimensional reduction**: Seurat offers several non-linear dimensional reduction techniques, such as tSNE and UMAP, to visualize and explore these datasets. The goal of these algorithms is to learn underlying structure in the dataset, in order to place similar cells together in low-dimensional space. UMAP is used here.

With Seurat, all plotting functions return ggplot2-based plots by default, allowing one to easily capture and manipulate plots just like any other ggplot2-based plot.
