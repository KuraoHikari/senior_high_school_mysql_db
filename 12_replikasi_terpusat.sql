USE senior_high_school;
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

INSERT INTO siswa_replica (siswa_id, nama, alamat, tanggal_lahir, kelas_id)
SELECT siswa_id, nama, alamat, tanggal_lahir, kelas_id
FROM siswa
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nama = VALUES(nama),
alamat = VALUES(alamat),
tanggal_lahir = VALUES(tanggal_lahir),
kelas_id = VALUES(kelas_id);