# Shared plotting theme for "From Formula to Stan"
# Sourced at the top of every chapter: source("R/theme.R")

library(ggplot2)

# Base theme: theme_minimal() with a few adjustments
theme_f2s <- function(base_size = 12) {
  theme_minimal(base_size = base_size) +
    theme(
      plot.title         = element_text(face = "bold", size = rel(1.1)),
      plot.subtitle      = element_text(colour = "grey35"),
      plot.caption       = element_text(colour = "grey50", size = rel(0.8)),
      axis.title         = element_text(colour = "grey25"),
      panel.grid.minor   = element_blank(),
      strip.text         = element_text(face = "bold", hjust = 0),
      legend.position    = "bottom"
    )
}

theme_set(theme_f2s())

# A small, consistent palette used across chapters
f2s_colors <- c(
  data    = "grey40",   # observed data
  truth   = "#D55E00",  # true parameter values (simulation)
  post    = "#0072B2",  # posterior
  prior   = "#999999",  # prior
  accent  = "#009E73"   # highlights
)

# Default fill / colour for ggdist and stat_* geoms
update_geom_defaults("point", list(colour = f2s_colors[["data"]], alpha = 0.7))
