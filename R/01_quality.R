#' Rapport de qualite d'un dataset
#'
#' Resume la completude et le typage de chaque colonne d'un
#' `mecore::me_dataset`. Ne modifie jamais les donnees (voir
#' `clean_missing()` pour la partie qui agit).
#'
#' @param dataset_name Nom du dataset source.
#' @param n_rows Nombre de lignes.
#' @param n_cols Nombre de colonnes.
#' @param summary Un `data.frame` avec une ligne par colonne :
#'   `column`, `type`, `n_missing`, `pct_missing`.
#' @export
me_quality_report <- S7::new_class(
  "me_quality_report",
  package = "medata",
  properties = list(
    dataset_name = S7::class_character,
    n_rows       = S7::class_double,
    n_cols       = S7::class_double,
    summary      = S7::class_data.frame
  )
)

#' Construire un rapport de qualite pour un dataset
#'
#' @param dataset Un `mecore::me_dataset`.
#' @return Un `me_quality_report`.
#' @export
quality_report <- function(dataset) {
  if (!S7::S7_inherits(dataset, mecore::me_dataset)) {
    mecore::me_validation_error("`dataset` doit etre un mecore::me_dataset")
  }
  df <- dataset@data

  resume <- data.frame(
    column      = names(df),
    type        = vapply(df, function(col) class(col)[1], character(1)),
    n_missing   = vapply(df, function(col) sum(is.na(col)), integer(1)),
    stringsAsFactors = FALSE
  )
  resume$pct_missing <- round(100 * resume$n_missing / nrow(df), 1)

  me_quality_report(
    dataset_name = dataset@name,
    n_rows = as.double(nrow(df)),
    n_cols = as.double(ncol(df)),
    summary = resume
  )
}
