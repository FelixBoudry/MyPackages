% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/importCsvFolder.R
\name{importCsvFolder}
\alias{importCsvFolder}
\title{importCsvFolder}
\usage{
importCsvFolder(dataPath, rowsToImport = "all", colsToImport = "all")
}
\arguments{
\item{dataPath}{Location of the folder containing the data to import.}

\item{rowsToImport}{First row to import (default = "all").}

\item{colsToImport}{First column to import (default = "all").}
}
\value{
Return a list of dataframes containing the data from specified
  folder. The dataframes are subset by first row and column specified.
}
\description{
Import all csv files of specific folders to a list of data
  frames.
}
\examples{
\dontrun{importCsvFolder("./datas/myFolder/")}

}
