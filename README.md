# jenkins-mock-build-container
A docker build container for use with jenkins that is primed with a mock chroot for RPM package builds

You must run this container in privileged mode, as mock requires this.
Before you use it, be sure to start up the container in privileged
mode and prime the cache by mock building the primer rpm.  Commit this
new version of the container and you're good to go!

Anthony Green
green@redhat.com

