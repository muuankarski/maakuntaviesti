library(tidyverse)
library(stringr)
joukkue <- readRDS("./_data/joukkue.RDS")
pisteet <- readRDS("./_data/pisteet.RDS")
tulos_df <- readRDS("./_data/tulos_df.RDS")


tul <- readLines(con = "http://results1.ultimate.dk/events/2017/ski/maakuntaviesti/results/Lehdisto%20lopputulokset%20ja%20nimet_5.txt")
tu <- tul[grep("^[0-8]\\.\\sosuus", tul)]
tu <- gsub(".+: ", "", tu)
tu <- gsub("[0-9]+\\) ", "", tu)


da <- data_frame(osuus1=unlist(strsplit(tu[1],split = ",")),
                osuus2=unlist(strsplit(tu[2],split = ",")),
                osuus3=unlist(strsplit(tu[3],split = ",")),
                osuus4=unlist(strsplit(tu[4],split = ",")),
                osuus5=unlist(strsplit(tu[5],split = ",")),
                osuus6=unlist(strsplit(tu[6],split = ",")),
                osuus7=unlist(strsplit(tu[7],split = ",")),
                osuus8=unlist(strsplit(tu[8],split = ",")))

db <- data_frame(osuus1=unlist(strsplit(tu[9],split = ",")),
                osuus2=unlist(strsplit(tu[10],split = ",")),
                osuus3=unlist(strsplit(tu[11],split = ",")),
                osuus4=unlist(strsplit(tu[12],split = ",")),
                osuus5=unlist(strsplit(tu[13],split = ",")),
                osuus6=unlist(strsplit(tu[14],split = ",")),
                osuus7=unlist(strsplit(tu[15],split = ",")),
                osuus8=unlist(strsplit(tu[16],split = ",")))

library(stringi)
d <- bind_rows(da,db)
d %>% gather(., osuus, aika, 1:8) %>% 
  mutate(aika = gsub("(\\s[0-9])","§\\1",aika))  %>% 
  filter(!aika %in% " ") %>% 
  separate(aika, into = c("nimi","time"), sep = "§") %>% 
  mutate(joukkue = nimi,
         joukkue = gsub(" III"," 3",joukkue),
         joukkue = gsub(" II"," 2",joukkue),
         joukkue = gsub(" IV"," 4",joukkue),
         joukkue = tolower(joukkue),
         nro = gsub("[^0-9]", "", joukkue),
         nro = ifelse(nro == "", 1, nro),
         joukkue = gsub("[0-9]", "", joukkue),
         joukkue = str_trim(joukkue),
         nimi = gsub("(\\S+)$","", joukkue),
         joukkue = stri_trans_totitle(word(joukkue,-1)),
         nimi = stri_trans_totitle(nimi),
         joukkue = paste(joukkue, nro), 
         # joukkue = gsub("[^(\\S+)$]","", joukkue),
         # joukkue_nr = gsub("[^.+ $]","",joukkue),
         # joukkue_nr = ifelse(nchar(joukkue_nr) > 3, NA, joukkue_nr),
         # or = joukkue,
         # joukkue2 = gsub("[^A-Ö]+$","",joukkue),
         # joukkue = gsub(".+\\s","",joukkue),
         nimi = str_trim(nimi),
         joukkue = str_trim(joukkue),
         time = gsub(".[0-9]$","", time),
         # time = as.POSIXct(time, format="%M:%S"),
         # aika = format(.POSIXct(time), "%M:%S"),
         time = str_trim(time),
         time_min = gsub(":.+", "", time),
         time_sec = gsub("^.+:", "", time)
         ) %>% 
  select(-nro) -> dd

joukkue$joukkue <- as.character(joukkue$joukkue)
joukkue$joukkue <- gsub("Uusikaarlepyy/Nykarleby", "Uusikaarlepyy", joukkue$joukkue)
joukkue$joukkue <- gsub("Kruunupyy/Kronoby", "Kruunupyy", joukkue$joukkue)
joukkue$joukkue <- gsub("Luoto/Larsmo", "Luoto", joukkue$joukkue)
joukkue$joukkue <- gsub("Kokkola/Karleby", "Kokkola", joukkue$joukkue)
joukkue$joukkue <- gsub("Pietarsaari/Jakobstad", "Pietarsaari", joukkue$joukkue)

j <- joukkue[c("joukkue","nro","Sarja")]
j$joukkue <- str_trim(j$joukkue)
j <- j[!duplicated(j[c("joukkue","nro")]),]

dat <- left_join(dd, j)

saveRDS(dat, "./_data/lopputulokset.RDS")

