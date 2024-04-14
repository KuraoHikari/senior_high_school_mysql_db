CREATE TABLE siswa_replica (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);

DELIMITER //
CREATE TRIGGER replikasi_siswa AFTER INSERT ON siswa
FOR EACH ROW
BEGIN
    INSERT INTO siswa_replica (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
    VALUES (NEW.siswa_id, NEW.nama, NEW.alamat, NEW.tanggal_lahir, NEW.kelas_id);
END //
DELIMITER ;

INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('John Doe', 'Jl. Merdeka No. 123', '2006-05-15', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Jane Doe', 'Jl. Pahlawan No. 456', '2005-09-20', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Michael Smith', 'Jl. Sudirman No. 789', '2007-03-10', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Emma Johnson', 'Jl. Gatot Subroto No. 321', '2006-12-28', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('William Wilson', 'Jl. Diponegoro No. 555', '2005-08-03', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Sophia Brown', 'Jl. Asia Afrika No. 777', '2007-01-18', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Daniel Lee', 'Jl. Hayam Wuruk No. 999', '2006-07-22', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Olivia Taylor', 'Jl. Juanda No. 111', '2005-11-09', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('James Martinez', 'Jl. Teuku Umar No. 222', '2007-04-30', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Amelia White', 'Jl. Raden Saleh No. 333', '2006-02-14', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ethan Anderson', 'Jl. Hang Tuah No. 444', '2005-06-25', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ava Garcia', 'Jl. Imam Bonjol No. 666', '2007-09-12', 3);

CREATE DATABASE db_slave;
USE db_slave;
CREATE TABLE siswa (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);


USE senior_high_school;
DELIMITER //
CREATE TRIGGER Replikasi_After_Insert AFTER INSERT ON siswa FOR EACH ROW
BEGIN
    INSERT INTO db_slave.siswa (siswa_id, nama, alamat, tanggal_lahir, kelas_id) 
    VALUES (NEW.siswa_id, NEW.nama, NEW.alamat, NEW.tanggal_lahir, NEW.kelas_id);
END //
DELIMITER ;

INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('John Doe', 'Jl. Merdeka No. 123', '2006-05-15', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Jane Doe', 'Jl. Pahlawan No. 456', '2005-09-20', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Michael Smith', 'Jl. Sudirman No. 789', '2007-03-10', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Emma Johnson', 'Jl. Gatot Subroto No. 321', '2006-12-28', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('William Wilson', 'Jl. Diponegoro No. 555', '2005-08-03', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Sophia Brown', 'Jl. Asia Afrika No. 777', '2007-01-18', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Daniel Lee', 'Jl. Hayam Wuruk No. 999', '2006-07-22', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Olivia Taylor', 'Jl. Juanda No. 111', '2005-11-09', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('James Martinez', 'Jl. Teuku Umar No. 222', '2007-04-30', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Amelia White', 'Jl. Raden Saleh No. 333', '2006-02-14', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ethan Anderson', 'Jl. Hang Tuah No. 444', '2005-06-25', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ava Garcia', 'Jl. Imam Bonjol No. 666', '2007-09-12', 3);

CREATE TABLE fact_avg_nilai_akhir_high (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2),
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);


CREATE TABLE fact_avg_nilai_akhir_low (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2),
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);

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

INSERT INTO fact_avg_nilai_akhir (siswa_id, nilai_akhir) VALUES (1, 75.50);
INSERT INTO fact_avg_nilai_akhir (siswa_id, nilai_akhir) VALUES (2, 65.00);

DELIMITER //
CREATE TRIGGER sharding_mult_after_insert
AFTER INSERT ON fact_avg_nilai_akhir FOR EACH ROW
BEGIN
    IF NEW.nilai_akhir > 70 THEN
        INSERT INTO db_slave.fact_avg_nilai_akhir (siswa_id, nilai_akhir) VALUES (NEW.siswa_id, NEW.nilai_akhir);
    END IF;
END //
DELIMITER ;

INSERT INTO fact_avg_nilai_akhir (siswa_id, nilai_akhir) VALUES (1, 80.00);
INSERT INTO fact_avg_nilai_akhir (siswa_id, nilai_akhir) VALUES (2, 60.00);

-- CREATE TABLE fact_avg_nilai_akhir (
--     fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
--     siswa_id INT,
--     nilai_akhir DECIMAL(10, 2),
--     FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
-- ) PARTITION BY RANGE (nilai_akhir)(
-- PARTITION PO VALUES LESS THAN (25),
-- PARTITION p1 VALUES LESS THAN (50), 
-- PARTITION P2 VALUES LESS THAN (75),
-- PARTITION P3 VALUES LESS THAN MAXVALUE
-- );
-- mending ulang dari awal :3 aokwowokw ga expext ada ginian aowkowkokwokwok

SELECT * FROM fact_avg_nilai_akhir PARTITION (p2);

CREATE TABLE fact_avg_nilai_akhir_sync (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2),
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);

INSERT INTO fact_avg_nilai_akhir_sync (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, nilai_akhir
FROM fact_avg_nilai_akhir
WHERE nilai_akhir > 70
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);


USE db_slave;

CREATE TABLE fact_avg_nilai_akhir_sync (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2)
);

INSERT INTO db_slave.fact_avg_nilai_akhir_sync (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, nilai_akhir
FROM senior_high_school.fact_avg_nilai_akhir
WHERE nilai_akhir > 70
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);