library(devtools)
install_github("ChristinaMasco/song")
library(song)

TT6_MN <- sample_song
#convert BPK_WN$ID into a factor with 2 levels
TT6_MN$ID <- factor(TT6_MN$ID, levels = c("NOCA", "MODO"))
#convert to dataframe
TT6 <- as.data.frame(TT6_MN)
#runcode
tt6_mn <- song.FromDataObj(TT6)
tt6_mn_s <- song.Simulate(tt6_mn)
song.Summarize(tt6_mn_s)



#sampledata
load("wrens.rda")
str(wrens)
birds <- song.FromDataObj(wrens)
rndbirds <- song.Simulate(birds)
song.Summarize(rndbirds)
?song.Summarize
