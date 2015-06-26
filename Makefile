PYTHON27_PREFIX=/usr
PYTHON27_HEADERS=$(PYTHON27_PREFIX)/include/python2.7
PYTHON27_LIBS=$(PYTHON27_PREFIX)/lib

XED_PREFIX=pin-2.14-71313-gcc.4.4.7-linux/extras/xed-ia32
# XED_PREFIX=pin-2.14-71313-gcc.4.4.7-linux/extras/xed-intel64
XED_HEADERS=$(XED_PREFIX)/include
XED_LIBS=$(XED_PREFIX)/lib

W=-Wall -Wextra \
    -Wno-unknown-warning \
    -Wno-unknown-warning-option \
    -Wno-unused-parameter \
    -Wno-old-style-declaration \
    -Wno-strict-aliasing

CFLAGS=-fPIC -O2 -I$(PYTHON27_HEADERS) -I$(XED_HEADERS) $(W) -ggdb
LDFLAGS=-L$(PYTHON27_LIBS) -lpython2.7 -L$(XED_LIBS) -lxed -shared

OBJS=check.o rflags.o operand.o instruction.o decoder.o encoder.o pyxed.o
BIN=pyxed.so

CC=cc

all: pyc $(OBJS)
	$(CC) $(OBJS) -o $(BIN) $(LDFLAGS)

.PHONY: clean
clean: pyc
	rm -fr $(OBJS) $(BIN) core *.core a.out *~

.PHONY: pyc
pyc:
	rm -fr *.pyc
