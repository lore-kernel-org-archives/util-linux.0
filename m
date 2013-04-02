Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51598 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762152Ab3DBTne (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:34 -0400
Received: by mail-wg0-f54.google.com with SMTP id a12so885660wgh.9
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/13] chrt: make command syntax easier to understand in usage()
Date: Tue,  2 Apr 2013 20:42:56 +0100
Message-Id: <1364931777-2645-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And mention in manual that the default is referring to the internal
default of this command, not the Linux system default.  Manual page
example also tries to be a little more complete how to use the command.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 schedutils/chrt.1 | 11 ++++++++---
 schedutils/chrt.c |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index b85717b..50aa841 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -91,8 +91,10 @@ Operate on an existing PID and do not launch a new task.
 .TP
 .B -r, --rr
 Set scheduling policy to
-.BR SCHED_RR
-(the default).
+.BR SCHED_RR .
+When policy is not defined the
+.B SCHED_RR
+is used as default.
 .TP
 .B -R, --reset-on-fork
 Add
@@ -123,7 +125,7 @@ You can also retrieve the real-time attributes of an existing task:
 .I pid
 .TP
 Or set them:
-.B chrt \-p
+.B chrt \-r \-p
 .I prio pid
 .SH PERMISSIONS
 A user must possess
@@ -138,6 +140,9 @@ and
 .BR SCHED_RR
 are part of POSIX 1003.1b Process Scheduling. The other scheduling attributes
 may be ignored on some systems.
+.P
+Linux default scheduling policy is
+.BR SCHED_OTHER .
 .SH AUTHOR
 Written by Robert M. Love.
 .SH COPYRIGHT
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 60ec73e..20df6fa 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -62,9 +62,9 @@ static void __attribute__((__noreturn__)) show_usage(int rc)
 	fprintf(out, _(
 	"\nchrt - manipulate real-time attributes of a process\n"
 	"\nSet policy:\n"
-	"  chrt [options] <policy> <priority> {<pid> | <command> [<arg> ...]}\n"
+	"  chrt [options] [-policy] <priority> [-p <pid> | <command> <arg> ...]\n"
 	"\nGet policy:\n"
-	"  chrt [options] {<pid> | <command> [<arg> ...]}\n"));
+	"  chrt [options] -p <pid>\n"));
 
 	fprintf(out, _(
 	"\nScheduling policies:\n"
-- 
1.8.2

