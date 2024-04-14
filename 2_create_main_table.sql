CREATE TABLE siswa (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);

CREATE TABLE guru (
    guru_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    mata_pelajaran_id INT,
    INDEX nama_idx USING HASH (nama)
);

CREATE TABLE mata_pelajaran (
    mata_pelajaran_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    INDEX nama_idx USING BTREE (nama)
);

CREATE TABLE absen (
    absen_id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    siswa_id INT,
    status ENUM('Hadir', 'Izin', 'Sakit', 'Alpha')
);

CREATE INDEX status_idx ON absen(status);

CREATE TABLE spp (
    spp_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    bulan INT,
    tahun INT,
    jumlah DECIMAL(10, 2),
    status ENUM('Lunas', 'Belum Lunas'),
    INDEX status_idx (status)
);

CREATE TABLE tugas (
    tugas_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    mata_pelajaran_id INT,
    detail TEXT,
    deadline DATE,
    FULLTEXT(detail)
);

CREATE TABLE kelas (
    kelas_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(100),
    tingkat INT,
    INDEX nama_kelas_idx (nama_kelas)
);

CREATE TABLE nilai_akhir_mata_pelajaran (
    nilai_akhir_mata_pelajaran_id INT AUTO_INCREMENT PRIMARY KEY,
    guru_id INT,
    siswa_id INT,
    mata_pelajaran_id INT,
    nilai_akhir INT,
   INDEX nilai_akhir_idx (nilai_akhir)
);

CREATE TABLE fact_pembayaran_spp (
    fact_pembayaran_spp_id INT AUTO_INCREMENT PRIMARY KEY,
    spp_id INT,
    siswa_id INT,
    kelas_id INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(kelas_id),
    FOREIGN KEY (spp_id) REFERENCES spp(spp_id)
);

CREATE TABLE fact_avg_nilai_akhir (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2),
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
) PARTITION BY RANGE (nilai_akhir)(
PARTITION PO VALUES LESS THAN (25),
PARTITION p1 VALUES LESS THAN (50), 
PARTITION P2 VALUES LESS THAN (75),
PARTITION P3 VALUES LESS THAN MAXVALUE
);

CREATE TABLE fact_absen_siswa (
    fact_absen_siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    total_absen_hadir INT,
    total_absen_tidak_hadir INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);