# PixelsForge Database Documentation

This directory contains the complete database implementation for PixelsForge video editing platform.

## Structure

- `migrations/`: Database schema creation and updates
  - `001_initial_schema.sql`: Main database tables
  - `002_add_indexes.sql`: Performance optimization indexes
  - `003_create_views.sql`: Useful database views
  - `004_create_stored_procedures.sql`: Common operations

- `seeds/`: Sample data for development
  - `001_admin_users.sql`: Admin and sample client accounts
  - `002_sample_editors.sql`: Sample editor profiles
  - `003_sample_clients.sql`: Additional client accounts
  - `004_sample_jobs.sql`: Sample job posts and applications

- `functions/`: Database functions
  - `calculate_editor_rating.sql`: Calculates average rating for an editor
  - `get_editor_stats.sql`: Returns various editor statistics

- `triggers/`: Database triggers
  - `after_user_insert.sql`: Creates editor profile when new editor registers
  - `after_job_completion.sql`: Handles job completion workflow

## Installation

1. Create the database:
   ```bash
   mysql -u root -p < migrations/001_initial_schema.sql