## ---- OS detection ------------------------------------------------------
os <- Sys.info()[["sysname"]]
## ---- Repository settings -----------------------------------------------
if (identical(os, "Linux") && file.exists("/etc/os-release")) {
  os_release <- NA_character_
  distro <- readLines("/etc/os-release", warn = FALSE)
  version_line <- distro[grep("^VERSION_ID=", distro)]
  if (length(version_line)) {
    os_release <- sub('^VERSION_ID="?([^"]*)"?$', "\\1", version_line)
  }
  if (identical(os_release, "24.04")) {
    options(
      repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/noble/latest")
    )
  } else {
    options(
      repos = c(CRAN = "https://cloud.r-project.org")
    )
  }
} else if (identical(os, "Darwin")) {
  options(
    repos = c(CRAN = "https://cloud.r-project.org"),
    pkgType = "mac.binary.big-sur-arm64",
    install.packages.compile.from.source = "never"
  )
} else {
  options(
    repos = c(CRAN = "https://cloud.r-project.org")
  )
}
## ---- General options ---------------------------------------------------
options(
  blogdown.generator = "jekyll",
  blogdown.method = "custom",
  blogdown.subdir = "assets"
)
## ---- Quit shortcut -----------------------------------------------------
Q <- structure("no", class = "no")
print.no <- q
