USE pixelsforge;

DELIMITER //
CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.user_type = 'editor' THEN
        -- Create empty editor profile
        INSERT INTO editor_profiles (
            user_id,
            headline,
            availability,
            is_approved
        ) VALUES (
            NEW.user_id,
            'New Video Editor',
            'project-based',
            FALSE
        );
    END IF;
END //
DELIMITER ;