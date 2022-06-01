#' Calculate the mean values for specified rows
#'
#' @param dataFrame The dataframe to analyse.
#' @param valsToCompute The values to analyse in that dataframe.
#'
#' @return
#' @export
#'
#' @examples
#' getDFRowsMean(myDataFrame, c("height", "weight"))
#'
getDFRowsMean <- function(dataFrame, valsToCompute) {
  tmpDF <- NULL
  rowMeansDF <- NULL
  for (val in valsToCompute) {
    tmpDF <- select(dataFrame, contains(val))
    tmpDF <- rowMeans(tmpDF, na.rm = T)
    rowMeansDF <- cbind(rowMeansDF, tmpDF)
  }
  colnames(rowMeansDF) <- as.list(valsToCompute)
  return(as.data.frame(rowMeansDF))
}
