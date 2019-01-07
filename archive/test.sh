#!/bin/sh
# Anticonf (tm) script by Jeroen Ooms (2015)
# This script will query 'pkg-config' for the required cflags and ldflags.
# If pkg-config is unavailable or does not find the library, try setting
# INCLUDE_DIR and LIB_DIR manually via e.g:
# R CMD INSTALL --configure-vars='INCLUDE_DIR=/.../include LIB_DIR=/.../lib'

# Library settings
PKG_CONFIG_NAME="libxml-2.0"
PKG_DEB_NAME="libxml2-dev"
PKG_RPM_NAME="libxml2-devel"
PKG_CSW_NAME="libxml2_dev"
PKG_TEST_HEADER="<libxml/tree.h>"
PKG_LIBS="-lxml2"

# Use xml2-config if available
xml2-config --version >/dev/null 2>&1
if [ $? -eq 0 ]; then
  PKGCONFIG_CFLAGS=`xml2-config --cflags`
  PKGCONFIG_LIBS=`xml2-config --libs`

  echo $PKGCONFIG_CFLAGS
  # MacOS versions El Capitan and later ship a xml2-config which appends `xcrun
  # --show-sdk-path` to the xml2-config. So we remove it if it is present.
  # (https://stat.ethz.ch/pipermail/r-sig-mac/2016-September/012046.html)
  if echo $OSTYPE | grep -q '^darwin'; then
    PKGCONFIG_CFLAGS=`echo $PKGCONFIG_CFLAGS | perl -pe "s{\Q\`xcrun -show-sdk-path\`\E}{}"`
    PKGCONFIG_LIBS=`echo $PKGCONFIG_LIBS | perl -pe "s{\Q\`xcrun -show-sdk-path\`\E}{}"`

  echo $PKGCONFIG_CFLAGS | perl -pe "s{\Q\`xcrun -show-sdk-path\`\E}{}"

  PKGCONFIG_CFLAGS=`xml2-config --cflags`
  PKGCONFIG_CFLAGS=`echo $PKGCONFIG_CFLAGS | perl -pe "s{\Q\`xcrun -show-sdk-path\`\E}{}"`
  echo $PKGCONFIG_CFLAGS
  fi
else
  pkg-config --version >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    PKGCONFIG_CFLAGS=`pkg-config --cflags $PKG_CONFIG_NAME`
    PKGCONFIG_LIBS=`pkg-config --libs $PKG_CONFIG_NAME`
  fi
fi

# Note that cflags may be empty in case of success
if [ "$INCLUDE_DIR" ] || [ "$LIB_DIR" ]; then
  echo "Found INCLUDE_DIR and/or LIB_DIR!"
  PKG_CFLAGS="-I$INCLUDE_DIR $PKG_CFLAGS"
  PKG_LIBS="-L$LIB_DIR $PKG_LIBS"
elif [ "$PKGCONFIG_CFLAGS" ] || [ "$PKGCONFIG_LIBS" ]; then
  echo "Found pkg-config cflags and libs!"
  PKG_CFLAGS=${PKGCONFIG_CFLAGS}
  PKG_LIBS=${PKGCONFIG_LIBS}
fi

# Find compiler
CC=`${R_HOME}/bin/R CMD config CC`
CFLAGS=`${R_HOME}/bin/R CMD config CFLAGS`
CPPFLAGS=`${R_HOME}/bin/R CMD config CPPFLAGS`

# For debugging
echo "Using PKG_CFLAGS=$PKG_CFLAGS"
echo "Using PKG_LIBS=$PKG_LIBS"

# Test configuration
echo "#include $PKG_TEST_HEADER" | ${CC} ${CPPFLAGS} ${PKG_CFLAGS} ${CFLAGS} -E -xc - >/dev/null 2>&1 || R_CONFIG_ERROR=1;

