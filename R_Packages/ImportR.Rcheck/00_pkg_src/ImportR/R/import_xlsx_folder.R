#' @title importXlsxFolder
#' @description Import all excel files of specific folders to a list of data
#'   frames.
#'
#' @param data_path Location of the folder containing the data to import.
#' @param rows_to_import First row to import (default = "all").
#' @param cols_to_import First column to import (default = "all").
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

import_xlsx_folder <-
  function(data_path,
           rows_to_import = "all",
           cols_to_import = "all",
           ...) {
    csv_file_list <-
      list.files(path = data_path,
                 full.names = TRUE)
    data_tables <- lapply(csv_file_list, read_excel, ...)
    if (rows_to_import == "all" && cols_to_import == "all") {
      for (i in 1:length(csv_file_list)) {
        data_tables[[i]] <- data_tables[[i]][] %>%
          clean_names()
      }
    }
    else if (rows_to_import == "all" &&
             cols_to_import != "all") {
      for (i in 1:length(csv_file_list)) {
        data_tables[[i]] <- data_tables[[i]][, cols_to_import] %>%
          clean_names()
      }
    }
    else if (rows_to_import != "all" &&
             cols_to_import == "all") {
      for (i in 1:length(csv_file_list)) {
        data_tables[[i]] <- data_tables[[i]][rows_to_import,] %>%
          clean_names()
      }
    }
    else {
      for (i in 1:length(csv_file_list)) {
        data_tables[[i]] <-
          data_tables[[i]][rows_to_import, cols_to_import] %>%
          clean_names()
      }
    }
    names(data_tables) <-
      gsub("^.*/", "", csv_file_list) #Delete path part and names data frames
    return(data_tables)
  }
