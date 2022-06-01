#' Find data from HIE athletes.
#'
#' @param folderToScan Path for the folder containing the datas.
#'
#' @return Two dataframes listing the files for HIE and not HIE athletes and their oxygen saturation difference (SaO2)
#' @export
#'
#' @examples
#' listHIE("./datas/myFolder/)
#'
listHIE <- function(folderToScan) {
  myFolderFiles <- list.files(folderToScan)
  assign(paste0("athleteHIE",folderToScan), data.frame(name = c("file names"), deltaSaO2 = c("deltas")))
  assign(paste0("athletenHIE",folderToScan), data.frame(name = c("file names"), deltaSaO2 = c("deltas")))
  for (myFile in myFolderFiles) {
    workFile <- read_excel(paste0(folderToScan, myFile))
    maxSaO2 <- max(workFile[["SaO2"]], na.rm = TRUE)
    minSaO2 <- min(workFile[["SaO2"]], na.rm = TRUE)
    deltaSaO2 <- maxSaO2 - minSaO2
    if (deltaSaO2 > 4) {
      assign(paste0("athleteHIE", folderToScan), rbind(c(paste0(myFile), deltaSaO2)))
    } else {
      assign(paste0("athletenHIE", folderToScan), rbind(c(paste0(myFile), deltaSaO2)))
    }
  }
}
