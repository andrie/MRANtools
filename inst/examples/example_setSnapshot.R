oldRepo <- getOption("repos")

# Empty date field returns current repo
setSnapshot()
setSnapshot(NULL)

# Valid snapshot date
setSnapshot("2014-11-16")

# Invalid snapshot date (in future), returns error
try(
  setSnapshot("2024-11-16")
)

options(repos = oldRepo)
