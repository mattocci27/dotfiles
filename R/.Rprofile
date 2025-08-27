# Get the operating system information
os_info <- Sys.info()["sysname"]

if (os_info == "Linux") {
  distro_info <- system("cat /etc/os-release", intern = TRUE)

  # Extract the version_id from distro_info
  version_line <- distro_info[grep("^VERSION_ID", distro_info)]

  if (length(version_line) > 0) {
    os_release <- sub(".*=\"?([^\"]*)\"?", "\\1", version_line)
  }
}

# Set CRAN repository and package type based on OS
if (os_info == "Linux" && os_release == "22.04") {
  options(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/jammy/latest"))
} else if (os_info == "Darwin") {
  options(
    repos   = c(CRAN = "https://cran.r-project.org"),  # use CRAN for Mac binaries
    pkgType = "mac.binary.arm64"                       # prefer ARM binaries on Apple Silicon
  )
} else if (os_info == "Windows") {
  options(repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"))
}

# read packages
options(
  #defaultPackages=c(getOption("defaultPackages"),"tidyverse", "rmarkdown"),
  blogdown.generator = "jekyll",
  blogdown.method = "custom",
  blogdown.subdir = "assets"
)

# short cut for quit
class(Q)=Q="no";print.no=q
