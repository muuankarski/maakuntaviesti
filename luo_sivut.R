joukkue <- readRDS("./_data/joukkue.RDS")
pisteet <- readRDS("./_data/pisteet.RDS")
tulos_df <- readRDS("./_data/tulos_df.RDS")

akt_paikat <- na.omit(tulos_df)
akt_p <- as.numeric(unique(akt_paikat$paikka))

for (cc in akt_p){
filename <- paste0("piste",cc,".Rmd")
file.create(filename)  

osuus <- pisteet$osuus[cc]
jarj <- pisteet$id[cc]
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

<!-- <meta http-equiv="refresh" content="15"> -->

<div class="alert alert-dismissible alert-danger">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Huomio!</strong> </br> Hiihtäjien nimet eivät ajan tasalla!
</div>

```{r setup, include = F, echo=FALSE}
library(knitr)
knitr::opts_chunk$set(list(echo=FALSE,eval=TRUE,cache=FALSE,warning=FALSE,message=FALSE))
library(tidyverse)
joukkue <- readRDS("./_data/joukkue.RDS")
pisteet <- readRDS("./_data/pisteet.RDS")
tulos_df <- readRDS("./_data/tulos_df.RDS")
```
#  {.tabset}

`päivitetty: `r Sys.time()``

## Kokonaistilanne

```{r}
cc <- ',cc,'
osuus <- pisteet$osuus[cc]
jarj <- pisteet$id[cc]
km <- pisteet$km[cc]

ostulos <- tulos_df[tulos_df$paikka == cc, ]
osjoukkue <- joukkue[joukkue$osuus == osuus, ]
ostulos$nimi <- osjoukkue$nimi[match(ostulos$nr, osjoukkue$nro)]
ostulos$joukkue <- osjoukkue$joukkue[match(ostulos$nr, osjoukkue$nro)]
ostulos$Sarja <- osjoukkue$Sarja[match(ostulos$nr, osjoukkue$nro)]
ostulos$sarja <- gsub("-sarja","",ostulos$Sarja)
ostulos_orig <- ostulos
ostulos$time <- as.POSIXct(ostulos$aika, format="%H:%M:%S")
ostulos %>% mutate(ero = time - time[1]) -> ostulos
ostulos$ero <- format(.POSIXct(ostulos$ero), "%M:%S")
ostulos <- na.omit(ostulos)
if (nrow(ostulos) != 0){
ostulos$sija <- 1:nrow(ostulos)
tbl <- ostulos %>% select(sija,nro,nimi,joukkue,sarja,ero)
',
'knitr::kable(tbl,  "html", table.attr=',"'class=",'"table table-striped table-hover"',"',row.names=FALSE)
}
```

",
'
## A-sarja

```{r}
ostulos <- ostulos_orig[ostulos_orig$sarja == "A",]
ostulos$time <- as.POSIXct(ostulos$aika, format="%H:%M:%S")
ostulos %>% mutate(ero = time - time[1]) -> ostulos
ostulos$ero <- format(.POSIXct(ostulos$ero), "%M:%S")
ostulos <- na.omit(ostulos)
if (nrow(ostulos) != 0){
ostulos$sija <- 1:nrow(ostulos)
tbl <- ostulos %>% select(sija,nro,nimi,joukkue,sarja,ero)
',
'knitr::kable(tbl,  "html", table.attr=',"'class=",'"table table-striped table-hover"',"',row.names=FALSE)
}
```
",
'
## B-sarja

```{r}
ostulos <- ostulos_orig[ostulos_orig$sarja == "B",]
ostulos$time <- as.POSIXct(ostulos$aika, format="%H:%M:%S")
ostulos %>% mutate(ero = time - time[1]) -> ostulos
ostulos$ero <- format(.POSIXct(ostulos$ero), "%M:%S")
ostulos <- na.omit(ostulos)
if (nrow(ostulos) != 0){
ostulos$sija <- 1:nrow(ostulos)
tbl <- ostulos %>% select(sija,nro,nimi,joukkue,sarja,ero)
',
'knitr::kable(tbl,  "html", table.attr=',"'class=",'"table table-striped table-hover"',"',row.names=FALSE)
}
```
"
), 
append=TRUE, 
file=filename)

}
