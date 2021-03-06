.PHONY: build run stop inspect

IMAGE_NAME = glenn_harper/rebirth-demo-flask:latest
CONTAINER_NAME = rebirth-demo
REPO_TAG = rebirth.azurecr.io/demo/flask-tensor:latest

build:
	sudo docker build -t $(IMAGE_NAME) .

release:
	sudo docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -t $(IMAGE_NAME)

run:
	sudo docker run --rm -p 5555:5555 --name $(CONTAINER_NAME) $(IMAGE_NAME)

inspect:
	sudo docker inspect $(IMAGE_NAME)

shell: 
	sudo docker exec -it $(CONTAINER_NAME) /bin/sh

stop:
	sudo docker stop $(IMAGE_NAME)

tag:
	sudo docker tag $(IMAGE_NAME) $(REPO_TAG)

push:
	sudo docker push $(REPO_TAG)
