#' Compute the mean value of specified columns for a list of dataframes.
#'
#' @param dataFrameList A list containing the data frames to analyse.
#' @param colsToCompute A vector with the columns to analyse.
#'
#' @return Returns a dataframe with the columns name and their means for each
#' dataframe in the specified list.
#' @export
#'
#' @examples
#' getDFLColsMean(myList, c("Time", "Distance"))
#' getDFLColsMean(myList, columnsList)
#'
getDFLColsMean <- function(dataFrameList, colsToCompute) {
  means <- NULL
  for (col in colsToCompute) {
    colMeans <- NULL
    for (df in dataFrameList) {
      colMeans <-
        rbind(colMeans, mean(as.numeric(df[complete.cases(df[, col]), col])))
    }
    means <- cbind(means, colMeans)
  }
  colnames(means) <- as.list(colsToCompute)
  return(as.data.frame(means))
}
