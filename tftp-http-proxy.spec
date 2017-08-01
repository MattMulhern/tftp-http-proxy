Name: tftp-http-proxy
Version: %{version}
Release: %{release}
License: MIT
Url: https://github.com/mh-cbon/go-bin-rpm
Summary: Create binary rpm package with ease

%description
Create binary rpm package with ease

%prep

%build

%install
mkdir -p %{buildroot}/%{_bindir}
cp  %{_topdir}/dist/tftp-http-proxy %{buildroot}/%{_bindir}/tftp-http-proxy


%files
%{_bindir}/tftp-http-proxy


%clean

%changelog

