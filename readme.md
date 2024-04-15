# Table of Contents

- [How to Run](#how-to-run)
- [Database Creation Script](#database-creation-script)
- [Database Table Creation Script](#database-table-creation-script) - [Tabel Siswa](#tabel-siswa) - [Tabel Guru](#tabel-guru) - [Tabel Mata Pelajaran](#tabel-mata-pelajaran) - [Tabel Absen](#tabel-absen) - [Tabel SPP](#tabel-spp) - [Tabel Tugas](#tabel-tugas) - [Tabel Kelas](#tabel-kelas) - [Tabel Nilai Akhir Mata Pelajaran](#tabel-nilai-akhir-mata-pelajaran) - [Tabel Fact Pembayaran SPP](#tabel-fact-pembayaran-spp) - [Tabel Fact Avg Nilai Akhir](#tabel-fact-avg-nilai-akhir) - [Tabel Fact Absen Siswa](#tabel-fact-absen-siswa) -[Database Procedures, Functions, Views, and Triggers](#database-procedures-functions-views-and-triggers) - [Trigger: after_siswa_insert](#trigger-after_siswa_insert) - [Procedure: AddNewSiswa](#procedure-addnewsiswa) - [Function: GetTotalStudents](#function-gettotalstudents) - [View: view_siswa_kelas](#view-view_siswa_kelas)
- [Database Seeder Script](#database-seeder-script)
  - [Query Overview Seeder](#query-overview-seeder)
    - [Mata Pelajaran](#mata-pelajaran)
    - [Kelas](#kelas)
    - [Guru](#guru)
    - [Siswa](#siswa)
- [Database Procedure Script Nilai Akhir](#database-procedure-script-nilai-akhir)
  - [Query Overview Procedure Nilai Akhir](#query-overview-procedure-nilai-akhir)
    - [Procedure: InsertRandomNilaiAkhirForAllStudents](#procedure-insertrandomnilaiakhirforallstudents)
    - [Procedure: CalculateAndInsertAvgNilaiAkhir](#procedure-calculateandinsertavgnilaiakhir)
- [Database Procedure for Fact Pembayaran SPP](#database-procedure-for-fact-pembayaran-spp)
  - [Query Overview](#query-overview-fact-pembayaran-spp)
    - [Procedure: InsertFactPembayaranSpp](#procedure-insertfactpembayaranspp)
- [Database Procedure For Absen](#database-procedure-for-absen)
  - [Query Overview Absen](#query-overview-absen)
    - [Procedure: InsertAbsensiByDate](#procedure-insertabsensibydate)
- [Database Procedure For Bulk Insert Absen](#database-procedure-for-bulk-insert-absen)
  - [Query Overview Bulk Insert Absen](#query-overview-bulk-insert-absen)
    - [Procedure: InsertAbsensiByDate](#procedure-insertabsensibydate)
- [Database Procedure Fact Absen Siswa](#database-procedure-fact-absen-siswa)
  - [Query Overview Absen Siswa](#query-overview-absen-siswa)
    - [Procedure: UpdateOrInsertFactAbsenSiswa](#procedure-updateorinsertfactabsensiswa)
- [Database Procedure For Execution Script](#database-procedure-for-execution-script)
  - [Query Overview Execution Script](#query-overview-execution-script)
- [Database Table Creation and Procedure For Perform Siswa](#database-table-creation-and-procedure-for-perform-siswa)
  - [Query Overview Creation and Procedure For Perform Siswa](#query-overview-creation-and-procedure-for-perform-siswa)
    - [Table: perform_siswa](#table-perform_siswa)
    - [Procedure: InsertIntoPerformSiswa](#procedure-insertintoperformsiswa)
    - [Procedure: InsertIntoPerformSiswa](#procedure-insertintoperformsiswa)
    - [View: view_complete_perform_siswa](#view-view_complete_perform_siswa)
- [Database Synchronization - 11_data_syncro.sql](#database-synchronization---11_data_syncrosql)
- [Centralized Replication - 12_replikasi_terpusat.sql](#centralized-replication---12_replikasi_terpusatsql)
  - [Tabel `siswa_replica`](#tabel-siswa_replica)
  - [Tabel `replikasi_siswa`](#tabel-replikasi_siswa)
  - [Sinkronisasi Data Awal Centralized Replication](#sinkronisasi-data-awal-centralized-replication)
- [Membuat Database `db_slave`](#membuat-database-dbslave)
  - [Membuat Tabel `siswa` di `db_slave`](#membuat-tabel-siswa-di-dbslave)
  - [Membuat Trigger `Replikasi_After_Insert`](#membuat-trigger-replikasi_after_insert)
  - [Sinkronisasi Data Awal Multi-Database Replication](#sinkronisasi-data-awal-multi-database-replication)
- [Centralized Sharding - 14_sharding_terpusat.sql](#centralized-sharding---14_sharding_terpusatsql)
  - [Membuat Tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low`](#membuat-tabel-fact_avg_nilai_akhir_high-dan-fact_avg_nilai_akhir_low)
  - [Membuat Trigger `sharding_after_insert`](#membuat-trigger-sharding_after_insert)
  - [Sinkronisasi Data Awal Centralized Sharding](#sinkronisasi-data-awal-centralized-sharding)
- [Multi-Database Sharding - 15_sharding_mult.sql](#multi-database-sharding---15_sharding_multsql)
  - [Membuat Tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low` di `db_slave`](#membuat-tabel-fact_avg_nilai_akhir_high-dan-fact_avg_nilai_akhir_low-di-dbslave)
  - [Membuat Trigger `sharding_after_insert_mult`](#membuat-trigger-sharding_after_insert_mult)
  - [Sinkronisasi Data Awal Multi-Database Sharding](#sinkronisasi-data-awal-multi-database-sharding)
- [Data Partitioning and Synchronization - 16_partitioning_data_sync.sql](#data-partitioning-and-synchronization---16_partitioning_data_syncsql)
  - [Membuat Tabel `fact_avg_nilai_akhir_sync` di `senior_high_school` dan `db_slave`](#membuat-tabel-fact_avg_nilai_akhir_sync-di-senior_high_school-dan-dbslave)
  - [Sinkronisasi Data Awal Data Partitioning and Synchronization](#sinkronisasi-data-awal-data-partitioning-and-synchronization)
  - [Query Data dari Partisi Tertentu](#query-data-dari-partisi-tertentu)
- [Tentang Penulis](#tentang-penulis)
  - [Kontak](#kontak)
  - [Lisensi](#lisensi)
  - [Kontribusi](#kontribusi)

## How to Run

1. Buka klien SQL Anda (misalnya, MySQL Workbench, phpMyAdmin, dsb.).
2. Salin dan tempelkan query ini ke klien SQL Anda.
3. Jalankan query.

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

# Database Procedures, Functions, Views, and Triggers

File `3_procedure_func_view_trigger.sql` berisi skrip SQL untuk membuat prosedur, fungsi, tampilan, dan pemicu dalam database.

## Query Overview

### Trigger: after_siswa_insert

```sql
DELIMITER $$

CREATE TRIGGER after_siswa_insert
AFTER INSERT ON siswa
FOR EACH ROW
BEGIN
    INSERT INTO spp (siswa_id,bulan,tahun, jumlah,status) VALUES (NEW.siswa_id, 6,2024,3000,'Belum Lunas');
END$$

DELIMITER ;
```

Trigger after_siswa_insert akan dijalankan setelah setiap insert pada tabel siswa. Trigger ini akan memasukkan entri baru ke tabel spp dengan siswa_id yang baru ditambahkan.

### Procedure: AddNewSiswa

```sql
DELIMITER $$

CREATE PROCEDURE AddNewSiswa(IN _nama VARCHAR(100), IN _alamat VARCHAR(255), IN _tanggal_lahir DATE, IN _kelas_id INT)
BEGIN
    INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES (_nama, _alamat, _tanggal_lahir, _kelas_id);
END$$

DELIMITER ;
```

Prosedur AddNewSiswa digunakan untuk menambahkan entri baru ke tabel siswa. Prosedur ini menerima empat parameter: \_nama, \_alamat, \_tanggal_lahir, dan \_kelas_id.

### Function: GetTotalStudents

```sql
DELIMITER $$

CREATE FUNCTION GetTotalStudents() RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM siswa;
    RETURN total;
END$$

DELIMITER ;
```

Fungsi GetTotalStudents digunakan untuk mendapatkan total siswa dalam database. Fungsi ini mengembalikan jumlah siswa.

### View: view_siswa_kelas

```sql
CREATE VIEW view_siswa_kelas AS
SELECT s.siswa_id, s.nama, k.nama_kelas
FROM siswa s
JOIN kelas k ON s.kelas_id = k.kelas_id;
```

View view_siswa_kelas digunakan untuk melihat siswa_id, nama, dan nama_kelas dari setiap siswa.

# Database Seeder Script

File `4_run_seeder.sql` berisi skrip SQL untuk mengisi tabel-tabel dalam database dengan data awal.

## Query Overview Seeder

Skrip ini mengisi tabel `mata_pelajaran`, `kelas`, `guru`, dan `siswa` dengan data awal.

### Mata Pelajaran

```sql
INSERT INTO mata_pelajaran (nama) VALUES ('Matematika');
INSERT INTO mata_pelajaran (nama) VALUES ('Bahasa Indonesia');
INSERT INTO mata_pelajaran (nama) VALUES ('Bahasa Inggris');
```

Ini memasukkan tiga mata pelajaran: Matematika, Bahasa Indonesia, dan Bahasa Inggris ke dalam tabel mata_pelajaran.

### Kelas

```sql
INSERT INTO kelas (nama_kelas, tingkat) VALUES ('X IPA 1', 10);
INSERT INTO kelas (nama_kelas, tingkat) VALUES ('X IPA 2', 10);
INSERT INTO kelas (nama_kelas, tingkat) VALUES ('X IPA 3', 10);
```

Ini memasukkan tiga kelas: X IPA 1, X IPA 2, dan X IPA 3 ke dalam tabel kelas.

### Guru

```sql
INSERT INTO guru (nama, mata_pelajaran_id) VALUES ('Budi Santoso', 1);
INSERT INTO guru (nama, mata_pelajaran_id) VALUES ('Anita Wijaya', 2);
INSERT INTO guru (nama, mata_pelajaran_id) VALUES ('Dewi Rahayu', 3);
```

Ini memasukkan tiga guru: Budi Santoso, Anita Wijaya, dan Dewi Rahayu ke dalam tabel guru.

### Siswa

```sql
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('John Doe', 'Jl. Merdeka No. 123', '2006-05-15', 1);
...
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ava Garcia', 'Jl. Imam Bonjol No. 666', '2007-09-12', 3);
```

Ini memasukkan beberapa siswa ke dalam tabel siswa.

# Database Procedure Script Nilai Akhir

File `5_procedure_for_nilai_akhir.sql` berisi dua prosedur SQL yang digunakan untuk mengotomatisasi proses penilaian di sebuah institusi pendidikan.

## Query Overview Procedure Nilai Akhir

### Procedure: InsertRandomNilaiAkhirForAllStudents

```sql
DELIMITER $$

CREATE PROCEDURE InsertRandomNilaiAkhirForAllStudents()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE student_id INT;
    DECLARE subject_id INT;
    DECLARE guru_id_to_use INT;
    DECLARE random_nilai_akhir INT;

    DECLARE cur1 CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE cur2 CURSOR FOR SELECT mata_pelajaran_id FROM mata_pelajaran;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;

    student_loop: LOOP
        FETCH cur1 INTO student_id;
        IF done THEN
            LEAVE student_loop;
        END IF;

        OPEN cur2;

        subject_loop: LOOP
            FETCH cur2 INTO subject_id;
            IF done THEN
                LEAVE subject_loop;
            END IF;

            -- Select guru_id based on the mata_pelajaran_id
            SELECT guru_id INTO guru_id_to_use
            FROM guru
            WHERE mata_pelajaran_id = subject_id
            LIMIT 1; -- Mengasumsikan setiap mata pelajaran memiliki minimal satu guru

            -- Generate a random nilai_akhir between 50 and 100
            SET random_nilai_akhir = FLOOR(50 + RAND() * 51);

            -- Insert data into nilai_akhir_mata_pelajaran table
            INSERT INTO nilai_akhir_mata_pelajaran(guru_id, siswa_id, mata_pelajaran_id, nilai_akhir)
            VALUES (guru_id_to_use, student_id, subject_id, random_nilai_akhir);

        END LOOP subject_loop;

        CLOSE cur2;
        SET done = FALSE;
    END LOOP student_loop;

    CLOSE cur1;
END$$

DELIMITER ;
```

Prosedur ini bertujuan untuk memasukkan nilai akhir acak untuk setiap siswa di setiap mata pelajaran yang ada. Nilai akhir yang dihasilkan akan berada dalam rentang 50 hingga 100.

Prosedur InsertRandomNilaiAkhirForAllStudents digunakan untuk mengisi tabel nilai_akhir_mata_pelajaran dengan nilai acak untuk setiap siswa dan setiap mata pelajaran. Prosedur ini melakukan hal berikut:

```
1. Membuka kursor untuk setiap siswa dan setiap mata pelajaran.
2. Untuk setiap siswa, prosedur ini membuka kursor untuk setiap mata pelajaran.
3. Untuk setiap mata pelajaran, prosedur ini memilih guru yang mengajar mata pelajaran tersebut.
4. Prosedur ini menghasilkan nilai acak antara 50 dan 100.
5. Prosedur ini memasukkan data ke dalam tabel nilai_akhir_mata_pelajaran dengan guru, siswa, mata pelajaran, dan nilai acak yang telah dipilih.
6. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa dan setiap mata pelajaran.
```

### Procedure: CalculateAndInsertAvgNilaiAkhir

```sql
DELIMITER $$

CREATE PROCEDURE CalculateAndInsertAvgNilaiAkhir()
BEGIN
    DECLARE finished INT DEFAULT FALSE;
    DECLARE student_id INT;
    DECLARE avg_nilai DECIMAL(10,2);
    DECLARE cursor_siswa CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN cursor_siswa;

    -- Loop through all students
    student_loop: LOOP
        FETCH cursor_siswa INTO student_id;
        IF finished THEN
            LEAVE student_loop;
        END IF;

        -- Calculate the average final score for the current student
        SELECT AVG(nilai_akhir) INTO avg_nilai
        FROM nilai_akhir_mata_pelajaran
        WHERE siswa_id = student_id;

        -- Insert the student_id and calculated average into fact_avg_nilai_akhir
        INSERT INTO fact_avg_nilai_akhir (siswa_id, nilai_akhir)
        VALUES (student_id, avg_nilai);

    END LOOP;

    CLOSE cursor_siswa;
END$$

DELIMITER ;
```

Prosedur CalculateAndInsertAvgNilaiAkhir digunakan untuk menghitung rata-rata nilai akhir untuk setiap siswa dan memasukkannya ke dalam tabel fact_avg_nilai_akhir. Prosedur ini melakukan hal berikut:

```

1. Membuka kursor untuk setiap siswa.
2. Untuk setiap siswa, prosedur ini menghitung rata-rata nilai akhir dari tabel nilai_akhir_mata_pelajaran.
3. Prosedur ini memasukkan siswa_id dan rata-rata nilai yang telah dihitung ke dalam tabel fact_avg_nilai_akhir.
4. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa.

```

# Database Procedure for Fact Pembayaran SPP

File `6_procedure_for_fact_pembayaran_spp.sql` berisi skrip SQL untuk membuat prosedur yang mengisi tabel `fact_pembayaran_spp` dengan data acak.

## Query Overview Fact Pembayaran Spp

### Procedure: InsertFactPembayaranSpp

```sql
DELIMITER $$

CREATE PROCEDURE InsertFactPembayaranSpp()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_siswa_id INT;
    DECLARE current_kelas_id INT;
    DECLARE current_spp_id INT;
    DECLARE cursor_siswa CURSOR FOR SELECT siswa_id, kelas_id FROM siswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cursor_siswa;

    read_loop: LOOP
        -- Fetch siswa_id and kelas_id from the cursor
        FETCH cursor_siswa INTO current_siswa_id, current_kelas_id;

        -- If no more rows, leave the read loop
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Get the spp_id for the current siswa_id
        SELECT spp_id INTO current_spp_id
        FROM spp
        WHERE siswa_id = current_siswa_id
        ORDER BY tahun DESC, bulan DESC LIMIT 1; -- Assumption: Get the latest spp_id if there are multiple

        -- Check if an spp_id was found
        IF current_spp_id IS NOT NULL THEN
            -- Insert the data into fact_pembayaran_spp
            INSERT INTO fact_pembayaran_spp (spp_id, siswa_id, kelas_id)
            VALUES (current_spp_id, current_siswa_id, current_kelas_id);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE cursor_siswa;
END$$

DELIMITER ;
```

Prosedur InsertFactPembayaranSpp digunakan untuk mengisi tabel fact_pembayaran_spp dengan data acak. Prosedur ini melakukan hal berikut:

```
1. Membuka kursor untuk setiap siswa.
2. Untuk setiap siswa, prosedur ini memilih entri spp yang berkaitan dengan siswa tersebut.
3. Prosedur ini menghasilkan status pembayaran acak (dibayar atau belum dibayar).
4. Prosedur ini memasukkan data ke dalam tabel fact_pembayaran_spp dengan spp_id dan status pembayaran yang telah dipilih.
5. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa.
```

# Database Procedure For Absen

File `7_procedure_for_absen.sql` berisi skrip SQL untuk membuat prosedur yang mengisi tabel `absen` dengan data acak.

## Query Overview Absen

### Procedure: InsertAbsensiByDate

```sql
DELIMITER $$

CREATE PROCEDURE InsertAbsensiByDate(IN _tanggal DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE _siswa_id INT;
    DECLARE _status ENUM('Hadir', 'Izin', 'Sakit', 'Alpha');
    DECLARE rand_status INT;

    DECLARE siswa_cursor CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN siswa_cursor;

    insert_loop: LOOP
        FETCH siswa_cursor INTO _siswa_id;
        IF done THEN
            LEAVE insert_loop;
        END IF;

        -- Generate a random number between 1 and 4 for random status
        SET rand_status = FLOOR(1 + RAND() * 4);

        -- Determine the status based on the random number
        CASE
            WHEN rand_status = 1 THEN SET _status = 'Hadir';
            WHEN rand_status = 2 THEN SET _status = 'Izin';
            WHEN rand_status = 3 THEN SET _status = 'Sakit';
            ELSE SET _status = 'Alpha';
        END CASE;

        -- Insert the attendance record for the student with the random status
        INSERT INTO absen (tanggal, siswa_id, status) VALUES (_tanggal, _siswa_id, _status);
    END LOOP;

    CLOSE siswa_cursor;
END$$

DELIMITER ;
```

Prosedur InsertAbsensiByDate digunakan untuk mengisi tabel absen dengan data acak berdasarkan tanggal yang diberikan. Prosedur ini melakukan hal berikut:

```
1. Membuka kursor untuk setiap siswa.
2. Untuk setiap siswa, prosedur ini menghasilkan status kehadiran acak (Hadir, Izin, Sakit, Alpha).
3. Prosedur ini memasukkan data ke dalam tabel absen dengan tanggal, siswa_id, dan status kehadiran yang telah dipilih.
4. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa.
```

# Database Procedure For Bulk Insert Absen

File `7_procedure_for_absen.sql` berisi skrip SQL untuk membuat prosedur yang mengisi tabel `absen` dengan data acak berdasarkan tanggal yang diberikan.

## Query Overview Bulk Insert Absen

### Procedure: InsertAbsensiByDate

```sql
DELIMITER $$

CREATE PROCEDURE InsertAbsensiByRange()
BEGIN
    DECLARE tanggal_mulai DATE;
    DECLARE tanggal_selesai DATE;

    SET tanggal_mulai = '2023-04-01';
    SET tanggal_selesai = '2023-04-10';

    WHILE tanggal_mulai <= tanggal_selesai DO
        CALL InsertAbsensiByDate(tanggal_mulai);
        SET tanggal_mulai = DATE_ADD(tanggal_mulai, INTERVAL 1 DAY);
    END WHILE;
END$$

DELIMITER ;
```

Prosedur InsertAbsensiByDate digunakan untuk mengisi tabel absen dengan data acak berdasarkan tanggal yang diberikan. Prosedur ini melakukan hal berikut:

```
1. Membuka kursor untuk setiap siswa.
2. Untuk setiap siswa, prosedur ini menghasilkan status kehadiran acak (Hadir, Izin, Sakit, Alpha).
3. Prosedur ini memasukkan data ke dalam tabel absen dengan tanggal, siswa_id, dan status kehadiran yang telah dipilih.
4. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa.
```

# Database Procedure Fact Absen Siswa

File `8_procedure_for_fact_absen.sql` berisi skrip SQL untuk membuat prosedur yang menghitung dan memperbarui atau memasukkan jumlah absen 'Hadir' dan absen 'Tidak Hadir' untuk setiap siswa.

## Query Overview Absen Siswa

### Procedure: UpdateOrInsertFactAbsenSiswa

```sql
DELIMITER $$

CREATE PROCEDURE UpdateFactAbsenSiswa()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_siswa_id INT;
    DECLARE hadir_count INT;
    DECLARE tidak_hadir_count INT;

    -- Cursor to iterate over each student
    DECLARE siswa_cursor CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN siswa_cursor;

    -- Loop through all students
    read_loop: LOOP
        FETCH siswa_cursor INTO current_siswa_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Count the number of 'Hadir' statuses for the current student
        SELECT COUNT(*) INTO hadir_count
        FROM absen
        WHERE siswa_id = current_siswa_id AND status = 'Hadir';

        -- Count the number of statuses other than 'Hadir' for the current student
        SELECT COUNT(*) INTO tidak_hadir_count
        FROM absen
        WHERE siswa_id = current_siswa_id AND status <> 'Hadir';

        -- Check if the current student already has a record in the fact_absen_siswa table
        IF EXISTS(SELECT 1 FROM fact_absen_siswa WHERE siswa_id = current_siswa_id) THEN
            -- Update if exists
            UPDATE fact_absen_siswa
            SET total_absen_hadir = hadir_count,
                total_absen_tidak_hadir = tidak_hadir_count
            WHERE siswa_id = current_siswa_id;
        ELSE
            -- Insert if not exists
            INSERT INTO fact_absen_siswa (siswa_id, total_absen_hadir, total_absen_tidak_hadir)
            VALUES (current_siswa_id, hadir_count, tidak_hadir_count);
        END IF;

    END LOOP;

    CLOSE siswa_cursor;
END$$

DELIMITER ;
```

Prosedur UpdateOrInsertFactAbsenSiswa digunakan untuk menghitung jumlah absen 'Hadir' dan 'Tidak Hadir' untuk setiap siswa dan memperbarui atau memasukkan data tersebut ke dalam tabel fact_absen_siswa. Prosedur ini melakukan hal berikut:

```
1. Membuka kursor untuk setiap siswa.
2. Untuk setiap siswa, prosedur ini menghitung jumlah absen 'Hadir' dan 'Tidak Hadir' dari tabel absen.
3. Jika siswa tersebut sudah memiliki catatan di tabel fact_absen_siswa, prosedur ini memperbarui catatan tersebut dengan jumlah absen 'Hadir' dan 'Tidak Hadir' yang baru.
4. Jika siswa tersebut belum memiliki catatan di tabel fact_absen_siswa, prosedur ini memasukkan siswa_id, jumlah absen 'Hadir', dan jumlah absen 'Tidak Hadir' ke dalam tabel tersebut.
5. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa.
```

# Database Procedure For Execution Script

File `9_run_all_procedure.sql` berisi skrip SQL untuk menjalankan semua prosedur yang telah dibuat sebelumnya.

## Query Overview Execution Script

```sql
CALL InsertRandomNilaiAkhirForAllStudents();

CALL CalculateAndInsertAvgNilaiAkhir();

CALL InsertFactPembayaranSpp();

CALL InsertAbsensiByRange();

CALL UpdateFactAbsenSiswa();
```

```
Skrip ini menjalankan prosedur-prosedur berikut:

1. `InsertRandomNilaiAkhirForAllStudents`: Mengisi tabel `nilai_akhir_mata_pelajaran` dengan nilai acak untuk setiap siswa dan setiap mata pelajaran.

2. `CalculateAndInsertAvgNilaiAkhir`: Menghitung rata-rata nilai akhir untuk setiap siswa dan memasukkannya ke dalam tabel `fact_avg_nilai_akhir`.

3. `InsertFactPembayaranSpp`: Mengisi tabel `fact_pembayaran_spp` dengan data acak.

4. `InsertAbsensiByRange`: Mengisi tabel `absen` dengan data acak berdasarkan rentang tanggal yang diberikan.

5. `UpdateFactAbsenSiswa`: Menghitung jumlah absen 'Hadir' dan 'Tidak Hadir' untuk setiap siswa dan memperbarui atau memasukkan data tersebut ke dalam tabel `fact_absen_siswa`.
```

# Database Table Creation and Procedure For Perform Siswa

File `10_snowflake_table_perform_siswa.sql` berisi skrip SQL untuk membuat tabel `perform_siswa` dan prosedur `InsertIntoPerformSiswa`.

## Query Overview Creation and Procedure For Perform Siswa

### Table: perform_siswa

```sql
CREATE TABLE perform_siswa (
    perform_siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    fact_pembayaran_spp_id INT,
    fact_absen_siswa_id INT,
    fact_avg_nilai_akhir_id INT,
    siswa_id INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id),
    FOREIGN KEY (fact_pembayaran_spp_id) REFERENCES fact_pembayaran_spp(fact_pembayaran_spp_id),
    FOREIGN KEY (fact_absen_siswa_id) REFERENCES fact_absen_siswa(fact_absen_siswa_id),
    FOREIGN KEY (fact_avg_nilai_akhir_id) REFERENCES fact_avg_nilai_akhir(fact_avg_nilai_akhir_id)
);
```

Tabel perform_siswa dibuat untuk menyimpan performa siswa. Tabel ini memiliki kolom berikut:

```
- perform_siswa_id: ID unik untuk setiap baris dalam tabel.
- fact_pembayaran_spp_id: ID dari tabel fact_pembayaran_spp yang berisi informasi tentang pembayaran SPP siswa.
- fact_absen_siswa_id: ID dari tabel fact_absen_siswa yang berisi informasi tentang absensi siswa.
- fact_avg_nilai_akhir_id: ID dari tabel fact_avg_nilai_akhir yang berisi informasi tentang nilai akhir rata-rata siswa.
- siswa_id: ID siswa.
```

### Procedure: InsertIntoPerformSiswa

```sql
DELIMITER $$

CREATE PROCEDURE InsertIntoPerformSiswa()
BEGIN
    DECLARE finished INT DEFAULT FALSE;
    DECLARE current_siswa_id INT;
    DECLARE current_fact_pembayaran_spp_id INT;
    DECLARE current_fact_absen_siswa_id INT;
    DECLARE current_fact_avg_nilai_akhir_id INT;

    DECLARE siswa_cursor CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN siswa_cursor;

    -- Looping through each student in the siswa table
    student_loop: LOOP
        FETCH siswa_cursor INTO current_siswa_id;
        IF finished THEN
            LEAVE student_loop;
        END IF;

        -- Finding the corresponding fact_pembayaran_spp_id
        SELECT fact_pembayaran_spp_id INTO current_fact_pembayaran_spp_id
        FROM fact_pembayaran_spp
        WHERE siswa_id = current_siswa_id
        ORDER BY fact_pembayaran_spp_id DESC
        LIMIT 1;

        -- Finding the corresponding fact_absen_siswa_id
        SELECT fact_absen_siswa_id INTO current_fact_absen_siswa_id
        FROM fact_absen_siswa
        WHERE siswa_id = current_siswa_id
        ORDER BY fact_absen_siswa_id DESC
        LIMIT 1;

        -- Finding the corresponding fact_avg_nilai_akhir_id
        SELECT fact_avg_nilai_akhir_id INTO current_fact_avg_nilai_akhir_id
        FROM fact_avg_nilai_akhir
        WHERE siswa_id = current_siswa_id
        ORDER BY fact_avg_nilai_akhir_id DESC
        LIMIT 1;

        -- Inserting data into the perform_siswa table
        INSERT INTO perform_siswa (siswa_id, fact_pembayaran_spp_id, fact_absen_siswa_id, fact_avg_nilai_akhir_id)
        VALUES (current_siswa_id, current_fact_pembayaran_spp_id, current_fact_absen_siswa_id, current_fact_avg_nilai_akhir_id);

    END LOOP;

    CLOSE siswa_cursor;
END$$

DELIMITER ;

CALL InsertIntoPerformSiswa();
```

Prosedur InsertIntoPerformSiswa digunakan untuk memasukkan data ke dalam tabel perform_siswa. Prosedur ini melakukan hal berikut:

```
1. Membuka kursor untuk setiap siswa.
2. Untuk setiap siswa, prosedur ini mencari fact_pembayaran_spp_id, fact_absen_siswa_id, dan fact_avg_nilai_akhir_id yang berkaitan dengan siswa tersebut.
3. Prosedur ini memasukkan siswa_id, fact_pembayaran_spp_id, fact_absen_siswa_id, dan fact_avg_nilai_akhir_id ke dalam tabel perform_siswa.
4. Prosedur ini mengulangi langkah-langkah ini untuk setiap siswa.
```

### View: view_complete_perform_siswa

```sql
CREATE VIEW view_complete_perform_siswa AS
SELECT
    s.nama AS nama_siswa,
    k.nama_kelas AS nama_kelas_siswa,
    spp.jumlah AS spp_siswa,
    spp.status AS status_spp,
    avg_nilai.nilai_akhir AS avg_nilai_akhir,
    absen.total_absen_hadir AS total_absen_hadir_siswa,
    absen.total_absen_tidak_hadir AS total_absen_tidak_hadir_siswa
FROM
    perform_siswa ps
INNER JOIN
    siswa s ON ps.siswa_id = s.siswa_id
INNER JOIN
    kelas k ON s.kelas_id = k.kelas_id
INNER JOIN
    fact_pembayaran_spp f_spp ON ps.fact_pembayaran_spp_id = f_spp.fact_pembayaran_spp_id
INNER JOIN
    spp ON f_spp.spp_id = spp.spp_id
INNER JOIN
    fact_avg_nilai_akhir avg_nilai ON ps.fact_avg_nilai_akhir_id = avg_nilai.fact_avg_nilai_akhir_id
INNER JOIN
    fact_absen_siswa absen ON ps.fact_absen_siswa_id = absen.fact_absen_siswa_id;
```

View view_complete_perform_siswa dibuat untuk menyediakan tampilan lengkap tentang performa siswa. View ini menggabungkan data dari tabel perform_siswa, siswa, kelas, fact_pembayaran_spp, spp, fact_avg_nilai_akhir, dan fact_absen_siswa.

View ini menampilkan kolom berikut:

```
- nama_siswa: Nama siswa.
- nama_kelas_siswa: Nama kelas siswa.
- spp_siswa: Jumlah SPP siswa.
- status_spp: Status pembayaran SPP siswa.
- avg_nilai_akhir: Nilai akhir rata-rata siswa.
- total_absen_hadir_siswa: Total absen 'Hadir' siswa.
- total_absen_tidak_hadir_siswa: Total absen 'Tidak Hadir' siswa.
```

# Database Synchronization - 11_data_syncro.sql

File `11_data_syncro.sql` ini hanya berisi percobaan dan catatan, sehingga tidak ada yang spesial di dalamnya. File ini menciptakan tabel `siswa_replica` dan trigger `replikasi_siswa` yang bertujuan untuk mereplikasi data siswa setiap kali ada penambahan data baru ke tabel `siswa`. Namun, untuk tujuan praktis dan penggunaan sehari-hari, file ini dapat diabaikan.

## Langkah Selanjutnya

Silakan lanjutkan ke file `12_replikasi_terpusat.sql` untuk melihat implementasi replikasi data yang lebih terpusat dan terorganisir.

# Centralized Replication - 12_replikasi_terpusat.sql

File `12_replikasi_terpusat.sql` ini berisi skrip SQL untuk membuat replikasi data yang lebih terpusat dan terorganisir.

### Tabel `siswa_replica`

Tabel ini adalah replika dari tabel `siswa`. Setiap kali ada penambahan data baru ke tabel `siswa`, data tersebut juga akan ditambahkan ke tabel `siswa_replica`.

```sql
CREATE TABLE siswa_replica (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);
```

### Tabel `replikasi_siswa`

Trigger ini dibuat untuk mereplikasi data siswa setiap kali ada penambahan data baru ke tabel `siswa`.

```sql
DELIMITER //
CREATE TRIGGER replikasi_siswa AFTER INSERT ON siswa
FOR EACH ROW
BEGIN
    INSERT INTO siswa_replica (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
    VALUES (NEW.siswa_id, NEW.nama, NEW.alamat, NEW.tanggal_lahir, NEW.kelas_id);
END //
DELIMITER ;
```

### Sinkronisasi Data Awal Centralized Replication

Untuk memastikan data di tabel `siswa_replica` sama dengan tabel `siswa`, kita melakukan sinkronisasi data awal dengan perintah berikut:

```sql
INSERT INTO siswa_replica (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
SELECT siswa_id, nama, alamat, tanggal_lahir, kelas_id
FROM siswa
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nama = VALUES(nama),
alamat = VALUES(alamat),
tanggal_lahir = VALUES(tanggal_lahir),
kelas_id = VALUES(kelas_id);
```

# Multi-Database Replication - 13_replikasi_mult.sql

File `13_replikasi_mult.sql` ini berisi skrip SQL untuk membuat replikasi data antara dua database: `senior_high_school` dan `db_slave`.

## Membuat Database `db_slave`

Database `db_slave` dibuat sebagai tempat untuk menyimpan data replika dari tabel `siswa` di database `senior_high_school`.

```sql
CREATE DATABASE db_slave;
```

### Membuat Tabel `siswa` di `db_slave`

Tabel `siswa` di `db_slave` memiliki struktur yang sama dengan tabel `siswa` di `senior_high_school`.

```sql
USE db_slave;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
CREATE TABLE siswa (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);
```

### Membuat Trigger `Replikasi_After_Insert`

Trigger ini dibuat di database `senior_high_school` untuk mereplikasi data siswa setiap kali ada penambahan data baru ke tabel `siswa`.

```sql
USE senior_high_school;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
DELIMITER //
CREATE TRIGGER Replikasi_After_Insert AFTER INSERT ON siswa FOR EACH ROW
BEGIN
    INSERT INTO db_slave.siswa (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
    VALUES (NEW.siswa_id, NEW.nama, NEW.alamat, NEW.tanggal_lahir, NEW.kelas_id);
END //
DELIMITER ;
```

### Sinkronisasi Data Awal Multi-Database Replication

Untuk memastikan data di tabel `siswa` di `db_slave` sama dengan tabel `siswa` di `senior_high_school`, kita melakukan sinkronisasi data awal dengan perintah berikut:

```sql
INSERT INTO db_slave.siswa (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
SELECT siswa_id, nama, alamat, tanggal_lahir, kelas_id
FROM senior_high_school.siswa
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nama = VALUES(nama),
alamat = VALUES(alamat),
tanggal_lahir = VALUES(tanggal_lahir),
kelas_id = VALUES(kelas_id);
```

# Centralized Sharding - 14_sharding_terpusat.sql

File `14_sharding_terpusat.sql` ini berisi skrip SQL untuk membuat sharding data yang lebih terpusat dan terorganisir. Sharding adalah teknik membagi data ke dalam beberapa tabel untuk meningkatkan kinerja dan skalabilitas.

### Membuat Tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low`

Kita membuat dua tabel, `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low`, sebagai tempat untuk menyimpan data siswa yang di-shard berdasarkan nilai akhir mereka.

```sql
CREATE TABLE fact_avg_nilai_akhir_high (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2)
);

CREATE TABLE fact_avg_nilai_akhir_low (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2)
);
```

### Membuat Tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low`

Trigger ini dibuat di database `senior_high_school` untuk membagi data siswa ke `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low` setiap kali ada penambahan data baru ke tabel `fact_avg_nilai_akhir`.

```sql
DELIMITER //
CREATE TRIGGER sharding_after_insert AFTER INSERT ON fact_avg_nilai_akhir FOR EACH ROW
BEGIN
    IF NEW.nilai_akhir > 70 THEN
        INSERT INTO fact_avg_nilai_akhir_high (siswa_id, nilai_akhir) VALUES (NEW.siswa_id, NEW.nilai_akhir);
    ELSE
        INSERT INTO fact_avg_nilai_akhir_low (siswa_id, nilai_akhir) VALUES (NEW.siswa_id, NEW.nilai_akhir);
    END IF;
END //
DELIMITER ;
```

### Sinkronisasi Data Awal Centralized Sharding

Untuk memastikan data di tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low` sama dengan tabel `fact_avg_nilai_akhir`, kita melakukan sinkronisasi data awal dengan perintah berikut:

```sql
INSERT INTO fact_avg_nilai_akhir_high (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, nilai_akhir
FROM fact_avg_nilai_akhir
WHERE nilai_akhir > 70
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);

INSERT INTO fact_avg_nilai_akhir_low (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, nilai_akhir
FROM fact_avg_nilai_akhir
WHERE nilai_akhir < 71
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);
```

# Multi-Database Sharding - 15_sharding_mult.sql

File `15_sharding_mult.sql` ini berisi skrip SQL untuk membuat sharding data yang lebih terpusat dan terorganisir di beberapa database. Sharding adalah teknik membagi data ke dalam beberapa tabel untuk meningkatkan kinerja dan skalabilitas.

### Membuat Tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low` di `db_slave`

Kita membuat dua tabel, `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low`, di database `db_slave` sebagai tempat untuk menyimpan data siswa yang di-shard berdasarkan nilai akhir mereka.

```sql
USE db_slave;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
CREATE TABLE fact_avg_nilai_akhir_high (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2)
);

CREATE TABLE fact_avg_nilai_akhir_low (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2)
);
```

### Membuat Trigger `sharding_after_insert_mult`

Trigger ini dibuat di database `senior_high_school` untuk membagi data siswa ke `db_slave.fact_avg_nilai_akhir_high` dan `db_slave.fact_avg_nilai_akhir_low` setiap kali ada penambahan data baru ke tabel `fact_avg_nilai_akhir`.

```sql
USE senior_high_school;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
DELIMITER //
CREATE TRIGGER sharding_after_insert_mult AFTER INSERT ON fact_avg_nilai_akhir FOR EACH ROW
BEGIN
    IF NEW.nilai_akhir > 70 THEN
        INSERT INTO db_slave.fact_avg_nilai_akhir_high (siswa_id, nilai_akhir) VALUES (NEW.siswa_id, NEW.nilai_akhir);
    ELSE
        INSERT INTO db_slave.fact_avg_nilai_akhir_low (siswa_id, nilai_akhir) VALUES (NEW.siswa_id, NEW.nilai_akhir);
    END IF;
END //
DELIMITER ;
```

### Sinkronisasi Data Awal Multi-Database Sharding

Untuk memastikan data di tabel `fact_avg_nilai_akhir_high` dan `fact_avg_nilai_akhir_low` di `db_slave` sama dengan tabel `fact_avg_nilai_akhir` di `senior_high_school`, kita melakukan sinkronisasi data awal dengan perintah berikut:

```sql
INSERT INTO db_slave.fact_avg_nilai_akhir_high (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, nilai_akhir
FROM senior_high_school.fact_avg_nilai_akhir
WHERE nilai_akhir > 70
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);

INSERT INTO db_slave.fact_avg_nilai_akhir_low (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, nilai_akhir
FROM senior_high_school.fact_avg_nilai_akhir
WHERE nilai_akhir < 71
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);
```

# Data Partitioning and Synchronization - 16_partitioning_data_sync.sql

File `16_partitioning_data_sync.sql` ini berisi skrip SQL untuk melakukan partisi data dan sinkronisasi data antara dua database. Partisi data adalah teknik membagi data ke dalam beberapa bagian untuk meningkatkan kinerja dan skalabilitas.

### Membuat Tabel `fact_avg_nilai_akhir_sync` di `senior_high_school` dan `db_slave`

Kita membuat tabel `fact_avg_nilai_akhir_sync` di kedua database. Tabel ini akan dipartisi berdasarkan nilai akhir siswa.

```sql
USE senior_high_school;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
CREATE TABLE fact_avg_nilai_akhir_sync (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT,
    siswa_id INT,
    nilai_akhir INT,
    PRIMARY KEY (fact_avg_nilai_akhir_id,nilai_akhir)
)PARTITION BY RANGE (nilai_akhir)(
PARTITION PO VALUES LESS THAN (25),
PARTITION p1 VALUES LESS THAN (50),
PARTITION P2 VALUES LESS THAN (75),
PARTITION P3 VALUES LESS THAN MAXVALUE
);

USE db_slave;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
CREATE TABLE fact_avg_nilai_akhir_sync (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT,
    siswa_id INT,
    nilai_akhir INT,
    PRIMARY KEY (fact_avg_nilai_akhir_id,nilai_akhir)
)PARTITION BY RANGE (nilai_akhir)(
PARTITION PO VALUES LESS THAN (25),
PARTITION p1 VALUES LESS THAN (50),
PARTITION P2 VALUES LESS THAN (75),
PARTITION P3 VALUES LESS THAN MAXVALUE
);
```

### Sinkronisasi Data Awal Data Partitioning and Synchronization

Untuk memastikan data di tabel `fact_avg_nilai_akhir_sync` di kedua database sama dengan tabel `fact_avg_nilai_akhir` di `senior_high_school`, kita melakukan sinkronisasi data awal dengan perintah berikut:

```sql
USE senior_high_school;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
INSERT INTO fact_avg_nilai_akhir_sync (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, CAST(nilai_akhir AS SIGNED) AS nilai_akhir
FROM fact_avg_nilai_akhir
WHERE nilai_akhir > 10
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);

USE senior_high_school;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
INSERT INTO db_slave.fact_avg_nilai_akhir_sync (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, CAST(nilai_akhir AS SIGNED) AS nilai_akhir
FROM senior_high_school.fact_avg_nilai_akhir
WHERE nilai_akhir > 10
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);
```

### Query Data dari Partisi Tertentu

Kita dapat melakukan query data dari partisi tertentu dengan perintah berikut:

```sql
USE senior_high_school;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
SELECT * FROM fact_avg_nilai_akhir_sync PARTITION (p2);

USE db_slave;
-- di phpmyadmin harus di arahin dahulu cursor routenya ke db ini
SELECT * FROM fact_avg_nilai_akhir_sync PARTITION (p2);
```

# Tentang Penulis

Nama saya adalah Kurao Hikari, seorang pengembang perangkat lunak dengan pengalaman dalam berbagai teknologi dan bahasa pemrograman. Saya memiliki minat khusus dalam pengembangan web, basis data, dan teknologi cloud.

Saya telah bekerja pada berbagai proyek, mulai dari aplikasi web skala kecil hingga sistem enterprise yang kompleks. Saya selalu berusaha untuk belajar dan mengembangkan keterampilan saya, dan saya sangat bersemangat tentang berbagi pengetahuan saya dengan komunitas.

## Kontak

Jika Anda memiliki pertanyaan atau ingin berdiskusi tentang proyek atau kode ini, jangan ragu untuk menghubungi saya:

- Email: kuraoindra@gmail.com / dewaindra705@gmail.com
- GitHub: KuraoHikari

## Lisensi

Proyek ini dilisensikan di bawah [Lisensi MIT](LICENSE).

## Kontribusi

Kontribusi selalu diterima! Jika Anda memiliki saran, masalah, atau pertanyaan, silakan buat issue atau pull request.

Terima kasih telah mengunjungi repositori ini!
