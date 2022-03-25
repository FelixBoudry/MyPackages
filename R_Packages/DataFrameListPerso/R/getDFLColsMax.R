#' Retrieve max value of each col in a data frame list
#'
#' @param data_frame_list List containing the dataframes to analyse.
#' @param cols_to_compute Vector with the columns to analyse.
#'
#' @return Returns a dataframe with the columns name and their maximum for each
#' dataframe in the specified list.
#' @export
#'
#' @examples
get.DFL.cols.max <- function(data_frame_list, cols_to_compute) {
  maxs <- NULL
  for (col in cols_to_compute) {
    colMaxs <- NULL
    for (df in data_frame_list) {
      df[df == ""] <- NA
      df[df == " "] <- NA
      colMaxs <-
        rbind(colMaxs, max(as.numeric(df[complete.cases(df[, col]), col])))
    }
    maxs <- cbind(maxs, colMaxs)
  }
  colnames(maxs) <- as.list(cols_to_compute)
  return(as.data.frame(maxs))
}
