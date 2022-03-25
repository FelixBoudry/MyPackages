# Retrieve values in the next cell
get.right.cell.val <-
  function(data_frame_list,
           values_to_retrieve,
           subject_selection = selectedSubjects) {
    result_DF <- NULL
    subjectCount <- 0
    for (df in data_frame_list) {
      subjectCount <- subjectCount + 1
      data_row <- NULL
      data_row <- cbind(data_row, subject_selection[subjectCount])
      for (val in values_to_retrieve) {
        data_row <-
          cbind(data_row, df[which(df == val, arr.ind = TRUE)[1],
                             which(df == val, arr.ind = TRUE)[2] + 1])
      }
      result_DF <- as.data.frame(rbind(result_DF, data_row))
    }
    colnames(result_DF) <- c("Subject", as.list(values_to_retrieve))
    return(result_DF)
  }
