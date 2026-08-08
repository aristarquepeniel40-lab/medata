helper_metadata <- function() {
  mecore::me_metadata(
    project_name = "p", organization = "o", country = "c", donor = "d", manager = "m",
    start_date = Sys.Date(), end_date = Sys.Date() + 1,
    version = "0.1", description = "d", objectives = "o", sdgs = character(0)
  )
}

helper_csv <- function(content) {
  path <- tempfile(fileext = ".csv")
  writeLines(content, path)
  path
}

test_that("import_csv construit un me_dataset valide", {
  path <- helper_csv(c("age,revenu", "20,50000", "22,60000"))
  d <- import_csv(path, name = "d1", metadata = helper_metadata())
  expect_true(S7::S7_inherits(d, mecore::me_dataset))
  expect_equal(nrow(d@data), 2)
})

test_that("import_csv bloque un fichier non conforme au schema", {
  path <- helper_csv(c("age,revenu", "vingt,50000"))
  schema <- mecore::me_schema(fields = list(
    mecore::me_schema_field(name = "age", type = "double", label = "Age", required = TRUE)
  ))
  expect_error(
    import_csv(path, name = "d1", metadata = helper_metadata(), schema = schema),
    regexp = "schema non respecte"
  )
})

test_that("import_csv signale un fichier introuvable", {
  expect_error(
    import_csv("/chemin/inexistant.csv", name = "d1", metadata = helper_metadata()),
    regexp = "introuvable"
  )
})

test_that("quality_report calcule correctement la completude", {
  path <- helper_csv(c("age,revenu", "20,50000", "22,", "25,60000"))
  d <- import_csv(path, name = "d1", metadata = helper_metadata())
  qr <- quality_report(d)
  expect_equal(qr@n_rows, 3)
  ligne_revenu <- qr@summary[qr@summary$column == "revenu", ]
  expect_equal(ligne_revenu$n_missing, 1)
})

test_that("clean_missing 'flag' ne modifie pas les donnees", {
  path <- helper_csv(c("age,revenu", "20,50000", "22,"))
  d <- import_csv(path, name = "d1", metadata = helper_metadata())
  res <- clean_missing(d, strategy = "flag")
  expect_equal(nrow(res$dataset@data), 2)
})

test_that("clean_missing 'drop_rows' retire les lignes incompletes", {
  path <- helper_csv(c("age,revenu", "20,50000", "22,"))
  d <- import_csv(path, name = "d1", metadata = helper_metadata())
  res <- clean_missing(d, strategy = "drop_rows")
  expect_equal(nrow(res$dataset@data), 1)
})

test_that("clean_missing signale une colonne cible introuvable", {
  path <- helper_csv(c("age,revenu", "20,50000"))
  d <- import_csv(path, name = "d1", metadata = helper_metadata())
  expect_error(
    clean_missing(d, columns = "inexistante", strategy = "drop_rows"),
    regexp = "introuvable"
  )
})
