Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:50269 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab1KPQ5a (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2011 11:57:30 -0500
Message-ID: <4EC3EB77.2020000@bernhard-voelker.de>
Date: Wed, 16 Nov 2011 17:57:27 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] prlimit: add support for executing a command
Content-Type: multipart/mixed;
 boundary="------------040305020302070905060501"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040305020302070905060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As previously dicussed [1] here comes the patch for executing a command
(alternatively to setting limits for a running process via --pid).

[1] http://article.gmane.org/gmane.linux.utilities.util-linux-ng/5038,

Have fun,
Berny

--------------040305020302070905060501
Content-Type: text/x-patch;
 name="prlimit-exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="prlimit-exec.patch"

>From cd30ce6baa45fe9b58c50fea0caf3ab8bd81a066 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 16 Nov 2011 17:42:01 +0100
Subject: [PATCH] prlimit: add support for executing a command

prlimit.c: Alternatively to applying the limits to an existing process via the
--pid option, allow a command to be executed. Adapted usage() accordingly.

prlimit.1: mention new syntax.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 sys-utils/prlimit.1 |   14 +++++++++++++-
 sys-utils/prlimit.c |   17 +++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index cc40ac4..6b91214 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -9,12 +9,22 @@ get and set a process resource limits.
 .SH SYNOPSIS
 .B prlimit
 .RB [options]
-.RB [ \-\-{resource_name}[=limits] ]
+.RB [ \-\-{resource_name}[=limits]
+.RB [ \-\-pid\ PID]
+
+.B prlimit
+.RB [options]
+.RB [ \-\-{resource_name}[=limits]]
+.RB "command " [ argument ...]
 
 .SH DESCRIPTION
 Given a process id and one or more resources, \fBprlimit\fP tries to retrieve
 and/or modify the limits.
 
+When \fIcommand\fR is given,
+.B prlimit
+will run this command with the given arguments.
+
 The \fIlimits\fP format is composed by a soft and a hard (ceiling) value, separated
 by a semicolon (:), in order to modify the existing value(s). If no limits are
 used, \fBprlimit\fP will only display the current values. If one of the values
@@ -92,6 +102,8 @@ of open files to 1024 and 4095, respectively.
 Modify only the soft limit for the amount of processes.
 .IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
 Set the amount of processes for both soft and ceiling values to unlimited.
+.IP "\fBprlimit --cpu=10 sort -u hugefile\fP"
+Set the soft and hard CPU time limit and run 'sort'.
 
 .SH "SEE ALSO"
 .BR prlimit (2),
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index bcbfb5a..1d91909 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -152,7 +152,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 
 	fprintf(out,
-		_(" %s [options]\n"), program_invocation_short_name);
+		_(" %s [options] [-p PID]\n"), program_invocation_short_name);
+	fprintf(out,
+		_(" %s [options] COMMAND\n"), program_invocation_short_name);
 
 	fputs(_("\nGeneral Options:\n"), out);
 	fputs(_(" -p, --pid <pid>        process id\n"
@@ -521,7 +523,7 @@ int main(int argc, char **argv)
 	assert(MAX_RESOURCES == STACK + 1);
 
 	while((opt = getopt_long(argc, argv,
-				 "c::d::e::f::i::l::m::n::q::r::s::t::u::v::x::y::p:o:vVh",
+				 "+c::d::e::f::i::l::m::n::q::r::s::t::u::v::x::y::p:o:vVh",
 				 longopts, NULL)) != -1) {
 		switch(opt) {
 		case 'c':
@@ -608,8 +610,9 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
-	if (argc > optind)
-		usage(stderr);
+	if (argc > optind && pid)
+		errx(EXIT_FAILURE,
+			_("--pid option and COMMAND are mutually exclusive"));
 
 	if (!ncolumns) {
 		/* default columns */
@@ -632,6 +635,12 @@ int main(int argc, char **argv)
 
 	if (!list_empty(&lims))
 		show_limits(&lims, tt_flags);
+		
+	if (argc > optind) {
+		/* prlimit [options] COMMAND */			
+		execvp(argv[optind], &argv[optind]);
+		err(EXIT_FAILURE, _("executing %s failed"), argv[optind]);
+	}
 
 	return EXIT_SUCCESS;
 }
-- 
1.7.3.4


--------------040305020302070905060501--
