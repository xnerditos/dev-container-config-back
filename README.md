# Dev container config

This repo provides config for bringing up a dev container for backend devs

## Configuring your environment to use Dev Containers for development

To use Dev Containers

1. Install Docker.  If you are using an Ubuntu based distribution of Linux, you can use the script `install-docker-ubuntu.sh`.  *Reboot after installing!*  Once you have Docker installed, run a test command to verify:  `docker run hello-world`.  It should return a message that Docker is correctly installed.  For information about installing Docker on Windows or Mac (or for more information about installing it on Linux) [see this page](https://docs.docker.com/get-docker/).

2. Install the extensions in Visual Studio Code for Dev Containers (Remote Containers)

```
code --install-extension code --install-extension ms-vscode-remote.remote-containers
```

3. Define the environment variables `GITHUB_USER` and `PACKAGE_ACCESS`.  If you are in Linux, these must be in defined in `.bashrc` or one of the "profile" dotfiles.  `GITHUB_USER` is your github user name.  `PACKAGE_ACCESS` is a github token with "package:read" access (see the [dotfiles repo](https://github.com/xnerditos/dotfiles) for info about creating the token. If you do not have these defined, you will have to run the script `~/setup/add-nuget-package-source.sh` from within the container.
 
```
export GITHUB_USER=mygithubuser
export PACKAGE_ACCESS=ghp_WLXXxhb7PhfR3mhCMbHLveR6LaSR8k4961if111
```

4. If you are using SSH to access github, then you will have to add the SSH key to the container.  You can do this automatically by copying it to the root of the repository as `github_key`.  DO NOT check in this file (it should be ignored anyway).  This must be done *before starting the container*.  Alternatively, from within the container run the script `~/install/add-github-ssh-key.sh` which will allow you to paste in the contents of the key.

5. If you have additional configuration that you want to be run, create a file called `dev_container_custom_bootstrap.sh` and put it in the root of the repository.  DO NOT check it in (it should be ignored anyway).

## Using Dev Containers for development

To do development on a repo, run VS Code.  The project must already contain the `.devcontainers` configuration (see [Setting up a project for Dev Containers](#setting-up-a-project-for-dev-containers))  Also, remember you must have the environment variables set up [as indicated above in step 3](#configuring-your-environment-to-use-dev-containers-for-development) if you want the container to automatically init correctly without additional steps! 

From the command pallette choose "Dev Containers:  Open Workspace in Container..."  Choose the workspace.  Your container will be created.  The first run will take longer as the container is built.  After that, container start-up should be almost instantaneous.  

Note that the following files must be ignored in `.gitignore` and should never be checked in:

`dev_container_custom_bootstrap.sh`
`github_key`

This are the suggested entries to add to `.gitignore`, which will cause the top `devcontainer.json` to be included but none in any sub folders, as well as the indicated files. 
```
/github_key
/dev_container_custom_bootstrap.sh
devcontainer/
!/.devcontainer/devcontainer.json
```


## Setting up a project for Dev Containers

To allow a project to use Dev Containers, copy the folder `devcontainers_config` from this repo as `.devcontainers` to the project root folder (where the workspace file is)

## Container desktop

The container config contains a lite desktop that can be accessed via the browser.  Simply point an instance of your browser to http://localhost:6080 and use `vscode` as the password when prompted. 

Right clicking on the desktop brings up the options for applications that can be run directly.  Also, GUI applications opened via the build in VS Code terminal will display on the lite-desktop.  

## Container additional install and utilities

The container config contains some additional things that you can do via scripts that are automatically installed

### Additional setup
* `~/setup/install-chrome.sh`:  Installs Google Chrome
* `~/setup/add-github-ssh-key.sh`: Allows you to set up the github SSH key if this was not done on container setup
* `~/setup/add-nuget-packet-source.sh`: Allows you to set up the Nuget package source if this was not done on container setup

### Utilities

* `edit-desktop-menu`:  Edits the menu for the lite desktop
* `run-detached`:  Lets you run applications detached from the console.  Example: `run-detached google-chrome` will open Google Chrome but detached from the built-in terminal.