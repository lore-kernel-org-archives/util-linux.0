Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59688 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUap (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:45 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so6204082obc.19
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/10] kill: move sigqueue inputs to control struct
Date: Sun,  9 Mar 2014 15:30:23 -0500
Message-Id: <1394397023-7050-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use of global variables is messy.  The earlier implementation also
assumed queue argument never to be textual, such as 'HUP', which now
works as one might expect.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index e5ec01e..40f354c 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -66,10 +66,14 @@ struct kill_control {
 	char *arg;
 	pid_t pid;
 	int numsig;
+#ifdef HAVE_SIGQUEUE
+	union sigval sigdata;
+#endif
 	unsigned int
 		check_all:1,
 		do_kill:1,
-		do_pid:1;
+		do_pid:1,
+		use_sigval:1;
 };
 
 struct signv {
@@ -163,10 +167,6 @@ static void printsignals(FILE *fp, int pretty);
 static void __attribute__((__noreturn__)) usage(FILE *out);
 static int kill_verbose(const struct kill_control *ctl);
 
-#ifdef HAVE_SIGQUEUE
-static int use_sigval;
-static union sigval sigdata;
-#endif
 
 int main(int argc, char **argv)
 {
@@ -289,18 +289,21 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 			}
 			continue;
 		}
+#ifdef HAVE_SIGQUEUE
 		if (!strcmp(arg, "-q") || !strcmp(arg, "--queue")) {
 			if (argc < 2)
 				errx(EXIT_FAILURE, _("option '%s' requires an argument"), arg);
 			argc--, argv++;
 			arg = *argv;
-#ifdef HAVE_SIGQUEUE
-			sigdata.sival_int =
-			    strtos32_or_err(arg, _("invalid sigval argument"));
-			use_sigval = 1;
-#endif
+			if ((ctl->numsig = arg_to_signum(arg, 0)) < 0) {
+				nosig(arg);
+				exit(EXIT_FAILURE);
+			}
+			ctl->sigdata.sival_int = ctl->numsig;
+			ctl->use_sigval = 1;
 			continue;
 		}
+#endif
 		/* 'arg' begins with a dash but is not a known option.
 		 * So it's probably something like -HUP, or -1/-n try to
 		 * deal with it.
@@ -467,7 +470,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -a, --all              do not restrict the name-to-pid conversion to processes\n"
 		"                        with the same uid as the present process\n"), out);
 	fputs(_(" -s, --signal <sig>     send specified signal\n"), out);
+#ifdef HAVE_SIGQUEUE
 	fputs(_(" -q, --queue <sig>      use sigqueue(2) rather than kill(2)\n"), out);
+#endif
 	fputs(_(" -p, --pid              print pids without signaling them\n"), out);
 	fputs(_(" -l, --list [=<signal>] list signal names, or convert one to a name\n"), out);
 	fputs(_(" -L, --table            list signal names and numbers\n"), out);
@@ -487,8 +492,8 @@ static int kill_verbose(const struct kill_control *ctl)
 		return 0;
 	}
 #ifdef HAVE_SIGQUEUE
-	if (use_sigval)
-		rc = sigqueue(ctl->pid, ctl->numsig, sigdata);
+	if (ctl->use_sigval)
+		rc = sigqueue(ctl->pid, ctl->numsig, ctl->sigdata);
 	else
 #endif
 		rc = kill(ctl->pid, ctl->numsig);
-- 
1.9.0

