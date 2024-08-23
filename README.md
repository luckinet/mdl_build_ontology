# description

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7228853.svg)](https://doi.org/10.5281/zenodo.7228853)
[![CC-By license](https://img.shields.io/badge/License-CC--BY-blue.svg)](https://creativecommons.org/licenses/by/4.0)
[![Website https://geokur-dmp2.geo.tu-dresden.de/Skosmos/skosmos/en/](https://img.shields.io/website-up-down-green-red/http/monip.org.svg)](https://geokur-dmp2.geo.tu-dresden.de/Skosmos/skosmos/en/)

**1. Rationale**

The LUCKINet land use ontology expands AGROVOC (https://agrovoc.fao.org/browse/agrovoc/en/), which was developed by the Food and Agriculture Organization of the United Nations (FAO). Like AGROVOC, the LUCKINet land use ontology uses semantic web technology powered by the [Simple Knowledge Organization System](https://www.w3.org/TR/skos-primer/) (SKOS).

The ontology has been primarily developed to support the LUCKINet effort to standardize approaches that develop gridded information on land use dynamics. The ontology covers concepts of landcover, land use and agricultural commodity labels and contains:

1. harmonized concept of the LUCKINet and GeoKur projects and the semantic matches between them, and
2. mappings to other external ontologies, vocabularies or lists of concepts from databases or publications.

We built the ontology with a strong focus on mapping LUCKINet concepts to FAO/AGROVOC concepts to foster interoperability with the wealth of other projects building on AGROVOC. Moreover, concepts from different state-of-the-art datasets are considered, for example, on land use from statistical agencies worldwide and the (grey) literature or landcover data such as [CORINE Land Cover](https://land.copernicus.eu/pan-european/corine-land-cover) because its [nomenclature](https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/) is very well defined and documented. Furthermore, the hierarchical structure of CORINE allows mapping various other land cover and land use datasets into a common ontology. This is a crucial milestone necessary to consistently allocate land use statistics across time and space into widely available landcover data products, the primary goal of LUCKINet.

Over time, more concepts from external ontologies, vocabularies or lists will be added to this ontology within the LUCKINet project. Moreover, community development is possible by replicating the procedures used here, which may ultimately lead to improved interoperability between the ontological basis of many projects.

**2. Method**

We have built the ontology with the R-package [ontologics v0.5.2](https://cran.r-project.org/web/packages/ontologics/index.html), which enables reproducibility and transparency in creating an ontology. A script documenting this process is part of this publication.

_2.1_ _Sources_

The ontology is an amalgamation of various datasets:

1. The [FAO Indicative Crop Classification](https://datalab.review.fao.org/datalab/caliper/web/classification-page/43) (ICC) v1.1 provides a hierarchical structure of crop and livestock concepts.
2. The [FAO Crops and livestock products](https://www.fao.org/faostat/en/#data/QCL) (QCL) dataset contains a range of concepts used by the FAO and frequently by statistical offices of nations that make their census data publicly available.
3. The [FAO Land Use](https://www.fao.org/faostat/en/#data/RL) (RL) dataset contains a hierarchical set of land-use concepts that represent the most harmonized representation of land-use concepts to date.
4. The [FAO Forest Resource Assessment](https://www.fao.org/3/I8661EN/i8661en.pdf) (FRA) contains a detailed set of forest classes that fit well with the FAO Land Use vocabulary and represent relevant classes at a coarse scale (Sections 1b, 1e, 1f).
5. [CORINE Land Cover](https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/) (CLC) classes are used as the basis to define the (hierarchical) organization of land cover and land use classes (into which the crop and livestock commodities are nested).

_2.2 Classes_

The ontology is hierarchically structured into the following classes:

-   **domain:** the overarching dimensions into which all other concepts are nested. These represent conceptually different kinds of classification systems. At the current stage of this ontology, these are _surface types_ to describe the configuration of the earth's surface (essentially replicating the CORINE ontology) and _production systems_ to describe the hierarchical organization of commodities (mainly replicating the FAO classification).
    -   **landcover group:** groups of landcover types (as the top-most surface types class) describing the respective _areas_, such as AGRICULTURAL AREAS, FOREST AND SEMI-NATURAL AREAS, WETLANDS and others.
        -   **Landcover:** concepts that describe a unique cover type, taken mainly from the CORINE classification, with minor adaptions.
            -   **land use:** the socio-economic dimension, i.e., how the land under a particular cover is used. At the current state of this ontology, only the landcover groups AGRICULTURAL AREAS and FOREST AND SEMI-NATURAL AREAS are detailed because they are the focus of the first iteration of the LUCKINet land use time series.
                
    -   **group:** groups of crop or livestock commodities as the top-most class of production systems
        -   **class:** classes of similar commodities.
            -   **aggregate:** some commodities are very similar and thus reported together by some national statistical agencies or the FAO (this class is at the same level as commodities).
            -   **commodity:** individual commodities (typically at the level of species or variety).

_2.3 Concepts_

The bulk content of the ontology consists of a collection of concepts, where each concept is an instance of a specific class. The concepts also bear hierarchical relations determined by their class affiliation. For example, the concept of _Permanent Grazing_ (class: land use) is semantically narrower than _Permanent Cropland_ (class: **landcover**), which in turn is narrower than the concept of _Agricultural Areas_ (class: **lancover group**), which, finally, is narrower than _surface types_ (class: **domain**).

_2.4 Mappings_

As far as possible, concepts are mapped to all corresponding wikidata concepts. For example, the concept of _maize_ is mapped to wikidata concepts [Q11575](https://www.wikidata.org/wiki/Q11575) and [Q25618328](https://www.wikidata.org/wiki/Q25618328). Moreover, concepts are mapped to the

-   life-form concepts _graminoid_, _forb_, _herb_, _shrub_, _tree_
-   use-type concepts _bioenergy_, _fibre_, _food_, _wood_, _forage_, _silage_, _fodder_, _industrial_, _recreation_, _medicinal_ and _labour_
-   the persistence concepts _temporary_ and _permanent_

**3. Files**

-   build_luckinet_landuse_ontology.R: The script used to build this ontology
-   luckiOnto.rds: the ontology to access and manipulate with R and the ontologics R-package
-   luckiOnto.ttl: the semantic web compatible turtle file

**4. Version changes**


**5. Acknowledgements**

- This work was supported by funding to Carsten Meyer through the Flexpool mechanism of the German Centre for Integrative Biodiversity Research (iDiv) (FZT-118, DFG).
- Several developments in this software stem from work on the GeoKur research data infrastructure. GeoKur is granted by the BMBF (Federal Ministry of Education and Research) under number 16QK04A.

# references
* [[Ehrmann2022]]
