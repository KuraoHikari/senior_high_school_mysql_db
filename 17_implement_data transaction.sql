DELIMITER //
CREATE PROCEDURE InsertDataWithTransaction()
BEGIN
  START TRANSACTION;
  BEGIN
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
  END;
  COMMIT;
END //
DELIMITER ;

CALL InsertDataWithTransaction();