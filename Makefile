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

SCRIPTS=		distbb distbb_slave distbb_upload_logs \
			distbb_upload_pkgs distbb_report

FILES=			distbb.conf distbb_common.sh

FILESDIR=			${EGDIR}
FILESDIR_distbb_common.sh=	${LIBEXECDIR}

MKMAN=			no

WARNS=			4

BIRTHDATE=		2008-12-31

PROJECTNAME=		distbb

distbb: distbb.in
	sed 's,@@sysconfdir@@,${SYSCONFDIR},g' ${.ALLSRC} > ${.TARGET}
distbb_slave: distbb_slave.in
	sed 's,@@sysconfdir@@,${SYSCONFDIR},g' ${.ALLSRC} > ${.TARGET}
distbb_upload_logs: distbb_upload_logs.in
	sed 's,@@sysconfdir@@,${SYSCONFDIR},g' ${.ALLSRC} > ${.TARGET}
distbb_upload_pkgs: distbb_upload_pkgs.in
	sed 's,@@sysconfdir@@,${SYSCONFDIR},g' ${.ALLSRC} > ${.TARGET}
distbb_report: distbb_report.in
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
