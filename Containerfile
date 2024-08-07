FROM registry.redhat.io/rhel9/rhel-bootc:9.4

# Copy our custom configuration in /etc/vmware-tools/tools.conf
# COPY etc/ /etc/
# RUN dnf -y install open-vm-tools && \
#     dnf clean all && \
#     systemctl enable vmtoolsd.service

#install packages
RUN dnf install -y httpd && dnf clean all

#start the services automatically on boot
RUN systemctl enable httpd

#create an awe inspiring home page!
RUN echo '<h1 style="text-align:center;">Welcome to image mode for RHEL</h1>' >> /var/www/html/index.html
