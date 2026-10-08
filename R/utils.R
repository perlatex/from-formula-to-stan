# Helpers for "From Formula to Stan"
# Sourced at the top of every chapter: source("R/utils.R")

# Print a Stan file, or a single block of it, so that the page always shows
# exactly the code that cmdstanr compiles (one source of truth: stan/*.stan).
#
# Use in a chunk with:
#   #| echo: false
#   #| class-output: stan
#   show_stan("stan/ch05_linear.stan")            # whole file
#   show_stan("stan/ch05_linear.stan", "model")   # one block
show_stan <- function(file, block = NULL) {
  lines <- readLines(file, warn = FALSE)

  if (!is.null(block)) {
    pattern <- paste0("^\\s*", block, "\\s*\\{")
    start <- grep(pattern, lines)[1]
    if (is.na(start)) stop("Block '", block, "' not found in ", file)

    depth <- 0
    end <- start
    for (k in start:length(lines)) {
      depth <- depth +
        lengths(regmatches(lines[k], gregexpr("\\{", lines[k]))) -
        lengths(regmatches(lines[k], gregexpr("\\}", lines[k])))
      if (depth == 0) {
        end <- k
        break
      }
    }
    lines <- lines[start:end]
  }

  cat(lines, sep = "\n")
}
