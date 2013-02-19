DESTDIR=
install:
	install -d ${DESTDIR}/{usr/bin,etc}
	install yais ${DESTDIR}/usr/bin/yais
	cp -a yais.d ${DESTDIR}/etc/
	sed -i ${DESTDIR}/usr/bin/yais -e 's/yais.d/\/etc\/yais.d/g' 

.PHONY: install

