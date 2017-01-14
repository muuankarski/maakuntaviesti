library(tidyverse)
# Lue joukkuelista
# d_list <- yaml::yaml.load_file("./_data/teams.yml")
# j <- plyr::ldply (d_list, data.frame, stringsAsFactors=FALSE)
# joukkue <- gather(j, key = osuus, value = hiihtaja, 3:ncol(j))
# joukkue$osuus <- gsub("os", "", joukkue$osuus)
# saveRDS(joukkue, "./_data/joukkue.RDS")


# skreippaa joukkuelista
# download.file("https://secure.onreg.com/onreg2/users/reports_public.php?id=3533&list=false&type=csv&reportid=2&checksum=a506bc3723826fbc9fd83f3b4698e9d3",destfile = "./_data/joukkueet_2.csv")
# tbl <- read.csv("./_data/joukkueet_23.csv", skip = 1)
# tbl %>% filter(grepl("[0-9]",nro)) %>%
#   group_by(nro) %>% mutate(osuus=row_number()) %>% ungroup() -> joukkue
# saveRDS(joukkue, "./_data/joukkue.RDS")

# valiaikapisteet
d_list <- yaml::yaml.load_file("./_data/pisteet.yml")
pisteet <- plyr::ldply (d_list, data.frame, stringsAsFactors=FALSE)
saveRDS(pisteet, "./_data/pisteet.RDS")

# tulokset
tulos <- read.csv("./_data/tulos.csv", stringsAsFactors = FALSE)
nrot <- tulos %>% select(starts_with("nr"))
ajat <- tulos %>% select(starts_with("aika"))
nrot %>% gather(key = paikka, value = nro) %>% 
  mutate(paikka = gsub("nr","",paikka)) -> nro
ajat %>% gather(key = paikka, value = aika) %>% 
  mutate(paikka = gsub("aika","",paikka)) -> aika
# tulos_df <- merge(aika,nro,by="paikka", all.x=TRUE)
# tulos_df <- tulos_df[!duplicated(tulos_df[c("aika","nro")]),]
tulos_df <- bind_cols(aika,nro)
names(tulos_df) <- c("paikka","aika","paikka2","nro")
tulos_df$paikka2 <- NULL
saveRDS(tulos_df, "./_data/tulos_df.RDS")


