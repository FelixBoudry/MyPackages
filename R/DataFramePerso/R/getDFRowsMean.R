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
