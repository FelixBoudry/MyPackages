# Script installing personal packages from github in the dev version.

if (require(!devtools)) {
  install.packages("devtools")
  library(devtools)
}

install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/DataFrameListPerso",
               auth_token = "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")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/DataFramePerso",
               auth_token = "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")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/ImportPerso",
               auth_token = "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")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/PhysioFunctions",
               auth_token = "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")
install_github("FelixBoudry/MyPackages",
               subdir = "tree/Dev/R_Packages/TimePerso",
               auth_token = "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")
