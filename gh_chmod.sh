#! /bin/bash

ORG_NAME=$1
ASSIGNMENT_NAME=$2
PERMISSION=$3

function updatePermission() {
    USERNAME=$1
    repoName=${ASSIGNMENT_NAME}-${USERNAME}
    echo "Updating permission for user: $USERNAME to write access to repo: ${repoName}"

    (gh api \
      --method PUT \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      /repos/$ORG_NAME/${repoName}/collaborators/${USERNAME} \
       -f "permission=$PERMISSION") || true
}

# gh auth login

for USER in $(cat usernames)
do
    updatePermission $USER
done