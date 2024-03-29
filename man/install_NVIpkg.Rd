% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/install_NVIpkg.R
\name{install_NVIpkg}
\alias{install_NVIpkg}
\title{Install an NVIverse Package during the Development Phase}
\usage{
install_NVIpkg(
  pkg = stringi::stri_extract_last_words(usethis::proj_path()),
  pkg_path = usethis::proj_path(),
  lib = R.home(),
  rsource,
  username = "NorwegianVeterinaryInstitute",
  ...
)
}
\arguments{
\item{pkg}{[\code{character(1)}]\cr
The package name. Defaults to \code{stringi::stri_extract_last_words(usethis::proj_path())}.}

\item{pkg_path}{[\code{character(1)}]\cr
The path to the package directory. Defaults to \code{usethis::proj_path()}.}

\item{lib}{[\code{character(1)}]\cr
The library directory where to install. Defaults to \code{R.home()}.}

\item{rsource}{[\code{character(1)}]\cr
Source of package. Must be one of c("github", "local").}

\item{username}{[\code{character(1)}]\cr
The github username where the repository is found. Defaults to
    "NorwegianVeterinaryInstitute".}

\item{\dots}{Other arguments to be passed to
\ifelse{html}{\code{\link[remotes:install_github]{remotes::install_github}}}{\code{remotes::install_github}},
or
\ifelse{html}{\code{\link[devtools:install]{devtools::install}}}{\code{devtools::install}}.}
}
\value{
None. Installs a package.
}
\description{
Installation of an NVIverse package from github or
    from local directory. Mainly intended for installation of a
    package during development to test new code in the package
    scripts .
}
\details{
When \code{rsource = "github"}, the default is to install
    the latest version in the main branch at the NorwegianVeterinaryInstitute
    package repository. During package development one will usually
    change the username to your own.

The repository can be changed by giving more arguments that
    will be passed to
    \ifelse{html}{\code{\link[remotes:install_github]{install_github}}}{\code{remotes::install_github}},
    see
    \ifelse{html}{\code{\link[remotes:install_github]{install_github}}}{\code{remotes::install_github}},
    for full description of the arguments \code{repo}, \code{username},
    and \code{ref}.

When \code{rsource = "local"}, it installs the package from a
    local copy of the package repository. It defaults to install
    the active branch. Use \code{rsource = "local"} to test new
    code during development.

For installing the latest released versions of \code{NVIverse} packages, use
    \ifelse{html}{\code{\link[remotes:install_github]{install_github}}}{\code{remotes::install_github}},
    or
    \ifelse{html}{\code{\link[NVIbatch:use_NVIverse]{NVIbatch::use_NVIverse}}}{\code{NVIbatch::use_NVIverse}}.
}
\examples{
\dontrun{
# Installs a package from local PC
# You need to be in a package directory at you PC for the code to work.
pkg <- stringi::stri_extract_last_words(usethis::proj_path())
pkg_path = usethis::proj_path()

NVIpackager::install_NVIpkg(pkg = pkg, pkg_path = pkg_path, rsource = "local")
}

}
\author{
Petter Hopp Petter.Hopp@vetinst.no
}
