# ----
# title       : build ontology
# description : This is the main script for building the LUCKINet commodity ontology and territory gazetteer.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-27
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_ontology.md"))
# ----

# set module-specific paths ----
#
dir_data <- .get_path("onto",  "_data")
path_onto <- paste0(dir_data, "lucki_onto.rds")


# run scripts ----
#
.run_submodules(model = model_info, module = "onto")

