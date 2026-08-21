# Rapport de qualite d'un dataset

Resume la completude et le typage de chaque colonne d'un
[`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html).
Ne modifie jamais les donnees (voir
[`clean_missing()`](https://aristarquepeniel40-lab.github.io/medata/reference/clean_missing.md)
pour la partie qui agit).

## Usage

``` r
me_quality_report(
  dataset_name = character(0),
  n_rows = numeric(0),
  n_cols = numeric(0),
  summary = (function (.data = list(), row.names = NULL) 
 {
     if (is.null(row.names))
    {
         list2DF(.data)
     }
     else {
         out <- list2DF(.data,
    length(row.names))
attr(out, "row.names") <- row.names
         out
     }

    })()
)
```

## Arguments

- dataset_name:

  Nom du dataset source.

- n_rows:

  Nombre de lignes.

- n_cols:

  Nombre de colonnes.

- summary:

  Un `data.frame` avec une ligne par colonne : `column`, `type`,
  `n_missing`, `pct_missing`.
