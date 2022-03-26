#' Title
#'
#' @param dataFrameList
#' @param colsToCompute
#'
#' @return
#' @export
#'
#' @examples
#'
getDFLRowsMean <- function(dataFrameList, colsToCompute) {
  meanDF <- data.frame()[60, 0]
  for (col in colsToCompute) {
    colVals <- data.frame()
    for (rowNB in 1:60) {
      vals <- NULL
      for (df in dataFrameList) {
        vals <- c(vals, df[rowNB, col])
      }
      meanVal <- mean(vals, na.rm = T)
      colVals <- rbind(colVals, meanVal)
    }
    meanDF <- cbind(meanDF, colVals, row.names = NULL)
  }
  colnames(meanDF) <- as.list(colsToCompute)
  return(meanDF)
}
