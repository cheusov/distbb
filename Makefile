##################################################

LIBEXECDIR ?=			${PREFIX}/libexec/distbb
DATADIR ?=			${PREFIX}/share/distbb
EGDIR ?=			${PREFIX}/share/distbb
AWKMODDIR ?=			${PREFIX}/share/runawk
ICONDIR ?=			${DATADIR}
CSSDIR ?=			${DATADIR}

##################################################

.include "version.mk"

INSCRIPTS =	distbb stage_init stage_build \
		stage_checks \
		stage_gen_report_data stage_gen_report stage_update_best \
		stage_summary stage_checksum \
		stage_upload_logs stage_upload_pkgs \
		stage_send_report slave distbb_diff upload_pkgs_all_files \
		upload_pkgs_built_total upload_pkgs_no_bin_on_cdrom \
		upload_pkgs_no_bin_on_ftp make-depends \
		gen_queue gen_weights pkg_summary2build_deps \
		wrapper_unpriv wrapper distbb_chroot distbb_grep

INFILES =			distbb.conf distbb.local.mk distbb.mk \
				common distbb.default.conf

SCRIPTS=			${INSCRIPTS}
SCRIPTSDIR =			${LIBEXECDIR}
SCRIPTSDIR_distbb =		${BINDIR}
SCRIPTSDIR_distbb_diff =	${BINDIR}

FILES =				${INFILES} distbb.css distbb.ico distbb.awk

FILESDIR =			${EGDIR}
FILESDIR_distbb.mk =		${DATADIR}
FILESDIR_distbb.default.conf =	${DATADIR}
FILESDIR_distbb.ico =		${ICONDIR}
FILESDIR_distbb.css =		${CSSDIR}
FILESDIR_distbb.awk =		${AWKMODDIR}
FILESDIR_common =		${LIBEXECDIR}

BIRTHDATE =			2008-03-03

PROJECTNAME =			distbb

INTEXTS_REPLS +=    sysconfdir  ${SYSCONFDIR}
INTEXTS_REPLS +=    libexecdir  ${LIBEXECDIR}
INTEXTS_REPLS +=    root_libexecdir  ${PREFIX}/libexec
INTEXTS_REPLS +=    prefix      ${PREFIX}
INTEXTS_REPLS +=    bindir      ${BINDIR}
INTEXTS_REPLS +=    sbindir     ${SBINDIR}
INTEXTS_REPLS +=    datadir     ${DATADIR}
INTEXTS_REPLS +=    icondir     ${ICONDIR}
INTEXTS_REPLS +=    cssdir      ${CSSDIR}
INTEXTS_REPLS +=    version     ${VERSION}

CLEANFILES += *~ core* distbb.1 distbb.cat1 ChangeLog
CLEANFILES += ${INSCRIPTS} ${INFILES} distbb.html

##################################################

.include <mkc.prog.mk>
