DELIMITER //

CREATE PROCEDURE AnalyzeTable(IN tableName VARCHAR(255))
BEGIN
    SET @s = CONCAT('ANALYZE TABLE ', tableName);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;
