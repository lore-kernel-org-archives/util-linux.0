Return-Path: <SRS0=fzFR=OP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F445C04EB8
	for <util-linux@archiver.kernel.org>; Thu,  6 Dec 2018 11:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE520661
	for <util-linux@archiver.kernel.org>; Thu,  6 Dec 2018 11:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openfortress.nl header.i=rick@openfortress.nl header.b="NhHrjOL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDE520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openfortress.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbeLFLnR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:43:17 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:44193 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727832AbeLFLnR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Dec 2018 06:43:17 -0500
Received: from popmini.vanrein.org ([83.161.146.46])
        by smtp-cloud9.xs4all.net with ESMTP
        id Us3lg71knMlDTUs3mglbkg; Thu, 06 Dec 2018 12:43:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openfortress.nl; 
 i=rick@openfortress.nl; q=dns/txt; s=fame; t=1544096587; 
 h=message-id : date : from : mime-version : to : subject 
 : content-type : content-transfer-encoding : date : from 
 : subject; 
 bh=qBfEZDY8CA7wp+zBCr1JeBJQmT15y7ZAmC58PFMjmio=; 
 b=NhHrjOL97VUsoI+tC8ANkRxBuSxO9lG+8QUhk8s47tWYPEv8ROiqyS66
 TPLRj/b9B0c58ud9J/tkgK7kzApNNLjvHwMq6jIvoAvVHwjRNrmDWSkFec
 CF3U5WPaedddK7r96xLrRMdtR2ycvp6k9Ch5szmOHfUBH7pgU05wSQch0=
Received: by fame.vanrein.org (Postfix, from userid 1006)
        id 4AD78273B6; Thu,  6 Dec 2018 11:43:07 +0000 (UTC)
Received: from airhead.local (phantom.vanrein.org [83.161.146.46])
        by fame.vanrein.org (Postfix) with ESMTPA id 7B5D1273A4;
        Thu,  6 Dec 2018 11:43:03 +0000 (UTC)
Message-ID: <5C090B46.5090200@openfortress.nl>
Date:   Thu, 06 Dec 2018 12:43:02 +0100
From:   Rick van Rein <rick@openfortress.nl>
User-Agent: Postbox 3.0.11 (Macintosh/20140602)
MIME-Version: 1.0
To:     util-linux@vger.kernel.org
Subject: PATCH: script: Introduced a streaming output command
X-Enigmail-Version: 1.2.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.4
X-CMAE-Envelope: MS4wfCP63iAWpFKtFxuvlmvyC/zLaIJMXtKShl1SpsytmguSf9jwTJO6qeQnFDem2e1d1LFhMBbb15MCXqw/4uGtE4iI620/gvv+kG34a+QReMqZfnQnxDrJ
 h68+ccnbdS1mL8MfNfw159PsykpPcdF1B6yzZOG7/Ev+wArgSn08StF5hDcP2gIx4fu8fRVrNFzVZg==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Besides output to a file, this patch introduces commands for
interactive streaming, such as over a network connection.  A
default "scriptstream" command may be locally installed with
all the bells and whistles that make sense locally.

Signed-off-by: Rick van Rein <rick@openfortress.nl>
---
diff --git a/AUTHORS b/AUTHORS
index d7dbbd6d5..84399e833 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -543,6 +543,7 @@ CONTRIBUTORS:
       Richard W.M. Jones <rjones@redhat.com>
       Richard Yann <yann.richard@uhb.fr>
       Richard Yao <ryao@gentoo.org>
+      Rick van Rein <rick@openfortress.nl>
       Rickard Faith <faith@cs.unc.edu>
       Rick Sladkey <jrs@world.std.com>
       Riku Voipio <riku.voipio@iki.fi>
diff --git a/term-utils/script.1 b/term-utils/script.1
index 0fb4c4fd7..2eb740d89 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -31,13 +31,18 @@
 .\"
 .\"	@(#)script.1	6.5 (Berkeley) 7/27/91
 .\"
-.TH SCRIPT "1" "June 2014" "util-linux" "User Commands"
+.TH SCRIPT "1" "December 2018" "util-linux" "User Commands"
 .SH NAME
 script \- make typescript of terminal session
 .SH SYNOPSIS
 .B script
 [options]
 .RI [ file ]
+.PP
+.B script
+[options]
+.RI [ cmd
+.RI [ args... ]]
 .SH DESCRIPTION
 .B script
 makes a typescript of everything displayed on your terminal.  It is
useful for
@@ -45,14 +50,31 @@ students who need a hardcopy record of an
interactive session as proof of an
 assignment, as the typescript file can be printed out later with
 .BR lpr (1).
 .PP
-If the argument
-.I file
-is given,
 .B script
-saves the dialogue in this
-.IR file .
-If no filename is given, the dialogue is saved in the file
+in its second form can stream its output to a command.  This is useful
to link
+to a variety of forms of sharing, including interactively through a command
+like
+.BR nc (1).
+.PP
+The first form is assumed when one or no
+.I file
+argument is supplied but no
+.I -s
+option.
+In this case, the dialogue is saved in
+.I file
+or, if this is not supplied, in the default output file
 .BR typescript .
+.PP
+The second form is assumed in the other cases,
+and the dialogue is then streamed to the standard input of
+.I cmd [args...]
+or, if this is not supplied, to the standard input of
+the default streaming command
+.BR scriptstream .
+Note that the default streaming command is not installed along with
+.BR script ,
+as it is intended to facilitate locally meaningful streaming options.
 .SH OPTIONS
 Below, the \fIsize\fR argument may be followed by the multiplicative
 suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB,
EiB, ZiB and YiB
@@ -65,6 +87,7 @@ Append the output to
 or to
 .BR typescript ,
 retaining the prior contents.
+This is ignored when streaming to a command.
 .TP
 \fB\-c\fR, \fB\-\-command\fR \fIcommand\fR
 Run the
@@ -82,6 +105,7 @@ the child process is always stored in type script
file too.
 Flush output after each write.  This is nice for telecooperation: one
person
 does `mkfifo foo; script -f foo', and another can supervise real-time
what is
 being done using `cat foo'.
+This behaviour is implied for output to a streaming command.
 .TP
 \fB\-\-force\fR
 Allow the default output destination, i.e. the typescript file, to be a
hard
@@ -99,6 +123,20 @@ Due to buffering, the resulting output file might be
larger than the specified v
 \fB\-q\fR, \fB\-\-quiet\fR
 Be quiet (do not write start and done messages to standard output).
 .TP
+\fB\-s\fR, \fB\-\-stream\fR
+Do not output to a file, but to a streaming command.  This option is
+implied when more than a single
+.I file
+is given, as that can only be meaningfully interpreted as the form
+.I cmd args...
+but the option must be specified when streaming to the form
+.I cmd
+or when no command is specified at all.  In the latter case, the
+default command
+.B scriptstream
+is started.  This command is not installed by default, but may be
+created to obtain locally useful default behaviour.
+.TP
 \fB\-t\fR[\fIfile\fR], \fB\-\-timing\fR[=\fIfile\fR]
 Output timing data to standard error, or to
 .I file
@@ -162,6 +200,29 @@ You should also avoid use of script in command
pipes, as
 .B script
 can read more input than you would expect.
 .PP
+An example of a
+.B scriptstream
+command that would stream information to a certain port on a
+certain server could be
+.RS
+.RE
+.sp
+.na
+.RS
+.nf
+#!/bin/sh
+#
+# /usr/local/bin/scriptstream -- used for "script -s"
+#
+nc -q0 2001:db8::1234 5678 | sed 's/$/\\r/'
+.fi
+.RE
+.ad
+.PP
+Note how
+.IR nc (1)
+is said to terminate when reading EOF, and line endings of
+any output is mapped from LF to CRLF.
 .SH ENVIRONMENT
 The following environment variable is utilized by
 .BR script :
diff --git a/term-utils/script.c b/term-utils/script.c
index 7692f91e2..7a74ee3c6 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -39,6 +39,9 @@
  *
  * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
  * - fixed a rare deadlock after child termination
+ *
+ * 2018-12-05 Rick van Rein <rick@openfortress.nl>
+ * - added streaming command as an output option
  */

 #include <stdio.h>
@@ -97,12 +100,16 @@ UL_DEBUG_DEFINE_MASKNAMES(script) =
UL_DEBUG_EMPTY_MASKNAMES;
 #endif

 #define DEFAULT_TYPESCRIPT_FILENAME "typescript"
+#define DEFAULT_TYPESCRIPT_COMMAND  "scriptstream"

 struct script_control {
 	char *shell;		/* shell to be executed */
 	char *command;		/* command to be executed */
 	char *fname;		/* output file path */
 	FILE *typescriptfp;	/* output file pointer */
+	int stream;		/* output to streaming command */
+	char **streamcmd;	/* streaming command */
+	char *minicmd [2];	/* storage for a mini streaming command */
 	char *tname;		/* timing file path */
 	FILE *timingfp;		/* timing file pointer */
 	uint64_t outsz;         /* current output file size */
@@ -112,7 +119,9 @@ struct script_control {
 	int slave;		/* pseudoterminal slave file descriptor */
 	int poll_timeout;	/* poll() timeout, used in end of execution */
 	pid_t child;		/* child pid */
+	pid_t streampid;	/* streaming process */
 	int childstatus;	/* child process exit value */
+	int streamstatus;	/* streaming process exit value */
 	struct termios attrs;	/* slave terminal runtime attributes */
 	struct winsize win;	/* terminal window size */
 #if !HAVE_LIBUTIL || !HAVE_PTY_H
@@ -161,7 +170,7 @@ static void __attribute__((__noreturn__)) usage(void)
 {
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] [file]\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] [file]\n %s [options] [cmd
[args...]]\n"), program_invocation_short_name,
program_invocation_short_name);

 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Make a typescript of a terminal session.\n"), out);
@@ -172,6 +181,7 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -e, --return                  return exit code of the child process\n"
 		" -f, --flush                   run flush after each write\n"
 		"     --force                   use output file even when it is a link\n"
+		" -s, --stream                  do not output to file but to a
streaming command\n"
 		" -o, --output-limit <size>     terminate if output files exceed size\n"
 		" -q, --quiet                   be quiet\n"
 		" -t[<file>], --timing[=<file>] output timing data to stderr or to
FILE\n"
@@ -313,15 +323,27 @@ static void __attribute__((__noreturn__))
fail(struct script_control *ctl)

 static void wait_for_child(struct script_control *ctl, int wait)
 {
-	int status;
-	pid_t pid;
 	int options = wait ? 0 : WNOHANG;

 	DBG(MISC, ul_debug("waiting for child"));

-	while ((pid = wait3(&status, options, NULL)) > 0)
-		if (pid == ctl->child)
-			ctl->childstatus = status;
+	waitpid(ctl->child, &ctl->childstatus, options);
+}
+
+static void wait_for_stream_cmd(struct script_control *ctl, int wait)
+{
+	int options = wait ? 0 : WNOHANG;
+
+	if (ctl->stream && ctl->typescriptfp) {
+		DBG(MISC, ul_debug("closing stream subcommand"));
+		fclose (ctl->typescriptfp);
+		ctl->typescriptfp = NULL;
+		kill(ctl->streampid, SIGTERM);
+	}
+
+	DBG(MISC, ul_debug("waiting for stream subcommand"));
+
+	waitpid(ctl->streampid, &ctl->streamstatus, options);
 }

 static void write_output(struct script_control *ctl, char *obuf,
@@ -483,6 +505,7 @@ static void handle_signal(struct script_control
*ctl, int fd)
 		    || info.ssi_code == CLD_KILLED
 		    || info.ssi_code == CLD_DUMPED) {
 			wait_for_child(ctl, 0);
+			wait_for_stream_cmd(ctl, 0);
 			ctl->poll_timeout = 10;

 		/* In case of ssi_code is CLD_TRAPPED, CLD_STOPPED, or CLD_CONTINUED */
@@ -519,6 +542,7 @@ static void handle_signal(struct script_control
*ctl, int fd)
 static void do_io(struct script_control *ctl)
 {
 	int ret, eof = 0;
+	int cmdio[2];
 	time_t tvec = script_time((time_t *)NULL);
 	enum {
 		POLLFD_SIGNAL = 0,
@@ -533,9 +557,33 @@ static void do_io(struct script_control *ctl)
 	};


-	if ((ctl->typescriptfp =
-	     fopen(ctl->fname, ctl->append ? "a" UL_CLOEXECSTR : "w"
UL_CLOEXECSTR)) == NULL) {
-
+	if (ctl->stream) {
+		if (pipe(cmdio) == -1) {
+			warn(_("pipe failed"));
+			fail(ctl);
+			exit(1);
+		}
+		ctl->streampid = fork();
+		switch (ctl->streampid) {
+		case -1: /* error */
+			warn(_("fork failed"));
+			fail(ctl);
+			exit(1);
+		case 0: /* child */
+			close(cmdio[1]);
+			dup2(cmdio[0],0);
+			execvp(ctl->streamcmd[0], ctl->streamcmd);
+			fprintf(stderr,_("streaming command failed: %s\r\n"),strerror(errno));
+			exit(1);
+			break;
+		default: /* parent */
+			close(cmdio[0]);
+			ctl->typescriptfp = fdopen(cmdio[1],"w");
+		}
+	} else {
+		ctl->typescriptfp = fopen(ctl->fname, ctl->append ? "a" UL_CLOEXECSTR
: "w" UL_CLOEXECSTR);
+	}
+	if (ctl->typescriptfp == NULL) {
 		restore_tty(ctl, TCSANOW);
 		warn(_("cannot open %s"), ctl->fname);
 		fail(ctl);
@@ -622,6 +670,9 @@ static void do_io(struct script_control *ctl)
 		wait_for_child(ctl, 1);

 	done(ctl);
+
+	if (ctl->stream)
+		wait_for_stream_cmd(ctl, 1);
 }

 static void getslave(struct script_control *ctl)
@@ -775,6 +826,7 @@ int main(int argc, char **argv)
 		{"flush", no_argument, NULL, 'f'},
 		{"force", no_argument, NULL, FORCE_OPTION,},
 		{"output-limit", required_argument, NULL, 'o'},
+		{"stream", no_argument, NULL, 's'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"timing", optional_argument, NULL, 't'},
 		{"version", no_argument, NULL, 'V'},
@@ -797,7 +849,7 @@ int main(int argc, char **argv)

 	script_init_debug();

-	while ((ch = getopt_long(argc, argv, "ac:efo:qt::Vh", longopts, NULL))
!= -1)
+	while ((ch = getopt_long(argc, argv, "ac:efo:sqt::Vh", longopts,
NULL)) != -1)
 		switch (ch) {
 		case 'a':
 			ctl.append = 1;
@@ -817,6 +869,10 @@ int main(int argc, char **argv)
 		case 'o':
 			ctl.maxsz = strtosize_or_err(optarg, _("failed to parse output limit
size"));
 			break;
+		case 's':
+			ctl.stream = 1;
+			ctl.flush = 1;
+			break;
 		case 'q':
 			ctl.quiet = 1;
 			break;
@@ -837,12 +893,32 @@ int main(int argc, char **argv)
 		}
 	argc -= optind;
 	argv += optind;
-
-	if (argc > 0)
-		ctl.fname = argv[0];
-	else {
-		ctl.fname = DEFAULT_TYPESCRIPT_FILENAME;
-		die_if_link(&ctl);
+	assert (argv [argc] == NULL);
+
+	/* streaming may be ordered with option --stream or with argc > 1 */
+	if (argc == 0) {
+		if (ctl.stream) {
+			ctl.minicmd[0] = DEFAULT_TYPESCRIPT_COMMAND;
+			ctl.minicmd[1] = NULL;
+			ctl.streamcmd = &ctl.minicmd[0];
+		} else {
+			/* No default implementation to make this pluggable */
+			ctl.fname = DEFAULT_TYPESCRIPT_FILENAME;
+			die_if_link(&ctl);
+		}
+	} else if (argc == 1) {
+		if (ctl.stream) {
+			ctl.minicmd[0] = argv[0];
+			ctl.minicmd[1] = NULL;
+			ctl.streamcmd = &ctl.minicmd[0];
+		} else {
+			ctl.fname = argv[0];
+		}
+	} else {
+		/* implicit streaming for more than 1 command argument */
+		ctl.streamcmd = argv;
+		ctl.stream = 1;
+		ctl.flush = 1;
 	}

 	ctl.shell = getenv("SHELL");
@@ -850,8 +926,13 @@ int main(int argc, char **argv)
 		ctl.shell = _PATH_BSHELL;

 	getmaster(&ctl);
-	if (!ctl.quiet)
-		printf(_("Script started, file is %s\n"), ctl.fname);
+	if (!ctl.quiet) {
+		if (ctl.stream) {
+			printf(_("Script started, streaming command is %s\n"),
ctl.streamcmd[0]);
+		} else {
+			printf(_("Script started, file is %s\n"), ctl.fname);
+		}
+	}
 	enable_rawmode_tty(&ctl);

 #ifdef HAVE_LIBUTEMPTER
