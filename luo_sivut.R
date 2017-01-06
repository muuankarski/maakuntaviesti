

for (cc in pisteet$id){
filename <- paste0("piste",cc,".Rmd")
file.create(filename)  

osuus <- pisteet$osuus[cc]
jarj <- pisteet$jarj[cc]
km <- pisteet$km[cc]


cat(paste0(
'---
title: "Osuus ',osuus,' väliaika ',jarj,' kohdassa ',km,' km"
output: html_document
#toc: true
#toc_float: true
#number_sections: yes
#code_folding: hide
---
  

```{r setup, include = F, echo=FALSE}
library(knitr)
knitr::opts_chunk$set(list(echo=TRUE,
eval=TRUE,
cache=FALSE,
warning=FALSE,
message=FALSE))
opts_chunk$set(fig.width = 10, fig.height = 10)
library(tidyverse)
joukkue <- readRDS("./_data/joukkue.RDS")
pisteet <- readRDS("./_data/pisteet.RDS")
tulos_df <- readRDS("./_data/tulos_df.RDS")
```
    

```{r, echo=FALSE}
cc <- ',cc,'
osuus <- pisteet$osuus[cc]
jarj <- pisteet$jarj[cc]
km <- pisteet$km[cc]

ostulos <- tulos_df[tulos_df$paikka == cc, ]
osjoukkue <- joukkue[joukkue$osuus == osuus, ]
ostulos$nimi <- osjoukkue$nimi[match(ostulos$nr, osjoukkue$nro)]
ostulos$joukkue <- osjoukkue$joukkue[match(ostulos$nr, osjoukkue$nro)]
ostulos$time <- as.POSIXct(ostulos$aika, format="%H:%M:%S")
tbl <- ostulos %>% select(nro,nimi,joukkue,aika)
',
'knitr::kable(tbl,  "html", table.attr=',"'class=",'"table table-striped table-hover"',"',row.names=FALSE)
```"
), 
append=TRUE, 
file=filename)

}
