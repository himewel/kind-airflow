SHELL:=/bin/bash

image=docker.pkg.github.com/himewel/kind-airflow

export CLUSTER
export NAMESPACE
export PORT

.PHONY: build
build:
	docker build . --tag $(image)

.PHONY: start
start:
	docker run \
		--env CLUSTER=$(CLUSTER) \
		--env NAMESPACE=$(NAMESPACE) \
		--interactive \
		--network=host \
		--rm \
		--tty \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube/config:/root/.kube/config:rw \
		$(image)

.PHONY: stop
stop:
	docker run \
		--env CLUSTER=$(CLUSTER) \
		--env NAMESPACE=$(NAMESPACE) \
		--interactive \
		--network=host \
		--tty \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube/config:/root/.kube/config:rw \
		$(image) \
		./tools/stop.sh

.PHONY: forward-webserver
forward-webserver:
	docker run \
		--detach \
		--env PORT=$(PORT) \
		--env NAMESPACE=$(NAMESPACE) \
		--network=host \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube/config:/root/.kube/config:rw \
		$(image) \
		./tools/forward-webserver.sh

.PHONY: forward-flower
forward-flower:
	docker run \
		--detach \
		--env PORT=$(PORT) \
		--env NAMESPACE=$(NAMESPACE) \
		--network=host \
		--rm \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ~/.kube/config:/root/.kube/config:rw \
		$(image) \
		./tools/forward-flower.sh
