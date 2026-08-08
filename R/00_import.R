#' Importer un dataset depuis un fichier CSV
#'
#' Lit un CSV et construit un `mecore::me_dataset`. Si `schema` est
#' fourni, valide les donnees AVANT de retourner l'objet (via
#' `mecore::check_schema()`) — comble l'angle mort identifie : jusqu'ici,
#' rien n'empechait `meindicator::compute_indicator()` de calculer un
#' indicateur sur des donnees mal typees.
#'
#' @param path Chemin du fichier CSV.
#' @param name Nom du dataset (voir `mecore::me_dataset`).
#' @param metadata Un `mecore::me_metadata`.
#' @param schema Un `mecore::me_schema` optionnel. Si fourni et non
#'   respecte, leve une erreur (le dataset n'est jamais retourne invalide).
#' @param ... Arguments additionnels passes a `utils::read.csv()`
#'   (ex. `sep = ";"`, `dec = ","`).
#' @return Un `mecore::me_dataset`.
#' @export
import_csv <- function(path, name, metadata, schema = NULL, ...) {
  if (!file.exists(path)) {
    mecore::me_validation_error(sprintf("fichier introuvable : '%s'", path))
  }

  df <- utils::read.csv(path, stringsAsFactors = FALSE, ...)

  if (!is.null(schema)) {
    mecore::check_schema(df, schema)  # leve une erreur si non conforme
  }

  mecore::me_dataset(name = name, data = df, metadata = metadata)
}
