-- Run this as postgres superuser, connected to bsides database
-- Grants necessary privileges to the application user

GRANT USAGE ON SCHEMA public TO bsides_server;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO bsides_server;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO bsides_server;

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bsides_server;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT USAGE ON SEQUENCES TO bsides_server;