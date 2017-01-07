
source("./process_data.R")
source("./luo_sivut.R")

system('rsync -avzhe "ssh -i /home/aurelius/avaimet/ibm64-rsync-key" --progress --delete  ~/btsync/mk/web/vetu/maakuntaviesti/_site/ muuankarski@kapsi.fi:sites/online.vetu.fi/www/')

file.remove(list.files(path = "./", pattern = ".Rmd", full.names = TRUE))


# Jari 0400-755737
# Tero 040-8485265
# kuntawlan "1010acdc10"