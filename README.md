MRANtools
=========

R package with tools to query and work with MRAN snapshots


# Functions you may want to try:

1. `setSnapshot()`

    ```r
    # Empty date field returns current repo
    setSnapshot()
    setSnapshot(NULL)
    
    # Valid snapshot date
    setSnapshot("2014-11-16")
    
    ```


2. `mtCompare()`

    ```r
    
    # Summarise package differences between two snapshot dates
    x <- mtCompare(c("2014-10-01", "2014-11-15"))
    str(x)
    ```

3. `mtPkgAvail`

    ```r
    # Retrieve matrix with package information on snapshot date
    x <- mtPkgAvail("2014-10-01")
    colnames(x)
    head(x[, c("Package", "Version")])
    ```


