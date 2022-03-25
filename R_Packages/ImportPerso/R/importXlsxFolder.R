import.xlsx.sep <-
  function(path_to_data,
           rows_to_import = "all",
           columns_to_import = "all") {
    if (!require(readxl)) {
      install.packages("readxl");
      library(readxl)
      }
    csvFileList <-
      list.files(path = path_to_data,
                 full.names = TRUE)
    dataTables <- lapply(csvFileList, read_excel)
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
