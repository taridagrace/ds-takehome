library(glmtoolbox)

library(ggplot2)

validasi <- read.csv("validasi.csv")

head(validasi)

library(ResourceSelection)


# 1. HL Test

hl <- hoslem.test(x = validasi$aktual, y = validasi$prediksi, g = 10)
print(hl)

# Hasil HL Test menunjukkan p-value sangat kecil (< 0.05),
# artinya model tidak fit sempurna terhadap data.
# Namun, hal ini biasa terjadi pada data besar.
# Dengan validasi tambahan seperti calibration curve & cut-off,
# model tetap bisa digunakan dengan pengambilan keputusan yang terkontrol.

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


# 3. Cut-off

cutoff <- quantile(validasi$prediksi, probs = 0.95)
print(paste("Cut-off score (≤5% risiko default):", cutoff))
