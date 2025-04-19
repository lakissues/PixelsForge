USE pixelsforge;

-- Admin user
INSERT INTO users (
    email, 
    password_hash, 
    first_name, 
    last_name, 
    user_type, 
    is_verified
) VALUES (
    'admin@pixelsforge.com', 
    '$2a$12$5zgMV3l3Y9bJ5hOYqJQzUeZ5v5nQ6X5wX8dJ5mY7z6X5vQ8nY7z6X5', -- hashed password
    'Admin', 
    'User', 
    'admin', 
    TRUE
);

-- Sample client
INSERT INTO users (
    email, 
    password_hash, 
    first_name, 
    last_name, 
    user_type, 
    is_verified
) VALUES (
    'client@example.com', 
    '$2a$12$5zgMV3l3Y9bJ5hOYqJQzUeZ5v5nQ6X5wX8dJ5mY7z6X5vQ8nY7z6X5', -- hashed password
    'John', 
    'Client', 
    'client', 
    TRUE
);