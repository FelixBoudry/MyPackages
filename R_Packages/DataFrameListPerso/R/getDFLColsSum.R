#' Compute the sums of specified columns for a list of dataframes.
#'
#' @param dataFrameList List containing the dataframes to analyse.
#' @param colsToCompute A vector with the columns to analyse.
#'
#' @return Returns a dataframe with the columns name and their sums for each
#' dataframe in the specified list.
#' @export
#'
#' @examples
#' getDFLColsSum(myList, c("Time", "Distance"))
#' getDFLColsSum(myList, columnsList)
#'
get.DFL.cols.sum <- function(dataFrameList, colsToCompute) {
  means <- NULL
  for (col in colsToCompute) {
    colMeans <- NULL
    for (df in dataFrameList) {
      colMeans <-
        rbind(colMeans, sum(as.numeric(df[complete.cases(df[, col]), col])))
    }
    means <- cbind(means, colMeans)
  }
  colnames(means) <- as.list(colsToCompute)
  return(as.data.frame(means))
}
