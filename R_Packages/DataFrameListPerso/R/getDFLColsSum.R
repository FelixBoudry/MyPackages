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
