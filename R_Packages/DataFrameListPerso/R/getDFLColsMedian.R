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
