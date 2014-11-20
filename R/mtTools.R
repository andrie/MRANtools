#' Find available packages for a given MRAN snapshot date
#'
#' @inheritParams setSnapshot
#'
#' @param type character, indicating the type of package to download and install.  Possible values are (currently) "source", "mac.binary", "mac.binary.mavericks" and "win.binary".
#' @param fields Passed to \code{\link[utils]{available.packages}}
#'
#' @export
mtPkgAvail <- function(date){  #}, type="source", fields=NULL){
#   available.packages(
#     contrib.url(setSnapshot(date), type=type),
#     fields=fields
#   )
  url <- "http://mran.revolutionanalytics.com/snapshot/%s/web/packages/packages.rds"
  z <- readRDS(gzcon(url(sprintf(url, date))))
  rownames(z) <- gsub(".*/(.*?)/DESCRIPTION", "\\1", rownames(z))
  z
}


#' Inverse setdiff.
#'
#' Wrapper around \code{\link[base]{setdiff}} to invert the arguments.
#'
#' @param x vector (of the same mode) containing a sequence of items (conceptually) with no duplicated values.
#' @param y vector (of the same mode) containing a sequence of items (conceptually) with no duplicated values.
#'
#' @export
setdiffinv <- function(x, y) setdiff(y, x)

#' Compare package status on two different MRAN snapshot dates.
#'
#' @inheritParams mtPkgAvail
#' @param dates Character vector with two ISO dates, e.g. \code{c("2014-10-01", "2014-11-01")}.
#'
#' @example /inst/examples/example_mtCompare.R
#'
#' @export
mtCompare <- function(dates, type="source"){
  FUN=list(dropped = setdiff, added = setdiffinv, same = intersect)
  foo <- function(FUN, pdbList){
    pkgCol <- "Package"
    p1 <- pdbList[[1]][, pkgCol]
    p2 <- pdbList[[2]][, pkgCol]
    match.fun(FUN)(p1, p2)
  }

  pdbList <- lapply(dates, mtPkgAvail)
  if(!is.list(FUN)) {
    foo(FUN, pdbList)
  } else {
    z <- lapply(FUN, foo, pdbList)
    names(z) <- names(FUN)
    idx <- which(
      pdbList[[1]][z$same, "Version"] != pdbList[[2]][z$same, "Version"]
    )
    z[["updated"]] <- z$same[idx]
    z[["same"]] <- setdiff(z[["same"]], z[["updated"]])
    z
  }
}
