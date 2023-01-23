# Dev container config

This repo provides config for bringing up a dev container for backend devs

## Using Dev Containers for development

To use Dev Containers

1. Install the extensions in Visual Studio Code for Dev Containers (Remote Containers)

```
code --install-extension code --install-extension ms-vscode-remote.remote-containers
```

2. Define the environment variables `GITHUB_USER` and `PACKAGE_ACCESS`.  If you are in Linux, these must be in defined in `.bashrc` or one of the "profile" dotfiles.  `GITHUB_USER` is your github user name.  `PACKAGE_ACCESS` is a github token with "package:read" access (see the [dotfiles repo](https://github.com/xnerditos/dotfiles) for info about creating the token. If you do not have these defined, the container config will fail. 
```
export GITHUB_USER=mygithubuser
export PACKAGE_ACCESS=ghp_WLXXxhb7PhfR3mhCMbHLveR6LaSR8k4961if111
```

3. In VS Code, open your Settings and search for "dotfiles".  For the `Dev Containers` extension, there is a setting `Dotfiles: Repository`.  Paste this repo `git@github.com:xnerditos/dev_container_config_back.git` as the value.  

4. To do development on a repo, run VS Code.  From the command pallette choose "Dev Containers:  Open Workspace in Container..."  Your container will be created. 

If you are using SSH to access github, then you will have to add the SSH key to the container.  You cna do this automatically by copying it to the root of the repository as `github_key` _before you start your dev container_.  DO NOT check in this file (it should be ignored anyway)

To add it manually, within the container (using vs code)...

1. Run `code ~/.ssh/config` and add a line `IdentityFile /home/vscode/.ssh/github_key` (or just uncomment it)

2. Run `code ~/.ssh/github_key` and paste in the contents of the key

After this, your github key should be automatically used.

## Setting up a project for Dev Containers

To allow a project to use Dev Containers, you copy the folder `devcontainers_config` as `.devcontainers` to the project root folder (where the workspace file is)

