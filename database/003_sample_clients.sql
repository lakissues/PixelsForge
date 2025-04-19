USE pixelsforge;

-- Sample client 1
INSERT INTO users (
    email, 
    password_hash, 
    first_name, 
    last_name, 
    user_type, 
    is_verified
) VALUES (
    'brand@example.com', 
    '$2a$12$5zgMV3l3Y9bJ5hOYqJQzUeZ5v5nQ6X5wX8dJ5mY7z6X5vQ8nY7z6X5', 
    'Acme', 
    'Brand', 
    'client', 
    TRUE
);

-- Sample client 2
INSERT INTO users (
    email, 
    password_hash, 
    first_name, 
    last_name, 
    user_type, 
    is_verified
) VALUES (
    'creator@example.com', 
    '$2a$12$5zgMV3l3Y9bJ5hOYqJQzUeZ5v5nQ6X5wX8dJ5mY7z6X5vQ8nY7z6X5', 
    'Content', 
    'Creator', 
    'client', 
    TRUE
);