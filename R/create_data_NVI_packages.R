# GENERATE DATA FRAME WITH ONE ROW PER NVI-package ----
NVI_packages <- as.data.frame(rbind(c("NVIconfig", "Private",
                                  "Configuration information necessary for some NVIverse functions"),
                                c("NVIdb", "Public",
                                  "Tools to facilitate the use of NVI's databases"),
                                c("NVIpretty",  "Public",
                                  "Tools to make R-output pretty in accord with NVI's graphical profile"),
                                c("NVIbatch",  "Public",
                                  "Tools to facilitate the running of R-scripts in batch mode at NVI"),
                                c("NVIcheckmate",  "Public",
                                  "Extension of checkmate with argument checking adapted for NVIverse"),
                                c("OKplan",  "Public",
                                  "Tools to facilitate the planning of surveillance programmes for the NFSA"),
                                c("OKcheck",  "Public",
                                  "Tools to facilitate checking of data from national surveillance programmes")))
colnames(NVI_packages) <- c("Package", "Status", "Description")

# SAVE IN PACKAGE DATA ----
usethis::use_data(name = NVI_packages, overwrite = TRUE, internal = FALSE)
