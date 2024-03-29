% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update_reference_manual.R
\name{update_reference_manual}
\alias{update_reference_manual}
\title{Update reference manual}
\usage{
update_reference_manual(
  pkg = stringi::stri_extract_last_words(usethis::proj_path()),
  pkg_path = usethis::proj_path(),
  manual = "update"
)
}
\arguments{
\item{pkg}{[\code{character(1)}]\cr
The package name. Defaults to \code{stringi::stri_extract_last_words(usethis::proj_path())}.}

\item{pkg_path}{[\code{character(1)}]\cr
The path to the package directory. Defaults to \code{usethis::proj_path()}.}

\item{manual}{[\code{character(1)}]\cr
Must be one of c("include", "update", "remove"), see details. Defaults to
    "update".}
}
\value{
None. Creates or updates the PDF reference manual in directory "./vignettes/".
}
\description{
Update the PDF reference manual and save it together with the vignettes.
}
\details{
The default is \code{manual = "update"} that will update the reference
    manual if it exists, but will do nothing if it doesn't exist. Use
    \code{manual = "include"} to make the reference manual for the first time.
    For both \code{manual = c("include", "update")}, the \code{DESCRIPTION} and
    \code{.gitignore} will be checked and modified if necessary and the "pkgname.pdf.asis"
    will be created in addition to the reference manual "pkgname.pdf".

    Use \code{manual = "remove"} to remove the reference manual. This will remove
    the reference manual "pkgname.pdf" and the file "pkgname.pdf.asis" and modify
    \code{.gitignore}. Any changes that have been done to the \code{DESCRIPTION} will not
    be reversed as these may also be used by other processes. If these should be
    reversed, it must be done manually.
}
\examples{
\dontrun{
# Update the reference manual if it already exists
library(NVIpackager)
update_reference_manual(manual = "update")
}
}
\author{
Petter Hopp Petter.Hopp@vetinst.no
}
