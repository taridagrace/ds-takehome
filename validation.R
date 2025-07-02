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


# 2. Calibration Curve

p <- ggplot(validasi, aes(x = prediksi, y = aktual)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "loess") +
  labs(title = "Calibration Curve",
       x = "Prediksi Probabilitas",
       y = "Aktual Default")

print(p)

ggsave("calibration_curve.png")
