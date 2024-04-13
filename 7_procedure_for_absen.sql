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