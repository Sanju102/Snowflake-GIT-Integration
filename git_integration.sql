-- Switch role to AccountAdmin to execute below tasks
USE ROLE ACCOUNTADMIN;

-- Creating DB to save all objects 
CREATE OR REPLACE DATABASE SNOWGIT;

-- Create an secret for authentication
CREATE OR REPLACE SECRET GIT_SECRET
    TYPE=PASSWORD
    USERNAME='<Github Username>'
    PASSWORD='<PAT>'
    ;

-- Display all secrets
SHOW SECRETS;

-- Create an API integration
CREATE OR REPLACE API INTEGRATION GIT_API_INTEGRATION
    API_PROVIDER=git_https_api
    API_ALLOWED_PREFIXES=('https://github.com/<Github Username>/')
    ALLOWED_AUTHENTICATION_SECRETS=(GIT_SECRET)
    ENABLED=TRUE
    ;
-- Display all API integrations
SHOW API INTEGRATIONS;
