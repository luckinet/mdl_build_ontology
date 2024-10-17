# 2024-10-17

- edit readme to include not only the ontology, but also the gazetteer and to be more general.

# 2024-09-27

- publish version 2 of the LUCKINet land-use ontology to zenodo.

# 2023-06-05 - extension to level 6

- for the GPW project, data at level 6 are available, hence the ontology needed to be extended.
- rework extracting and integrating the previous labels, which made the code simpler to understand and able to run for all levels

# 2023-05-26 - animal types

- include animal types to distinguish cattle, goats and sheep further
- provide use_type and used_part from the respective look-up table
- revise mapping attributes to commodities and to animal types
- revise documentation of the attributes per section

# 2023-04-21 - initial recording (changes from 1.0.0)

- reorganise land use and land cover classification. It's questionable whether land use concepts can properly be nested within land cover, because different covers can have the same use (where unique nesting is impossible) and because different data products of land cover have different legends (where a land use may have to be mapped to different land covers, with potentially the same name but different meaning in different land cover products)
- include a clc (Corine landcover) and esalc (ESA CCI Landcover) label that assign the land use class to (several) land cover classes
- write clearer descriptions for all concepts
- introduce attributes for commodities and create mappings for them. Those are intended for modelling and allocation
