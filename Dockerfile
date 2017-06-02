FROM rhel7:latest
MAINTAINER Anthony Green <green@redhat.com>

# Update the image with the bits that we need
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
RUN yum -y update
RUN yum install -y openssh-server mock rpm-build git subversion cvs make createrepo autoconf

# Configure our container so jenkins can connect and run mock
RUN adduser jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN usermod -a -G mock jenkins
RUN mkdir -p /var/run/sshd
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd  

# Prime the mock root cache
ADD mock-chroot-primer.spec mock-chroot-primer.spec 
RUN rpmbuild --define "_sourcedir ." --define "_srcrpmdir ." --bs mock-chroot-primer.spec

# Can't do this at docker build time as it requires a privileged
# container, so do it after the fact and commit the change.  
# RUN mock --rebuild mock-chroot-primer-1-1.src.rpm

# Jenkins will ssh into this...
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

