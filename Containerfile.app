# Base on latest SOE
FROM quay.io/jwennerberg/soe-bootc:latest

LABEL MAINTAINER="A-team"

# Add extra system dependencies or services
RUN dnf install -y postgresql-server postgresql && \
    rm -rf /var/{cache,log} /var/lib/{dnf,rhsm}

# Add Image analysis app
COPY quadlets/image_analysis/ /usr/share/containers/systemd/
RUN ln -s ../image_analysis.target /usr/lib/systemd/system/default.target.wants
