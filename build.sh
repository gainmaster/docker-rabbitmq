#!/usr/bin/env bash

trap 'exit 1' ERR   # Exit script with error if command fails

if [[ -z $(which docker) ]]; then
    echo "Missing docker client which is required for building, testing and pushing"
    exit 3
fi

declare PROJECT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
declare DOCKER_IMAGE_NAME="gainmaster/rabbitmq"

cd $PROJECT_DIRECTORY


function build_rabbitmq_tar
{
    $PROJECT_DIRECTORY/utility/rabbitmq-builder.sh
}

function build_docker_image 
{
    docker build -t ${DOCKER_IMAGE_NAME}:latest .
}

function delete_rabbitmq_tar
{
    rm $PROJECT_DIRECTORY/rabbitmq.pkg.tar.xz
}

function test_docker_image
{
    docker history ${DOCKER_IMAGE_NAME}:latest 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant test ${DOCKER_IMAGE_NAME}:latest, the image is not built"
        exit 2
    fi

    bats test/
}

function run_docker_image
{
    docker history ${DOCKER_IMAGE_NAME}:latest 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant run ${DOCKER_IMAGE_NAME}:latest, the image is not built"
        exit 2
    fi

    docker run --rm -it -p 5672:5672 -p 15672:15672 ${DOCKER_IMAGE_NAME}:latest
}


function push_docker_image 
{
    docker history $DOCKER_IMAGE_NAME:latest 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant push ${DOCKER_IMAGE_NAME}:latest, the image is not built"
        exit 2
    fi

    [ -z "$DOCKER_EMAIL" ]    && { echo "Need to set DOCKER_EMAIL";    exit 4; }
    [ -z "$DOCKER_USER" ]     && { echo "Need to set DOCKER_USER";     exit 4; }
    [ -z "$DOCKER_PASSWORD" ] && { echo "Need to set DOCKER_PASSWORD"; exit 4; }

    if [[ $EUID -ne 0 ]]; then
        if [[ -z $(which sudo) ]]; then
            echo "Missing sudo client which is required for pushing when not root"
            exit 2
        fi

        sudo docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
        sudo docker push $DOCKER_IMAGE_NAME:latest
    else
        docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
        docker push $DOCKER_IMAGE_NAME:latest
    fi
}


#
# Handle input
#
actions=("$@")

if [ ${#actions[@]} -eq 0 ]; then
    actions=(pre-build build post-build test push)
fi

for action in "${actions[@]}"; do 
    case "$action" in
        pre-build)
            echo "Executing pre-build action"
            build_rabbitmq_tar
            ;;

        build)
            echo "Executing build action"
            build_docker_image
            ;;
        
        post-build)
            echo "Executing post-build action"
            delete_rabbitmq_tar
            ;;

        test)
            echo "Executing test action"
            test_docker_image
            ;;

        run)
            echo "Executing run action"
            run_docker_image
            ;;

        push)
            echo "Executing push action"
            push_docker_image 
            ;;

        *) echo "Ignoring invalid action ${action}" ;;
    esac
done