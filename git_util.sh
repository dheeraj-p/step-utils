#! /bin/bash

ACTION=$1
ORG_NAME=$2
ASSIGNMENT_NAME=$3
USERNAMES_FILE="usernames"


clone_all () {
  for USERNAME in $(cat $USERNAMES_FILE); do
    CLONE_DIR="assignments/$ASSIGNMENT_NAME/$USERNAME"
    if [ -d $CLONE_DIR ] ; then
      continue  
    fi
    
    REPO_NAME=$ASSIGNMENT_NAME-$USERNAME
    git clone "git@github.com:$ORG_NAME/$REPO_NAME" $CLONE_DIR
    echo "Sleeping..."
    echo "--------------------"
    sleep 1
  done
}

pull_all () {
  WORKSPACE_DIR=$(pwd)
  for USERNAME in $(cat $USERNAMES_FILE); do
    CLONED_DIR="assignments/$ASSIGNMENT_NAME/$USERNAME"
    
    echo "Pulling $ASSIGNMENT_NAME for $USERNAME"
    cd $CLONED_DIR
    git pull
    cd $WORKSPACE_DIR
    echo "Sleeping..."
    echo "--------------------"
    sleep 1
  done
}

case $ACTION in
  pull)
    pull_all
    ;;
  
  clone)
    clone_all
    ;;
  
  *)
    echo "Small utility to clone and pull repositories for a specific assignment created using Github Classroom"
    echo ""
    echo "Usage:"
    echo "  ./git_util.sh clone org_name assignment_name"
    echo "  ./git_util.sh pull org_name assignment_name"
    echo ""
    echo "Note: This script expects usernames to be present in a new line separated text file named 'usernames'"
    ;;

esac