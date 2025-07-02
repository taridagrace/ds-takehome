library(glmtoolbox)

library(ggplot2)

validasi <- read.csv("validasi.csv")

head(validasi)

library(ResourceSelection)

# 1. HL Test

hl <- hoslem.test(x = validasi$aktual, y = validasi$prediksi, g = 10)
print(hl)

hl$p.value        
hl$statistic     
hl$expected      
hl$observed      