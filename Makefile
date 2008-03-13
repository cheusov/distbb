##################################################

PREFIX?=/usr/local
SYSCONFDIR?=${PREFIX}/etc
BINDIR?=${PREFIX}/bin
MANDIR?=${PREFIX}/man
EGDIR?=${PREFIX}/share/distbb

POD2MAN?=		pod2man
POD2HTML?=		pod2html

INST_DIR?=		${INSTALL} -d

# directory with distbb sources
SRCROOT?=		${.PARSEDIR}

##################################################

.include "Makefile.version"

SCRIPTS=		distbb distbb_slave
FILES=			distbb.conf

FILESDIR=		${EGDIR}

MKMAN=			no

WARNS=			4

BIRTHDATE=		2008-12-31

PROJECTNAME=		distbb

distbb: distbb.in
	sed 's,@@sysconfdir@@,${SYSCONFDIR},g' ${.ALLSRC} > ${.TARGET}
distbb_slave: distbb_slave.in
	sed 's,@@sysconfdir@@,${SYSCONFDIR},g' ${.ALLSRC} > ${.TARGET}

distbb.1 : distbb.pod
	$(POD2MAN) -s 1 -r 'AWK Wrapper' -n distbb \
	   -c 'DISTBB manual page' ${.ALLSRC} > ${.TARGET}
distbb.html : distbb.pod
	$(POD2HTML) --infile=${.ALLSRC} --outfile=${.TARGET}

.PHONY: clean-my
clean: clean-my
clean-my:
	rm -f *~ core* distbb.1 distbb.cat1 ChangeLog
	rm -f distbb.html

##################################################
.PHONY: install-dirs
install-dirs:
	$(INST_DIR) ${DESTDIR}${BINDIR}
	$(INST_DIR) ${DESTDIR}${EGDIR}
.if "$(MKMAN)" != "no"
	$(INST_DIR) ${DESTDIR}${MANDIR}/man1
.if "$(MKCATPAGES)" != "no"
	$(INST_DIR) ${DESTDIR}${MANDIR}/cat1
.endif
.endif

##################################################
.PATH : ${SRCROOT}

.sinclude "Makefile.cvsdist"

.include <bsd.prog.mk>
