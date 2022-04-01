#' Title
#'
#' @param dataFrameList
#' @param neededInfo
#'
#' @return
#' @export
#'
#' @examples
#'
findInfoList <- function(dataFrameList = Data, neededInfo = neededInfo) {
  allInfos <- data.table(matrix(nrow = 0, ncol = length(neededInfo)))
  for (dataFrame in dataFrameList) {
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
  allInfos <- rbind(allInfos, myInfos)
}
