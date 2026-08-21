# Guide d’intégration — medata

Comme pour `mecore` et `meindicator`, tout ce code a été réellement
testé dans mon environnement, `mecore` et `meindicator` installés au
préalable. Un bug réel a été trouvé et corrigé en route (§3).

## 1. Pré-requis

`medata` dépend de `mecore`. Place ce dossier à côté de `mecore/` et
`meindicator/` (pas dedans). `mecore` doit déjà être installé
(`devtools::install()` depuis le projet `mecore`, comme fait
précédemment).

## 2. Installation

Même règle que les deux précédents : pas de `NAMESPACE` dans cette
archive, on laisse `roxygen2` le générer.

``` r

setwd("chemin/vers/medata")
devtools::document()
devtools::load_all(".")
source("walking_skeleton.R")   # doit afficher "TOUS LES TESTS MEDATA PASSENT."
devtools::test()
devtools::check()
```

N’oublie pas d’ajouter le fichier `LICENSE` (déjà inclus dans cette
archive, donc rien à faire ici contrairement à `meindicator` où je
l’avais oublié).

## 3. Bug trouvé en testant

[`nrow()`](https://rdrr.io/r/base/nrow.html)/[`ncol()`](https://rdrr.io/r/base/nrow.html)
retournent des `integer`, mais la propriété S7 `class_double` de
`me_quality_report` exige strictement un `double` — S7 ne fait pas de
coercion implicite `integer` → `double` comme le ferait R de base.
Corrigé avec `as.double(nrow(df))`. À garder en tête pour toute future
propriété `class_double` alimentée par une fonction R qui retourne un
entier (`nrow`, `ncol`, `length`, `sum` sur des entiers…).

## 4. Ce que fait ce package (V1 minimale)

- `import_csv(path, name, metadata, schema = NULL)` — importe un CSV en
  `me_dataset`. Si `schema` est fourni, **bloque l’import** si les
  données ne correspondent pas (comble l’angle mort : jusqu’ici rien
  n’empêchait `meindicator::compute_indicator()` de calculer sur des
  données mal typées).
- `quality_report(dataset)` → `me_quality_report` — complétude et typage
  par colonne, sans jamais modifier les données.
- `clean_missing(dataset, strategy = "flag" | "drop_rows")` — `"flag"`
  ne modifie rien (juste le rapport) ; `"drop_rows"` retire les lignes
  incomplètes sur les colonnes ciblées.
- `me_describe()` enregistré sur `me_quality_report` (générique
  cross-package de `mecore`, même mécanisme `.onLoad` que
  `meindicator`).

## 5. Sortie réelle du walking skeleton (testée ici)

    Import valide : OK - 4 lignes
    Import invalide bloque : schema non respecte :
    - colonne 'age' : type attendu 'double', type reel 'character'
    Rapport qualite 'enquete' : 4 lignes, 2 colonnes. Pire colonne : 'revenu' (25.0% manquant).
    Strategie flag : OK, donnees inchangees ( 4 lignes)
    Strategie drop_rows : OK, 3 lignes (1 retiree)
    Indicateur calcule sur donnees nettoyees : 25.33333

    TOUS LES TESTS MEDATA PASSENT.

La dernière ligne avant “TOUS LES TESTS…” est la preuve concrète que
l’angle mort est comblé : un indicateur `meindicator` calculé sur des
données passées par `medata` (import validé + nettoyage).
