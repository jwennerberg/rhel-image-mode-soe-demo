.PHONY: build-soe
build-soe:
	@podman build -t quay.io/jwennerberg/soe-bootc:10 -f Containerfile.soe
	#@podman tag quay.io/jwennerberg/soe-bootc:10 satellite.gbg.a.wnn.se/rh/rhel-bootc/rhel-soe-bootc:10

.PHONY: push-soe
push-soe:
	@podman push quay.io/jwennerberg/soe-bootc:10

.PHONY: build-app-bootc
build-app-bootc-10:
	@podman build -t quay.io/jwennerberg/object-detection-bootc:dev -f Containerfile.app
	#@podman tag quay.io/jwennerberg/object-detection-bootc:dev satellite.gbg.lab.a.wnn.se/lab/rhel-bootc/objectdetection-bootc:dev

.PHONY: build-app-bootc
build-app-bootc:
	@podman build -t quay.io/jwennerberg/app-bootc:dev -f Containerfile.app

.PHONY: push-app-bootc
push-app-bootc:
	@podman push quay.io/jwennerberg/app-bootc:dev 

.PHONY: build-push-app
build-push-app: build-app-bootc push-app-bootc

.PHONY: convert
convert:
	#"[ ! -d ./output ]" && mkdir ./output
	podman image scp admin@localhost::soe-bootc:10
	sudo podman run \
	    --rm \
	    -it \
	    --privileged \
	    --pull=newer \
	    --security-opt label=type:unconfined_t \
	    -v ./output:/output \
	    -v ./config.toml:/config.toml \
	    -v /var/lib/containers/storage:/var/lib/containers/storage \
	    registry.redhat.io/rhel10/bootc-image-builder:latest \
	    --type qcow2 \
	    quay.io/jwennerberg/soe-bootc:10

