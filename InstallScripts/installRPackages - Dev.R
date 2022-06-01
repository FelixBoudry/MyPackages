# Script installing personal packages from github in the dev version.

if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/DataFrameListPerso")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/DataFramePerso")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/ImportPerso")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/PhysioFunctions")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/TimePerso")
