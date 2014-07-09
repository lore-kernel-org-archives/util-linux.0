Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:57357 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbaGIN3W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 09:29:22 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] textual: fix the usage message of kill
Date: Wed,  9 Jul 2014 15:29:09 +0200
Message-Id: <1404912550-2573-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using angular brackets around each individual argument, indenting a
continuation line, not using a space before =, improving some wordings,
and the argument of --queue is a value (a piece of data), not a signal.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/kill.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 5d2f27d..f2362c3 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -303,17 +303,17 @@ static int arg_to_signum(char *arg, int maskbit)
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] <pid|name>...\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <pid>|<name>...\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all              do not restrict the name-to-pid conversion to processes\n"
-		"                        with the same uid as the present process\n"), out);
-	fputs(_(" -s, --signal <sig>     send specified signal\n"), out);
+		"                          with the same uid as the present process\n"), out);
+	fputs(_(" -s, --signal <signal>  send this <signal> instead of SIGTERM\n"), out);
 #ifdef HAVE_SIGQUEUE
-	fputs(_(" -q, --queue <sig>      use sigqueue(2) rather than kill(2)\n"), out);
+	fputs(_(" -q, --queue <value>    use sigqueue(2), not kill(2), and pass <value> as data\n"), out);
 #endif
 	fputs(_(" -p, --pid              print pids without signaling them\n"), out);
-	fputs(_(" -l, --list [=<signal>] list signal names, or convert one to a name\n"), out);
+	fputs(_(" -l, --list[=<signal>]  list signal names, or convert a signal number to a name\n"), out);
 	fputs(_(" -L, --table            list signal names and numbers\n"), out);
 	fputs(_("     --verbose          print pids that will be signaled\n"), out);
 
@@ -423,15 +423,15 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 		 * So it's probably something like -HUP, or -1/-n try to
 		 * deal with it.
 		 *
-		 * -n could be signal n, or pid -n (i.e., process group
-		 * number).  In case of doubt POSIX tells us to assume a
-		 * signal.  If a signal has been parsed, assume it is a
-		 * pid, break.  */
+		 * -n could be either signal n or pid -n (a process group
+		 * number).  In case of doubt, POSIX tells us to assume a
+		 * signal.  But if a signal has already been parsed, then
+		 * assume it is a process group, so stop parsing options. */
 		if (ctl->do_kill)
 			break;
 		arg++;
 		if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
-			errx(EXIT_FAILURE, _("invalid sigval argument"));
+			errx(EXIT_FAILURE, _("invalid signal name or number: %s"), arg);
 		ctl->do_kill = 1;
 		if (ctl->do_pid)
 			errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
-- 
1.7.0.4

