#!/bin/bash
#
# Script to install pirouette and its dependencies
# on the Peregrine computer cluster
#
# Usage:
# 
# sbatch install_pirouette.sh
#
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=install_pirouette
#SBATCH --output=install_pirouette.log
#module load GCCcore/4.9.3 
#module load XZ/5.2.2-foss-2016a
module load R
Rscript -e 'devtools::install_github("ropensci/mauricer")'
Rscript -e 'devtools::install_github("ropensci/babette")'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys")'
Rscript -e 'beastier::install_beast2()'
Rscript -e 'mauricer::install_beast2_pkg("NS")' || true
