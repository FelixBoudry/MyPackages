# Retrieve the TTM in the exercise time
get.TTM <-
  function(data_frame_list,
           vals_to_compute,
           subject_selection = selectedSubjects,
           time_data = NULL) {
    time_df <- NULL
    subjectCount <- 0
    if (is.null(time_data) == FALSE) {
      for (DF in data_frame_list) {
        subjectCount <- subjectCount + 1
        start_time <-
          time_data[which(time_data == subject_selection[subjectCount]),
                    "Start_time"]
        start_time <- as.POSIXct(start_time, format = "%H:%M:%S")
        end_time <-
          time_data[which(time_data == subject_selection[subjectCount]),
                    "End_time"]
        end_time <- as.POSIXct(end_time, format = "%H:%M:%S")
        start_row <- NULL
        end_row <- NULL
        start_row <-
          max(which(!(
            as.POSIXct(DF[["t"]], format = "%H:%M:%S") > start_time
          )), na.rm = TRUE)
        end_row <-
          max(which(!(
            as.POSIXct(DF[["t"]], format = "%H:%M:%S") > end_time
          )), na.rm = TRUE)
        DF <- DF[start_row:end_row,]
        col_df <- NULL
        col_df <- cbind(col_df, subject_selection[subjectCount])
        for (val in vals_to_compute) {
          col_df <- cbind(col_df, as.character(DF[which.max(DF[[val]]), "t"]))
        }
        time_df <- rbind(time_df, col_df)
      }
    }
    else {
      for (DF in data_frame_list) {
        subjectCount <- subjectCount + 1
        col_df <- NULL
        col_df <- cbind(col_df, subject_selection[subjectCount])
        for (val in vals_to_compute) {
          col_df <- cbind(col_df, as.character(DF[which.max(DF[[val]]), "t"]))
        }
        time_df <- rbind(time_df, col_df)
      }
    }
    colNames <- c("Subject", as.list(vals_to_compute))
    colnames(time_df) <- as.list(colNames)
    return(as.data.frame(time_df))
  }
