library(tidyverse)
# Lue joukkuelista
d_list <- yaml::yaml.load_file("./_data/teams.yml")
j <- plyr::ldply (d_list, data.frame, stringsAsFactors=FALSE)
joukkue <- gather(j, key = osuus, value = hiihtaja, 3:ncol(j))
joukkue$osuus <- gsub("os", "", joukkue$osuus)
saveRDS(joukkue, "./_data/joukkue.RDS")

# valiaikapisteet
d_list <- yaml::yaml.load_file("./_data/pisteet.yml")
pisteet <- plyr::ldply (d_list, data.frame, stringsAsFactors=FALSE)
saveRDS(pisteet, "./_data/pisteet.RDS")

# tulokset
d_list <- yaml::yaml.load_file("./_data/tulos.yml")
tulos <- plyr::ldply (d_list, data.frame, stringsAsFactors=FALSE)

df <- gather(tulos, key = sija, value = arvo, 2:ncol(tulos))
df %>% separate(col = arvo, into = c("nr","aika"), sep = " ", remove = TRUE) %>% 
  mutate(sija = gsub("sija_", "", sija), 
         aika = gsub('"', '', aika)) -> tulos_df
saveRDS(tulos_df, "./_data/tulos_df.RDS")


