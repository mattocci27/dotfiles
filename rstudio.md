sudo docker run --rm --name rstudio -p 8787:8787 -e PASSWORD=test rocker/rstudio

sudo docker run -d --name rstudio -e PASSWORD=test -p 8787:8787 rocker/rstudio
