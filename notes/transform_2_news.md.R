

pkg_path = usethis::proj_path()
pkg <- stringi::stri_extract_last_words(pkg_path)
NEWS_file <- NULL
if (file.exists(file.path(pkg_path, "NEWS"))) {NEWS_file <- "NEWS"}
if (file.exists(file.path(pkg_path, "NEWS.md"))) {NEWS_file <- "NEWS.md"}
news_text <- readLines(con = file.path(pkg_path, NEWS_file))
news_text <- gsub(pattern = "^First release:", replacement = "## First release:", news_text)
news_text <- gsub(pattern = "^New features:", replacement = "## New features:", news_text)
news_text <- gsub(pattern = "^Bug fixes:", replacement = "## Bug fixes:", news_text)
news_text <- gsub(pattern = "^Other changes:", replacement = "## Other changes:", news_text)
news_text <- gsub(pattern = "^BREAKING CHANGES:", replacement = "## BREAKING CHANGES:", news_text)
news_text <- gsub(pattern = paste0("^", pkg),
                  replacement = paste("#", pkg),
                  news_text)
news_text <- subset(news_text, substr(news_text, 1, 5) != "-----")
writeLines(text = news_text,
           con = file.path(pkg_path, "NEWS.md"))
