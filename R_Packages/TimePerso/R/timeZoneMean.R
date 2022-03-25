#Compute mean values in a specified time zone
time.zone.mean <-
  function(data_frame_list,
           vals_to_compute,
           start_time,
           end_time,
           time_data,
           subject_selection = selectedSubjects) {
    result_df <- NULL
    subjectCount <- 0
    for (DF in data_frame_list) {
      start_time_prog <- NULL
      end_time_prog <- NULL
      subjectCount <- subjectCount + 1
      origin <-
        as.POSIXct(time_data[subjectCount, "Start_time"], format = "%H:%M:%S")
      start_time_prog <- hms(start_time)
      start_time_prog <- period_to_seconds(start_time_prog)
      end_time_prog <- hms(end_time)
      end_time_prog <- period_to_seconds(end_time_prog)
      start_time_dat <- hms(time_data[subjectCount, "Start_time"])
      start_time_dat <- period_to_seconds(start_time_dat)
      start_time_prog <- seconds_to_period(start_time_prog)
      start_time_prog <-
        as.POSIXct(start_time_prog, origin = origin)
      end_time_prog <- seconds_to_period(end_time_prog)
      end_time_prog <- as.POSIXct(end_time_prog, origin = origin)
      start_row <- NULL
      end_row <- NULL
      start_row <-
        max(which(!(
          as.POSIXct(DF[["t"]], format = "%H:%M:%S") > start_time_prog
        )), na.rm = TRUE)
      end_row <-
        max(which(!(
          as.POSIXct(DF[["t"]], format = "%H:%M:%S") > end_time_prog
        )), na.rm = TRUE)
      DF <- DF[start_row:end_row,]
      col_df <- NULL
      col_df <- cbind(col_df, subject_selection[subjectCount])
      for (val in vals_to_compute) {
        col_df <-
          cbind(col_df, round(mean(as.numeric(DF[[val]]), na.rm = TRUE), 2))
      }
      result_df <- rbind(result_df, col_df)
    }
    colNames <- c("Subject", as.list(vals_to_compute))
    colnames(result_df) <- as.list(colNames)
    return(as.data.frame(result_df))
  }
