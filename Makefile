PROG=tftp-http-proxy
PACKAGE=bwalex/$(PROG)
SOURCEDIR=.
DESTDIR?=/sbin

NAME=${PROG}
DIST=.el7
SPECFILE="${NAME}.spec"
RELEASE?=dev
VERSION?=0.1

GO?=go
GOPATH = $(CURDIR)/.gopath
BASE = $(GOPATH)/src/$(PACKAGE)

SOURCES := $(shell find $(SOURCEDIR) -name '*.go')

dist/$(PROG): $(SOURCES) | $(BASE)
	cd $(BASE) && GOPATH=$(GOPATH) $(GO) build -o $@

build: dist/$(PROG)

$(BASE):
	@mkdir -p $(dir $@)
	@ln -sf $(CURDIR) $@

.PHONY: clean
clean:
	rm -rf build dist RPMS SRPMS BUILDROOT pkg-build

install:
	 cp dist/${PROG} ${DESTDIR}/${PROG}

uninstall:
	 rm ${DESTDIR}/${PROG}

rpm:  build
	rpmbuild --define "_sourcedir $(SOURCEDIR)" \
	--define "_specdir $(PWD)" \
	--define "_builddir $(PWD)/build" \
	--define "release $(RELEASE)" \
	--define "version $(VERSION)" \
	--define "_rpmdir $(PWD)/RPMS" \
	--define "_topdir $(PWD)" \
	--define "dist $(DIST)" -bb $(SPECFILE)
