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