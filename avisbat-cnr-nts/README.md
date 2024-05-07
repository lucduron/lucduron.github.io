avisbat-cnr-nts
===============

> Outils pour la génération (et la validation XSD) d'avis à la batellerie par CNR au format XML (NtS-FTM)

## 0 - Données

Deux exports de l'[ADS](https://data.sifrs.fr/) ont été réalisé (au 24/04/2024) :

* [tableau des écluses CNR](0-data/export_risindex_Ecluses_Rhone.csv)
* [tableau des hectomètres (PK tous les 0.1 km) CNR](0-data/export_risindex_Hectometres_Rhone.csv)

Le réseau est également décrit dans le code par deux tables :
* le [détails des secteurs (nom, PK début/fin et écluses)](avisbat/secteur.py) (voir la constante `SECTEURS`)
* le [corridor (avec l'itinéraire et le PK) de chaque écluse](avisbat/ecluse.py) (voir la constante `FAIRWAY_NAMES`)

Le [fichier de validation XSD](0-data/NtS_XSD_V.4.0.4.0.xsd) est intégré.

## 1 - Fichiers modèles (templates)

Voir les deux fichiers modèles XML (avec des balises spéciales entre `{{ }}` et `{% %}`) :

* [0-declaration.xml](1-avisbat-templates/0-declaration.xml)
* [1-cloture.xml](1-avisbat-templates/1-cloture.xml)

## 2 - Fichies générés

12 fichiers XML ont été générés à partir des données et des modèles à l'aide du script `generate_avisbat.py` :

| Secteur | Avis de déclaration                                                | Avis de clôture                                                |
|---------|--------------------------------------------------------------------|--------------------------------------------------------------------|
| 1       | [FRA_FR_2024_00001.xml](2-avisbat-generated/FRA_FR_2024_00001.xml) | [FRA_FR_2024_00007.xml](2-avisbat-generated/FRA_FR_2024_00007.xml) |
| 2       | [FRA_FR_2024_00002.xml](2-avisbat-generated/FRA_FR_2024_00002.xml) | [FRA_FR_2024_00008.xml](2-avisbat-generated/FRA_FR_2024_00008.xml) |
| 3       | [FRA_FR_2024_00003.xml](2-avisbat-generated/FRA_FR_2024_00003.xml) | [FRA_FR_2024_00009.xml](2-avisbat-generated/FRA_FR_2024_00009.xml) |
| 4       | [FRA_FR_2024_00001.xml](2-avisbat-generated/FRA_FR_2024_00004.xml) | [FRA_FR_2024_00010.xml](2-avisbat-generated/FRA_FR_2024_00010.xml) |
| 5       | [FRA_FR_2024_00005.xml](2-avisbat-generated/FRA_FR_2024_00005.xml) | [FRA_FR_2024_00011.xml](2-avisbat-generated/FRA_FR_2024_00011.xml) |
| 6       | [FRA_FR_2024_00006.xml](2-avisbat-generated/FRA_FR_2024_00006.xml) | [FRA_FR_2024_00012.xml](2-avisbat-generated/FRA_FR_2024_00012.xml) |

## 3 - Fichies rendus en HTML

Les fichiers sont également associés à des fichiers XSL pour se rendre compte du rendu final (proche du PDF). 
