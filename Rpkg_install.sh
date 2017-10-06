#!/bin/sh
while read line
do
  echo $line
  export line
  Rscript .R/Rpkgs.r $line
done < .R/Rpkgs_list.txt
