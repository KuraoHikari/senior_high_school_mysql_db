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