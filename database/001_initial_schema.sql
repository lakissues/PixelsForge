-- Main database schema
CREATE DATABASE IF NOT EXISTS pixelsforge;
USE pixelsforge;

-- Users Table (for both clients and editors)
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    profile_picture_url VARCHAR(255),
    user_type ENUM('client', 'editor', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE,
    verification_token VARCHAR(255),
    reset_token VARCHAR(255),
    reset_token_expires TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Editor Profiles Table
CREATE TABLE IF NOT EXISTS editor_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    headline VARCHAR(255),
    bio TEXT,
    hourly_rate DECIMAL(10,2),
    availability ENUM('full-time', 'part-time', 'project-based') NOT NULL,
    experience_years INT,
    location VARCHAR(100),
    timezone VARCHAR(50),
    is_approved BOOLEAN DEFAULT FALSE,
    approval_status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    rejection_reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Editor Skills Table
CREATE TABLE IF NOT EXISTS editor_skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    profile_id INT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    proficiency ENUM('beginner', 'intermediate', 'advanced', 'expert') NOT NULL,
    FOREIGN KEY (profile_id) REFERENCES editor_profiles(profile_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Editor Software Proficiency
CREATE TABLE IF NOT EXISTS editor_software (
    software_id INT AUTO_INCREMENT PRIMARY KEY,
    profile_id INT NOT NULL,
    software_name VARCHAR(100) NOT NULL,
    proficiency ENUM('beginner', 'intermediate', 'advanced', 'expert') NOT NULL,
    years_of_experience INT,
    FOREIGN KEY (profile_id) REFERENCES editor_profiles(profile_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Editor Portfolio Items
CREATE TABLE IF NOT EXISTS editor_portfolio (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    profile_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    media_url VARCHAR(255) NOT NULL,
    media_type ENUM('image', 'video', 'link') NOT NULL,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (profile_id) REFERENCES editor_profiles(profile_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Job Posts (Hire Editor Section)
CREATE TABLE IF NOT EXISTS job_posts (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    project_type ENUM('youtube', 'commercial', 'social_media', 'corporate', 'short_film', 'other') NOT NULL,
    budget_range ENUM('100-500', '500-1000', '1000-2500', '2500+', 'custom') NOT NULL,
    custom_budget DECIMAL(10,2),
    deadline DATE,
    status ENUM('draft', 'posted', 'in_progress', 'completed', 'cancelled') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Job Attachments (Reference Files)
CREATE TABLE IF NOT EXISTS job_attachments (
    attachment_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    file_url VARCHAR(255) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) NOT NULL,
    file_size INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES job_posts(job_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Job Applications
CREATE TABLE IF NOT EXISTS job_applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    editor_id INT NOT NULL,
    proposal TEXT NOT NULL,
    bid_amount DECIMAL(10,2),
    estimated_days INT,
    status ENUM('submitted', 'viewed', 'shortlisted', 'rejected', 'hired') DEFAULT 'submitted',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES job_posts(job_id) ON DELETE CASCADE,
    FOREIGN KEY (editor_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_application (job_id, editor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Contracts
CREATE TABLE IF NOT EXISTS contracts (
    contract_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    editor_id INT NOT NULL,
    client_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    agreed_price DECIMAL(10,2) NOT NULL,
    payment_schedule ENUM('full_upfront', '50-50', 'milestones', 'hourly') NOT NULL,
    status ENUM('active', 'completed', 'terminated', 'disputed') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES job_posts(job_id),
    FOREIGN KEY (editor_id) REFERENCES users(user_id),
    FOREIGN KEY (client_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Milestones (for payment schedules)
CREATE TABLE IF NOT EXISTS milestones (
    milestone_id INT AUTO_INCREMENT PRIMARY KEY,
    contract_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    amount DECIMAL(10,2) NOT NULL,
    due_date DATE,
    status ENUM('pending', 'submitted', 'approved', 'paid') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (contract_id) REFERENCES contracts(contract_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Messages (Communication between clients and editors)
CREATE TABLE IF NOT EXISTS messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    job_id INT,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES job_posts(job_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reviews and Ratings
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    contract_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    reviewee_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    FOREIGN KEY (reviewer_id) REFERENCES users(user_id),
    FOREIGN KEY (reviewee_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    notification_type ENUM('application', 'message', 'contract', 'payment', 'system') NOT NULL,
    reference_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;