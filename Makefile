SHELL:=/bin/bash

kind-image=docker.pkg.github.com/himewel/kind-airflow
repository=docker.pkg.github.com/himewel/airflow

export CLUSTER
export RELEASE
export PORT
export TAG

.PHONY: build
build:
	docker build --tag $(kind-image) ./tools

.PHONY: start
start:
	docker run \
		--env CLUSTER=$(CLUSTER) \
		--env RELEASE=$(RELEASE) \
		--interactive \
		--network=host \
		--rm \
		--tty \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume $(PWD)/settings.yaml:/root/settings.yaml \
		--volume ~/.kube:/root/.kube:rw \
		--volume ~/.helm:/root/.helm:rw \
		$(kind-image)

.PHONY: stop
stop:
	docker run \
		--env CLUSTER=$(CLUSTER) \
		--interactive \
		--network=host \
		--tty \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube:/root/.kube:rw \
		$(kind-image) \
		./tools/stop.sh

.PHONY: forward-webserver
forward-webserver:
	docker run \
		--detach \
		--env PORT=$(PORT) \
		--env RELEASE=$(RELEASE) \
		--network=host \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube/config:/root/.kube/config:rw \
		$(kind-image) \
		./tools/forward-webserver.sh

.PHONY: forward-flower
forward-flower:
	docker run \
		--detach \
		--env PORT=$(PORT) \
		--env RELEASE=$(RELEASE) \
		--network=host \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube/config:/root/.kube/config:rw \
		$(kind-image) \
		./tools/forward-flower.sh

.PHONY: deploy
deploy:
	docker build --tag $(repository):$(TAG) .;
	docker run \
		--env CLUSTER=$(CLUSTER) \
		--env RELEASE=$(RELEASE) \
		--interactive \
		--network=host \
		--tty \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume $(PWD)/settings.yaml:/root/settings.yaml \
		--volume ~/.kube:/root/.kube:rw \
		--volume ~/.helm:/root/.helm:rw \
		$(kind-image) \
		./tools/upgrade-helm.sh
