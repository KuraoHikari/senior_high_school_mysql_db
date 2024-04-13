CREATE DATABASE senior_high_school;
USE senior_high_school;

CREATE TABLE siswa (
    siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat VARCHAR(255),
    tanggal_lahir DATE,
    kelas_id INT,
    INDEX nama_idx (nama)
);

CREATE TABLE guru (
    guru_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    mata_pelajaran_id INT,
    INDEX nama_idx USING HASH (nama)
);

CREATE TABLE mata_pelajaran (
    mata_pelajaran_id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    INDEX nama_idx USING BTREE (nama)
);

CREATE TABLE absen (
    absen_id INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    siswa_id INT,
    status ENUM('Hadir', 'Izin', 'Sakit', 'Alpha')
);

CREATE INDEX status_idx ON absen(status);

CREATE TABLE spp (
    spp_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    bulan INT,
    tahun INT,
    jumlah DECIMAL(10, 2),
    status ENUM('Lunas', 'Belum Lunas'),
    INDEX status_idx (status)
);

CREATE TABLE tugas (
    tugas_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    mata_pelajaran_id INT,
    detail TEXT,
    deadline DATE,
    FULLTEXT(detail)
);

CREATE TABLE kelas (
    kelas_id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kelas VARCHAR(100),
    tingkat INT,
    INDEX nama_kelas_idx (nama_kelas)
);

CREATE TABLE nilai_akhir_mata_pelajaran (
    nilai_akhir_mata_pelajaran_id INT AUTO_INCREMENT PRIMARY KEY,
    guru_id INT,
    siswa_id INT,
    mata_pelajaran_id INT,
    nilai_akhir INT,
   INDEX nilai_akhir_idx (nilai_akhir)
);

CREATE TABLE fact_pembayaran_spp (
    fact_pembayaran_spp_id INT AUTO_INCREMENT PRIMARY KEY,
    spp_id INT,
    siswa_id INT,
    kelas_id INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(kelas_id),
    FOREIGN KEY (spp_id) REFERENCES spp(spp_id)
);

CREATE TABLE fact_avg_nilai_akhir (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    nilai_akhir DECIMAL(10, 2),
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);

CREATE TABLE fact_absen_siswa (
    fact_absen_siswa_id INT AUTO_INCREMENT PRIMARY KEY,
    siswa_id INT,
    total_absen_hadir INT,
    total_absen_tidak_hadir INT,
    FOREIGN KEY (siswa_id) REFERENCES siswa(siswa_id)
);

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


INSERT INTO mata_pelajaran (nama) VALUES ('Matematika');
INSERT INTO mata_pelajaran (nama) VALUES ('Bahasa Indonesia');
INSERT INTO mata_pelajaran (nama) VALUES ('Bahasa Inggris');

INSERT INTO kelas (nama_kelas, tingkat) VALUES ('X IPA 1', 10);
INSERT INTO kelas (nama_kelas, tingkat) VALUES ('X IPA 2', 10);
INSERT INTO kelas (nama_kelas, tingkat) VALUES ('X IPA 3', 10);

INSERT INTO guru (nama, mata_pelajaran_id) VALUES ('Budi Santoso', 1);
INSERT INTO guru (nama, mata_pelajaran_id) VALUES ('Anita Wijaya', 2);
INSERT INTO guru (nama, mata_pelajaran_id) VALUES ('Dewi Rahayu', 3);


INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('John Doe', 'Jl. Merdeka No. 123', '2006-05-15', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Jane Doe', 'Jl. Pahlawan No. 456', '2005-09-20', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Michael Smith', 'Jl. Sudirman No. 789', '2007-03-10', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Emma Johnson', 'Jl. Gatot Subroto No. 321', '2006-12-28', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('William Wilson', 'Jl. Diponegoro No. 555', '2005-08-03', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Sophia Brown', 'Jl. Asia Afrika No. 777', '2007-01-18', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Daniel Lee', 'Jl. Hayam Wuruk No. 999', '2006-07-22', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Olivia Taylor', 'Jl. Juanda No. 111', '2005-11-09', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('James Martinez', 'Jl. Teuku Umar No. 222', '2007-04-30', 3);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Amelia White', 'Jl. Raden Saleh No. 333', '2006-02-14', 1);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ethan Anderson', 'Jl. Hang Tuah No. 444', '2005-06-25', 2);
INSERT INTO siswa (nama, alamat, tanggal_lahir, kelas_id) VALUES ('Ava Garcia', 'Jl. Imam Bonjol No. 666', '2007-09-12', 3);


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

CALL InsertRandomNilaiAkhirForAllStudents();

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

CALL CalculateAndInsertAvgNilaiAkhir();

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

CALL InsertFactPembayaranSpp();

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

CALL InsertAbsensiByRange();

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

CALL UpdateFactAbsenSiswa();