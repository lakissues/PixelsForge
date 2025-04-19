USE pixelsforge;

-- Indexes for performance optimization
CREATE INDEX idx_editor_skills ON editor_skills(skill_name);
CREATE INDEX idx_editor_software ON editor_software(software_name);
CREATE INDEX idx_job_status ON job_posts(status);
CREATE INDEX idx_job_type ON job_posts(project_type);
CREATE INDEX idx_editor_availability ON editor_profiles(availability, is_approved);
CREATE INDEX idx_application_status ON job_applications(status);
CREATE INDEX idx_contract_status ON contracts(status);
CREATE INDEX idx_notification_user ON notifications(user_id, is_read);
CREATE INDEX idx_message_conversation ON messages(
    LEAST(sender_id, receiver_id),
    GREATEST(sender_id, receiver_id),
    created_at
);