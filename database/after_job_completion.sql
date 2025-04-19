USE pixelsforge;

DELIMITER //
CREATE TRIGGER after_job_completion
AFTER UPDATE ON contracts
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' AND OLD.status != 'completed' THEN
        -- Update the job post status
        UPDATE job_posts
        SET status = 'completed',
            updated_at = NOW()
        WHERE job_id = NEW.job_id;
        
        -- Notify both parties
        INSERT INTO notifications (user_id, title, message, notification_type, reference_id)
        VALUES 
        (NEW.client_id, 'Project Completed', 'Your project has been marked as completed', 'contract', NEW.contract_id),
        (NEW.editor_id, 'Project Completed', 'You marked the project as completed', 'contract', NEW.contract_id);
    END IF;
END //
DELIMITER ;