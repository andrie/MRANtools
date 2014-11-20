#' Set MRAN snapshot date.
#'
#' @param date Character vector with ISO date, e.g. "2014-09-17".
#' @param MRANroot URL containing snapshots
#' @export
#'
#' @example /inst/examples/example_setSnapshot.R
setSnapshot <- function(date, MRANroot = "http://mran.revolutionanalytics.com/snapshot/"){
  if(missing(date) || is.null(date)) return(getOption("repos"))
  repoDate <- paste0(MRANroot, date)
  response <- tryCatch(
    suppressWarnings(readLines(repoDate)),
    error = function(e)e
  )
  if(inherits(response, "error")) stop(paste0("Invalid snapshot date."))
  options(repos = c(CRAN = repoDate))
  getOption("repos")
}
