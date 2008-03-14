##################################################

PREFIX?=/usr/local
SYSCONFDIR?=${PREFIX}/etc
BINDIR?=${PREFIX}/bin
MANDIR?=${PREFIX}/man
LIBEXECDIR?=${PREFIX}/libexec/distbb
EGDIR?=${PREFIX}/share/distbb

POD2MAN?=		pod2man
POD2HTML?=		pod2html

INST_DIR?=		${INSTALL} -d

# directory with distbb sources
SRCROOT?=		${.PARSEDIR}

##################################################

.include "Makefile.version"

SCRIPTS=			distbb distbb_slave distbb_upload_logs \
				distbb_upload_pkgs distbb_report \
				distbb_lock distbb_slave distbb_slave_test
SCRIPTSDIR_distbb_slave=	${LIBEXECDIR}
SCRIPTSDIR_distbb_slave_test=	${LIBEXECDIR}
SCRIPTSDIR_distbb_lock=		${LIBEXECDIR}

FILES=				distbb.conf distbb_common
FILESDIR=			${EGDIR}
FILESDIR_distbb_common=		${LIBEXECDIR}

MKMAN=			no

WARNS=			4

BIRTHDATE=		2008-12-31

PROJECTNAME=		distbb

.SUFFIXES:		.in

.in:
	sed -e 's,@@sysconfdir@@,${SYSCONFDIR},g' \
	    -e 's,@@libexecdir@@,${LIBEXECDIR},g' \
	    -e 's,@@prefix@@,${PREFIX},g' \
	    ${.ALLSRC} > ${.TARGET}

distbb.1 : distbb.pod
	$(POD2MAN) -s 1 -r 'AWK Wrapper' -n distbb \
	   -c 'DISTBB manual page' ${.ALLSRC} > ${.TARGET}
distbb.html : distbb.pod
	$(POD2HTML) --infile=${.ALLSRC} --outfile=${.TARGET}

.PHONY: clean-my
clean: clean-my
clean-my:
	rm -f *~ core* distbb.1 distbb.cat1 ChangeLog
	rm -rf ${SCRIPTS} ${FILES}
	rm -f distbb.html

##################################################
.PHONY: install-dirs
install-dirs:
	$(INST_DIR) ${DESTDIR}${BINDIR}
	$(INST_DIR) ${DESTDIR}${EGDIR}
	$(INST_DIR) ${DESTDIR}${LIBEXECDIR}
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
