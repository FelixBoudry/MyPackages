# Import all csv files of specific folders to a list of data frames
importCsvFolder <-
  function(path_to_data,
           file_type = "*.csv",
           rows_to_import = "all",
           columns_to_import = "all") {
    csvFileList <-
      list.files(path = path_to_data,
                 pattern = file_type,
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
