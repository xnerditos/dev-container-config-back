#/bin/bash

if [[ -n "$(docker ps -a -q)" ]]; then
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q) -f
fi;
docker system prune --all --force 
# if [[ -n "$(docker images -a -q)" ]]; then
#     docker rmi $(docker images -a -q) -f
# fi
# if [[ -n "$(docker volume ls -q)" ]]; then
#     docker volume rm $(docker volume ls -q) -f
# fi

