library(mecore)
library(medata)
library(S7)

# Fichiers de test generes ici (portable Windows/Linux/Mac), plutot que
# des chemins /tmp/ codes en dur (bug de portabilite trouve en testant
# chez l'utilisateur - /tmp n'existe pas nativement sous Windows).
chemin_valide <- tempfile(fileext = ".csv")
writeLines(c("age,revenu", "20,50000", "22,", "25,60000", "31,75000"), chemin_valide)

chemin_invalide <- tempfile(fileext = ".csv")
writeLines(c("age,revenu", "vingt,50000", "22,75000"), chemin_invalide)

meta <- me_metadata(
  project_name = "Pilote medata", organization = "Universite de Parakou",
  country = "Benin", donor = "N/A", manager = "Peniel",
  start_date = Sys.Date(), end_date = Sys.Date() + 365,
  version = "0.1", description = "test", objectives = "test", sdgs = character(0)
)

schema <- me_schema(fields = list(
  me_schema_field(name = "age", type = "double", label = "Age", required = TRUE),
  me_schema_field(name = "revenu", type = "double", label = "Revenu", required = TRUE)
))

# 1. Import valide, avec schema
d <- import_csv(chemin_valide, name = "enquete", metadata = meta, schema = schema)
stopifnot(S7_inherits(d, me_dataset))
cat("Import valide : OK -", nrow(d@data), "lignes\n")

# 2. L'angle mort comble : import invalide DOIT etre bloque avant de devenir un me_dataset
res <- tryCatch({
  import_csv(chemin_invalide, name = "enquete_bad", metadata = meta, schema = schema)
  "PAS D'ERREUR (BUG)"
}, error = function(e) conditionMessage(e))
cat("Import invalide bloque :", res, "\n")
stopifnot(grepl("schema non respecte", res))

# 3. Rapport de qualite
qr <- quality_report(d)
stopifnot(S7_inherits(qr, medata::me_quality_report))
print(qr@summary)
cat(me_describe(qr), "\n")

# 4. Nettoyage - strategie flag (ne modifie rien)
res_flag <- clean_missing(d, strategy = "flag")
stopifnot(nrow(res_flag$dataset@data) == nrow(d@data))
cat("Strategie flag : OK, donnees inchangees (", nrow(res_flag$dataset@data), "lignes)\n")

# 5. Nettoyage - strategie drop_rows (doit retirer la ligne avec revenu manquant)
res_drop <- clean_missing(d, strategy = "drop_rows")
stopifnot(nrow(res_drop$dataset@data) == nrow(d@data) - 1)
cat("Strategie drop_rows : OK,", nrow(res_drop$dataset@data), "lignes (1 retiree)\n")

# 6. Integration avec meindicator (le vrai objectif : combler l'angle mort)
library(meindicator)
i <- compute_indicator(res_drop$dataset, ~ mean(age), "Age moyen", "annees")
cat("Indicateur calcule sur donnees nettoyees :", i@value, "\n")

cat("\nTOUS LES TESTS MEDATA PASSENT.\n")
