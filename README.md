# Dev container config

This repo provides config for bringing up a dev container for backend devs

## Configuring your environment to use Dev Containers for development

To use Dev Containers

1. Install Docker.  If you are using an Ubuntu based distribution of Linux, you can use the script `install-docker-ubuntu.sh`.  *Reboot after installing!*

2. Install the extensions in Visual Studio Code for Dev Containers (Remote Containers)

```
code --install-extension code --install-extension ms-vscode-remote.remote-containers
```

3. Define the environment variables `GITHUB_USER` and `PACKAGE_ACCESS`.  If you are in Linux, these must be in defined in `.bashrc` or one of the "profile" dotfiles.  `GITHUB_USER` is your github user name.  `PACKAGE_ACCESS` is a github token with "package:read" access (see the [dotfiles repo](https://github.com/xnerditos/dotfiles) for info about creating the token. If you do not have these defined, the container config will fail. 
```
export GITHUB_USER=mygithubuser
export PACKAGE_ACCESS=ghp_WLXXxhb7PhfR3mhCMbHLveR6LaSR8k4961if111
```

4. If you are using SSH to access github, then you will have to add the SSH key to the container.  You cna do this automatically by copying it to the root of the repository as `github_key`.  DO NOT check in this file (it should be ignored anyway)

## Using Dev Containers for development

To do development on a repo, run VS Code.  The project must already contain the `.devcontainers` configuration (see [Setting up a project for Dev Containers](#setting-up-a-project-for-dev-containers))  Also, remember tou must have the environment variables set up [as indicated above in step 3](#configuring-your-environment-to-use-dev-containers-for-development)! 

From the command pallette choose "Dev Containers:  Open Workspace in Container..."  Choose the workspace.  Your container will be created.  The first run will take longer as the container is built.  After that, container start-up should be almost instantaneous.  

## Setting up a project for Dev Containers

To allow a project to use Dev Containers, copy the folder `devcontainers_config` from this repo as `.devcontainers` to the project root folder (where the workspace file is)


