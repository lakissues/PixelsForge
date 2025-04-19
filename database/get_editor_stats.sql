USE pixelsforge;

DELIMITER //
CREATE FUNCTION get_editor_stats(p_editor_id INT, p_stat_type VARCHAR(20)) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE result INT;
    
    CASE p_stat_type
        WHEN 'completed_projects' THEN
            SELECT COUNT(*) INTO result
            FROM contracts
            WHERE editor_id = p_editor_id AND status = 'completed';
            
        WHEN 'active_projects' THEN
            SELECT COUNT(*) INTO result
            FROM contracts
            WHERE editor_id = p_editor_id AND status = 'active';
            
        WHEN 'total_earnings' THEN
            SELECT IFNULL(SUM(agreed_price), 0) INTO result
            FROM contracts
            WHERE editor_id = p_editor_id AND status = 'completed';
            
        ELSE
            SET result = 0;
    END CASE;
    
    RETURN result;
END //
DELIMITER ;