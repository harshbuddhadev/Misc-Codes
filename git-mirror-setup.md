# How to Setup Git Mirror from GitLab to GitHub

## Create a Duplicate Repo in GitHub

1. Go to https://github.com/new
2. Under Owner Select your account
3. Under Repository name enter same Repo name as entered in GitLab
4. Enter Same Description as entered in GitLab
5. Set the Visibility of the Repo (Public/Private) as required
6. Untick Add a README file
7. Under add .gitignore, Select None
8. Under License, Select None
9. Click on "Create repository" button and wait for few seconds until it gets created successfully
10. Copy and save the Repo SSH URL

![GitHub-Create-Repo](./Images/github-create-repo.png)


## Add Repo Mirror to GitLab

11. Open the Repo you want to mirror
12. From the Left Sidebar, Click on Settings
13. Under Settings, Click on Repositories
14. Expand Mirroring Repositories
15. Paste the SSH Url after Making the following changes
    - replace ":" with "/" inside the url
    - add "ssh://" to the start of the url
    - Sample URL
    ```text
    #Orignal
    git@github.com:harshbuddhadev/Misc-Codes.git
    #Modified
    ssh://git@github.com/harshbuddhadev/Misc-Codes.git
    ```
16. Enter the Following Values

| Parameter             	| Value          	|
|-----------------------	|----------------	|
| Mirror Direction      	| Push           	|
| Authentication Method 	| SSH Public Key 	|

17. Click on Mirror Repository

![GitLab-Mirror-Repo](./Images/gitlab-mirror-repo.png)


18. Once the Mirror has Been Created, Click on the Copy SSH Key Button and save the SSH Key

![GitLab-Mirror-Copy-Key](./Images/gitlab-mirror-copy-key.png)


## Enter SSH Key in GitHub

19. Go to the GitHub Repo
20. Click on Settings
21. Click on Deploy Keys on the Sidebar
22. Click on "Add deploy key"
23. Under Title enter the following:
    ```text
    #Format
    <first name> @ <repo name> @ gitlab-mirror
    #Sample
    harsh@misc-codes@gitlab-mirror
    ```
24. Under Key, paste the previously copied SSH Key (Step 18)
25. Select Allow Write Access
26. Click on Add Key

![GitHub-add-SSH-Deploy-Key](./Images/github-add-ssh-deploy-key.png)


## Verify Mirroring Setup

27. Go the the list of Mirrored Repositories in GitLab (Same Page as Step 18)

28. Click on Update Now Button and Wait 5 mins
29. Refresh the page after 5 mins and make sure there are no errors

![GitLab-Refresh-Mirror-Repo-Status](./Images/gitlab-refresh-mirror-repo-status.png)

## Setup is Complete
---