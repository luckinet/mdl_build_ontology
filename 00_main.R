# ----
# title       : build ontology
# description : This is the main script for building the LUCKINet commodity ontology and territory gazetteer.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2025-01-20
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_ontology.md"))
# ----

# set module-specific paths ----
#
path_onto <- paste0(.get_path("onto",  "_data"), "lucki_onto.rds")
path_gaz <- paste0(.get_path("onto",  "_data"), "lucki_gazetteer.rds")

# run scripts ----
#
.run_submodules(model = model_info, module = "onto")

