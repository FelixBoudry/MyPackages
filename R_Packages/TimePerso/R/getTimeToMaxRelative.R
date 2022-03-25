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
