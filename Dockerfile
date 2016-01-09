FROM rhel7:latest
MAINTAINER Anthony Green <green@redhat.com>

# Update the image with the bits that we need
RUN yum -y update
RUN yum install -y openssh-server mock rpm-build

# Configure our container so jenkins can connect and run mock
RUN adduser jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN usermod -a -G mock jenkins
RUN mkdir -p /var/run/sshd
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd  

# Prime the mock root
ADD mock-chroot-primer.spec
rpmbuild --define "_sourcedir ." --define "_srcrpmdir ." --bs mock-chroot-primer.spec
mock --rebuild mock-chroot-primer-1-1.src.rpm

# Jenkins will ssh into this...
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
