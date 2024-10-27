# ----
# title       : build ontology - make gazetteer
# description : This is a script for building the LUCKINet territory gazetteer.
# license     : https://creativecommons.org/licenses/by-sa/4.0/
# authors     : Steffen Ehrmann
# date        : 2024-09-27
# version     : 1.0.0
# status      : done
# comment     : file.edit(paste0(dir_docs, "/documentation/mdl_build_ontology.md"))
# ----

message("\n---- build gazetteer for territories ----")

# make paths ----
#
ontoDir <- .get_path("onto", "_data")
path_gadm <- paste0(ontoDir, "gadm_410-levels.gpkg")
path_gadm_zip <- paste0(ontoDir, "gadm_410-levels.zip")
path_geoschemeToGADM <- paste0(ontoDir, "geoscheme_to_gadm.rds")

# load data ----
#
# unpack the file, if it's not yet unpacked
if(!testFileExists(path_gadm)){
  if(!testFileExists(path_gadm_zip)){
    stop("please store the GADM dataset in '", ontoDir, "'")
  } else {
    message(" --> unpacking GADM basis")
    unzip(path_gadm_zip, exdir = ontoDir)
  }
}

gadm <- st_read(dsn = path_gadm, layer = "ADM_0") |>
  st_drop_geometry() |>
  rename(NAME_0 = COUNTRY)
gadm_layers <- st_layers(dsn = path_gadm)

geoscheme <- read_csv2(file = paste0(ontoDir, "UNSD — Methodology.csv"))

# 3. data processing ----
#
other <- tibble(un_region = c("Asia", "Europe", "Asia"),
                un_subregion = c("Eastern Asia", "Southern Europe", "Western Asia"),
                iso_a3 = c("TWN", "XKO", "ZNC"),
                unit = c("Taiwan", "Kosovo", "Northern Cyprus"))

# first, build the UN geoscheme ...
temp_geoseries <- geoscheme |>
  mutate(un_subregion = if_else(!is.na(`Intermediate Region Name`), `Intermediate Region Name`, `Sub-region Name`)) |>
  select(unit = `Country or Area`,
         un_region = `Region Name`,
         un_subregion,
         m49 = `M49 Code`,
         iso_a2 = `ISO-alpha2 Code`,
         iso_a3 = `ISO-alpha3 Code`) |>
  filter(!is.na(un_region)) |>  # this filters out only Antarctica
  bind_rows(other) |>
  full_join(gadm, by = c("iso_a3" = "GID_0")) |>
  filter(!is.na(un_region)) |>
  filter(!is.na(NAME_0))

# ... then, start a new ontology
message(" --> initiate gazetteer")
gazetteer <- start_ontology(name = "lucki_gazetteer", path = dir_data,
                            version = "1.0.0",
                            code = ".xxx",
                            description = "the intial LUCKINet gazetteer",
                            homepage = "https://www.luckinet.org",
                            license = "https://creativecommons.org/licenses/by/4.0/",
                            notes = "This gazetteer nests each country and their sub-level territories into the United Nations geoscheme.")

# define GADM as source
gazetteer <- new_source(name = "gadm",
                        version = "4.1",
                        date = Sys.Date(),
                        description = "GADM wants to map the administrative areas of all countries, at all levels of sub-division. We provide data at high spatial resolutions that includes an extensive set of attributes.",
                        homepage = "https://gadm.org/index.html",
                        license = "https://creativecommons.org/licenses/by/4.0/",
                        ontology = gazetteer)

gazetteer <- new_source(name = "alt",
                        version = "4.1",
                        date = Sys.Date(),
                        description = "alternative territory names according to GADM",
                        homepage = "https://gadm.org/index.html",
                        license = "https://creativecommons.org/licenses/by/4.0/",
                        ontology = gazetteer)

# define new classes
gazetteer <- new_class(new = "un_region", target = NA,
                       description = "region according to the UN geoscheme", ontology = gazetteer)
gazetteer <- new_class(new = "un_subregion", target = "un_region",
                       description = "sub-region according to the UN geoscheme", ontology = gazetteer)
gazetteer <- new_class(new = "ADM0", target = "un_subregion",
                       description = "the first administrative level of the GADM gazetteer", ontology = gazetteer)
gazetteer <- new_class(new = "ADM1", target = "ADM0",
                       description = "the second administrative level of the GADM gazetteer", ontology = gazetteer)
gazetteer <- new_class(new = "ADM2", target = "ADM1",
                       description = "the third administrative level of the GADM gazetteer", ontology = gazetteer)
gazetteer <- new_class(new = "ADM3", target = "ADM2",
                       description = "the fourth administrative level of the GADM gazetteer", ontology = gazetteer)
gazetteer <- new_class(new = "ADM4", target = "ADM3",
                       description = "the fifth administrative level of the GADM gazetteer", ontology = gazetteer)
gazetteer <- new_class(new = "ADM5", target = "ADM4",
                       description = "the sixth administrative level of the GADM gazetteer", ontology = gazetteer)

# define the harmonised concepts
message("     UN geoscheme")
un_region <- toupper(unique(temp_geoseries$un_region))

gazetteer <- new_concept(new = un_region,
                         class = "un_region",
                         ontology =  gazetteer)

un_subregion <- temp_geoseries |>
  select(broader = un_region, concept = un_subregion) |>
  distinct() |>
  mutate(broader = toupper(broader))

tempConcepts <- get_concept(label = un_subregion$broader, ontology = gazetteer) |>
  left_join(un_subregion |> select(label = broader, concept), ., by = "label")
gazetteer <- new_concept(new = tempConcepts$concept,
                         broader = tempConcepts,
                         class = "un_subregion",
                         ontology =  gazetteer)

for(i in 1:6){

  message("     GADM level ", i)

  thisLabel <- paste0("NAME_", i-1)
  gazetteer <- new_mapping(new = thisLabel,
                           target = tibble(label = paste0("ADM", i-1)),
                           source = "gadm", match = "close", certainty = 3,
                           type = "class", ontology = gazetteer)

  if(i == 1){
    prevLabel <- "un_subregion"
  } else {
    prevLabel <- paste0("NAME_", i-2)
  }

  temp <- st_read(dsn = path_gadm, layer = gadm_layers$name[i]) |>
    st_drop_geometry() |>
    rename(NAME_0 = COUNTRY) |>
    rename(iso_a3 = GID_0) |>
    as_tibble() |>
    mutate(across(everything(), ~na_if(x = ., y = "NA"))) |>
    filter(if_any(matches(paste0("ENGTYPE_", i-1)), ~ !.x %in% c("Water body", "Water Body", "Waterbody"))) |>
    # selecting only distinct values will keep the nation, but not the disputed areas that are listed under the same COUNTRY value.
    distinct(pick(starts_with("NAME_")), .keep_all = TRUE) |>
    mutate(across(all_of(contains("NAME_")),
                  function(x){
                    temp <- trimws(x)
                    str_replace_all(string = temp, pattern = "[.]", replacement = "")
                  })) |>
    select(-NAME_0)

  mapGADM <- temp |>
    mutate(gadm = TRUE) |>
    full_join(temp_geoseries, by = "iso_a3") |>
    # mutate(!!thisLabel := if_else(is.na(!!sym(thisLabel)), !!sym(prevLabel), !!sym(thisLabel))) |>
    select(-NAME_0) |>
    rename(NAME_0 = unit) |>
    filter(!is.na(un_subregion)) |>
    filter(!is.na(gadm))

  if(i == 1){

    mapGADM <- mapGADM |>
      rename("previous_label" = !!prevLabel)

    previous <- get_concept(label = un_subregion$concept, ontology = gazetteer) |>
      rename(previous_label = label)

  } else {

    if(any(c(paste0("VARNAME_", i-1), paste0("NL_NAME_", i-1)) %in% colnames(mapGADM))){
      mapGADM <- mapGADM |>
        # summarize alternative names and type into a distinct column
        unite(alt, any_of(paste0("VARNAME_", i-1)), any_of(paste0("NL_NAME_", i-1)), sep = "|", na.rm = TRUE) |>
        mutate(across("alt", ~na_if(x = ., y = "")))
    } else {
      mapGADM <- mapGADM |>
        mutate(alt = NA_character_)
    }

    mapGADM <- mapGADM |>
      unite(col = "previous_label", sort(str_subset(colnames(mapGADM), "^NAME_"))[1:(i-1)], sep = ".", na.rm = TRUE, remove = FALSE)

    if(i == 2) {
      previous <- get_concept(label = items[[prevLabel]], has_broader = items$id, class = paste0("ADM", i-2), ontology = gazetteer) |>
        rename(previous_label = label)
    } else {
      previous <- get_concept(label = items[[prevLabel]], has_broader = items$id, class = paste0("ADM", i-2), ontology = gazetteer) |>
        left_join(previous |> select(id, previous_label), c("has_broader" = "id")) |>
        unite(col = "previous_label", previous_label, label, sep = ".", na.rm = TRUE, remove = FALSE)
    }

  }

  items <- mapGADM |>
    filter(!is.na(!!sym(thisLabel))) |>
    # get previous names into the tibble
    left_join(previous, by = "previous_label") |>
    filter(!is.na(id) | !is.na(has_broader))

  # test whether broader concepts are all present
  broaderMissing <- get_concept(label = items[[{{thisLabel}}]], ontology = gazetteer) |>
    filter(is.na(id))
  if(dim(broaderMissing)[1] != 0) stop("some broader concepts are missing from the current ontology!")

  # assign the new concepts into the ontology
  gazetteer <- new_concept(new = items |> pull({{thisLabel}}),
                           broader = items |> select(id, label = previous_label, class),
                           class = paste0("ADM", i-1),
                           ontology =  gazetteer)

  if(i == 1){

    # at the national level, also assign the nation already as close match
    gazetteer <- new_mapping(new = items$NAME_0,
                             target = left_join(items |> select(label = NAME_0),
                                                get_concept(label = items$NAME_0, ontology = gazetteer),
                                                by = "label") |>
                               select(id, label, class, has_broader),
                             source = "gadm", match = "close", certainty = 3,
                             ontology = gazetteer)

  } else {

    # map the alternative names and territory type
    if(any(!is.na(items$alt))){

      allItems <- items |>
        separate_longer_delim(cols = alt, delim = "|")
      gazetteer <- new_mapping(new = allItems |> pull(alt),
                               target = left_join(allItems |> select(label = {{thisLabel}}, has_broader = id),
                                                  get_concept(label = allItems |> pull({{thisLabel}}), has_broader = allItems$id, class = paste0("ADM", i-1), ontology = gazetteer),
                                                  by = c("label", "has_broader")),
                               source = "alt", match = "close", certainty = 3,
                               ontology = gazetteer)
    }

  }

}

# 4. write output ----
#
write_rds(x = temp_geoseries, file = path_geoschemeToGADM)
write_rds(x = gazetteer, file = path_gaz)
gaz_updated <- TRUE


# beep(sound = 10)
message("\n     ... done")
