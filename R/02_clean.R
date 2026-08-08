#' Gerer les valeurs manquantes d'un dataset
#'
#' Deux strategies volontairement simples pour cette V1 :
#' - `"flag"` (par defaut) : ne modifie rien, retourne juste le rapport
#'   de qualite pour decision humaine.
#' - `"drop_rows"` : supprime les lignes contenant au moins une valeur
#'   manquante dans les colonnes ciblees.
#'
#' @param dataset Un `mecore::me_dataset`.
#' @param columns Colonnes a considerer (par defaut : toutes).
#' @param strategy `"flag"` ou `"drop_rows"`.
#' @return Une liste `list(dataset = ..., report = ...)` : `dataset` est
#'   inchange si `strategy = "flag"`, modifie si `"drop_rows"` ; `report`
#'   est le `me_quality_report` calcule AVANT toute modification.
#' @export
clean_missing <- function(dataset, columns = NULL, strategy = c("flag", "drop_rows")) {
  strategy <- match.arg(strategy)
  if (!S7::S7_inherits(dataset, mecore::me_dataset)) {
    mecore::me_validation_error("`dataset` doit etre un mecore::me_dataset")
  }

  report_avant <- quality_report(dataset)

  if (strategy == "flag") {
    return(list(dataset = dataset, report = report_avant))
  }

  # strategy == "drop_rows"
  cols_cibles <- if (is.null(columns)) names(dataset@data) else columns
  manquantes <- setdiff(cols_cibles, names(dataset@data))
  if (length(manquantes) > 0) {
    mecore::me_validation_error(sprintf(
      "colonne(s) introuvable(s) : %s", paste(manquantes, collapse = ", ")
    ))
  }

  lignes_completes <- stats::complete.cases(dataset@data[, cols_cibles, drop = FALSE])
  dataset@data <- dataset@data[lignes_completes, , drop = FALSE]

  list(dataset = dataset, report = report_avant)
}
