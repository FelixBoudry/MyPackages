#' Title
#'
#' @param neededInfo
#'
#' @return
#' @export
#'
#' @examples
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
