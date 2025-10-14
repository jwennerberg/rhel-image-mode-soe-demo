.PHONY: build-bootc
build-bootc:
	@podman build -t satellite.summit.lab.a.wnn.se/rh_lab/rhel-bootc/objectdetection-bootc:dev -f Containerfile

.PHONY: push-bootc
push-bootc:
	@podman push satellite.summit.lab.a.wnn.se/rh_lab/rhel-bootc/objectdetection-bootc:dev

.PHONY: build-push
build-push: build-bootc push-bootc
