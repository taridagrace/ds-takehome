\# Data Scientist Take-Home Test



Repository ini berisi solusi untuk tes Data Scientist, yang mencakup 3 bagian utama:  

(A) menganalisis transaksi e-commerce dengan SQL

(B) membuat \& menjelaskan model risiko kredit di Python

(C) memvalidasi model di R



\## Struktur Folder

\- data/

&nbsp; - e\_commerce\_transactions.csv

&nbsp; - credit\_scoring.csv

\- notebooks/

&nbsp; - B\_modeling.ipynb

\- analysis.sql → Jawaban SQL Analytics (Bagian A)

\- validation.R → Validasi model di R (Bagian C)

\- A\_findings.md → Insight deteksi anomali (Bagian A)

\- C\_summary.md → Ringkasan cut-off risiko default (Bagian C)

\- shap\_top10.png → Visualisasi SHAP top-10 fitur (Bagian B)

\- decision\_slide.pdf → 1-slide keputusan pinjaman IDR 5 juta

\- calibration\_curve.png → Hasil visualisasi kurva kalibrasi (Bagian C)

\- validasi.csv → Output prediksi \& aktual untuk validasi model di R

\- README.md → Petunjuk ringkas menjalankan proyek



\## Cara Menjalankan

\- SQL (Bagian A): Jalankan analysis.sql di MySQL / MySQL Workbench

\- Python (Bagian B): Buka notebooks/B\_modeling.ipynb di Jupyter Notebook

\- R (Bagian C): Jalankan validation.R di RStudio

&nbsp; - Pastikan validasi.csv ada di folder utama (root repo)



\## Tag Submission

Setelah semua bagian selesai, gunakan tag berikut untuk menandai versi final:



```bash

git tag -a submission -m "final"

git push origin submission

