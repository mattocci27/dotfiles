# works with base packages
argv <- commandArgs(trailingOnly = TRUE)
my_lib <- argv[1]

# list of installed packages
lib <- .libPaths()[1]
tmp0 <- as.data.frame(installed.packages(lib), stringsAsFactors=FALSE)
tmp <- tmp0[tmp0$Package != "nvimcom", ] # remove nvimcom to avoid erro
pkg_list <- tmp$Package 
   

res <- sum(grepl(my_lib, pkg_list))

#av_pk <- available.packages(contriburl = contrib.url("https://clound.r-project.org/"))
av_pk <- available.packages(contriburl = contrib.url("https://mirror.lzu.edu.cn/CRAN/"))

pkgInfoRepo <- function(pkg.name, av_pk) {
  if (pkg.name %in% av_pk[,1]){
    d = av_pk[pkg.name,]
    as.character(d["Version"])
  } else {
    print(paste(pkg.name, "is not in CRAN"))
  }
}

if (!is.na(my_lib)) {
  # install packages from Rpkgs_list.txt
  if (res == 0) {
    install.packages(my_lib,
                   #repos = "https://cloud.r-project.org/")
                   repos = "https://mirror.lzu.edu.cn/CRAN/")
  } else {
    print(paste(my_lib, "is already installed!"))
  }
} else {
  # update installed packages
  for (i in 1:nrow(tmp)) {
    pkg <- tmp[i, "Package"]
    ver <- tmp[i, "Version"]

    #if (str_detect(tmp[i,1],pkg)) {
    if (grep(tmp[i,1],pkg)) {
      if (pkgInfoRepo(pkg, av_pk) == ver) {
        print(paste(pkg, "is up to date"))
      } else {
        install.packages(pkg,
                   #  repos = "https://cloud.r-project.org/")
                     repos = "https://mirror.lzu.edu.cn/CRAN/")
      }
    } else {print("not in CRAN")}
  }
}

