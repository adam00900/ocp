#!/bin/bash

docker run \
	--name olm-mirror \
	-p 5000:5000 \
	-v /opt/registry/data:/var/lib/registry:z \
	-d \
	docker.io/library/registry

