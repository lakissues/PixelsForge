USE pixelsforge;

DELIMITER //
CREATE FUNCTION calculate_editor_rating(p_editor_id INT) 
RETURNS DECIMAL(3,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(3,2);
    
    SELECT AVG(rating) INTO avg_rating
    FROM reviews r
    JOIN contracts c ON r.contract_id = c.contract_id
    WHERE c.editor_id = p_editor_id;
    
    IF avg_rating IS NULL THEN
        RETURN 0.0;
    ELSE
        RETURN avg_rating;
    END IF;
END //
DELIMITER ;