.PHONY: build-soe-10
build-soe-10:
	@podman build -t quay.io/jwennerberg/soe-bootc:10 -f Containerfile.soe.10

.PHONY: build-soe
build-soe:
	@podman build -t quay.io/jwennerberg/soe-bootc:base -f Containerfile.soe

.PHONY: push-soe
push-soe:
	@podman push quay.io/jwennerberg/soe-bootc:base

.PHONY: build-app-bootc-10
build-app-bootc-10:
	@podman build -t quay.io/jwennerberg/object-detection-bootc:dev -f Containerfile.app.10
	@podman tag quay.io/jwennerberg/object-detection-bootc:dev satellite.summit.lab.a.wnn.se/rh_lab/rhel-bootc/objectdetection-bootc:dev

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
	@[ ! -d ./output ] && mkdir ./output
	@podman image scp admin@localhost::app-bootc:dev
	@sudo podman run \
	    --rm \
	    -it \
	    --privileged \
	    --pull=newer \
	    --security-opt label=type:unconfined_t \
	    -v $(pwd)/output:/output \
	    -v ./config.toml:/config.toml \
	    -v /var/lib/containers/storage:/var/lib/containers/storage \
	    registry.redhat.io/rhel9/bootc-image-builder:latest \
	    --type qcow2 \
	    --local \
	    app-bootc:dev
