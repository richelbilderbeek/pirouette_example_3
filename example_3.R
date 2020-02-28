#
# Standard
#
library(pirouette)
suppressMessages(library(ggplot2))

################################################################################
# Constants
################################################################################
is_testing <- is_on_travis()
example_no <- 3
rng_seed <- 314
folder_name <- paste0("example_", example_no, "_", rng_seed)

################################################################################
# Create phylogeny
################################################################################
phylogeny  <- ape::read.tree(
  text = "(((A:8, B:8):1, C:9):1, ((D:8, E:8):1, F:9):1);"
)

################################################################################
# Setup pirouette
################################################################################
pir_params <- create_std_pir_params(folder_name = folder_name)

# Shorter on Travis
if (is_testing) {
  pir_params <- shorten_pir_params(pir_params)
}

errors <- pir_run(
  phylogeny,
  pir_params = pir_params
)

ape::write.tree(phylogeny, file = "true_tree.newick")

utils::write.csv(
  x = errors,
  file = file.path(folder_name, "errors.csv"),
  row.names = FALSE
)

pir_plot(errors) +
  ggsave(file.path(folder_name, "errors.png"), width = 7, height = 7)

pir_to_pics(
  phylogeny = phylogeny,
  pir_params = pir_params,
  folder = folder_name
)

pir_to_tables(
  pir_params = pir_params,
  folder = folder_name
)
