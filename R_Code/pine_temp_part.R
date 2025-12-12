##### Large scale temporal partitioning
#running pairwise t.tests
#remove first column
avoidance_large <- tpart_large
avoid_large <- avoidance_large[,-1]
avoid_WEVI <- avoid_large[,-c(3:8)]
avoid_CAWR <- avoid_large[,-c(1,2,5,6,7,8)]
avoid_PIWA <- avoid_large[,-c(1,2,3,4,7,8)]
avoid_MODO <- avoid_large[,-c(1:6)]
#is the data normally distributed?
apply(avoid_large, 2, shapiro.test) # all variables are normally distributed

WEVI_a <- avoid$WEVI_a
WEVI_o <- avoid$WEVI_o
CAWR_a <- avoid_CAWR$CAWR_a
CAWR_o <- avoid_CAWR$CAWR_o
PIWA_a <- avoid_PIWA$PIWA_a
PIWA_o <- avoid_PIWA$PIWO_o
MODO_a <- avoid_MODO$MODO_a
MODO_o <- avoid_MODO$MODO_o
library(car)
library(MuMIn)
library(ggplot2)
#unequal or equal variances?

var.test(PIWA_a,PIWA_o)

#unpaired t tests
ttest1 <- t.test(WEVI_a,WEVI_o, var.equal = FALSE)
ttest2 <- t.test(CAWR_a,CAWR_o, var.equal = FALSE)
ttest3 <- t.test(PIWA_a,PIWA_o, var.equal = FALSE)
ttest4 <- t.test(MODO_a,MODO_o, var.equal = FALSE)
ttest5 <- t.test(CAWR,PIWA, var.equal = TRUE)
ttest6 <- t.test(PIWA,MODO, var.equal = TRUE)

ttest4

##Create figure showcasing differences in song overlap and avoidance between NOCA and 4 species
#Converts the data frame columns into a matrix 
#and transposes it to make the "species" categories appear on the x-axis.
tpart_data <- tpart_large2
bar_data <- t(as.matrix(tpart_data[, c("song overlap","song avoidance")]))

#move left margin from 5 to 6 to make y axis label not bleed off page


tiff("Fig2.tiff", width = 12, height = 8, units = "in", res = 300)
par(mar = c(5, 6, 6, 2))
barplot_tpart <- barplot(bar_data, beside = TRUE, names.arg = tpart_data$species,
                         xlab = "Species",ylab = "Song Peak Similarity (%)",ylim = c(0.0,1.0),
                         legend = c("Song Peak Overlap","Song Peak Avoidance"),
                         cex.lab=1.5,cex.names = 1,
                         args.legend = list(cex = 1.25,bty="n"))

#add error bars
#song overlap
arrows(barplot_tpart[1,], tpart_data$`song overlap` - tpart_data$stdv,
       barplot_tpart[1,], tpart_data$`song overlap` + tpart_data$stdv,
       angle = 90, code = 3, length = 0.1, col = "black")

#song avoidance
arrows(barplot_tpart[2,], tpart_data$`song avoidance` - tpart_data$stdv,
       barplot_tpart[2,], tpart_data$`song avoidance` + tpart_data$stdv,
       angle = 90, code = 3, length = 0.1, col = "black")

dev.off()

palette()


##Create linear regression comparing species richness and song overlap of species pairs
tpart_ls_grad <- tpart_large3
nrow(tpart_ls_grad)
sim <- tpart_ls_grad[-(8:14),]
rich <- sim$richness
over <- sim$overlap
model1 <- lm(rich~over,data=sim)
summary(model1)
confint(model1, level = 0.95)

dis <- tpart_ls_grad[-(1:7),]
rich <- dis$richness
over <- dis$overlap
model2 <- lm(rich~over,data=dis)
summary(model2)
confint(model2, level = 0.95)


##are intercepts different?
rich_ls <- tpart_ls_grad$richness
species_ls <- tpart_ls_grad$species
over_ls <- tpart_ls_grad$overlap

## do the intercepts and slopes different between model 1 and model 2
model_ls <- lm(over_ls~rich_ls*species_ls,data = tpart_ls_grad)
summary(model_ls)

##run model without interaction term
model_ls2 <- lm(over_ls~rich_ls+species_ls,data = tpart_ls_grad)
summary(model_ls2)

## no significant difference in slopes of two models
anova(model_ls,model_ls2)


##Create figures of linear regressions
over <- tpart_ls_grad$overlap
rich_l <- tpart_ls_grad$richness
species_l <- tpart_ls_grad$species

tiff("Fig3a.tiff", width = 10, height = 8, units = "in", res = 300)
plot1 <- ggplot(tpart_ls_grad, aes(x = rich_l, y = over, color = species_l)) +
  geom_point(size = 4) +  # Add scatter points
  geom_smooth(method = "lm", se = TRUE, aes(fill = species_l),alpha=0.3) +  # Add trend lines
  labs(
    x = "Species Richness",
    y = "Song Peak Overlap (%)",
    color = "NOCA Song Similarity",
    linetype = "NOCA Song Similarity"
  ) +
  guides(
    color = guide_legend(title = "NOCA Song Similarity"),
    fill = guide_legend(title = "NOCA Song Similarity")  # Combine both into one legend
  )+ theme_minimal()+
  theme(
    axis.title = element_text(size = 16),       # Increase font size for axis titles
    axis.text = element_text(size = 12),       # Increase font size for axis tick labels
    legend.title = element_text(size = 14),    # Increase font size for legend title
    legend.text = element_text(size = 12),     # Increase font size for legend labels
    plot.title = element_text(size=20, face="bold")
  )


print(plot1)

dev.off()





##### Small Scale SONG Metrics
##Linear Regression of pairwise p metrics across richness gradient
tpart_snull <- tpart_small
nrow(tpart_snull)
sim_sn <- tpart_snull[-(9:16),]
rich_sn <- sim_sn$richness
psn<- sim_sn$p
modelsn <- lm(rich_sn~psn,data=sim_sn)
summary(modelsn)
confint(modelsn, level = 0.95)

sim_dn <- tpart_snull[-(1:8),]
rich_dn <- sim_dn$richness
pdn <- sim_dn$p
modelsn2 <- lm(rich_dn~pdn,data=sim_dn)
summary(modelsn2)
confint(modelsn2, level = 0.95)


##are intercepts different?
rich_n <- tpart_snull$richness
species_n <- tpart_snull$species
p_n <- tpart_snull$p

## do the intercepts and slopes different between model 1 and model 2
model_sn <- lm(p_n~rich_n*species_n,data = tpart_snull)
summary(model_sn)

##run model without interaction term
model_sn2 <- lm(p_n~rich_n+species_n,data = tpart_snull)
summary(model_sn2)

## no significant difference in slopes of two models
anova(model_sn,model_sn2)


#plot SONG p values vs richness regression
p <- tpart_snull$p
rich <- tpart_snull$richness
species <- tpart_snull$species

tiff("Fig3b.tiff", width = 10, height = 8, units = "in", res = 300)
plot2 <- ggplot(tpart_snull, aes(x = rich, y = p, color = species)) +
  geom_point(size = 4) +  # Add scatter points
  geom_smooth(method = "lm", se = TRUE, aes(fill = species),alpha=0.3) +  # Add trend lines
  labs(
    x = "Species Richness",
    y = "SONG P Value",
    color = "NOCA Song Similarity",
    linetype = "NOCA Song Similarity"
  ) +
  guides(
    color = guide_legend(title = "NOCA Song Similarity"),
    fill = guide_legend(title = "NOCA Song Similarity")  # Combine both into one legend
  )+ theme_minimal()+
  theme(
    axis.title = element_text(size = 16),       # Increase font size for axis titles
    axis.text = element_text(size = 12),       # Increase font size for axis tick labels
    legend.title = element_text(size = 14),    # Increase font size for legend title
    legend.text = element_text(size = 12),     # Increase font size for legend labels
    plot.title = element_text(size=20, face="bold")
  )


print(plot2)

dev.off()


##are mean SONG p metrics different from null (0.5)? p>0.05 data is normal
tpart_song <- tpart_small2
shapiro.test(tpart_song$modo)
#wevi not normal, cawr not normal,piwa not normal, modo not normal
#log transform data
tparts_log <- log(tpart_song)
shapiro.test(tparts_log$wevi)
tparts_sqt <- sqrt(tpart_song)
shapiro.test(tparts_sqt$wevi)
#still not normal

wilcox.test(tpart_song$modo,tpart_song$null,exact = FALSE)
#wevi and cawr differ form 0.5, modo and piwa do not

wilcox.test(tpart_song$piwa,tpart_song$modo,exact = FALSE)



#is the data normally distributed?
apply(avoid_large, 2, shapiro.test)
#unequal or equal variances?
var.test(PIWA_a,PIWA_o)

#run t-test
ttest1 <- t.test(WEVI_a,WEVI_o, var.equal = FALSE)

#plot SONG p metric bar graphs

mean_snull <- data.frame(
  Species = c("CAWR", "WEVI", "PIWA", "MODO"),
  mean = c(0.74, 0.68, 0.44, 0.44),
  sd = c(0.26, 0.29, 0.36, 0.3))
class(mean_snull)

#default par() margins:par(mar = c(5, 4, 4, 2) + 0.1)

tiff("mean_snullplot.tiff", width = 10, height = 8, units = "in", res = 300)
par(mar = c(4,6,8,2))


bar_centers <- barplot(mean_snull$mean, names.arg = mean_snull$Species, 
                       ylim = c(0, max(mean_snull$mean + mean_snull$sd) * 1.1),
                       col = "skyblue", ylab = "Average Overlap P Value",
                       space = 0.5,cex.lab=1.5,cex.axis = 1.2,cex.names = 1.25)

# Add error bars
arrows(bar_centers, mean_snull$mean - mean_snull$sd,
       bar_centers, mean_snull$mean + mean_snull$sd,
       angle = 90, code = 3, length = 0.1,lwd = 1.5)

dev.off()

#asterisk above 1st bar
text(x = bar_centers[1], y = mean_snull$mean[1] + mean_snull$sd[1] + 0.05, 
     labels = "***", cex = 1.5)
#asterisk above 1st bar
text(x = bar_centers[2], y = mean_snull$mean[2] + mean_snull$sd[1] + 0.08, 
     labels = "***", cex = 1.5)

dev.off()


##plot both overlap vs richness regressions together
library(gridExtra)

tiff("Figure3.tiff", width = 10, height = 8, units = "in", res = 300)
grid.arrange(plot1, plot2, nrow = 2)
dev.off()




