Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44762 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934084AbaEKT07 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:26:59 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so3496206wib.12
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:26:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/12] cytune: remove from util-linux
Date: Sun, 11 May 2014 20:26:39 +0100
Message-Id: <1399836409-7769-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Assumption is there are not many who need this tool.  Whom ever they
might be the recommendation is to use the command from old util-linux
release.  Second reason to removal is difficulty to test hardware
specific command when none of the active project members does not seem to
have such.  Basically the command has reached dead end what comes to
maintainability of it.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore                                         |   1 -
 bash-completion/Makemodule.am                      |   4 -
 bash-completion/cytune                             |  41 --
 configure.ac                                       |   9 -
 sys-utils/Makemodule.am                            |   7 -
 sys-utils/cyclades.h                               |  16 -
 sys-utils/cytune.8                                 | 194 ---------
 sys-utils/cytune.c                                 | 461 ---------------------
 tests/expected/build-sys/config-all                |   1 -
 tests/expected/build-sys/config-all-devel          |   1 -
 tests/expected/build-sys/config-all-non-nls        |   1 -
 tests/expected/build-sys/config-audit              |   1 -
 tests/expected/build-sys/config-chfnsh-libuser     |   1 -
 tests/expected/build-sys/config-chfnsh-no-password |   1 -
 tests/expected/build-sys/config-chfnsh-pam         |   1 -
 tests/expected/build-sys/config-core               |   1 -
 tests/expected/build-sys/config-devel              |   1 -
 tests/expected/build-sys/config-devel-new-mount    |   1 -
 tests/expected/build-sys/config-devel-non-docs     |   1 -
 tests/expected/build-sys/config-non-libblkid       |   1 -
 tests/expected/build-sys/config-non-libmount       |   1 -
 tests/expected/build-sys/config-non-libs           |   1 -
 tests/expected/build-sys/config-non-libuuid        |   1 -
 tests/expected/build-sys/config-non-nls            |   1 -
 tests/expected/build-sys/config-selinux            |   1 -
 tests/expected/build-sys/config-slang              |   1 -
 tests/expected/build-sys/config-static             |   1 -
 27 files changed, 752 deletions(-)
 delete mode 100644 bash-completion/cytune
 delete mode 100644 sys-utils/cyclades.h
 delete mode 100644 sys-utils/cytune.8
 delete mode 100644 sys-utils/cytune.c

diff --git a/.gitignore b/.gitignore
index bafe258..968a089 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,7 +83,6 @@ update.log
 /colrm
 /column
 /ctrlaltdel
-/cytune
 /delpart
 /dmesg
 /eject
diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index aaf2737..0031aba 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -212,10 +212,6 @@ if BUILD_WDCTL
 dist_bashcompletion_DATA += \
 	bash-completion/wdctl
 endif
-if BUILD_CYTUNE
-dist_bashcompletion_DATA += \
-	bash-completion/cytune
-endif
 if LINUX
 dist_bashcompletion_DATA += \
 	bash-completion/blkdiscard \
diff --git a/bash-completion/cytune b/bash-completion/cytune
deleted file mode 100644
index f685c88..0000000
--- a/bash-completion/cytune
+++ /dev/null
@@ -1,41 +0,0 @@
-_cytune_module()
-{
-	local cur prev OPTS
-	COMPREPLY=()
-	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-s'|'--set-threshold'|'-S'|'--set-default-threshold'|'-t'|'--set-flush'|'-T'|'--set-default-flush')
-			COMPREPLY=( $(compgen -W "num" -- $cur) )
-			return 0
-			;;
-		'-i'|'--interval')
-			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
-			return 0
-			;;
-		'-h'|'--help'|'-V'|'--version')
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS="--set-threshold
-				--get-threshold
-				--set-default-threshold
-				--set-flush
-				--get-glush
-				--set-default-flush
-				--stats
-				--interval
-				--help
-				--version"
-			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
-			return 0
-			;;
-	esac
-	local IFS=$'\n'
-	compopt -o filenames
-	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/tty"}) )
-	return 0
-}
-complete -F _cytune_module cytune
diff --git a/configure.ac b/configure.ac
index bb469bb..c5a3ef5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -847,15 +847,6 @@ UL_REQUIRES_LINUX([losetup])
 AM_CONDITIONAL([BUILD_LOSETUP], [test "x$build_losetup" = xyes])
 
 
-AC_ARG_ENABLE([cytune],
-  AS_HELP_STRING([--disable-cytune], [do not build cytune]),
-  [], [enable_cytune=check]
-)
-UL_BUILD_INIT([cytune])
-UL_REQUIRES_LINUX([cytune])
-AM_CONDITIONAL([BUILD_CYTUNE], [test "x$build_cytune" = xyes])
-
-
 AC_ARG_ENABLE([fsck],
   AS_HELP_STRING([--disable-fsck], [do not build fsck]),
   [], [enable_fsck=check]
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index eb78176..9d69bc6 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -40,13 +40,6 @@ dist_man_MANS += sys-utils/tunelp.8
 tunelp_SOURCES = sys-utils/tunelp.c sys-utils/lp.h
 endif
 
-if BUILD_CYTUNE
-usrbin_exec_PROGRAMS += cytune
-dist_man_MANS += sys-utils/cytune.8
-cytune_SOURCES = sys-utils/cytune.c sys-utils/cyclades.h
-cytune_LDADD = $(LDADD) libcommon.la
-endif
-
 if BUILD_FSTRIM
 sbin_PROGRAMS += fstrim
 dist_man_MANS += sys-utils/fstrim.8
diff --git a/sys-utils/cyclades.h b/sys-utils/cyclades.h
deleted file mode 100644
index afcf600..0000000
--- a/sys-utils/cyclades.h
+++ /dev/null
@@ -1,16 +0,0 @@
-struct cyclades_monitor {
-        unsigned long           int_count;
-        unsigned long           char_count;
-        unsigned long           char_max;
-        unsigned long           char_last;
-};
-
-#define CYGETMON                0x435901
-#define CYGETTHRESH             0x435902
-#define CYSETTHRESH             0x435903
-#define CYGETDEFTHRESH          0x435904
-#define CYSETDEFTHRESH          0x435905
-#define CYGETTIMEOUT            0x435906
-#define CYSETTIMEOUT            0x435907
-#define CYGETDEFTIMEOUT         0x435908
-#define CYSETDEFTIMEOUT         0x435909
diff --git a/sys-utils/cytune.8 b/sys-utils/cytune.8
deleted file mode 100644
index 3bf7afc..0000000
--- a/sys-utils/cytune.8
+++ /dev/null
@@ -1,194 +0,0 @@
-.\" cytune.8 --
-.\" Created: Sat Mar  4 17:44:53 1995 by faith@cs.unc.edu
-.\" Update: Sat Mar  4 18:22:24 1995 by faith@cs.unc.edu
-.\" Update: Sun Mar  5 06:40:12 1995 by njs@scifi.emi.net
-.\" Copyright 1995 Rickard E. Faith (faith@cs.unc.edu)
-.\"
-.\" Permission is granted to make and distribute verbatim copies of this
-.\" manual provided the copyright notice and this permission notice are
-.\" preserved on all copies.
-.\"
-.\" Permission is granted to copy and distribute modified versions of this
-.\" manual under the conditions for verbatim copying, provided that the
-.\" entire resulting derived work is distributed under the terms of a
-.\" permission notice identical to this one
-.\"
-.\" Since the Linux kernel and libraries are constantly changing, this
-.\" manual page may be incorrect or out-of-date.  The author(s) assume no
-.\" responsibility for errors or omissions, or for damages resulting from
-.\" the use of the information contained herein.  The author(s) may not
-.\" have taken the same level of care in the production of this manual,
-.\" which is licensed free of charge, as they might when working
-.\" professionally.
-.\"
-.\" Formatted or processed versions of this manual, if unaccompanied by
-.\" the source, must acknowledge the copyright and authors of this work.
-.\" "
-.TH CYTUNE 8 "September 2011" "util-linux" "System Administration"
-.SH NAME
-cytune \- tune driver parameters for Cyclades-Z multiport serial card
-.SH SYNOPSIS
-.B cytune
-.RI [options] tty ...
-.SH DESCRIPTION
-.B cytune
-queries and modifies the interruption threshold for the Cyclades driver.
-Each serial line on a Cyclades card has a 12-byte FIFO for input (and another
-12-byte FIFO for output).  The "threshold" specifies how many input
-characters must be present in the FIFO before an interruption is raised.
-When a Cyclades tty is opened, this threshold is set to a default value based
-on baud rate:
-.sp
-.RS
-Baud        Threshold
-.sp
-50-4800            10
-.br
-9600                8
-.br
-19200               4
-.br
-38400               2
-.br
-57600-150000        1
-.RE
-.PP
-If the threshold is set too low, the large number of interruptions can load
-the machine and decrease overall system throughput.  If the threshold is set
-too high, the FIFO buffer can overflow, and characters will be lost.  Slower
-machines, however, may not be able to deal with the interrupt load, and will
-require that the threshold be adjusted upwards.
-.PP
-If the cyclades driver was compiled with
-.B ENABLE_MONITORING
-defined, the cytune command can be used with the
-.B \-q
-option to report interrupts over the monitoring interval and characters
-transferred over the monitoring interval.  It will also report the state of
-the FIFO.  The maximum number of characters in the FIFO when an interrupt
-occurred, the instantaneous count of characters in the FIFO, and how many
-characters are now in the FIFO are reported.  This output might look like
-this:
-.sp
-.RS
-/dev/cubC0: 830 ints, 9130 chars; fifo: 11 threshold, 11 max, 11 now
-.br
-   166.259866 interrupts/second, 1828.858521 characters/second
-.RE
-.PP
-This output indicates that for this monitoring period, the interrupts were
-always being handled within one character time, because
-.B max
-never rose above
-.BR threshold .
-This is good, and you can probably run this way, provided that a large number
-of samples come out this way.  You will lose characters if you overrun the
-FIFO, as the Cyclades hardware does not seem to support the RTS RS-232 signal
-line for hardware flow control from the DCE to the DTE.
-.PP
-In query mode
-.B cytune
-will produce a summary report when ended with a SIGINT or when the threshold
-or timeout is changed.
-.PP
-There may be a responsiveness vs. throughput tradeoff.  The Cyclades card, at
-the higher speeds, is capable of putting a very high interrupt load on the
-system.  This will reduce the amount of CPU time available for other tasks on
-your system.  However, the time it takes to respond to a single character may
-be increased if you increase the threshold.  This might be noticed by
-monitoring
-.BR ping (8)
-times on a SLIP link controlled by a Cyclades card.  If your SLIP link is
-generally used for interactive work such as
-.BR telnet (1),
-you may want to leave the threshold low, so that characters are responded to
-as quickly as possible.  If your SLIP link is generally used for file
-transfer, WWW, and the like, setting the FIFO to a high value is likely to
-reduce the load on your system while not significantly affecting throughput.
-Alternatively, see the
-.B \-t
-or
-.B \-T
-options to adjust the time that the cyclades waits before flushing its
-buffer.  Units are 5ms.
-.PP
-If you are running a mouse on a Cyclades port, it is likely that you would
-want to maintain the threshold and timeout at a low value.
-.PP
-.SH OPTIONS
-.TP
-\fB\-s\fR, \fB\-\-set\-threshold\fR \fIvalue\fR
-Set the current threshold to
-.I value
-characters.  Note that if the
-.I tty
-is not being held open by another process, the threshold will be reset on the
-next open.  Only values between 1 and 12, inclusive, are permitted.
-.TP
-\fB\-t\fR, \fB\-\-set\-flush\fR \fIvalue\fR
-Set the current flush timeout to
-.I value
-units.  Note that if the
-.I tty
-is not being held open by another process, the threshold will be reset on the
-next open.  Only values between 0 and 255, inclusive, are permitted.  Setting
-.I value
-to zero forces the default, currently 0x20 (160ms), but soon to be 0x02
-(10ms).  Units are 5 ms.
-.TP
-\fB\-g\fR, \fB\-\-get-threshold\fR
-Get the current threshold and flush timeout values.
-.TP
-\fB\-S\fR, \fB\-\-set\-default\-threshold\fR \fIvalue\fR
-Set the default threshold to
-.I value
-characters.  When the
-.I tty
-is next opened, this value will be used instead of the default.  Only values
-between 1 and 12, inclusive, are permitted.
-.TP
-\fB\-T\fR, \fB\-\-set\-default\-flush\fR \fIvalue\fR
-Set the default flush timeout to
-.I value
-units.  When the
-.I tty
-is next opened, this value will be used instead of the default.  If
-.I value
-is zero, then the value will default to 0x20 (160ms), soon to be 0x02
-(10ms).
-.TP
-\fB\-G\fR, \fB\-\-get-flush\fR
-Get the default threshold and flush timeout values.
-.TP
-\fB\-q\fR, \fB\-\-stats\fR
-Gather statistics about the
-.IR tty .
-The results are only valid if the Cyclades driver has been compiled with
-.B ENABLE_MONITORING
-defined.  This is probably not the default.
-.TP
-\fB\-i\fR, \fB\-\-interval\fR \fIinterval\fR
-Statistics will be gathered every
-.I interval
-seconds.
-.SH BUGS
-If you run two copies of
-.B cytune
-at the same time to report statistics about the same port, the 'ints', 'chars',
-and 'max' value will be reset and not reported correctly.
-.B cytune
-should prevent this, but does not.
-.\" .SH AUTHOR
-.\" Nick Simicich (njs@scifi.emi.net), with modifications by
-.\" Rik Faith (faith@cs.unc.edu)
-.SH FILES
-.I /dev/ttyC[0-8]
-.br
-.I /dev/cubC[0-8]
-.SH "SEE ALSO"
-.BR setserial (8)
-.SH AVAILABILITY
-The cytune command is part of the util-linux package and is available from
-.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-Linux Kernel Archive
-.UE .
diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
deleted file mode 100644
index 15529ff..0000000
--- a/sys-utils/cytune.c
+++ /dev/null
@@ -1,461 +0,0 @@
-/* cytune.c -- Tune Cyclades driver
- *
- * Copyright 1995 Nick Simicich (njs@scifi.emi.net)
- * Modifications by Rik Faith (faith@cs.unc.edu)
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. All advertising materials mentioning features or use of this software
- *    must display the following acknowledgement:
- *      This product includes software developed by the Nick Simicich
- * 4. Neither the name of the Nick Simicich nor the names of its contributors
- *    may be used to endorse or promote products derived from this software
- *    without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY NICK SIMICICH AND CONTRIBUTORS ``AS IS'' AND
- * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED.  IN NO EVENT SHALL NICK SIMICICH OR CONTRIBUTORS BE LIABLE
- * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
- * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
- * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
- * SUCH DAMAGE.
- */
- /*
-  * 1999-02-22 Arkadiusz Miśkiewicz <misiek@pld.ORG.PL>
-  * - added Native Language Support
-  * Sun Mar 21 1999 - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
-  * - fixed strerr(errno) in gettext calls
-  */
-
-#include <getopt.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/ioctl.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <signal.h>
-#include <termios.h>
-
-#include "c.h"
-#include "cyclades.h"
-#include "closestream.h"
-#include "strutils.h"
-
-#if 0
-# ifndef XMIT
-#  include <linux/version.h>
-#  if LINUX_VERSION_CODE > 66056
-#   define XMIT
-#  endif
-# endif
-#endif
-
-#include "xalloc.h"
-#include "nls.h"
-/* Until it gets put in the kernel, toggle by hand. */
-#undef XMIT
-
-struct cyclades_control {
-	struct cyclades_monitor c;
-	int cfile;
-	int maxmax;
-	double maxtran;
-	double maxxmit;
-	unsigned long threshold_value;
-	unsigned long timeout_value;
-};
-struct cyclades_control *cmon;
-int cmon_index;
-
-static int global_argc, global_optind;
-static char ***global_argv;
-
-#define mvtime(tvpto, tvpfrom)  (((tvpto)->tv_sec = (tvpfrom)->tv_sec),(tvpto)->tv_usec = (tvpfrom)->tv_usec)
-
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
-{
-	fprintf(out, USAGE_HEADER);
-	fprintf(out, _(" %s [options] <tty>...\n"), program_invocation_short_name);
-	fprintf(out, USAGE_OPTIONS);
-	fprintf(out, _(" -s, --set-threshold <num>          set interruption threshold value\n"));
-	fprintf(out, _(" -g, --get-threshold                display the current values\n"));
-	fprintf(out, _(" -S, --set-default-threshold <num>  set the default threshold value\n"));
-	fprintf(out, _(" -t, --set-flush <num>              set the flush timeout\n"));
-	fprintf(out, _(" -G, --get-flush                    display the default values\n"));
-	fprintf(out, _(" -T, --set-default-flush <num>      set the default flush timeout\n"));
-	fprintf(out, _(" -q, --stats                        display statistics about the tty\n"));
-	fprintf(out, _(" -i, --interval <seconds>           gather statistics every <seconds> interval\n"));
-	fprintf(out, USAGE_SEPARATOR);
-	fprintf(out, USAGE_HELP);
-	fprintf(out, USAGE_VERSION);
-	fprintf(out, USAGE_MAN_TAIL("cytune(8)"));
-
-	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
-}
-
-static inline double dtime(struct timeval *tvpnew, struct timeval *tvpold)
-{
-	double diff;
-	diff = (double)tvpnew->tv_sec - (double)tvpold->tv_sec;
-	diff += ((double)tvpnew->tv_usec - (double)tvpold->tv_usec) / 1000000;
-	return diff;
-}
-
-static void summary(int sig)
-{
-	struct cyclades_control *cc;
-	int argc, local_optind;
-	char **argv;
-	int i;
-
-	argc = global_argc;
-	argv = *global_argv;
-	local_optind = global_optind;
-
-	if (sig > 0) {
-		for (i = local_optind; i < argc; i++) {
-			cc = &cmon[cmon_index];
-			warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %d,\n"
-				"and the maximum transfer rate in characters/second was %f"),
-			      argv[i], cc->threshold_value, cc->maxmax,
-			      cc->maxtran);
-		}
-		exit(EXIT_SUCCESS);
-	}
-	cc = &cmon[cmon_index];
-	if (cc->threshold_value > 0 && sig != -1) {
-		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"
-			"and the maximum transfer rate in characters/second was %f"),
-		      argv[cmon_index + local_optind], cc->threshold_value,
-		      cc->timeout_value, cc->maxmax, cc->maxtran);
-	}
-	cc->maxmax = 0;
-	cc->maxtran = 0.0;
-	cc->threshold_value = 0;
-	cc->timeout_value = 0;
-}
-
-static void query_tty_stats(int argc, char **argv, int interval, int numfiles,
-		     unsigned long *threshold_value,
-		     unsigned long *timeout_value)
-{
-	struct cyclades_monitor cywork;
-	struct timeval lasttime, thistime;
-	struct timezone tz = { 0, 0 };
-	int i;
-	double diff;
-	double xfer_rate;
-#ifdef XMIT
-	double xmit_rate;
-#endif
-
-	cmon = xmalloc(sizeof(struct cyclades_control) * numfiles);
-
-	if (signal(SIGINT, summary) ||
-	    signal(SIGQUIT, summary) || signal(SIGTERM, summary))
-		err(EXIT_FAILURE, _("cannot set signal handler"));
-	if (gettimeofday(&lasttime, &tz))
-		err(EXIT_FAILURE, _("gettimeofday failed"));
-
-	for (i = optind; i < argc; i++) {
-		cmon_index = i - optind;
-		cmon[cmon_index].cfile = open(argv[i], O_RDONLY);
-		if (cmon[cmon_index].cfile == -1)
-			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-		if (ioctl
-		    (cmon[cmon_index].cfile, CYGETMON, &cmon[cmon_index].c))
-			err(EXIT_FAILURE, _("cannot issue CYGETMON on %s"),
-			    argv[i]);
-		summary(-1);
-		if (ioctl
-		    (cmon[cmon_index].cfile, CYGETTHRESH, &threshold_value))
-			err(EXIT_FAILURE, _("cannot get threshold for %s"),
-			    argv[i]);
-		if (ioctl(cmon[cmon_index].cfile, CYGETTIMEOUT, &timeout_value))
-			err(EXIT_FAILURE, _("cannot get timeout for %s"),
-			    argv[i]);
-	}
-	while (1) {
-		sleep(interval);
-
-		if (gettimeofday(&thistime, &tz))
-			err(EXIT_FAILURE, _("gettimeofday failed"));
-		diff = dtime(&thistime, &lasttime);
-		mvtime(&lasttime, &thistime);
-
-		for (i = optind; i < argc; i++) {
-			cmon_index = i - optind;
-			if (ioctl(cmon[cmon_index].cfile, CYGETMON, &cywork))
-				err(EXIT_FAILURE,
-				    _("cannot issue CYGETMON on %s"), argv[i]);
-			if (ioctl
-			    (cmon[cmon_index].cfile, CYGETTHRESH,
-			     &threshold_value))
-				err(EXIT_FAILURE,
-				    _("cannot get threshold for %s"), argv[i]);
-			if (ioctl
-			    (cmon[cmon_index].cfile, CYGETTIMEOUT,
-			     &timeout_value))
-				err(EXIT_FAILURE,
-				    _("cannot get timeout for %s"), argv[i]);
-
-			xfer_rate = cywork.char_count / diff;
-#ifdef XMIT
-			xmit_rate = cywork.send_count / diff;
-#endif
-			if ((*threshold_value) !=
-			    cmon[cmon_index].threshold_value
-			    || (*timeout_value) !=
-			    cmon[cmon_index].timeout_value) {
-				summary(-2);
-				/* Note that the summary must come before the
-				 * setting of threshold_value */
-				cmon[cmon_index].threshold_value =
-				    (*threshold_value);
-				cmon[cmon_index].timeout_value =
-				    (*timeout_value);
-			} else {
-				/* Don't record this first cycle after change */
-				if (xfer_rate > cmon[cmon_index].maxtran)
-					cmon[cmon_index].maxtran = xfer_rate;
-#ifdef XMIT
-				if (xmit_rate > cmon[cmon_index].maxxmit)
-					cmon[cmon_index].maxxmit = xmit_rate;
-#endif
-				if (cmon[cmon_index].maxmax < 0 ||
-				    cywork.char_max >
-				    (unsigned long)cmon[cmon_index].maxmax)
-					cmon[cmon_index].maxmax =
-					    cywork.char_max;
-			}
-
-#ifdef XMIT
-			printf(_("%s: %lu ints, %lu/%lu chars; fifo: %lu thresh, %lu tmout, "
-				 "%lu max, %lu now\n"), argv[i],
-			       cywork.int_count, cywork.char_count,
-			       cywork.send_count, *threshold_value,
-			       *timeout_value, cywork.char_max,
-			       cywork.char_last);
-			printf(_("   %f int/sec; %f rec, %f send (char/sec)\n"),
-			       cywork.int_count / diff, xfer_rate, xmit_rate);
-#else
-			printf(_("%s: %lu ints, %lu chars; fifo: %lu thresh, %lu tmout, "
-				 "%lu max, %lu now\n"), argv[i],
-			       cywork.int_count, cywork.char_count,
-			       *threshold_value, *timeout_value, cywork.char_max,
-			       cywork.char_last);
-			printf(_("   %f int/sec; %f rec (char/sec)\n"),
-			       cywork.int_count / diff, xfer_rate);
-#endif
-			memcpy(&cmon[cmon_index].c, &cywork,
-			       sizeof(struct cyclades_monitor));
-		}
-	}
-
-	free(cmon);
-	return;
-}
-
-int main(int argc, char **argv)
-{
-	int query = 0;
-	int interval = 1;
-	int set = 0;
-	int set_val = -1;
-	int get = 0;
-	int set_def = 0;
-	int set_def_val = -1;
-	int get_def = 0;
-	int set_time = 0;
-	int set_time_val = -1;
-	int set_def_time = 0;
-	int set_def_time_val = -1;
-	int errflg = 0;
-	int file;
-	int numfiles;
-	int i;
-	unsigned long threshold_value;
-	unsigned long timeout_value;
-
-	static const struct option longopts[] = {
-		{"set-threshold", required_argument, NULL, 's'},
-		{"get-threshold", no_argument, NULL, 'g'},
-		{"set-default-threshold", required_argument, NULL, 'S'},
-		{"set-flush", required_argument, NULL, 't'},
-		{"get-flush", no_argument, NULL, 'G'},
-		{"set-default-flush", required_argument, NULL, 'T'},
-		{"stats", no_argument, NULL, 'q'},
-		{"interval", required_argument, NULL, 'i'},
-		{"version", no_argument, NULL, 'V'},
-		{"help", no_argument, NULL, 'h'},
-		{NULL, 0, NULL, 0}
-	};
-
-	/* For signal routine. */
-	global_argc = argc;
-	global_argv = &argv;
-
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	while ((i =
-		getopt_long(argc, argv, "qs:S:t:T:gGi:Vh", longopts,
-			    NULL)) != -1) {
-		switch (i) {
-		case 'q':
-			query = 1;
-			break;
-		case 'i':
-			interval = strtou32_or_err(optarg,
-						_("Invalid interval value"));
-			if (interval < 1) {
-				warnx(_("Invalid interval value: %d"),
-				      interval);
-				errflg++;
-			}
-			break;
-		case 's':
-			++set;
-			set_val = strtou32_or_err(optarg, _("Invalid set value"));
-			if (set_val < 1 || 12 < set_val) {
-				warnx(_("Invalid set value: %d"), set_val);
-				errflg++;
-			}
-			break;
-		case 'S':
-			++set_def;
-			set_def_val = strtou32_or_err(optarg,
-						_("Invalid default value"));
-			if (set_def_val < 0 || 12 < set_def_val) {
-				warnx(_("Invalid default value: %d"),
-				      set_def_val);
-				errflg++;
-			}
-			break;
-		case 't':
-			++set_time;
-			set_time_val = strtou32_or_err(optarg,
-						_("Invalid set time value"));
-			if (set_time_val < 1 || 255 < set_time_val) {
-				warnx(_("Invalid set time value: %d"),
-				      set_time_val);
-				errflg++;
-			}
-			break;
-		case 'T':
-			++set_def_time;
-			set_def_time_val = strtou32_or_err(optarg,
-						_("Invalid default time value"));
-			if (set_def_time_val < 0 || 255 < set_def_time_val) {
-				warnx(_("Invalid default time value: %d"),
-				      set_def_time_val);
-				errflg++;
-			}
-			break;
-		case 'g':
-			++get;
-			break;
-		case 'G':
-			++get_def;
-			break;
-		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
-			return EXIT_SUCCESS;
-		case 'h':
-			usage(stdout);
-		default:
-			usage(stderr);
-		}
-	}
-	numfiles = argc - optind;
-
-	if (errflg
-	    || (numfiles == 0)
-	    || (!query && !set && !set_def && !get && !get_def && !set_time && !set_def_time)
-	    || (set && set_def)
-	    || (set_time && set_def_time)
-	    || (get && get_def))
-		usage(stderr);
-
-	/* For signal routine. */
-	global_optind = optind;
-
-	if (set || set_def) {
-		for (i = optind; i < argc; i++) {
-			file = open(argv[i], O_RDONLY);
-			if (file == -1)
-				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-			if (ioctl(file,
-				  set ? CYSETTHRESH : CYSETDEFTHRESH,
-				  set ? set_val : set_def_val))
-				err(EXIT_FAILURE,
-				    _("cannot set %s to threshold %d"), argv[i],
-				    set ? set_val : set_def_val);
-			close(file);
-		}
-	}
-	if (set_time || set_def_time) {
-		for (i = optind; i < argc; i++) {
-			file = open(argv[i], O_RDONLY);
-			if (file == -1)
-				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-			if (ioctl(file,
-				  set_time ? CYSETTIMEOUT : CYSETDEFTIMEOUT,
-				  set_time ? set_time_val : set_def_time_val))
-				err(EXIT_FAILURE,
-				    _("cannot set %s to time threshold %d"),
-				    argv[i],
-				    set_time ? set_time_val : set_def_time_val);
-			close(file);
-		}
-	}
-
-	if (get || get_def) {
-		for (i = optind; i < argc; i++) {
-			file = open(argv[i], O_RDONLY);
-			if (file == -1)
-				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-			if (ioctl
-			    (file, get ? CYGETTHRESH : CYGETDEFTHRESH,
-			     &threshold_value))
-				err(EXIT_FAILURE,
-				    _("cannot get threshold for %s"), argv[i]);
-			if (ioctl
-			    (file, get ? CYGETTIMEOUT : CYGETDEFTIMEOUT,
-			     &timeout_value))
-				err(EXIT_FAILURE,
-				    _("cannot get timeout for %s"), argv[i]);
-			close(file);
-			if (get)
-				printf(_("%s: %ld current threshold and %ld current timeout\n"),
-					argv[i], threshold_value, timeout_value);
-			else
-				printf(_("%s: %ld default threshold and %ld default timeout\n"),
-					argv[i], threshold_value, timeout_value);
-		}
-	}
-
-	if (!query)
-		return EXIT_SUCCESS;
-
-	query_tty_stats(argc, argv, interval, numfiles, &threshold_value, &timeout_value);
-
-	return EXIT_SUCCESS;
-}
diff --git a/tests/expected/build-sys/config-all b/tests/expected/build-sys/config-all
index 2b2a487..428490f 100644
--- a/tests/expected/build-sys/config-all
+++ b/tests/expected/build-sys/config-all
@@ -37,7 +37,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-all-devel b/tests/expected/build-sys/config-all-devel
index f3933aa..812777d 100644
--- a/tests/expected/build-sys/config-all-devel
+++ b/tests/expected/build-sys/config-all-devel
@@ -73,7 +73,6 @@ mountpoint:  libblkid libmount libselinux libsepol libuuid
 arch:  
 chcpu:  
 ctrlaltdel:  
-cytune:  
 dmesg:  
 fallocate:  
 flock:  
diff --git a/tests/expected/build-sys/config-all-non-nls b/tests/expected/build-sys/config-all-non-nls
index 2b2a487..428490f 100644
--- a/tests/expected/build-sys/config-all-non-nls
+++ b/tests/expected/build-sys/config-all-non-nls
@@ -37,7 +37,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-audit b/tests/expected/build-sys/config-audit
index 4f37b1c..cb623be 100644
--- a/tests/expected/build-sys/config-audit
+++ b/tests/expected/build-sys/config-audit
@@ -34,7 +34,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-chfnsh-libuser b/tests/expected/build-sys/config-chfnsh-libuser
index 4863257..6ac5e56 100644
--- a/tests/expected/build-sys/config-chfnsh-libuser
+++ b/tests/expected/build-sys/config-chfnsh-libuser
@@ -36,7 +36,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-chfnsh-no-password b/tests/expected/build-sys/config-chfnsh-no-password
index 09831b6..7d04805 100644
--- a/tests/expected/build-sys/config-chfnsh-no-password
+++ b/tests/expected/build-sys/config-chfnsh-no-password
@@ -36,7 +36,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-chfnsh-pam b/tests/expected/build-sys/config-chfnsh-pam
index ccf0728..5fa2be1 100644
--- a/tests/expected/build-sys/config-chfnsh-pam
+++ b/tests/expected/build-sys/config-chfnsh-pam
@@ -36,7 +36,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-core b/tests/expected/build-sys/config-core
index 1d14682..a0e6dd4 100644
--- a/tests/expected/build-sys/config-core
+++ b/tests/expected/build-sys/config-core
@@ -34,7 +34,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-devel b/tests/expected/build-sys/config-devel
index ef6c556..1d377d9 100644
--- a/tests/expected/build-sys/config-devel
+++ b/tests/expected/build-sys/config-devel
@@ -37,7 +37,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-devel-new-mount b/tests/expected/build-sys/config-devel-new-mount
index 121a3f6..d56be6c 100644
--- a/tests/expected/build-sys/config-devel-new-mount
+++ b/tests/expected/build-sys/config-devel-new-mount
@@ -75,7 +75,6 @@ umount:  libblkid libmount libselinux libsepol libuuid
 arch:  
 chcpu:  
 ctrlaltdel:  
-cytune:  
 dmesg:  
 fallocate:  
 flock:  
diff --git a/tests/expected/build-sys/config-devel-non-docs b/tests/expected/build-sys/config-devel-non-docs
index ef6c556..1d377d9 100644
--- a/tests/expected/build-sys/config-devel-non-docs
+++ b/tests/expected/build-sys/config-devel-non-docs
@@ -37,7 +37,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-non-libblkid b/tests/expected/build-sys/config-non-libblkid
index c284f08..fa9ce33 100644
--- a/tests/expected/build-sys/config-non-libblkid
+++ b/tests/expected/build-sys/config-non-libblkid
@@ -15,7 +15,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 dmesg:  librt 
 fallocate:  
 fdformat:  
diff --git a/tests/expected/build-sys/config-non-libmount b/tests/expected/build-sys/config-non-libmount
index 22e1f96..78e659f 100644
--- a/tests/expected/build-sys/config-non-libmount
+++ b/tests/expected/build-sys/config-non-libmount
@@ -22,7 +22,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-non-libs b/tests/expected/build-sys/config-non-libs
index 46cc7be..2aa4820 100644
--- a/tests/expected/build-sys/config-non-libs
+++ b/tests/expected/build-sys/config-non-libs
@@ -10,7 +10,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 dmesg:  librt 
 fallocate:  
 fdformat:  
diff --git a/tests/expected/build-sys/config-non-libuuid b/tests/expected/build-sys/config-non-libuuid
index 6279aa5..91fe340 100644
--- a/tests/expected/build-sys/config-non-libuuid
+++ b/tests/expected/build-sys/config-non-libuuid
@@ -30,7 +30,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-non-nls b/tests/expected/build-sys/config-non-nls
index 1d14682..a0e6dd4 100644
--- a/tests/expected/build-sys/config-non-nls
+++ b/tests/expected/build-sys/config-non-nls
@@ -34,7 +34,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-selinux b/tests/expected/build-sys/config-selinux
index c0faa85..c2644ab 100644
--- a/tests/expected/build-sys/config-selinux
+++ b/tests/expected/build-sys/config-selinux
@@ -34,7 +34,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-slang b/tests/expected/build-sys/config-slang
index 7baebb9..3636492 100644
--- a/tests/expected/build-sys/config-slang
+++ b/tests/expected/build-sys/config-slang
@@ -34,7 +34,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
diff --git a/tests/expected/build-sys/config-static b/tests/expected/build-sys/config-static
index 5b91300..ba2184a 100644
--- a/tests/expected/build-sys/config-static
+++ b/tests/expected/build-sys/config-static
@@ -35,7 +35,6 @@ colcrt:
 colrm:  
 column:  
 ctrlaltdel:  
-cytune:  
 delpart:  
 dmesg:  librt 
 fallocate:  
-- 
1.9.2

