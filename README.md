# Hány éves vagyok
Estimate the age range of trees out of other attributes

## Motivation
A lot of cities already publish their street tree data as open data, but still some attributes are missing, like the plant year / tree age, that would be useful to determine their need of watering.

## Approach
* find patterns between other attributes and the age resp. plant year in existing data
  * genus
  * species
  * trunk circumference / trunk diameter
  * crown diameter
  * tree height
* maybe there already exist hash tables that provide insight of expected trunk circumference, crown diameter, tree height ranges for certain genus and species by age
* knowing about droughts may also influence the growth speed of trees and by this a lower trunk circumference might be expected than for trees of same age but with better water supply

## Implementation
* use some statistical methods like interpolation, extrapolation, correlation analysis, clustering
* use some machine learning in comparison

## Data to use
* Wikidata
* tree nursery data
* tree cadastre data

## Links
* [Flurbäume - Jährlicher Zuwachs des Stammumfangs von Bäumen nach verschiedenen Quellen, cm / Jahr](https://flurbaum.de/zuwachs-tabelle.html)
* [Baumalter - Schätz -O- Meter](https://www.baumportal.de/baum-alter-bestimmen)
* [geoclimbing.de - Woher weiß ich, wie alt ein Baum ist?](https://www.geoclimbing.de/knowledge-base/woher-weiss-ich-wie-alt-ein-baum-ist/)
* [Baumsicht - Baumalter bestimmen](https://baumsicht.de/alter/)
* [Das "geheime" Wachstum der Bäume](https://www.pflanzenforschung.de/de/pflanzenwissen/journal/das-geheime-wachstum-der-baeume)