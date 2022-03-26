#' Retrieve values in each data frame of a list
#'
#' @param dataFrameList List containing the dataframes to analyse.
#' @param colsToGet A vector with the columns to retrieve.
#' @param dataFrameSelection A list of dataframes to analyse in dataFrameList.
#' By default all dataframes are used.
#'
#' @return Returns a dataframe with the columns name (column and dataframe name)
#' and their values for each dataframe in the specified list.
#' @export
#'
#' @examples
#' getDFLColsVal(myList, c("VE", "VO2"))
#' getDFLColsVal(myList, c("VE", "VO2"), c("DF1", "DF2"))
#'
getDFLColsVal <-
  function(dataFrameList,
           colsToGet,
           dataFrameSelection = "all") {
    dfVal <- NULL
    if (dataFrameSelection == "all") {
      for (col in colsToGet) {
        colVal <- NULL
        position <- 0
        for (df in dataFrameList) {
          position <- position + 1
          colVal <- cbind(colVal, as.numeric(df[[col]]))
          colnames(colVal)[position] <-
            paste(col, "-" , names(dataFrameList[position]), sep = "")
        }
        dfVal <- cbind(dfVal, colVal)
      }
    } else {
      for (col in colsToGet) {
        colVal <- NULL
        position <- 0
        for (df in dataFrameList) {
          position <- position + 1
          colVal <- cbind(colVal, as.numeric(df[[col]]))
          colnames(colVal)[position] <-
            paste(col, "-" , dataFrameSelection[position], sep = "")
        }
        dfVal <- cbind(dfVal, colVal)
      }
    }
    return(as.data.frame(dfVal))
  }
