source("./process_data.R")
source("./luo_sivut.R")
source("./luo_yml.R")
rmarkdown::render_site()
system('rsync -avzhe "ssh -i /home/aurelius/avaimet/ibm64-rsync-key" --progress --delete  ~/btsync/mk/web/vetu/maakuntaviesti/_site/ muuankarski@kapsi.fi:sites/online.vetu.fi/www/')
# 
# rmds <- list.files(path = "./", pattern = ".Rmd", full.names = TRUE)
# f2520ile.remove(rmds[!grepl("index", rmds)])


# Jari 0400-755737
# Tero 040-8485265
# kuntawlan "1010acdc10"