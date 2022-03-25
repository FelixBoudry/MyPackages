#' Import all csv files of specific folders to a list of data frames
#'
#' @param path_to_data Location of the folder containing the data
#' @param rows_to_import First row to import (default = "all").
#' @param columns_to_import First column to import (default = "all").
#'
#' @return Return a list of dataframes containing the informations from the first row and column to the end of the files.
#' @export
#'
#' @examples
importCsvFolder <-
  function(path_to_data,
           rows_to_import = "all",
           columns_to_import = "all") {
    csvFileList <-
      list.files(path = path_to_data,
                 pattern = ".*.csv",
                 full.names = TRUE)
    dataTables <- lapply(csvFileList, read.csv, na.strings = c("", " ", "NA", "Na", "na"))
    if (rows_to_import == "all" && columns_to_import == "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][]
      }
    }
    else if (rows_to_import == "all" &&
             columns_to_import != "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][, columns_to_import]
      }
    }
    else if (rows_to_import != "all" &&
             columns_to_import == "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][rows_to_import,]
      }
    }
    else {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <-
          dataTables[[i]][rows_to_import, columns_to_import]
      }
    }
    names(dataTables) <-
      gsub("^.*/", "", csvFileList) #Delete path part and names data frames
    return(dataTables)
  }
