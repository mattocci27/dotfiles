# only use base packages
argv <- commandArgs(trailingOnly = TRUE)

my_lib <- argv[1]

pkg_list <- rownames(installed.packages())

res <- sum(grepl(my_lib, pkg_list))

if (res == 0) {
  install.packages(my_lib, 
                 repos = "https://cran.revolutionanalytics.com/")
} else {
  print(paste(my_lib, "is already installed!"))
}
  
