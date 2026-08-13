# medata

[![R-CMD-check](https://github.com/aristarquepeniel40-lab/medata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aristarquepeniel40-lab/medata/actions/workflows/R-CMD-check.yaml)

**Import, validation et nettoyage de données pour l'écosystème [MEverse](https://github.com/aristarquepeniel40-lab/mecore).**

Importe des `mecore::me_dataset` depuis des fichiers CSV ou Excel, valide
leur schéma *avant* toute utilisation en aval, et fournit un rapport de
qualité (complétude, typage) ainsi qu'un nettoyage minimal des valeurs
manquantes.

## Installation

```r
install.packages("remotes")
remotes::install_github("aristarquepeniel40-lab/mecore")   # dependance
remotes::install_github("aristarquepeniel40-lab/medata")
```

## Exemple rapide

```r
library(mecore)
library(medata)

meta <- me_metadata(
  project_name = "Suivi agricole", organization = "o", country = "Benin",
  donor = "d", manager = "m", start_date = Sys.Date(), end_date = Sys.Date() + 365,
  version = "1.0", description = "d", objectives = "o", sdgs = character(0)
)

# Import avec validation de schema : bloque si les donnees ne correspondent pas
schema <- me_schema(fields = list(
  me_schema_field(name = "age", type = "double", label = "Age", required = TRUE)
))
d <- import_csv("exploitants.csv", name = "exploitants", metadata = meta, schema = schema)

# Rapport de qualite, sans jamais modifier les donnees
qr <- quality_report(d)
print(qr@summary)
```

## Import Excel

```r
d <- import_xlsx("exploitants.xlsx", name = "exploitants", metadata = meta, sheet = "Exploitants")
```
(nécessite `install.packages("readxl")`)

## Fait partie de l'écosystème MEverse

[mecore](https://github.com/aristarquepeniel40-lab/mecore) (fondations) ·
**medata** (ce dépôt) ·
[meindicator](https://github.com/aristarquepeniel40-lab/meindicator) ·
[mecheck](https://github.com/aristarquepeniel40-lab/mecheck) ·
[mereport](https://github.com/aristarquepeniel40-lab/mereport)

## Licence

MIT — voir [`LICENSE`](LICENSE).
