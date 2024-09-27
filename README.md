[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7228853.svg)](https://doi.org/10.5281/zenodo.7228853) [![CC-By license](https://img.shields.io/badge/License-CC--BY-blue.svg)](https://creativecommons.org/licenses/by/4.0)

# 1. Rationale

The LUCKINet land use ontology expands AGROVOC (<https://agrovoc.fao.org/browse/agrovoc/en/>), developed by the Food and Agriculture Organization of the United Nations (FAO). Like AGROVOC, the LUCKINet land use ontology uses semantic web technology powered by the [Simple Knowledge Organization System](https://www.w3.org/TR/skos-primer/) (SKOS).

The ontology has been primarily developed to support the LUCKINet effort to standardize approaches that develop gridded information on land use dynamics. As standards develop from the needs of various stakeholders, we have designed this ontology in a way that it can grow organically with emerging use cases. The focal unit is the crop or livestock species, which makes it easy to align our ontology with other vocabularies and typologies. The ontology is distinguished into two main sections: landcover and land-use concepts.

We built the ontology with a strong focus on mapping land-use concepts to FAO/AGROVOC concepts to foster interoperability with the wealth of other projects building on AGROVOC. Moreover, concepts from different state-of-the-art datasets, such as land use from statistical agencies worldwide and the (grey) literature, are considered.

You will find landcover concepts in this ontology in an unfamiliar way. In many projects, landcover is an amalgamation of concepts across various functional types of concepts. For example, *cropland* is often regarded as a landcover, but because it also includes human activities managing that cover, it is not a pure *cover* but also a *use* type. We, therefore, revised the former version of this ontology, which was heavily centred on the [CORINE Land Cover](https://land.copernicus.eu/pan-european/corine-land-cover) classification, to be more consistent from a semantic point of view. The ontology is now distinguished into land cover, dynamic and use. *Cover* is characterized purely by the material or entities  covering the surface, *dynamics* are characterized by the most dominant process (such as management or productiveness), and *use* is characterized by how the sphere covering the surface is managed and what is used.

# 2. Method

The ontology was built with the R-package [`ontologics v0.7.3`](https://cran.r-project.org/web/packages/ontologics/index.html), which enables reproducibility and transparency in creating an ontology. A script documenting this process is part of this publication.

Concepts were taken from the external datasets harmonized during the LUCKINet and Global Pasture Watch project (the harmonized data are published on zenodo).

## 2.1 Sources

The ontology is an amalgamation of various datasets:

1.  The [FAO Indicative Crop Classification](https://datalab.review.fao.org/datalab/caliper/web/classification-page/43) (ICC) v1.1 provides a hierarchical structure of crop and livestock concepts.
2.  The [FAO Crops and livestock products](https://www.fao.org/faostat/en/#data/QCL) (QCL) dataset contains a range of concepts used by the FAO and frequently by statistical offices of nations that make their census data publicly available.
3.  The [FAO Land Use](https://www.fao.org/faostat/en/#data/RL) (RL) dataset contains a hierarchical set of land-use concepts that represent the most harmonized representation of land-use concepts to date.
4.  The [FAO Forest Resource Assessment](https://www.fao.org/3/I8661EN/i8661en.pdf) (FRA) contains a detailed set of forest classes that fit well with the FAO Land Use vocabulary and represent relevant classes at a coarse scale (Sections 1b, 1e, 1f).
5.  [CORINE Land Cover](https://land.copernicus.eu/user-corner/technical-library/corine-land-cover-nomenclature-guidelines/html/) (CLC) classes are used as the basis to define the (hierarchical) organization of land cover and land use classes (into which the crop and livestock commodities are nested).

## 2.2 Classes

The ontology is hierarchically structured into the following classes:

-   domain
    -   landcover
        -   land dynamic
            -   land use
    -   production
        -   group
            -   class
                -   crop
                -   animal
-   domain: the overarching dimensions into which all other concepts are nested. These represent conceptually different kinds of classification systems (landcover and production).
-   landcover: surface area described by the predominant landcover in that location.
-   production: surface area described by the crops and livestock produced in that location.
-   land dynamic: surface area described by the predominant attribute determining dynamics within the landcover type.
-   land use: surface area described by mutually exclusive types of how land covered by a particular type and dynamic is used.
-   group: broad groups of concepts that describe crops and livestock.
-   class: mutually exclusive types of concepts that describe crops and livestock.
-   crop/animal: individual commodities (typically at species level).

## 2.3 Concepts

The bulk of the ontology consists of a collection of concepts, each an instance of a specific class. The concepts also bear hierarchical relations determined by their class affiliation. For example, the concept of *Cultivated grazingland* (class: use) is semantically narrower than *Managed vegetation* (class: dynmic), which in turn is narrower than the concept of *VEGETATED LAND* (class: lancover), which is narrower than *landcover* (class: domain).

## 2.4 Mappings

As far as possible, concepts are mapped to all corresponding wikidata and GBIF concepts. For example, the concept of *maize* is mapped to wikidata concepts [Q11575](https://www.wikidata.org/wiki/Q11575) and [Q25618328](https://www.wikidata.org/wiki/Q25618328) and GBIF concept [5290052](https://www.gbif.org/species/5290052). Moreover, concepts are mapped to the

-   life-form concepts *graminoid*, *forb*, *herb*, *shrub*, *tree*
-   purpose concepts *energy*, *fibre*, *food*, *wood*, *forage*, *silage*, *fodder*, *industrial*, *recreation*, *medicinal* and *labour* and *reproduction*
-   used-part concepts *bark*, *bast*, *biomass*, *buds*, *bulb*, *eggs*, *flower*, *fruit*, *hair*, *honey*, *husk*, *leaves*, *lint*, *meat*, *dairy*, *resin*, *root*, *sap*, *seed*, *shoot*, *stalk*, *time*, *tuber, fur* and *silk*
-   agronomic attributes such as the *years-before-harvest* and *years-of-harvest* (i.e., for how many years a crop, once mature, can be harvested)

# 3. Files

-   `make_ontology.R`: The script used to build this ontology
-   `luckiOnto.rds`: the ontology to access and manipulate with R and the ontologics R-package

# 4. Version changes

-   uses a new version of `ontologics`
-   revised hierarchy of landcover concepts
-   includes livestock concepts
-   no mapping to "persistence" concepts anymore, instead years-before-harvest (YBH) and years-of-harvest (YOH) are introduced.
-   various rare species are now included

# 5. Acknowledgements

-   This work was supported by funding to Carsten Meyer through the Flexpool mechanism of the German Centre for Integrative Biodiversity Research (iDiv) (FZT-118, DFG).
-   Several developments in this software stem from work on the GeoKur research data infrastructure. GeoKur is granted by the BMBF (Federal Ministry of Education and Research) under number 16QK04A.
-   Revisions of the ontology pertaining to the landcover hierarchy and livestock concepts were made during the initial funding period of the Global Pasture Watch Project.
