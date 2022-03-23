################################################################################
#                                                                              #
#                 Personal functions for data analysis                         #
#                                                                              #

################################### Notes ######################################
#   DF = Data frame
#   DFL = Data frame list

################################# Libraries ####################################
# library(data.table)
# library(dplyr)

############################# Import functions #################################

# Import all csv files of specific folders to a list of data frames
import.csv.sep <-
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

import.xlsx.sep <-
  function(path_to_data,
           rows_to_import = "all",
           columns_to_import = "all") {
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

mergeAll <- function(DF1, DF2) {
  merge(DF1, DF2, all = TRUE)
}

################################### Unused #####################################

import.csv.sep_test <-
  function(path_to_data,
           file_type = "*.csv",
           rows_to_import = paste(1:nrow(dataTables[[i]])),
           columns_to_import = paste(1:ncol(dataTables[[i]]))) {
    csvFileList <-
      list.files(path = path_to_data,
                 pattern = file_type,
                 full.names = TRUE)
    dataTables <- lapply(csvFileList, read.csv)
    for (i in 1:length(csvFileList)) {
      dataTables[[i]] <-
        dataTables[[i]][rows_to_import, columns_to_import]
    }
    names(dataTables) <-
      gsub("^.*/", "", csvFileList) #Delete path part and names data frames
    return(dataTables)
  }

# Import csv files with specific rows
read.rows.csv <-
  function(path_to_data,
           na_strings = NA,
           subject_selection = selectedSubjects) {
    dataFrame <- read.csv(file = path_to_data, na.strings = na_strings)
    dataFrame <-
      dataFrame[dataFrame[["Subject"]] %in% subject_selection,]
    return(dataFrame)
  }

read.rows.time.csv <-
  function(path_to_data,
           na_strings = NA,
           subject_selection = selectedSubjects) {
    dataFrame <-
      read_csv(file = path_to_data,
               col_types = list(Time_WP = col_time(format = "%H:%M:%S")))
    dataFrame <-
      dataFrame[dataFrame[["Subject"]] %in% subject_selection,]
    return(dataFrame)
  }

############################ Retrieve functions ################################

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

# Retrieve max value of each col in a data frame list
get.DFL.cols.max <- function(data_frame_list, cols_to_compute) {
  maxs <- NULL
  for (col in cols_to_compute) {
    colMaxs <- NULL
    for (df in data_frame_list) {
      df[df == ""] <- NA
      df[df == " "] <- NA
      colMaxs <-
        rbind(colMaxs, max(as.numeric(df[complete.cases(df[, col]), col])))
    }
    maxs <- cbind(maxs, colMaxs)
  }
  colnames(maxs) <- as.list(cols_to_compute)
  return(as.data.frame(maxs))
}

# Retrieve max value of each col in a data frame
get.DF.cols.max <- function(data_frame, cols_to_compute) {
  maxs <- NULL
  for (col in cols_to_compute) {
    colMaxs <- NULL
    data_frame[data_frame == ""] <- NA
    data_frame[data_frame == " "] <- NA
    colMaxs <-
      rbind(colMaxs,
            max(as.numeric(data_frame[complete.cases(data_frame[, col]), col])))
    maxs <- cbind(maxs, colMaxs)
  }
  colnames(maxs) <- as.list(cols_to_compute)
  return(as.data.frame(maxs))
}

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

############################ Compute functions #################################

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

time.zone.median <-
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
          cbind(col_df, round(median(as.numeric(DF[[val]]), na.rm = TRUE), 2))
      }
      result_df <- rbind(result_df, col_df)
    }
    colNames <- c("Subject", as.list(vals_to_compute))
    colnames(result_df) <- as.list(colNames)
    return(as.data.frame(result_df))
  }

get.DFL.cols.mean <- function(data_frame_list, cols_to_compute) {
  means <- NULL
  for (col in cols_to_compute) {
    colMeans <- NULL
    for (df in data_frame_list) {
      df[df == ""] <- NA
      df[df == " "] <- NA
      colMeans <-
        rbind(colMeans, mean(as.numeric(df[complete.cases(df[, col]), col])))
    }
    means <- cbind(means, colMeans)
  }
  colnames(means) <- as.list(cols_to_compute)
  return(as.data.frame(means))
}

get.DF.cols.mean <- function(data_frame, cols_to_compute) {
  means <- NULL
  for (col in cols_to_compute) {
    colMeans <- NULL
    data_frame[data_frame == ""] <- NA
    data_frame[data_frame == " "] <- NA
    colMeans <-
      rbind(colMeans,
            mean(as.numeric(data_frame[complete.cases(data_frame[, col]), col])))
    means <- cbind(means, colMeans)
  }
  colnames(means) <- as.list(cols_to_compute)
  return(as.data.frame(means))
}

get.DF.cols.median <- function(data_frame, cols_to_compute) {
  medians <- NULL
  for (col in cols_to_compute) {
    colMedians <- NULL
    data_frame[data_frame == ""] <- NA
    data_frame[data_frame == " "] <- NA
    colMedians <-
      rbind(colMedians,
            median(as.numeric(data_frame[complete.cases(data_frame[, col]), col])))
    medians <- cbind(medians, colMedians)
  }
  colnames(medians) <- as.list(cols_to_compute)
  return(as.data.frame(medians))
}

get.DFL.cols.median <- function(data_frame_list, cols_to_compute) {
  medians <- NULL
  for (col in cols_to_compute) {
    colMedian <- NULL
    for (df in data_frame_list) {
      df[df == ""] <- NA
      df[df == " "] <- NA
      colMedian <-
        rbind(colMedian, median(as.numeric(df[complete.cases(df[, col]), col])))
    }
    medians <- cbind(medians, colMedian)
  }
  colnames(medians) <- as.list(cols_to_compute)
  return(as.data.frame(medians))
}

get.DF.rows.mean <- function(data_frame, vals_to_compute) {
  tmpDF <- NULL
  rowMeansDF <- NULL
  data_frame[data_frame == ""] <- NA
  data_frame[data_frame == " "] <- NA
  for (val in vals_to_compute) {
    tmpDF <- select(data_frame, contains(val))
    tmpDF <- rowMeans(tmpDF, na.rm = T)
    rowMeansDF <- cbind(rowMeansDF, tmpDF)
  }
  colnames(rowMeansDF) <- as.list(vals_to_compute)
  return(as.data.frame(rowMeansDF))
}

get.DFL.rows.mean <- function(data_frame_list, cols_to_compute) {
  meanDF <- data.frame()[60, 0]
  for (col in cols_to_compute) {
    colVals <- data.frame()
    for (rowNB in 1:60) {
      vals <- NULL
      for (df in data_frame_list) {
        vals <- c(vals, df[rowNB, col])
      }
      meanVal <- mean(vals, na.rm = T)
      colVals <- rbind(colVals, meanVal)
    }
    meanDF <- cbind(meanDF, colVals, row.names = NULL)
  }
  colnames(meanDF) <- as.list(cols_to_compute)
  return(meanDF)
}

get.DFL.rows.mean.rel <-
  function(data_frame_list, cols_to_compute) {
    meanDF <- data.frame()[60, 0]
    for (col in cols_to_compute) {
      colVals <- data.frame()
      for (rowNB in 1:60) {
        vals <- NULL
        for (df in data_frame_list) {
          vals <- c(vals, ((df[rowNB, col] / max(df[, col])) * 100))
        }
        meanVal <- mean(vals, na.rm = T)
        colVals <- rbind(colVals, meanVal)
      }
      meanDF <- cbind(meanDF, colVals, row.names = NULL)
    }
    colnames(meanDF) <- as.list(cols_to_compute)
    return(meanDF)
  }

get.TTM.rel <- function(data_frame_list, cols_to_compute) {
  TTMDF <- data.frame()[length(data_frame_list), 0]
  for (col in cols_to_compute) {
    colVals <- data.frame()[length(data_frame_list), 0]
    vals <- NULL
    for (df in data_frame_list) {
      vals <-
        c(vals, (round(((which.max(df[, col]) / nrow(df)) * 100
        ), 1)))
    }
    colVals <- cbind(colVals, vals, row.names = NULL)

    TTMDF <- cbind(TTMDF, colVals, row.names = NULL)
  }
  colnames(TTMDF) <- as.list(cols_to_compute)
  return(TTMDF)
}

get.DFL.cols.sum <- function(data_frame_list, cols_to_compute) {
  means <- NULL
  for (col in cols_to_compute) {
    colMeans <- NULL
    for (df in data_frame_list) {
      df[df == ""] <- NA
      df[df == " "] <- NA
      colMeans <-
        rbind(colMeans, sum(as.numeric(df[complete.cases(df[, col]), col])))
    }
    means <- cbind(means, colMeans)
  }
  colnames(means) <- as.list(cols_to_compute)
  return(as.data.frame(means))
}

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

############################ Math functions ####################################

############################# Test functions ###################################
