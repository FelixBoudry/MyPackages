#' @title importCsvFolder
#' @description Import all csv files of specific folders to a list of data
#'   frames.
#'
#' @param dataPath Location of the folder containing the data to import.
#' @param rowsToImport First row to import (default = "all").
#' @param colsToImport First column to import (default = "all").
#'
#' @return Return a list of dataframes containing the data from specified
#'   folder. The dataframes are subset by first row and column specified.
#'
#' @importFrom utils read.csv
#'
#' @examples
#' \dontrun{importCsvFolder("./datas/myFolder/")}
#'
#' @export

importCsvFolder <-
  function(dataPath,
           rowsToImport = "all",
           colsToImport = "all") {
    csvFileList <-
      list.files(path = dataPath,
                 pattern = ".*.csv",
                 full.names = TRUE)
    dataTables <-
      lapply(csvFileList, read.csv, na.strings = c("", " ", "NA", "Na", "na"))
    if (rowsToImport == "all" && colsToImport == "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][]
      }
    }
    else if (rowsToImport == "all" &&
             colsToImport != "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][, colsToImport]
      }
    }
    else if (rowsToImport != "all" &&
             colsToImport == "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][rowsToImport, ]
      }
    }
    else {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <-
          dataTables[[i]][rowsToImport, colsToImport]
      }
    }
    names(dataTables) <-
      gsub("^.*/", "", csvFileList) #Delete path part and names data frames
    return(dataTables)
  }
