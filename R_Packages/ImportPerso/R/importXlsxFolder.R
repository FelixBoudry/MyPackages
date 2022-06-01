#' Import all excel files of specific folders to a list of data frames
#'
#' @param dataPath Location of the folder containing the data
#' @param rowsToImport First row to import (default = "all").
#' @param colsToImport First column to import (default = "all").
#'
#' @return Return a list of dataframes containing the informations from the first row and column to the end of the files.
#' @export
#'
#' @examples
#' importXlsxSep("./datas/myFolder/")
#'
importXlsxSep <-
  function(dataPath,
           rowsToImport = "all",
           colsToImport = "all",
           ...) {
    if (!require(readxl)) {
      install.packages("readxl");
      library(readxl)
      }
    csvFileList <-
      list.files(path = dataPath,
                 full.names = TRUE)
    dataTables <- lapply(csvFileList, read_excel, ...)
    if (rowsToImport == "all" && colsToImport == "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][] %>%
          clean_names()
      }
    }
    else if (rowsToImport == "all" &&
             colsToImport != "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][, colsToImport] %>%
          clean_names()
      }
    }
    else if (rowsToImport != "all" &&
             colsToImport == "all") {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <- dataTables[[i]][rowsToImport,] %>%
          clean_names()
      }
    }
    else {
      for (i in 1:length(csvFileList)) {
        dataTables[[i]] <-
          dataTables[[i]][rowsToImport, colsToImport] %>%
          clean_names()
      }
    }
    names(dataTables) <-
      gsub("^.*/", "", csvFileList) #Delete path part and names data frames
    return(dataTables)
  }
