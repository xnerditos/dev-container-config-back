#!/bin/bash

echo "# remove this line and replace it with the contents of the SSH key to use for github" > $HOME/.ssh/github_key 
chmod 600 $HOME/.ssh/github_key 
nano $HOME/.ssh/github_key
echo "IdentityFile $HOME/.ssh/github_key" >> $HOME/.ssh/config
