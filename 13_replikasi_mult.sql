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

INSERT INTO db_slave.siswa (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
SELECT siswa_id, nama, alamat, tanggal_lahir, kelas_id
FROM senior_high_school.siswa
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nama = VALUES(nama),
alamat = VALUES(alamat),
tanggal_lahir = VALUES(tanggal_lahir),
kelas_id = VALUES(kelas_id);