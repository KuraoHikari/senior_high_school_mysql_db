# Database Creation Script

File `1_create_database.sql` berisi skrip SQL untuk membuat dan menggunakan database baru.

## Query Overview

```sql
CREATE DATABASE senior_high_school;
USE senior_high_school;
```

# Database Table Creation Script

File `2_create_main_table.sql` berisi skrip SQL untuk membuat tabel-tabel utama dalam database.

## Query Overview

### Tabel Siswa

```sql
CREATE TABLE siswa (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);
```

Tabel siswa berisi informasi tentang siswa. Setiap siswa memiliki siswa_id sebagai PRIMARY KEY, nama, alamat, tanggal_lahir, dan kelas_id sebagai KEY yang merujuk ke tabel kelas. Ada juga indeks pada kolom nama untuk mempercepat pencarian berdasarkan nama.

### Tabel Guru

```sql
CREATE TABLE guru (
    guru_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    mata_pelajaran_id INT,
    INDEX nama_idx USING HASH (nama)
);
```

Tabel guru berisi informasi tentang guru. Setiap guru memiliki guru_id sebagai PRIMARY KEY, nama, dan mata_pelajaran_id sebagai KEY yang merujuk ke tabel mata_pelajaran. Ada juga indeks hash pada kolom nama untuk mempercepat pencarian berdasarkan nama.

### Tabel Mata Pelajaran

```sql
CREATE TABLE mata_pelajaran (
    mata_pelajaran_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    INDEX nama_idx USING BTREE (nama)
);
```

Tabel mata_pelajaran berisi informasi tentang mata pelajaran. Setiap mata pelajaran memiliki mata_pelajaran_id sebagai PRIMARY KEY dan nama. Ada juga indeks B-tree pada kolom nama untuk mempercepat pencarian berdasarkan nama.

### Tabel Absen

```sql
CREATE TABLE absen (
    absen_id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    siswa_id INT,
    status ENUM('Hadir', 'Izin', 'Sakit', 'Alpha')
);

CREATE INDEX status_idx ON absen(status);
```

Tabel absen berisi informasi tentang absensi siswa. Setiap entri absensi memiliki absen_id sebagai PRIMARY KEY, tanggal, siswa_id sebagai KEY yang merujuk ke tabel siswa, dan status yang menunjukkan apakah siswa hadir, izin, sakit, atau alpha. Ada juga indeks pada kolom status untuk mempercepat pencarian berdasarkan status.

### Tabel SPP

```sql
CREATE TABLE spp (
    spp_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    bulan INT,
    tahun INT,
    jumlah DECIMAL(10, 2),
    status ENUM('Lunas', 'Belum Lunas'),
    INDEX status_idx (status)
);
```

Tabel spp berisi informasi tentang pembayaran SPP siswa. Setiap pembayaran memiliki spp_id sebagai PRIMARY KEY, siswa_id sebagai KEY yang merujuk ke tabel siswa, bulan, tahun, jumlah, dan status yang menunjukkan apakah SPP sudah lunas atau belum. Ada juga indeks pada kolom status untuk mempercepat pencarian berdasarkan status.

### Tabel Tugas

```sql
CREATE TABLE tugas (
    tugas_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    mata_pelajaran_id INT,
    detail TEXT,
    deadline DATE,
    FULLTEXT(detail)
);
```

Tabel tugas berisi informasi tentang tugas yang diberikan kepada siswa. Setiap tugas memiliki tugas_id sebagai PRIMARY KEY, siswa_id dan mata_pelajaran_id sebagai KEY yang merujuk ke tabel siswa dan mata_pelajaran masing-masing, detail, dan deadline. Ada juga indeks fulltext pada kolom detail untuk mempercepat pencarian berdasarkan detail tugas.

### Tabel Kelas

```sql
CREATE TABLE kelas (
    kelas_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(100),
    tingkat INT,
    INDEX nama_kelas_idx (nama_kelas)
);
```

Tabel kelas berisi informasi tentang kelas di sekolah. Setiap kelas memiliki kelas_id sebagai PRIMARY KEY, nama_kelas, dan tingkat. Ada juga indeks pada kolom nama_kelas untuk mempercepat pencarian berdasarkan nama kelas.

### Tabel Nilai Akhir Mata Pelajaran

```sql
CREATE TABLE nilai_akhir_mata_pelajaran (
    nilai_akhir_mata_pelajaran_id INT AUTO_INCREMENT PRIMARY KEY,
    guru_id INT,
    siswa_id INT,
    mata_pelajaran_id INT,
    nilai_akhir INT,
   INDEX nilai_akhir_idx (nilai_akhir)
);
```

Tabel nilai_akhir_mata_pelajaran berisi informasi tentang nilai akhir mata pelajaran siswa. Setiap nilai memiliki nilai_akhir_mata_pelajaran_id sebagai PRIMARY KEY, guru_id, siswa_id, dan mata_pelajaran_id sebagai KEY yang merujuk ke tabel guru, siswa, dan mata_pelajaran masing-masing, dan nilai_akhir. Ada juga indeks pada kolom nilai_akhir untuk mempercepat pencarian berdasarkan nilai akhir.

### Tabel Fact Pembayaran SPP

```sql
CREATE TABLE fact_pembayaran_spp (
    fact_pembayaran_spp_id INT AUTO_INCREMENT PRIMARY KEY,
    spp_id INT,
    siswa_id INT,
    kelas_id INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(kelas_id),
    FOREIGN KEY (spp_id) REFERENCES spp(spp_id)
);
```

Tabel fact_pembayaran_spp berisi informasi tentang fakta pembayaran SPP siswa. Setiap fakta memiliki fact_pembayaran_spp_id sebagai kunci utama, spp_id, siswa_id, dan kelas_id sebagai kunci asing yang merujuk ke tabel spp, siswa, dan kelas masing-masing.

### Tabel Fact Avg Nilai Akhir

```sql
CREATE TABLE fact_avg_nilai_akhir (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2),
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);
```

Tabel fact_avg_nilai_akhir berisi informasi tentang rata-rata nilai akhir siswa. Setiap entri memiliki fact_avg_nilai_akhir_id sebagai kunci utama, siswa_id sebagai kunci asing yang merujuk ke tabel siswa, dan nilai_akhir yang merupakan rata-rata nilai akhir siswa.

### Tabel Fact Absen Siswa

```sql
CREATE TABLE fact_absen_siswa (
    fact_absen_siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    total_absen_hadir INT,
    total_absen_tidak_hadir INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);
```

Tabel fact_absen_siswa berisi informasi tentang total absensi siswa. Setiap entri memiliki fact_absen_siswa_id sebagai kunci utama, siswa_id sebagai kunci asing yang merujuk ke tabel siswa, total_absen_hadir yang merupakan total kehadiran siswa, dan total_absen_tidak_hadir yang merupakan total ketidakhadiran siswa.
