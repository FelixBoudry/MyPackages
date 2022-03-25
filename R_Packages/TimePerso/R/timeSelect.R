# Retrieve values in each data frame of a list for the exercise time
time.select <-
  function(data_frame_list,
           cols_to_retrieve,
           time_data,
           selected_subjects = selectedSubjects) {
    dfList <- list()
    pos <- 0
    for (df in data_frame_list) {
      subDF <- NULL
      TT <- NULL
      tempDFList <- NULL
      pos <- pos + 1
      subject <- selected_subjects[pos]
      startTime <-
        time_data[which(time_data == subject), "Start_time"]
      startTimeX <-
        time_data[which(time_data == subject), "Start_time"]
      startTime <- as.POSIXct(startTime, format = "%H:%M:%S")
      endTime <- time_data[which(time_data == subject), "End_time"]
      endTime <- as.POSIXct(endTime, format = "%H:%M:%S")
      startRow <- NULL
      endRow <- NULL
      if (endTime == as.POSIXct("00:00:00", format = "%H:%M:%S")) {
        startRow <-
          min(which(as.POSIXct(df[["t"]], format = "%H:%M:%S") > startTime),
              na.rm = TRUE)
        endRow <- 100
        #nrow(i)
      }
      else {
        startRow <-
          min(which(as.POSIXct(df[["t"]], format = "%H:%M:%S") > startTime),
              na.rm = TRUE)
        endRow <-
          min(which(as.POSIXct(df[["t"]], format = "%H:%M:%S") > endTime),
              na.rm = TRUE)
      }
      TT <-
        period_to_seconds(hms(df[startRow:endRow, "t"])) - period_to_seconds(hms(startTimeX))
      subDF <- cbind(subDF, TT, row.names = NULL)
      for (col in cols_to_retrieve) {
        subDF <- cbind(subDF, as.numeric(df[[col]][startRow:endRow]))
      }
      names <- NULL
      names <- c("t", as.list(cols_to_retrieve))
      colnames(subDF) <- names
      tempDFList <- list(as.data.frame(subDF))
      dfList <- c(dfList, tempDFList)
    }
    names(dfList) <- selected_subjects
    return(dfList)
  }
