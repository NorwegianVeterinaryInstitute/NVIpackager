#' @title Data: Description of the NVIverse packages .
#'
#' @description A data frame with key information for the NVIverse packages. The
#'     information is mainly used as input to \code{CONTRIBUTING.md} and \code{README.Rmd}.
#' @details The data frame is generated in \code{./data-raw/generate_NVIpackages.R}.
#'     Edit this file to update the data frame with changes in the NVIverse packages.
#'
#' @format A data frame with 3 variables:
#' \describe{
#'   \item{Package}{name of the NVIverse package.}
#'   \item{Status}{Whether the package is "Private" or "Public".}
#'   \item{Description}{The short description of the package as given in the "Title" field in \code{DESCRIPTION}.}
#' }
#' @source \code{./data-raw/generate_NVIpackages.R} in package \code{NVIpackager}
"NVIpackages"
