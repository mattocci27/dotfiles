#!/usr/bin/env bash

# set -e

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi
    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

Rscript -e "pacman::p_load(
  tidyverse)"

Rscript -e "pacman::p_load(
  vegan)"

Rscript -e "pacman::p_load(
  rstan)"

if [ $(uname) == "Darwin" ]; then
ask "Install sf packages for mac?" Y && {
  Rscript -e 'install.packages("rgeos", repos="http://R-Forge.R-project.org", type="source")'
  Rscript -e 'install.packages("rgdal", repos="http://R-Forge.R-project.org", type="source")'
  Rscript -e 'install.packages("sf", type = "source", 
     configure.args = c("--with-sqlite3-lib=/opt/homebrew/opt/sqlite/lib",
     "--with-proj-lib=/opt/homebrew/opt/proj/lib"))'
  Rscript -e 'install.packages("terra", type = "source", 
     configure.args = c("--with-sqlite3-lib=/opt/homebrew/opt/sqlite/lib",
     "--with-proj-lib=/opt/homebrew/opt/proj/lib"))'
}
fi

Rscript -e "pacman::p_load(
    AmesHousing,
    FD,
    FactoMineR,
    GGally,
    MuMIn,
    ParBayesianOptimization,
    Rcpp,
    RcppEigen,
    RcppNumerical,
    adephylo,
    adespatial,
    animation,
    blogdown,
    bookdown,
    caper,
    clustermq,
    corrplot,
    cowplot,
    devtools,
    doMC,
    doSNOW,
    entropart,
    factoextra,
    flair,
    fontawesome,
    furrr,
    future,
    future.batchtools,
    future.callr,
    ggrepel,
    ggthemes,
    hexbin,
    httpgd,
    janitor,
    kableExtra,
    kfigr,
    languageserver,
    lavaan,
    lavaanPlot,
    lightgbm,
    lme4,
    memisc,
    microbenchmark,
    mnormt,
    multcompView,
    mvtnorm,
    nlme,
    pander,
    phytools,
    picante,
    png,
    provenance,
    rmarkdown,
    rstanarm,
    sads,
    semPlot,
    shiny,
    skimr,
    smatr,
    snowfall,
    tarchetypes,
    targets,
    tictoc,
    tidymodels,
    tidyverse,
    vegan,
    visNetwork
    )"
