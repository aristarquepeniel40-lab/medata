#' Importer un dataset depuis un fichier Excel
#'
#' Lit une feuille Excel et construit un `mecore::me_dataset`, sur le
#' meme modele qu'`import_csv()`. Si `schema` est fourni, valide les
#' donnees AVANT de retourner l'objet (via `mecore::check_schema()`).
#'
#' Necessite le package `readxl` (`Suggests`, pas `Imports` — coherent
#' avec le traitement d'`openxlsx` dans `mecore::export_logframe_xlsx()`).
#'
#' @param path Chemin du fichier `.xlsx`/`.xls`.
#' @param name Nom du dataset (voir `mecore::me_dataset`).
#' @param metadata Un `mecore::me_metadata`.
#' @param sheet Nom ou index de la feuille a lire (par defaut : la
#'   premiere).
#' @param schema Un `mecore::me_schema` optionnel. Si fourni et non
#'   respecte, leve une erreur (le dataset n'est jamais retourne invalide).
#' @param ... Arguments additionnels passes a `readxl::read_excel()`.
#' @return Un `mecore::me_dataset`.
#' @export
import_xlsx <- function(path, name, metadata, sheet = 1, schema = NULL, ...) {
  if (!file.exists(path)) {
    mecore::me_validation_error(sprintf("fichier introuvable : '%s'", path))
  }
  if (!requireNamespace("readxl", quietly = TRUE)) {
    mecore::me_dependency_error("le package 'readxl' est requis : install.packages('readxl')")
  }

  df <- as.data.frame(readxl::read_excel(path, sheet = sheet, ...))

  if (!is.null(schema)) {
    mecore::check_schema(df, schema)  # leve une erreur si non conforme
  }

  mecore::me_dataset(name = name, data = df, metadata = metadata)
}
