USE USE senior_high_school;
CREATE TABLE fact_avg_nilai_akhir_sync (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT,
    siswa_id INT,
    nilai_akhir INT,
    PRIMARY KEY (fact_avg_nilai_akhir_id,nilai_akhir)
)PARTITION BY RANGE (nilai_akhir)(
PARTITION PO VALUES LESS THAN (25),
PARTITION p1 VALUES LESS THAN (50), 
PARTITION P2 VALUES LESS THAN (75),
PARTITION P3 VALUES LESS THAN MAXVALUE
);



INSERT INTO fact_avg_nilai_akhir_sync (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, CAST(nilai_akhir AS SIGNED) AS nilai_akhir
FROM fact_avg_nilai_akhir
WHERE nilai_akhir > 10
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);

SELECT * FROM fact_avg_nilai_akhir_sync PARTITION (p2);


USE db_slave;

CREATE TABLE fact_avg_nilai_akhir_sync (
    fact_avg_nilai_akhir_id INT AUTO_INCREMENT,
    siswa_id INT,
    nilai_akhir INT,
    PRIMARY KEY (fact_avg_nilai_akhir_id,nilai_akhir)
)PARTITION BY RANGE (nilai_akhir)(
PARTITION PO VALUES LESS THAN (25),
PARTITION p1 VALUES LESS THAN (50), 
PARTITION P2 VALUES LESS THAN (75),
PARTITION P3 VALUES LESS THAN MAXVALUE
);

USE USE senior_high_school;

INSERT INTO db_slave.fact_avg_nilai_akhir_sync (fact_avg_nilai_akhir_id, siswa_id, nilai_akhir)
SELECT fact_avg_nilai_akhir_id, siswa_id, CAST(nilai_akhir AS SIGNED) AS nilai_akhir
FROM senior_high_school.fact_avg_nilai_akhir
WHERE nilai_akhir > 10
ON DUPLICATE KEY UPDATE
siswa_id = VALUES(siswa_id),
nilai_akhir = VALUES(nilai_akhir);

USE db_slave;
SELECT * FROM fact_avg_nilai_akhir_sync PARTITION (p2);