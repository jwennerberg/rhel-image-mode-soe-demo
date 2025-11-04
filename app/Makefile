.PHONY: build-bootc
build-bootc:
	#@podman build -t satellite.gbg.a.wnn.se/rh/rhel-bootc/objectdetection-bootc:dev -f Containerfile
	@podman build -t satellite.gbg.a.wnn.se/rh/rhel-bootc/objectdetection-bootc:dev -f Containerfile

.PHONY: push-bootc
push-bootc:
	@podman push satellite.a.wnn.se/rh/rhel-bootc/objectdetection-bootc:dev

.PHONY: build-push
build-push: build-bootc push-bootc

.PHONY: convert
convert:
	podman image scp admin@localhost::objectdetection-bootc:dev
	sudo podman run \
            --rm \
            -it \
            --privileged \
            --pull=newer \
            --security-opt label=type:unconfined_t \
            -v ../output:/output \
            -v ../config.toml:/config.toml \
            -v /var/lib/containers/storage:/var/lib/containers/storage \
            registry.redhat.io/rhel10/bootc-image-builder:latest \
            --type qcow2 \
            quay.io/jwennerberg/objectdetection-bootc:dev
