# medata 1.0.0

Première version stable.

## Fonctionnalités

* `import_csv()` — importe un CSV en `mecore::me_dataset`, avec
  validation de schéma optionnelle et bloquante.
* `import_xlsx()` — équivalent pour l'Excel (nécessite `readxl`, en
  `Suggests`).
* `quality_report()`/`me_quality_report` — complétude et typage par
  colonne, sans jamais modifier les données.
* `clean_missing()` — stratégies `"flag"` (observation) ou
  `"drop_rows"` (action) pour les valeurs manquantes.
* `me_describe()` enregistré sur `me_quality_report`.

## Corrections notables

* `nrow()`/`ncol()` retournent des `integer`, incompatibles avec une
  propriété S7 `class_double` (pas de coercion implicite) — corrigé
  avec `as.double(...)`.
* `describe()` renommé `me_describe()` (voir NEWS de `mecore`).
