# Retrieve values in each data frame of a list
get.DFL.cols.val <-
  function(data_frame_list,
           cols_to_retrieve,
           subject_selection = selectedSubjects) {
    dfVal <- NULL
    for (col in cols_to_retrieve) {
      colVal <- NULL
      n <- 0
      for (df in data_frame_list) {
        n <- n + 1
        colVal <- cbind(colVal, as.numeric(df[[col]]))
        colnames(colVal)[n] <-
          paste(col, "-" , subject_selection[n], sep = "")
      }
      dfVal <- cbind(dfVal, colVal)
    }
    return(as.data.frame(dfVal))
  }
