#' Find informations in a dataframe.
#'
#' @param neededInfo A vector containing the needed informations.
#'
#' @return Return a dataframe containing a column per information.
#' @export
#'
#' @examples
#' findInfo(c("name", "age"))
#' findInfo(myVector)
#'
findInfo <- function(neededInfo) {
  myInfos <- data.table(matrix(nrow = 0, ncol = length(neededInfo)))
  colnames(myInfos) <- neededInfo
  for (infoElement in neededInfo) {
    if (infoElement in colnames(dataFrame)) {
      myInfo[, infoElement] <- dataFrame[1, infoElement]
    } else if (which(dataFrame == val, arr.ind = TRUE)) {
      dataPosition <- which(dataFrame == val, arr.ind = TRUE)
      dataPosition[, "col"] <- dataPosition[, "col"] + 1
      myInfos[, infoElement] <- dataFrame[dataPosition[1, 1]]
    } else {
      myInfos[, infoElement] <- NA
    }
  }
}
