USE db_slave;

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

USE senior_high_school;

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
