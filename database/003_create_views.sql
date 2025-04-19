USE pixelsforge;

-- Approved editors view
CREATE OR REPLACE VIEW approved_editors AS
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.profile_picture_url,
    ep.profile_id,
    ep.headline,
    ep.bio,
    ep.hourly_rate,
    ep.availability,
    ep.experience_years,
    ep.location,
    ep.timezone
FROM 
    users u
JOIN 
    editor_profiles ep ON u.user_id = ep.user_id
WHERE 
    ep.is_approved = TRUE;

-- Job listings with application count
CREATE OR REPLACE VIEW job_listings AS
SELECT 
    j.job_id,
    j.title,
    j.description,
    j.project_type,
    j.budget_range,
    j.custom_budget,
    j.deadline,
    j.status,
    j.created_at,
    u.user_id AS client_id,
    u.first_name AS client_first_name,
    u.last_name AS client_last_name,
    COUNT(ja.application_id) AS application_count
FROM 
    job_posts j
JOIN 
    users u ON j.client_id = u.user_id
LEFT JOIN 
    job_applications ja ON j.job_id = ja.job_id
GROUP BY 
    j.job_id;

-- Editor stats view
CREATE OR REPLACE VIEW editor_stats AS
SELECT 
    ep.profile_id,
    ep.user_id,
    AVG(r.rating) AS avg_rating,
    COUNT(r.review_id) AS review_count,
    COUNT(DISTINCT c.contract_id) AS completed_projects,
    SUM(c.agreed_price) AS total_earnings
FROM 
    editor_profiles ep
LEFT JOIN 
    contracts c ON ep.user_id = c.editor_id AND c.status = 'completed'
LEFT JOIN 
    reviews r ON c.contract_id = r.contract_id AND r.reviewee_id = ep.user_id
GROUP BY 
    ep.profile_id;