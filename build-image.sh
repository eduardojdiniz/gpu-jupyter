#!/usr/bin/env bash
cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)

export TAGNAME="cuda-11.2_ubuntu-20.04"
export NB_USER="jovyan"
export NB_UID=1000
export NB_GID=100
export NB_PW="jovyan"

###################### build, run and push tensorflow image ##########################
echo
echo
echo "build, run and push full image with tag ${TAGNAME}."
bash generate-Dockerfile.sh --gpulibs

docker build --build-arg NB_USER=$NB_USER \
             --build-arg NB_UID=$NB_UID \
             --build-arg NB_GID=$NB_GID \
             --build-arg NB_PW=$NB_PW \
             --no-cache -t dinize/dev-jpyr:${TAGNAME} \
             .build/

#export IMG_ID=$(docker image ls | grep ${TAGNAME} | grep -v _python-only | grep -v _slim | head -1 | awk '{print $3}')
#echo "push image with ID $IMG_ID and Tag ${TAGNAME} ."

# docker tag $IMG_ID dinize/dev-jpyr:${TAGNAME}
#docker rm -f dev-jpr_1
#docker run --gpus all -d -it -p 8848:8888 -v $(pwd)/data:/home/jovyan/work -e GRANT_SUDO=yes -e JUPYTER_ENABLE_LAB=yes --user $NB_USER --restart always --name dev-jpyr_1 dinize/dev-jpyr:${TAGNAME}

# docker push dinize/dev-jpyr:${TAGNAME}
