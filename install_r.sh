#!/bin/sh
set -e
R_VERSION=4.0.3

## Download source code
curl -O https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz
## Extract source code
tar -xf R-${R_VERSION}.tar.gz
cd R-${R_VERSION}

## Set compiler flags
#R_PAPERSIZE=letter \
#R_BATCHSAVE="--no-save --no-restore" \
#R_BROWSER=xdg-open \
R_BROWSER=open
#PAGER=/usr/bin/pager \
#PERL=/usr/bin/perl \
#R_UNZIPCMD=/usr/bin/unzip \
#R_ZIPCMD=/usr/bin/zip \
#R_PRINTCMD=/usr/bin/lpr \
#LIBnn=lib \
#AWK=/usr/bin/awk \
CFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g"
CXXFLAGS="-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g"


FC="/usr/local/gfortran/bin/gfortran"
FLIBS="-L/usr/local/gfortran/lib/gcc/x86_64-apple-darwin18/8.2.0
  -L/usr/local/gfortran/lib -lgfortran -lquadmath -lm"

## Configure options
./configure --enable-R-shlib \
            --enable-memory-profiling \
            --with-readline \
            --with-blas="-lopenblas" \
            --with-tcltk \
            --disable-nls \
            --with-recommended-packages

## Build and install
make
make install

## Add a library directory (for user-installed packages)
&& mkdir -p /usr/local/lib/R/site-library \
&& chown root:staff /usr/local/lib/R/site-library \
&& chmod g+ws /usr/local/lib/R/site-library \
## Fix library path
&& sed -i '/^R_LIBS_USER=.*$/d' /usr/local/lib/R/etc/Renviron \
&& echo "R_LIBS_USER=\${R_LIBS_USER-'/usr/local/lib/R/site-library'}" >> /usr/local/lib/R/etc/Renviron \
&& echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/library'}" >> /usr/local/lib/R/etc/Renviron \
## Set configured CRAN mirror
&& if [ -z "$BUILD_DATE" ]; then MRAN=$CRAN; \
 else MRAN=https://mran.microsoft.com/snapshot/${BUILD_DATE}; fi \
 && echo MRAN=$MRAN >> /etc/environment \
&& echo "options(repos = c(CRAN='$MRAN'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site

ln -sf /usr/local/opt/openblas/lib/libopenblas.dylib /usr/local/Cellar/r/4.0.3/lib/R/lib/libRblas.dylib

BLAS:   /usr/local/lib/R/lib/libRblas.dylib

a <- rnorm(9)
b <- rnorm(9)
a1 <- matrix(a, ncol = 3)
b1 <- matrix(b, ncol = 3)
a1 %*% b1

a <- rnorm(2^12)
b <- rnorm(2^12)
a1 <- matrix(a, ncol = 2^6)
b1 <- matrix(b, ncol = 2^6)
system.time(a1 %*% b1)

log2(4096)
