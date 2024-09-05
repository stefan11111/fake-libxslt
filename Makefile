.POSIX:
XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -Wall -Wno-pedantic
XLDFLAGS = ${LDFLAGS} -shared -Wl
LIBDIR = /lib64

all:
	${CC} ${XCFLAGS} libexslt.c -c -o libexslt.o
	${CC} ${XCFLAGS} libexslt.o -o libexslt.so.0 ${XLDFLAGS},-soname,libexslt.so.0
	${CC} ${XCFLAGS} libxslt.c -c -o libxslt.o
	${CC} ${XCFLAGS} libxslt.o -o libxslt.so.1 ${XLDFLAGS},-soname,libxslt.so.1
	sed -e 's/__libdir__/usr\/\${LIBDIR}/g' libexslt.pc.in > libexslt.pc
	sed -e 's/__libdir__/usr\/\${LIBDIR}/g' libxslt.pc.in > libxslt.pc

install:
	LIBDIR = "/usr${LIBDIR}"
	mkdir -p ${DESTDIR}/usr/bin
	touch ${DESTDIR}/usr/bin/xsltproc
	chmod 755 ${DESTDIR}/usr/bin/xsltproc
	touch ${DESTDIR}/usr/bin/xslt-config
	chmod 755 ${DESTDIR}/usr/bin/xslt-config
	mkdir -p ${DESTDIR}/usr/include/libexslt
	cp -f exslt.h ${DESTDIR}/usr/include/libexslt/exslt.h
	touch ${DESTDIR}/usr/include/libexslt/exsltconfig.h
	touch ${DESTDIR}/usr/include/libexslt/exsltexports.h
	mkdir -p ${DESTDIR}/usr/include/libxslt
	cp -f xslt.h ${DESTDIR}/usr/include/libxslt/xslt.h
	mkdir -p ${DESTDIR}/usr/share/aclocal
	cp -f libxslt.m4 ${DESTDIR}/usr/share/aclocal/libxslt.m4
	mkdir -p ${DESTDIR}${LIBDIR}/pkgconfig
	cp -f libexslt.pc ${DESTDIR}${LIBDIR}/pkgconfig/libexslt.pc
	cp -f libxslt.pc ${DESTDIR}${LIBDIR}/pkgconfig/libxslt.pc
	mkdir -p ${DESTDIR}${LIBDIR}/cmake
	cp -rf libxslt ${DESTDIR}${LIBDIR}/cmake/libxslt
	mkdir -p ${DESTDIR}/usr/include/x86_64-pc-linux-gnu/libxslt
	cp -f xsltconfig.h ${DESTDIR}/usr/include/x86_64-pc-linux-gnu/libxslt/xsltconfig.h
	touch ${DESTDIR}${LIBDIR}/xsltConf.sh
	chmod 755 ${DESTDIR}${LIBDIR}/xsltConf.sh
	cp -f libexslt.so.0 ${DESTDIR}${LIBDIR}/libexslt.so.0
	ln -rsf ${DESTDIR}${LIBDIR}/libexslt.so.0 ${DESTDIR}${LIBDIR}/libexslt.so
	cp -f libxslt.so.0 ${DESTDIR}${LIBDIR}/libxslt.so.0
	ln -rsf ${DESTDIR}${LIBDIR}/libxslt.so.0 ${DESTDIR}${LIBDIR}/libxslt.so

uninstall:
	rm -f ${DESTDIR}/usr/bin/xsltproc
	rm -f ${DESTDIR}/usr/bin/xslt-config
	rm -f ${DESTDIR}/usr/include/libexslt
	rm -f ${DESTDIR}/usr/include/libxslt
	rm -f ${DESTDIR}/usr/share/aclocal/libxslt.m4
	rm -f ${DESTDIR}${LIBDIR}/pkgconfig/libexslt.pc
	rm -f ${DESTDIR}${LIBDIR}/pkgconfig/libxslt.pc
	rm -f ${DESTDIR}${LIBDIR}/cmake/libxslt
	rm -f ${DESTDIR}/usr/include/x86_64-pc-linux-gnu/libxslt/xsltconfig.h
	rm -f ${DESTDIR}${LIBDIR}/xsltConf.sh
	rm -f ${DESTDIR}${LIBDIR}/libexslt.so.0
	rm -f ${DESTDIR}${LIBDIR}/libexslt.so
	rm -f ${DESTDIR}${LIBDIR}/libxslt.so.0
	rm -f ${DESTDIR}${LIBDIR}/libxslt.so

clean:
	rm -f libexslt.o libxslt.o libexslt.so.0 libxslt.so.1 libexslt.pc libxslt.pc

.PHONY: all clean install uninstall
