
```
> cat /usr/local/Homebrew/Library/Homebrew/os/mac/pkgconfig/10.14/libxml-2.0.pc           INSERT
prefix=/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include
modules=1

Name: libXML
Version: 2.9.4
Description: libXML library version2.
Requires:
Libs: -L${libdir} -lxml2
Libs.private: -lz -lpthread -licucore -lm
Cflags: -I${includedir}/libxml2

```


```
prefix=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include
modules=1

Name: libXML
Version: 2.9.4
Description: libXML library version2.
Requires:
Libs: -L${libdir} -lxml2 -lz -lpthread -licucore -lm
Libs.private: -lz -lpthread -licucore -lm
Cflags: -I${includedir}/libxml2
```


mkdir tmp
cd tmp
wget https://cran.r-project.org/src/contrib/xml2_1.2.0.tar.gz
R CMD INSTALL xml2_1.2.0.tar.gz 


R CMD INSTALL xml2_1.2.0.tar.gz --configure-vars='INCLUDE_DIR=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include LIB_DIR=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/lib'
