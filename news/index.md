# Changelog

## medata 1.0.0

Première version stable.

### Fonctionnalités

- [`import_csv()`](https://aristarquepeniel40-lab.github.io/medata/reference/import_csv.md)
  — importe un CSV en
  [`mecore::me_dataset`](https://rdrr.io/pkg/mecore/man/me_dataset.html),
  avec validation de schéma optionnelle et bloquante.
- [`import_xlsx()`](https://aristarquepeniel40-lab.github.io/medata/reference/import_xlsx.md)
  — équivalent pour l’Excel (nécessite `readxl`, en `Suggests`).
- [`quality_report()`](https://aristarquepeniel40-lab.github.io/medata/reference/quality_report.md)/`me_quality_report`
  — complétude et typage par colonne, sans jamais modifier les données.
- [`clean_missing()`](https://aristarquepeniel40-lab.github.io/medata/reference/clean_missing.md)
  — stratégies `"flag"` (observation) ou `"drop_rows"` (action) pour les
  valeurs manquantes.
- [`me_describe()`](https://rdrr.io/pkg/mecore/man/me_describe.html)
  enregistré sur `me_quality_report`.

### Corrections notables

- [`nrow()`](https://rdrr.io/r/base/nrow.html)/[`ncol()`](https://rdrr.io/r/base/nrow.html)
  retournent des `integer`, incompatibles avec une propriété S7
  `class_double` (pas de coercion implicite) — corrigé avec
  `as.double(...)`.
- `describe()` renommé
  [`me_describe()`](https://rdrr.io/pkg/mecore/man/me_describe.html)
  (voir NEWS de `mecore`).
