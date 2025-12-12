###Latitudinal Gradient
rich3 <- richness_lat
richness <- rich3[,-1]

scale_nnd <- scale(richness$nnd)
scale_dbh <- scale(richness$dbh)
scale_ch <- scale(richness$ch)
scale_uh <- scale(richness$uh)
scale_us <- scale(richness$uss)
scale_uo <- scale(richness$uso)
scale_bg <- scale(richness$bg)
scale_jd <- scale(richness$jd)
scale_temp <- scale(richness$temp_month)
scale_hum <- scale(richness$hum_month)
scale_lat <- scale(richness$lat)
scale_area <- scale(richness$area)
rich <- richness$richness

cor_richness <- cor(richness)
cor_richness
library(corrplot)
library(MuMIn)
corrplot(cor_richness)

#nnd, dbh, ch, uss, uso, bg, jd all highly correlated with latitude


richness_model3 <- lm(rich~scale_lat+scale_temp+scale_hum+scale_area+scale_uh,data=richness)
summary(richness_model3)
options(na.action = "na.fail")
model_selection <- dredge(richness_model3)
print(model_selection)
richness_model4 <- lm(rich~scale_lat,data=richness)
summary(richness_model4)
confint(richness_model4,level = 0.95)
#latitude is best predictor

