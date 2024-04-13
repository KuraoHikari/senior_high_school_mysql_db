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