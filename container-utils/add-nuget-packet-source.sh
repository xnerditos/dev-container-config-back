#!/bin/bash

if [[ -z "$1" ]]; then 
    echo "Please provide your github user name"
    exit 1;
fi;
if [[ -z "$2" ]]; then 
    echo "Please provide a Github Personal Access Token for authentication to github"
    exit 1;
fi;

username=$1
token=$2

dotnet nuget add source https://nuget.pkg.github.com/xnerditos/index.json -n "xnerditos" --username $username --store-password-in-clear-text --password $token

