# Retrieve matrix with package information on snapshot date
x <- mtPkgAvail("2014-10-01")
colnames(x)
head(x[, c("Package", "Version")])
