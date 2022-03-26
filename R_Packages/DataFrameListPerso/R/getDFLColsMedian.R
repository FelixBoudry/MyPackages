#' Compute the median value of specified columns for a list of dataframes.
#'
#' @param dataFrameList List containing the dataframes to analyse.
#' @param colsToCompute A vector with the columns to analyse.
#'
#' @return Returns a dataframe with the columns name and their means for each
#' dataframe in the specified list.
#' @export
#'
#' @examples
#' getDFLColsMedian(myList, c("Time", "Distance"))
#' getDFLColsMedian(myList, columnsList)
#'
getDFLColsMedian <- function(dataFrameList, colsToCompute) {
  medians <- NULL
  for (col in colsToCompute) {
    colMedian <- NULL
    for (df in dataFrameList) {
      colMedian <-
        rbind(colMedian, median(as.numeric(df[complete.cases(df[, col]), col])))
    }
    medians <- cbind(medians, colMedian)
  }
  colnames(medians) <- as.list(colsToCompute)
  return(as.data.frame(medians))
}
