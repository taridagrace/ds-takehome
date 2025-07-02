\## A.4 – Deteksi Anomali

Dari hasil analisis kolom decoy\_noise, ditemukan ada beberapa transaksi yang nilai noise-nya beda cukup jauh dari payment\_value. 

Dengan ambang batas selisih > 150, saya menemukan 8 transaksi yang mencurigakan.



Dua transaksi yang paling menonjol adalah order\_id 109909 dan 107161, dengan selisih lebih dari 190. 

Nilai-nilai ini kemungkinan besar merupakan data palsu (decoy) yang sengaja dimasukkan, dan bisa menyesatkan model kalau tidak dibersihkan. 
Oleh karena itu, sebaiknya transaksi-transaksi ini dipisahkan atau ditandai sebelum lanjut ke tahap modeling.

