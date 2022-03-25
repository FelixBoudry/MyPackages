#' Retrieve max value for specified columns in a data frame list
#'
#' @param dataFrameList List containing the dataframes to analyse.
#' @param colsToCompute Vector with the columns to analyse.
#'
#' @return Returns a dataframe with the columns name and their maximum for each
#' dataframe in the specified list.
#' @export
#'
#' @examples
#' getDFLColsMax("./Datas/", c("Time", "Distance"))
#' getDFLColsMax("~/Storage/Datas/", myDataframeList)
#'
getDFLColsMax <- function(dataFrameList, colsToCompute) {
  results <- NULL
  for (col in colsToCompute) {
    colMaxs <- NULL
    for (df in dataFrameList) {
      colMaxs <-
        rbind(colMaxs, max(as.numeric(df[complete.cases(df[, col]), col])))
    }
    results <- cbind(results, colMaxs)
  }
  colnames(results) <- as.list(colsToCompute)
  return(as.data.frame(results))
}
