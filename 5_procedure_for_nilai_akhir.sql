DELIMITER $$

CREATE PROCEDURE InsertRandomNilaiAkhirForAllStudents()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE student_id INT;
    DECLARE subject_id INT;
    DECLARE guru_id_to_use INT;
    DECLARE random_nilai_akhir INT;

    DECLARE cur1 CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE cur2 CURSOR FOR SELECT mata_pelajaran_id FROM mata_pelajaran;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur1;

    student_loop: LOOP
        FETCH cur1 INTO student_id;
        IF done THEN
            LEAVE student_loop;
        END IF;

        OPEN cur2;

        subject_loop: LOOP
            FETCH cur2 INTO subject_id;
            IF done THEN
                LEAVE subject_loop;
            END IF;

            -- Select guru_id based on the mata_pelajaran_id
            SELECT guru_id INTO guru_id_to_use
            FROM guru
            WHERE mata_pelajaran_id = subject_id
            LIMIT 1; -- Mengasumsikan setiap mata pelajaran memiliki minimal satu guru

            -- Generate a random nilai_akhir between 50 and 100
            SET random_nilai_akhir = FLOOR(50 + RAND() * 51);

            -- Insert data into nilai_akhir_mata_pelajaran table
            INSERT INTO nilai_akhir_mata_pelajaran(guru_id, siswa_id, mata_pelajaran_id, nilai_akhir)
            VALUES (guru_id_to_use, student_id, subject_id, random_nilai_akhir);

        END LOOP subject_loop;

        CLOSE cur2;
        SET done = FALSE;
    END LOOP student_loop;

    CLOSE cur1;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE CalculateAndInsertAvgNilaiAkhir()
BEGIN
    DECLARE finished INT DEFAULT FALSE;
    DECLARE student_id INT;
    DECLARE avg_nilai DECIMAL(10,2);
    DECLARE cursor_siswa CURSOR FOR SELECT siswa_id FROM siswa;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;

    OPEN cursor_siswa;

    -- Loop through all students
    student_loop: LOOP
        FETCH cursor_siswa INTO student_id;
        IF finished THEN
            LEAVE student_loop;
        END IF;

        -- Calculate the average final score for the current student
        SELECT AVG(nilai_akhir) INTO avg_nilai
        FROM nilai_akhir_mata_pelajaran
        WHERE siswa_id = student_id;

        -- Insert the student_id and calculated average into fact_avg_nilai_akhir
        INSERT INTO fact_avg_nilai_akhir (siswa_id, nilai_akhir)
        VALUES (student_id, avg_nilai);

    END LOOP;

    CLOSE cursor_siswa;
END$$

DELIMITER ;