
source("./process_data.R")
source("./luo_sivut.R")
# rmarkdown::clean_site()
# rmarkdown::render_site(encoding = 'UTF-8')
system('rsync -avzhe "ssh -i /home/aurelius/avaimet/ibm64-rsync-key" --progress --delete  ~/btsync/mk/web/vetu/maakuntaviesti/_site/ muuankarski@kapsi.fi:sites/online.vetu.fi/www/')

file.remove(list.files(path = "./", pattern = ".Rmd", full.names = TRUE))
