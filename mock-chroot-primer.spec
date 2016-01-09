Name:      mock-chroot-primer
Version:   1
Release:   1
Summary:   mock chroot primer
Group:     System Environment/Base
License:   MIT
URL:       http://github.com/atgreen/jenkins-mock-build-container
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: noarch

# List all packages to bake into the build container's mock chroot.
# Put whatever you want here.  The sample list below is for building
# the GNU toolchain and QEMU.
BuildRequires:  texinfo bison flex zlib-devel gperf gmp-devel libmpc-devel 
BuildRequires:  mpfr-devel python-devel texinfo zlib-devel ncurses-devel
BuildRequires:  SDL-devel glib2-devel pixman-devel

%description
This package exists simply to prime the mock build chroots for our
jenkins build container.

%prep

%build

%install
rm -rf $RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root, 0755)

%changelog
* Sat Jan 09 2016 Anthony Green <green@redhat.com> - 1-1
- Create.
