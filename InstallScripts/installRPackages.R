# Script installing personal packages from github.

if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}

devtools::install_github(repo = "FelixBoudry/MyPackages",
                         subdir = "R_Packages/DataFrameListPerso")
devtools::install_github(repo = "FelixBoudry/MyPackages",
                         subdir = "R_Packages/DataFramePerso")
devtools::install_github(repo = "FelixBoudry/MyPackages",
                         subdir = "R_Packages/ImportPerso")
devtools::install_github(repo = "FelixBoudry/MyPackages",
                         subdir = "R_Packages/PhysioFunctions")
devtools::install_github(repo = "FelixBoudry/MyPackages",
                         subdir = "R_Packages/TimePerso")
