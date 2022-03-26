#' Retrieve values in the next cell
#'
#' @param dataFrameList List containing the dataframes to analyse.
#' @param valuesToGet The left cell that is known (you want to get the
#' value at it right)
#' @param selectedDataFrame Dataframes to analyse in the provided list.
#'
#' @return
#' @export
#'
#' @examples
getRightCellVal <- function(dataFrameList,
                            valuesToGet,
                            selectedDataFrame = selectedSubjects) {
  result_DF <- NULL
  subjectCount <- 0
  for (df in dataFrameList) {
    subjectCount <- subjectCount + 1
    data_row <- NULL
    data_row <- cbind(data_row, selectedDataFrame[subjectCount])
    for (val in valuesToGet) {
      data_row <-
        cbind(data_row, df[which(df == val, arr.ind = TRUE)[1],
                           which(df == val, arr.ind = TRUE)[2] + 1])
    }
    result_DF <- as.data.frame(rbind(result_DF, data_row))
  }
  colnames(result_DF) <- c("Subject", as.list(valuesToGet))
  return(result_DF)
}
