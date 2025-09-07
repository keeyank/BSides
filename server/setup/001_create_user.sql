-- Run this as postgres superuser
-- Creates the application user for the BSides server

CREATE USER bsides_server WITH PASSWORD 'your_secure_password_here';
GRANT CONNECT ON DATABASE bsides TO bsides_server;