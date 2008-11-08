##################################################

PREFIX?=/usr/local
SYSCONFDIR?=${PREFIX}/etc
BINDIR?=${PREFIX}/bin
SBINDIR?=${PREFIX}/sbin
MANDIR?=${PREFIX}/man
LIBEXECDIR?=${PREFIX}/libexec/distbb
DATADIR?=${PREFIX}/share/distbb
EGDIR?=${PREFIX}/share/distbb

POD2MAN?=		pod2man
POD2HTML?=		pod2html

INST_DIR?=		${INSTALL} -d

# directory with distbb sources
SRCROOT?=		${.PARSEDIR}

##################################################

.include "Makefile.version"

SCRIPTS=	distbb stage_init stage_build stage_post_build \
		stage_gen_report stage_update_best stage_upload_logs \
		stage_upload_pkgs stage_report \
		slave distbb_diff upload_pkgs_all_files \
		upload_pkgs_built_total upload_pkgs_no_bin_on_cdrom

SCRIPTSDIR=			${LIBEXECDIR}
SCRIPTSDIR_distbb=		${BINDIR}
SCRIPTSDIR_distbb_diff=		${BINDIR}

FILES=				distbb.conf distbb.local.mk distbb.mk \
				common distbb.default.conf

FILESDIR=			${EGDIR}
FILESDIR_distbb.mk=		${DATADIR}
FILESDIR_distbb.default.conf=	${DATADIR}
FILESDIR_common=		${LIBEXECDIR}

MKMAN=			no

WARNS=			4

BIRTHDATE=		2008-03-03

PROJECTNAME=		distbb

.SUFFIXES:		.in

# the following is necessary because bsd.file.mk
# is broken in pkgsrc (NetBSD pkg/39715)
all: distbb.conf common distbb.mk distbb.local.mk \
     upload_pkgs_all_files upload_pkgs_built_total \
     upload_pkgs_no_bin_on_cdrom

.in:
	sed -e 's,@@sysconfdir@@,${SYSCONFDIR},g' \
	    -e 's,@@libexecdir@@,${LIBEXECDIR},g' \
	    -e 's,@@prefix@@,${PREFIX},g' \
	    -e 's,@@bindir@@,${BINDIR},g' \
	    -e 's,@@sbindir@@,${SBINDIR},g' \
	    -e 's,@@datadir@@,${DATADIR},g' \
	    -e 's,@@version@@,${VERSION},g' \
	    ${.ALLSRC} > ${.TARGET}

distbb.1 : distbb.pod
	$(POD2MAN) -s 1 -r 'DISTributed Bulk Builder' -n distbb \
	   -c 'DISTBB manual page' ${.ALLSRC} > ${.TARGET}
distbb.html : distbb.pod
	$(POD2HTML) --infile=${.ALLSRC} --outfile=${.TARGET}

.PHONY: clean-my
clean: clean-my
clean-my:
	rm -f *~ core* distbb.1 distbb.cat1 ChangeLog
	rm -f ${SCRIPTS} ${FILES}
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

.include <bsd.prog.mk>
