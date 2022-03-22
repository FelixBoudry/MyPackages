get.TTM.time <-
  function(data_frame_list,
           vals_to_compute,
           subject_selection = selectedSubjects) {
    time_df <- NULL
    subjectCount <- 0
    for (DF in data_frame_list) {
      subjectCount <- subjectCount + 1
      col_df <- NULL
      # col_df <- cbind(col_df, subject_selection[subjectCount])
      for (val in vals_to_compute) {
        col_df <- cbind(col_df, as.numeric(DF[which.max(DF[[val]]), "t"]))
      }
      time_df <- rbind(time_df, col_df)
    }
    # colNames <- c("Subject", as.list(vals_to_compute))
    colNames <- as.list(vals_to_compute)
    colnames(time_df) <- as.list(colNames)
    return(as.data.frame(time_df))
  }
