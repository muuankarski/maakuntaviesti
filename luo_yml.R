joukkue <- readRDS("./_data/joukkue.RDS")
pisteet <- readRDS("./_data/pisteet.RDS")
tulos_df <- readRDS("./_data/tulos_df.RDS")

akt_paikat <- na.omit(tulos_df)
akt_p <- unique(akt_paikat$paikka)


if (1 %in% akt_p){
  
}

filename <- "_site.yml"
file.create(filename)  

cat(paste(
'name: "online.vetu.fi"
navbar:
  title: "etusivu"
  type: inverse
  left:',
if (1 %in% akt_p){'
   - text: "Osuus 1"
     menu:
     - text: "3.8 km"
       href:  piste1.html'},
if (2 %in% akt_p){'
     - text: "8.8 km"
       href:  piste2.html'},
if (3 %in% akt_p){'
   - text: "Osuus 2"
     menu:
     - text: "1.8 km"
       href:  piste3.html'},
if (4 %in% akt_p){'
   - text: "Osuus 3"
     menu:
     - text: "1.8 km"
       href:  piste4.html'},
if (5 %in% akt_p){'
   - text: "Osuus 4"
     menu:
     - text: "6.8 km"
       href:  piste5.html'},
if (6 %in% akt_p){'
   - text: "Osuus 5"
     menu:
     - text: "1.8 km"
       href:  piste6.html'},
if (7 %in% akt_p){'
   - text: "Osuus 6"
     menu:
     - text: "6.8 km"
       href:  piste7.html'},
if (8 %in% akt_p){'
   - text: "Osuus 7"
     menu:
     - text: "1.8 km"
       href:  piste8.html'},
if (9 %in% akt_p){'
   - text: "Osuus 8"
     menu:
     - text: "1.8 km"
       href:  piste9.html'},
if (10 %in% akt_p){'
     - text: "6.8 km"
       href:  piste10.html'},'
  right:
#    - text: "Mistä on kyse?"
#      img: plot/kela_logo.svg
#      href: about.html
   - icon: fa-info
     href: https://github.com/muuankarski/maakuntaviesti
output:
  html_document:
    theme: yeti
    highlight: textmate
#    include:
#      after_body: footer.html
#    css: styles.css

'), 
append=TRUE, 
file=filename)