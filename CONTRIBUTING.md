# Contribute to NVIpackager

<!-- CONTRIBUTING.md and ./vignettes/Contribute_to_NVIpkg.Rmd. are generated 
     from ./templates/Contribute_to_NVIpkg.Rmd in NVIpackager. 
     Please edit that file -->

Thank you for considering contributing to `NVIpackager`.

`NVIpackager` is one of several packages assembled under the name
`NVIverse`, a collection of R-packages with tools to facilitate data
management and data reporting at the Norwegian Veterinary Institute
(NVI).

### NVIverse packages

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 8%" />
<col style="width: 78%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Package</th>
<th style="text-align: left;">Status</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">NVIconfig</td>
<td style="text-align: left;">Private</td>
<td style="text-align: left;">Configuration information necessary for some NVIverse functions</td>
</tr>
<tr class="even">
<td style="text-align: left;">NVIdb</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Tools to facilitate the use of NVI’s databases</td>
</tr>
<tr class="odd">
<td style="text-align: left;">NVIpretty</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Tools to make R-output pretty in accord with NVI’s graphical profile</td>
</tr>
<tr class="even">
<td style="text-align: left;">NVIbatch</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Tools to facilitate the running of R-scripts in batch mode at NVI</td>
</tr>
<tr class="odd">
<td style="text-align: left;">OKplan</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Tools to facilitate the planning of surveillance programmes for the NFSA</td>
</tr>
<tr class="even">
<td style="text-align: left;">OKcheck</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Tools to facilitate checking of data from national surveillance programmes</td>
</tr>
<tr class="odd">
<td style="text-align: left;">NVIcheckmate</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Extension of checkmate with argument checking adapted for NVIverse</td>
</tr>
<tr class="even">
<td style="text-align: left;">NVIpackager</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Tools to facilitate the development of NVIverse packages</td>
</tr>
<tr class="odd">
<td style="text-align: left;">NVIrpackages</td>
<td style="text-align: left;">Public</td>
<td style="text-align: left;">Keeps a table of the R-Packages in NVIverse</td>
</tr>
</tbody>
</table>

## How you can contribute

There are several ways you can contribute to this project: ask a
question, propose an idea, report a bug, improve the documentation, or
contribute code.

### Ask a question

Using `NVIpackager` and need help? Browse the package help to see if you
can find a solution. Still problems? Post your question in R-forum at
workplace or contact the package maintainer by
[email](mailto:petter.hopp@vetinst.no).

### Propose an idea

Have an idea for a new `NVIpackager` feature? Take a look at the
`NVIpackager` help and [issue
list](https://github.com/NorwegianVeterinaryInstitute/NVIpackager/issues)
to see if it isn’t included or suggested yet. If not, suggest your idea
as an [issue on
GitHub](https://github.com/NorwegianVeterinaryInstitute/NVIpackager/issues/new).
While we can’t promise to implement your idea, it helps to:

-   Explain in detail how it would work.
-   Keep the scope as narrow as possible.

See below if you want to contribute code for your idea as well.

### Report a bug

Using `NVIpackager` and discovered a bug? Don’t let others have the same
experience and report it as an [issue on
GitHub](https://github.com/NorwegianVeterinaryInstitute/NVIpackager/issues/new)
so we can fix it. A good bug report makes it easier for us to do so, so
please include:

-   Any details about your local setup that might be helpful in
    troubleshooting.
-   Detailed steps to reproduce the bug.

### Improve the documentation

Noticed a typo on the function help? Think a function could use a better
example? Good documentation makes all the difference, so your help to
improve it is very welcome!

Functions are described as comments near their code and translated to
documentation using [`roxygen2`](https://klutometis.github.io/roxygen/).
If you want to improve a function description:

1.  Go to `R/` directory in the [code
    repository](https://github.com/NorwegianVeterinaryInstitute/NVIpackager/tree/main/R).
2.  Look for the file with the name of the function.
3.  [Propose a file
    change](https://help.github.com/articles/editing-files-in-another-user-s-repository/)
    to update the function documentation in the roxygen comments
    (starting with `#'`).

### Contribute code

Care to fix bugs or implement new functionality for our\_package? Great!
Have a look at the [issue
list](https://github.com/NorwegianVeterinaryInstitute/NVIpackager/issues)
and leave a comment on the things you want to work on. See also the
development guidelines below.

## Development guidelines

If you want to contribute code, you are welcome to do so. Please try to
adhere to some principles and style convention used for
`NVIverse`-packages.

-   Please limit the number of package dependencies for `NVIpackager`.
    The use of base functions is much appreciated.

-   New code should generally follow the tidyverse [style
    guide](http://style.tidyverse.org) with some modifications.

    -   use snake\_case for variable names, column names, function names
        etc.
    -   function names should start with a verb and should be
        descriptive and can be long. Avoid strange abbreviations.
    -   to indent the code you may use the short cut keys Ctrl+a (select
        all) and Ctrl+i (indent) when you are in R-studio.
    -   I recommend to use the
        [`styler`](https://CRAN.R-project.org/package=styler) package to
        apply spaces:
        `styler::style_file(filename, scope = c("spaces", "line_breaks"))`.
        Please don’t restyle code that has nothing to do with your pull
        request.

-   You should add a bullet point to `NEWS` motivating the change.

-   You should add yourself as a contributor to the `DESCRIPTION`.

-   If you’re adding a new function or new arguments to an existing
    function, you’ll also need to document them. `NVIverse`-packages use
    [`roxygen2`](https://cran.r-project.org/package=roxygen2), with
    [Markdown
    syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/markdown.html),
    for documentation. Make sure to re-run `devtools::document()` on the
    code before submitting.

-   `NVIverse`-packages use the assert-functions from
    [`checkmate`](https://CRAN.R-project.org/package=checkmate) package
    for argument checking as well as some additional assert\_functions
    in
    [`NVIcheckmate`](https://github.com/NorwegianVeterinaryInstitute/NVIcheckmate).
    Adding argument checking for new functions and/or arguments will be
    highly appreciated.

-   If you can, also write a test. `NVIverse`-packages use
    [`testthat`](https://cran.r-project.org/package=testthat) for tests.

-   Also run `devtools::check()` to make sure your function doesn’t
    imply downstream errors or warnings.

### Git commit standards

We follow the commit message style guide maintained within the
angular.js project.

The start of commit messages should be one of the following:

-   feat: A new feature
-   fix: A bug fix
-   doc: Documentation only changes
-   style: Changes that do not affect the meaning of the code
    (white-space, formatting, missing semi-colons, etc)
-   refactor: A code change that neither fixes a bug or adds a feature
-   perf: A code change that improves performance
-   test: Adding missing tests
-   chore: Changes to the build process or auxiliary tools and libraries
    such as documentation generation

Do not capitalize the first letter.

## Code of conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By participating to this project, you agree to abide by its terms.

## References

This document is adapted from a
[template](https://gist.github.com/peterdesmet/e90a1b0dc17af6c12daf6e8b2f044e7c)
by @peterdesmet .
