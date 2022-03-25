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
