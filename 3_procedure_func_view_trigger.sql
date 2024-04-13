
DELIMITER $$

CREATE TRIGGER after_siswa_insert
AFTER INSERT ON siswa
FOR EACH ROW
BEGIN
    INSERT INTO spp (siswa_id,bulan,tahun, jumlah,status) VALUES (NEW.siswa_id, 6,2024,3000,'Belum Lunas');
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE AddNewSiswa(IN _nama VARCHAR(100), IN _alamat VARCHAR(255), IN _tanggal_lahir DATE, IN _kelas_id INT)
BEGIN
    INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES (_nama, _alamat, _tanggal_lahir, _kelas_id);
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION GetTotalStudents() RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM siswa;
    RETURN total;
END$$

DELIMITER ;

CREATE VIEW view_siswa_kelas AS
SELECT s.siswa_id, s.nama, k.nama_kelas
FROM siswa s
JOIN kelas k ON s.kelas_id = k.kelas_id;