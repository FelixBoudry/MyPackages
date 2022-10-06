title: MyPackages
author: "Felix Boudry"
date: "3/31/2022"


# MyPackages

This repository is used as storage for my personal packages. They can be easily
installed using the install scripts.

# Install instructions

## R

You should install the package you want using the following command:
devtools::install_github(repo = "FelixBoudry/MyPackages",
                         ref = "branch",
                         subdir = "R_Packages/package_name")

Installation scripts are available in the InstallScripts folder.

# Packages

## R

### ImportR

Functions that allow importing multiple files (csv, xlsx, etc.) from folders.