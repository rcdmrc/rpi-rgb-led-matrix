# This toplevel Makefile compiles the library in the lib subdirectory.
# If you want to see how to integrate the library in your own projects, check
# out the sub-directories examples-api-use/ and utils/
RGB_LIBDIR=./lib
RGB_LIBRARY_NAME=rgbmatrix
RGB_LIBRARY=$(RGB_LIBDIR)/lib$(RGB_LIBRARY_NAME).a

INSTALL_PREFIX:=/usr/local

# Some language bindings.
PYTHON_LIB_DIR=bindings/python
CSHARP_LIB_DIR=bindings/c\#

all : $(RGB_LIBRARY)

$(RGB_LIBRARY): FORCE
	$(MAKE) -C $(RGB_LIBDIR)
	$(MAKE) -C examples-api-use

clean:
	$(MAKE) -C lib clean
	$(MAKE) -C utils clean
	$(MAKE) -C examples-api-use clean
	$(MAKE) -C $(PYTHON_LIB_DIR) clean

build-csharp:
	$(MAKE) -C $(CSHARP_LIB_DIR) nuget
	$(MAKE) -C $(CSHARP_LIB_DIR) build

build-python: $(RGB_LIBRARY)
	$(MAKE) -C $(PYTHON_LIB_DIR) build

install-python: build-python
	$(MAKE) -C $(PYTHON_LIB_DIR) install

install: $(RGB_LIBRARY)
	install -m 644 -Dv include/*.h -t $(INSTALL_PREFIX)/include
	install -m 644 -Dv lib/lib$(RGB_LIBRARY_NAME)* -t $(INSTALL_PREFIX)/lib

FORCE:
.PHONY: FORCE
