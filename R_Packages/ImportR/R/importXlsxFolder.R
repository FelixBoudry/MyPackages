#' @title importXlsxFolder
#' @description Import all excel files of specific folders to a list of data
#'   frames.
#'
#' @param dataPath Location of the folder containing the data to import.
#' @param rowsToImport First row to import (default = "all").
#' @param colsToImport First column to import (default = "all").
#' @param ... Add parameters to "read_excel".
#'
#' @return Return a list of dataframes containing the data from specified
#'   folder. The dataframes are subset by first row and column specified.
#'
#' @importFrom readxl read_excel
#' @importFrom janitor %>% clean_names
#'
#' @examples
#' \dontrun{importXlsxSep("./datas/myFolder/")}
#'
#' @export

importXlsxSep <-
  function(dataPath,
           rowsToImport = "all",
           colsToImport = "all",
           ...) {
    csvFileList <-
      list.files(path = dataPath,
                 full.names = TRUE)
    dataTables <- lapply(csvFileList, read_excel, na = c("", " ", "NA", "Na", "na"), ...)
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
