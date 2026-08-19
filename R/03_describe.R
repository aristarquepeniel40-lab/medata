# Meme piege que dans meindicator (voir ARCHITECTURE.md §5) : `me_describe`
# est un generique DEFINI DANS mecore. On ne peut pas compter sur
# @importFrom (poule et oeuf avec devtools::document()), donc alias local
# explicite via `mecore::`.
me_describe <- mecore::me_describe

#' @noRd
S7::method(me_describe, me_quality_report) <- function(x, ...) {
  pires <- x@summary[order(-x@summary$pct_missing), , drop = FALSE]
  pire <- pires[1, ]
  sprintf(
    "Rapport qualite '%s' : %d lignes, %d colonnes. Pire colonne : '%s' (%.1f%% manquant).",
    x@dataset_name, x@n_rows, x@n_cols, pire$column, pire$pct_missing
  )
}
