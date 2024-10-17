# mdl_build_ontology

## Rationale

This module has the purpose of building the *LUCKINet land use ontology* [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13847130.svg)](https://doi.org/10.5281/zenodo.13847130)
 and the gazetteer. This is the basis for all harmonized concept concerning landcover, land use and commodities and the territorial units used within the LUTS and GPW models. There are various locations in this modelling pipeline in which external concepts need to be adapted to a common set of terms, all of which are inserted into either the ontology, or the gazetteer. The ontology published in zenodo is the blank version that contains only the harmonized concept terms. Each module contains an updated version of the ontology or gazetteer, where the external concepts are related to the harmonized concepts according to the [SKOS](https://www.w3.org/TR/skos-reference/) logic.

## The input data

The ontology is based on:

- The [FAO Indicative Crop Classification](https://datalab.review.fao.org/datalab/caliper/web/classification-page/43) (ICC) v1.1 as a hierarchical structure of crop and livestock concepts.
- The [FAO Crops and livestock products](https://www.fao.org/faostat/en/#data/QCL) (QCL) dataset contains a range of concepts used by the FAO and frequently by statistical offices of nations that make their census data publicly available.
- The [FAO Land Use](https://www.fao.org/faostat/en/#data/RL) (RL) dataset contains a hierarchical set of land-use concepts that represent the most harmonized representation of land-use concepts to date.
- The [FAO Forest Resource Assessment](https://www.fao.org/3/I8661EN/i8661en.pdf) (FRA) contains a detailed set of forest classes that fit well with the FAO Land Use vocabulary and represent relevant classes at a coarse scale (Sections 1b, 1e, 1f).
- [CORINE Land Cover](https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/) (CLC) classes are used as the basis to define the (hierarchical) organization of land cover and land use classes (into which the crop and livestock commodities are nested).

Crop and livestock species are identified further by the [GBIF](https://www.gbif.org/) species codes and their [wikidata](https://www.wikidata.org/) ID.

The gazetteer is simply based on the hierarchical territory names that are recorded in the GADM dataset.

## Methods

### Meta data

There are no module-specific meta data here. Meta data of the input datasets are recorded directly in the ontology or gazetteer.

### Tools

The ontology and the gazetteer are both built with the R-package [`ontologics`](https://cran.r-project.org/web/packages/ontologics/index.html) and custom code snippets that pre-process everything.

## The output

The ontology and the gazetteer are both stored as `*.rds` files, which makes it easy to use them in our R-based modelling pipeline.

## Change-Log

Please find a documentation of recent changes [here](LOG.md).

## Acknowledgements
