#' Find informations in each dataframe from the specified list.
#'
#' @param dataFrameList List containing the dataframes.
#' @param neededInfo Vector with the needed informations.
#'
#' @return Return a dataframe with a column for each information and a row for
#' each dataframe
#' @export
#'
#' @examples
#'findInfoList(myList, c("name", "age"))
#'findInfoList(myList, myVector)
#'
findInfoList <-
  function(dataFrameList = Data,
           neededInfo = neededInfo) {
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
