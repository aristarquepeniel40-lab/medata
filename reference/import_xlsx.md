# Importer un dataset depuis un fichier Excel

Lit une feuille Excel et construit un
[`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html),
sur le meme modele
qu'[`import_csv()`](https://aristarquepeniel40-lab.github.io/medata/reference/import_csv.md).
Si `schema` est fourni, valide les donnees AVANT de retourner l'objet
(via
[`mecore::check_schema()`](https://rdrr.io/pkg/mecore/man/check_schema.html)).

## Usage

``` r
import_xlsx(path, name, metadata, sheet = 1, schema = NULL, ...)
```

## Arguments

- path:

  Chemin du fichier `.xlsx`/`.xls`.

- name:

  Nom du dataset (voir
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html)).

- metadata:

  Un
  [`mecore::me_metadata`](https://rdrr.io/pkg/mecore/man/me_metadata.html).

- sheet:

  Nom ou index de la feuille a lire (par defaut : la premiere).

- schema:

  Un
  [`mecore::me_schema`](https://rdrr.io/pkg/mecore/man/me_schema.html)
  optionnel. Si fourni et non respecte, leve une erreur (le dataset
  n'est jamais retourne invalide).

- ...:

  Arguments additionnels passes a
  [`readxl::read_excel()`](https://readxl.tidyverse.org/reference/read_excel.html).

## Value

Un
[`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html).

## Details

Necessite le package `readxl` (`Suggests`, pas `Imports` — coherent avec
le traitement d'`openxlsx` dans
[`mecore::export_logframe_xlsx()`](https://rdrr.io/pkg/mecore/man/export_logframe_xlsx.html)).
