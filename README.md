# Snowflake Git Integration: Step-by-Step Implementation

This project documents the process of connecting a Snowflake account to a GitHub repository to enable native version control.

## 🛠️ Implementation Steps

### 1. GitHub Authentication (PAT)
I generated a **Personal Access Token (Classic)** on GitHub with the `repo` scope. This token acts as the secure handshake between GitHub and Snowflake.

### 2. Role Elevation
All administrative tasks were performed under the **`ACCOUNTADMIN`** role in Snowsight to ensure proper permissions for creating security integrations.

### 3. Creating the Snowflake Secret
I stored the GitHub credentials securely within Snowflake. This prevents hardcoding sensitive tokens in scripts.

```sql
-- Role: ACCOUNTADMIN
CREATE OR REPLACE SECRET github_pat_secret
  TYPE = PASSWORD
  USERNAME = 'Your-GitHub-Username'
  PASSWORD = 'your-classic-pat-token-here';

```
### 4. Create the API Integration
This object authorizes Snowflake to communicate with the GitHub API domain.
```sql
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/your_org_or_user/')
  ENABLED = TRUE;
```
