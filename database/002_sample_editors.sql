USE pixelsforge;

-- Sample editor 1
INSERT INTO users (
    email, 
    password_hash, 
    first_name, 
    last_name, 
    user_type, 
    is_verified
) VALUES (
    'editor1@example.com', 
    '$2a$12$5zgMV3l3Y9bJ5hOYqJQzUeZ5v5nQ6X5wX8dJ5mY7z6X5vQ8nY7z6X5', 
    'Sarah', 
    'Editor', 
    'editor', 
    TRUE
);

SET @editor1_id = LAST_INSERT_ID();

INSERT INTO editor_profiles (
    user_id,
    headline,
    bio,
    hourly_rate,
    availability,
    experience_years,
    location,
    timezone,
    is_approved
) VALUES (
    @editor1_id,
    'Professional Video Editor',
    'I specialize in YouTube content creation with 5+ years of experience editing vlogs, tutorials, and product reviews.',
    45.00,
    'full-time',
    5,
    'New York, USA',
    'EST',
    TRUE
);

SET @profile1_id = LAST_INSERT_ID();

-- Skills for editor 1
INSERT INTO editor_skills (profile_id, skill_name, proficiency)
VALUES 
(@profile1_id, 'Video Editing', 'expert'),
(@profile1_id, 'Color Grading', 'advanced'),
(@profile1_id, 'Audio Mixing', 'intermediate');

-- Software for editor 1
INSERT INTO editor_software (profile_id, software_name, proficiency, years_of_experience)
VALUES 
(@profile1_id, 'Adobe Premiere Pro', 'expert', 5),
(@profile1_id, 'After Effects', 'advanced', 3),
(@profile1_id, 'DaVinci Resolve', 'intermediate', 2);

-- Portfolio items
INSERT INTO editor_portfolio (profile_id, title, description, media_url, media_type, is_featured)
VALUES 
(@profile1_id, 'Travel Vlog', 'Edited this travel vlog series for a popular YouTuber', 'https://example.com/video1.mp4', 'video', TRUE),
(@profile1_id, 'Product Review', 'Color grading and editing for tech product review', 'https://example.com/video2.mp4', 'video', FALSE);

-- Sample editor 2
INSERT INTO users (
    email, 
    password_hash, 
    first_name, 
    last_name, 
    user_type, 
    is_verified
) VALUES (
    'editor2@example.com', 
    '$2a$12$5zgMV3l3Y9bJ5hOYqJQzUeZ5v5nQ6X5wX8dJ5mY7z6X5vQ8nY7z6X5', 
    'Mike', 
    'Motion', 
    'editor', 
    TRUE
);

SET @editor2_id = LAST_INSERT_ID();

INSERT INTO editor_profiles (
    user_id,
    headline,
    bio,
    hourly_rate,
    availability,
    experience_years,
    location,
    timezone,
    is_approved
) VALUES (
    @editor2_id,
    'Motion Graphics Specialist',
    'I create stunning motion graphics and animations for commercials and social media.',
    75.00,
    'part-time',
    8,
    'Los Angeles, USA',
    'PST',
    TRUE
);

SET @profile2_id = LAST_INSERT_ID();

-- Skills for editor 2
INSERT INTO editor_skills (profile_id, skill_name, proficiency)
VALUES 
(@profile2_id, 'Motion Graphics', 'expert'),
(@profile2_id, '2D Animation', 'advanced'),
(@profile2_id, 'Visual Effects', 'intermediate');

-- Software for editor 2
INSERT INTO editor_software (profile_id, software_name, proficiency, years_of_experience)
VALUES 
(@profile2_id, 'After Effects', 'expert', 8),
(@profile2_id, 'Cinema 4D', 'advanced', 5),
(@profile2_id, 'Blender', 'intermediate', 3);

-- Portfolio items
INSERT INTO editor_portfolio (profile_id, title, description, media_url, media_type, is_featured)
VALUES 
(@profile2_id, 'Product Commercial', 'Motion graphics for tech product launch', 'https://example.com/motion1.mp4', 'video', TRUE),
(@profile2_id, 'Social Media Ad', 'Animated ad for Instagram', 'https://example.com/motion2.mp4', 'video', TRUE);