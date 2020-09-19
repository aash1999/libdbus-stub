.POSIX:

PREFIX  = /usr/local
XCFLAGS = -std=c99 -O3 \
		  -Wall -Wextra -pedantic -Wmissing-prototypes -Wstrict-prototypes \
		  -Wno-unused-parameter -DDBUS_COMPILATION -I$(PWD) \
		  $(CFLAGS) $(CPPFLAGS)

OBJ = \
	  dbus/dbus-address.o

HDR = \
	  dbus/dbus-types.h \
	  dbus/dbus-errors.h \
	  dbus/dbus-macros.h \
	  dbus/dbus-address.h \
	  dbus/dbus.h

all: libdbus.so

.c.o:
	$(CC) $(XCFLAGS) -c -o $@ $<

libdbus.so: $(OBJ)
	$(CC) $(XCFLAGS) -o $@ $(OBJ) $(LDFLAGS) -shared -Wl,-soname,libdbus.so.1

$(OBJ): $(HDR)

install: libdbus.so
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	cp liddbus.* $(DESTDIR)$(PREFIX)/lib/

clean:
	rm -f libdbus.* $(OBJ)

.PHONY: all clean install
