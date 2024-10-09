FROM quay.io/jwennerberg/soe-bootc:latest

RUN dnf install -y postgresql \
    && rm -rf /var/{cache,log} /var/lib/{dnf,rhsm}

# Image analysis inferencing
COPY quadlets/image_understanding.container /usr/share/containers/systemd/image_understanding.container
COPY quadlets/image_understanding.image /usr/share/containers/systemd/image_understanding.image
RUN ln -s ../image_understanding.target /usr/lib/systemd/system/default.target.wants
