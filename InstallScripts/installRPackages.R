# Script installing personal packages from github.

if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

install_github("FelixBoudry/MyPackages",
               subdir = "R_Packages/DataFrameListPerso")
install_github("FelixBoudry/MyPackages",
               subdir = "R_Packages/DataFramePerso")
install_github("FelixBoudry/MyPackages",
               subdir = "R_Packages/ImportPerso")
install_github("FelixBoudry/MyPackages",
               subdir = "R_Packages/PhysioFunctions")
install_github("FelixBoudry/MyPackages",
               subdir = "R_Packages/TimePerso")
