USE pixelsforge;

-- Get client IDs
SET @client1_id = (SELECT user_id FROM users WHERE email = 'client@example.com');
SET @client2_id = (SELECT user_id FROM users WHERE email = 'brand@example.com');
SET @client3_id = (SELECT user_id FROM users WHERE email = 'creator@example.com');

-- Job 1
INSERT INTO job_posts (
    client_id,
    title,
    description,
    project_type,
    budget_range,
    deadline,
    status
) VALUES (
    @client1_id,
    'YouTube Vlog Editing',
    'Need weekly editing for my travel vlog channel. Each video is 15-20 minutes long with multiple camera angles.',
    'youtube',
    '500-1000',
    DATE_ADD(CURDATE(), INTERVAL 30 DAY),
    'posted'
);

SET @job1_id = LAST_INSERT_ID();

-- Job 2
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
    @client2_id,
    'Product Commercial',
    'Need a 30-second product commercial with motion graphics and professional editing.',
    'commercial',
    'custom',
    2500.00,
    DATE_ADD(CURDATE(), INTERVAL 14 DAY),
    'posted'
);

SET @job2_id = LAST_INSERT_ID();

-- Job 3
INSERT INTO job_posts (
    client_id,
    title,
    description,
    project_type,
    budget_range,
    deadline,
    status
) VALUES (
    @client3_id,
    'Instagram Reels',
    'Need daily editing for Instagram Reels (15-30 seconds each) for my fashion brand.',
    'social_media',
    '100-500',
    DATE_ADD(CURDATE(), INTERVAL 7 DAY),
    'posted'
);

-- Sample applications
SET @editor1_id = (SELECT user_id FROM users WHERE email = 'editor1@example.com');
SET @editor2_id = (SELECT user_id FROM users WHERE email = 'editor2@example.com');

-- Editor 1 applies to Job 1
INSERT INTO job_applications (
    job_id,
    editor_id,
    proposal,
    bid_amount,
    estimated_days
) VALUES (
    @job1_id,
    @editor1_id,
    'I have extensive experience editing travel vlogs. I can provide cinematic transitions, color grading, and professional audio mixing.',
    750.00,
    5
);

-- Editor 2 applies to Job 2
INSERT INTO job_applications (
    job_id,
    editor_id,
    proposal,
    bid_amount,
    estimated_days
) VALUES (
    @job2_id,
    @editor2_id,
    'I specialize in motion graphics and can create stunning visuals for your product commercial. Check my portfolio for similar work.',
    2200.00,
    10
);

-- Editor 1 also applies to Job 2
INSERT INTO job_applications (
    job_id,
    editor_id,
    proposal,
    bid_amount,
    estimated_days
) VALUES (
    @job2_id,
    @editor1_id,
    'While I specialize in vlogs, I also have experience with product videos and can deliver high-quality results.',
    2000.00,
    12
);