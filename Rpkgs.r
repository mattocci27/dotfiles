# works with base packages

argv <- commandArgs(trailingOnly = TRUE)

my_lib <- argv[1]


# list of installed packages
lib <- .libPaths()[1]
tmp0 <- as.data.frame(installed.packages(lib), stringsAsFactors=FALSE)
tmp <- tmp0[tmp0$Package != "nvimcom", ] # remove nvimcom to avoid erro
pkg_list <- tmp$Package 
   

res <- sum(grepl(my_lib, pkg_list))

pkgInfoRepo <- function(pkg.name, url = "https://cran.revolutionanalytics.com/") {
  d = available.packages(contriburl = contrib.url(url))[pkg.name,]
  as.character(d["Version"])
}

if (!is.na(my_lib)) {
  # install packages from Rpkgs_list.txt
  if (res == 0) {
    install.packages(my_lib,
                   repos = "https://cran.revolutionanalytics.com/")
  } else {
    print(paste(my_lib, "is already installed!"))
  }
} else {
  # update installed packages
  for (i in 1:nrow(tmp)) {
    pkg <- tmp[i, "Package"]
    ver <- tmp[i, "Version"]

    if (pkgInfoRepo(pkg) == ver) {
      print(paste(pkg, "is up to date"))
    } else {
      install.packages(pkg,
                   repos = "https://cran.revolutionanalytics.com/")
    }
  }
}
