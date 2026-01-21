# Snowflake-GIT-Integration

## Step 1: Generate a GitHub PAT
Snowflake requires a PAT to authenticate with your private repositories.

1. Log in to your GitHub account.
2. Click your profile photo in the top-right corner and select Settings.
3. In the left sidebar, scroll down and click Developer settings.
4. Select Personal access tokens > Tokens (Fine-grained tokens).
5. Click Generate new token > Generate new token (classic).
6. Note: Give it a descriptive name (e.g., "Snowflake Integration").
7. Expiration: Set this according to your security policy (e.g., 90 days).
8. Select Scopes: At a minimum, check the repo box (this grants full control of private repositories).
9. Click Generate token.
10. Copy the token immediately. You will not be able to see it again.

[Click here to watch the Video Walkthrough: Generating a GitHub PAT](https://drive.google.com/file/d/1y_s7nqPRwVtLRPlGGNjEnvN4hEL4k1Y_/view?usp=sharing)

## Step 2: Security & API Configuration
In this phase, you are building the infrastructure required for Snowflake to securely store your credentials and establish a network connection to GitHub.

### 1. Context and Storage Setup
First, you elevate your privileges to ACCOUNTADMIN. This is necessary because creating "Integrations" is a high-level security task that standard users cannot perform. You then create a dedicated Database to act as a container for all your Git-related objects (secrets, integrations, and repositories), keeping your environment organized.

### 2. Creating the Secret (The Credential Store)
Instead of typing your GitHub password every time, you create a Secret object.

This acts as a secure vault within Snowflake.

It encrypts and stores your GitHub Username and the Personal Access Token (PAT) you generated in Step 1.

By using a Secret, your sensitive token is never exposed in plain text in your code or logs once it's created.

### 3. Creating the API Integration (The Network Bridge)
The API Integration is the "security gate" that allows Snowflake to communicate with the outside world.

Provider: You specify that this integration is specifically for Git via HTTPS.

Allowed Prefixes: This is a security restriction. You are telling Snowflake it is only allowed to connect to your specific GitHub profile or organization. It will block attempts to connect to any other URL.

Secret Linking: You explicitly link the Secret you created earlier to this integration. This tells Snowflake: "Whenever you use this network bridge to talk to GitHub, use these specific credentials to log in."

### 4. Verification
Finally, you use the "Show" commands to confirm that both the vault (Secret) and the bridge (Integration) were created successfully and are ready for use in the final step.
