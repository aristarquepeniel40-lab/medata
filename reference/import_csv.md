# Importer un dataset depuis un fichier CSV

Lit un CSV et construit un
[`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html).
Si `schema` est fourni, valide les donnees AVANT de retourner l'objet
(via
[`mecore::check_schema()`](https://rdrr.io/pkg/mecore/man/check_schema.html))
— comble l'angle mort identifie : jusqu'ici, rien n'empechait
`meindicator::compute_indicator()` de calculer un indicateur sur des
donnees mal typees.

## Usage

``` r
import_csv(path, name, metadata, schema = NULL, ...)
```

## Arguments

- path:

  Chemin du fichier CSV.

- name:

  Nom du dataset (voir
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html)).

- metadata:

  Un
  [`mecore::me_metadata`](https://rdrr.io/pkg/mecore/man/me_metadata.html).

- schema:

  Un
  [`mecore::me_schema`](https://rdrr.io/pkg/mecore/man/me_schema.html)
  optionnel. Si fourni et non respecte, leve une erreur (le dataset
  n'est jamais retourne invalide).

- ...:

  Arguments additionnels passes a
  [`utils::read.csv()`](https://rdrr.io/r/utils/read.table.html) (ex.
  `sep = ";"`, `dec = ","`).

## Value

Un
[`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html).
