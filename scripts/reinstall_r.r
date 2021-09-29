# setup
if (!require(tidyverse)) install.packages("tidyverse")
if (!require(fs)) install.packages("fs")
library(tidyverse)
library(fs)
# get all installed R versions
if (Sys.info()[["sysname"]] == "Darwin") { 
  r_dir <- tibble::tibble(path = fs::dir_ls(fs::path_dir(fs::path_dir(fs::path_dir(.libPaths()[[1]])))))
}
if (Sys.info()[["sysname"]] %in% c("Linux", "Windows")) {
  r_dir <- tibble::tibble(path = fs::dir_ls(fs::path_dir(.libPaths()[[1]])))
}
# cue music
r_dir <- r_dir %>%
  # drop current R version
  dplyr::filter(!(stringr::str_detect(path, "Current"))) %>%
  # extract the current and penultimate R versions as strings
  dplyr::rowwise() %>%
  dplyr::mutate(version = as.numeric(stringr::str_extract(path, "[0-9]\\.[0-9]"))) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(new_r = dplyr::nth(version, -1L), old_r = dplyr::nth(version, -2L)) %>%
  dplyr::mutate_at(vars("new_r", "old_r"), ~as.character(formatC(.x, digits = 1L, format = "f"))) %>%
  dplyr::filter(version == old_r)
# get new and old R library paths
new_libpath <- .libPaths()
old_libpath <- stringr::str_replace(new_libpath, r_dir$new_r, r_dir$old_r)
# get list of old installed R packages
pkg_list <- as.list(list.files(old_libpath))
# define install_all() function
install_all <- function(x) {
  print(x)
  install.packages(x, quiet = TRUE)
}
# install all R packages in pkg_list
purrr::quietly(purrr::walk(pkg_list, install_all))
