#################################################################
# Dockerfile
#
# Description:      R and required packages for the analysis of Affymetrix microarrays
# Tags:             None, for the moment
# Base Image:       r-base:3.4.0
#################################################################

#R image to be the base in order to build our new image
FROM r-base:3.4.0

#Create directories to save results
RUN mkdir /home/marnal
RUN mkdir projects
RUN mkdir /projects/sam

#Install Ubuntu extensions in order to run r
RUN apt-get update && apt-get install -y \
    r-cran-xml \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev
    
ENV PATH=pkg-config:$PATH

#Install Bioconductor packages first
RUN Rscript -e 'source("https://bioconductor.org/biocLite.R"); biocLite(pkgs=c("sva","Biobase","limma", "BiocGenerics","affxparser","affy", "affyPLM", "aroma.light", "gcrma", "oligo", "oligoClasses", "pdInfoBuilder", "preprocessCore", "AffymetrixDataTestFiles", "DNAcopy"))'

#Install packages from CRAN
RUN Rscript -e 'install.packages(c("R.utils","aroma.affymetrix","data.table", "gtools", "Rcpp","RColorBrewer", "gplots","scatterplot3d"))'

#Set wokingDir in /
WORKDIR /
