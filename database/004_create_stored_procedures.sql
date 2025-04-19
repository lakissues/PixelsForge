USE pixelsforge;

-- Procedure to approve an editor
DELIMITER //
CREATE PROCEDURE approve_editor(IN p_user_id INT, IN p_admin_id INT)
BEGIN
    DECLARE profile_exists INT;
    
    SELECT COUNT(*) INTO profile_exists 
    FROM editor_profiles 
    WHERE user_id = p_user_id;
    
    IF profile_exists > 0 THEN
        UPDATE editor_profiles 
        SET is_approved = TRUE, 
            approval_status = 'approved',
            updated_at = NOW()
        WHERE user_id = p_user_id;
        
        INSERT INTO notifications (user_id, title, message, notification_type, reference_id)
        VALUES (p_user_id, 'Profile Approved', 'Your editor profile has been approved!', 'system', p_user_id);
        
        SELECT 'Editor approved successfully' AS message;
    ELSE
        SELECT 'Editor profile not found' AS error;
    END IF;
END //
DELIMITER ;

-- Procedure to create a job post
DELIMITER //
CREATE PROCEDURE create_job_post(
    IN p_client_id INT,
    IN p_title VARCHAR(255),
    IN p_description TEXT,
    IN p_project_type ENUM('youtube', 'commercial', 'social_media', 'corporate', 'short_film', 'other'),
    IN p_budget_range ENUM('100-500', '500-1000', '1000-2500', '2500+', 'custom'),
    IN p_custom_budget DECIMAL(10,2),
    IN p_deadline DATE
)
BEGIN
    DECLARE is_client INT;
    
    SELECT COUNT(*) INTO is_client 
    FROM users 
    WHERE user_id = p_client_id AND user_type = 'client';
    
    IF is_client > 0 THEN
        INSERT INTO job_posts (
            client_id, 
            title, 
            description, 
            project_type, 
            budget_range, 
            custom_budget, 
            deadline,
            status
        ) VALUES (
            p_client_id, 
            p_title, 
            p_description, 
            p_project_type, 
            p_budget_range, 
            p_custom_budget, 
            p_deadline,
            'posted'
        );
        
        SELECT LAST_INSERT_ID() AS job_id, 'Job posted successfully' AS message;
    ELSE
        SELECT 'Only clients can post jobs' AS error;
    END IF;
END //
DELIMITER ;

-- Procedure to submit a job application
DELIMITER //
CREATE PROCEDURE submit_application(
    IN p_job_id INT,
    IN p_editor_id INT,
    IN p_proposal TEXT,
    IN p_bid_amount DECIMAL(10,2),
    IN p_estimated_days INT
)
BEGIN
    DECLARE is_editor INT;
    DECLARE job_exists INT;
    DECLARE already_applied INT;
    
    -- Check if user is an approved editor
    SELECT COUNT(*) INTO is_editor 
    FROM editor_profiles 
    WHERE user_id = p_editor_id AND is_approved = TRUE;
    
    -- Check if job exists
    SELECT COUNT(*) INTO job_exists 
    FROM job_posts 
    WHERE job_id = p_job_id AND status = 'posted';
    
    -- Check if already applied
    SELECT COUNT(*) INTO already_applied 
    FROM job_applications 
    WHERE job_id = p_job_id AND editor_id = p_editor_id;
    
    IF is_editor = 0 THEN
        SELECT 'Only approved editors can apply for jobs' AS error;
    ELSEIF job_exists = 0 THEN
        SELECT 'Job not found or not open for applications' AS error;
    ELSEIF already_applied > 0 THEN
        SELECT 'You have already applied for this job' AS error;
    ELSE
        INSERT INTO job_applications (
            job_id,
            editor_id,
            proposal,
            bid_amount,
            estimated_days,
            status
        ) VALUES (
            p_job_id,
            p_editor_id,
            p_proposal,
            p_bid_amount,
            p_estimated_days,
            'submitted'
        );
        
        -- Notify client
        INSERT INTO notifications (
            user_id,
            title,
            message,
            notification_type,
            reference_id
        )
        SELECT 
            j.client_id,
            'New Application',
            CONCAT(u.first_name, ' ', u.last_name, ' applied to your job: ', j.title),
            'application',
            LAST_INSERT_ID()
        FROM 
            job_posts j
        JOIN 
            users u ON p_editor_id = u.user_id
        WHERE 
            j.job_id = p_job_id;
        
        SELECT LAST_INSERT_ID() AS application_id, 'Application submitted successfully' AS message;
    END IF;
END //
DELIMITER ;