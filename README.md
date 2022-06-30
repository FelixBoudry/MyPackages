title: MyPackages
author: "Félix Boudry"
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

### DataFrameListPerso

Functions used to manipulate or repeat actions on dataframes stored in lists.

### DataFramePerso

Functions used to manipulate dataframes

### ImportR

Functions that allow importing multiple files (csv, xlsx, etc.) from folders.

### PhysioFunctions

Specifics functions used to analyse physiological data.

### SortPerso

Used to find data and informations about subjects.

### Times perso

Functions used to manipulate time data in dataframes, such as retriving time to
max duration.
