# Gerer les valeurs manquantes d'un dataset

Deux strategies volontairement simples pour cette V1 :

- `"flag"` (par defaut) : ne modifie rien, retourne juste le rapport de
  qualite pour decision humaine.

- `"drop_rows"` : supprime les lignes contenant au moins une valeur
  manquante dans les colonnes ciblees.

## Usage

``` r
clean_missing(dataset, columns = NULL, strategy = c("flag", "drop_rows"))
```

## Arguments

- dataset:

  Un
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html).

- columns:

  Colonnes a considerer (par defaut : toutes).

- strategy:

  `"flag"` ou `"drop_rows"`.

## Value

Une liste `list(dataset = ..., report = ...)` : `dataset` est inchange
si `strategy = "flag"`, modifie si `"drop_rows"` ; `report` est le
`me_quality_report` calcule AVANT toute modification.
