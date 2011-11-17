Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp5-g21.free.fr ([212.27.42.5]:33199 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab1KQHo5 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 17 Nov 2011 02:44:57 -0500
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 93C31D48402
	for <util-linux-ng@vger.kernel.org>; Thu, 17 Nov 2011 08:44:50 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 0C9F46013B
	for <util-linux-ng@vger.kernel.org>; Thu, 17 Nov 2011 08:44:49 +0100 (CET)
From: Jim Meyering <jim@meyering.net>
To: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: [PATCH] doc: prlimit.c, prlimit.1: s/amount/number/
Date: Thu, 17 Nov 2011 08:44:48 +0100
Message-ID: <87aa7v42hb.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


---
"amount" is appropriate only for CPU time.
For all of the others, "number" is the right word.
This also removed a trailing space in the very first hunk.

 sys-utils/prlimit.1 |   18 +++++++++---------
 sys-utils/prlimit.c |   10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index cc40ac4..2201655 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -23,7 +23,7 @@ infinity limit (RLIM_INFINITY), the -1 or 'unlimited' string can be passed.

 Because of the nature of limits, the soft value must be lower or equal to the
 high limit. To see all the available resource limits, refer to the RESOURCE
-OPTIONS section. 
+OPTIONS section.

 .IP "\fB<soft>:<hard>\fP  Specify both limits"
 .IP "\fB<soft>:\fP        Specify only the soft limit"
@@ -57,15 +57,15 @@ Maximum nice priority allowed to raise.
 .IP "\fB\-f, \-\-fsize\fP[=limits]"
 Maximum file size.
 .IP "\fB\-i, \-\-sigpending\fP[=limits]"
-Maximum amount of pending signals.
+Maximum number of pending signals.
 .IP "\fB\-l, \-\-memlock\fP[=limits]"
 Maximum locked-in-memory address space.
 .IP "\fB\-m, \-\-rss\fP[=limits]"
 Maximum Resident Set Size (RSS).
 .IP "\fB\-n, \-\-nofile\fP[=limits]"
-Maximum amount of open files.
+Maximum number of open files.
 .IP "\fB\-q, \-\-msgqueue\fP[=limits]"
-Maximum amount of bytes in POSIX message queues.
+Maximum number of bytes in POSIX message queues.
 .IP "\fB\-r, \-\-rtprio\fP[=limits]"
 Maximum real-time priority.
 .IP "\fB\-s, \-\-stack\fP[=limits]"
@@ -73,11 +73,11 @@ Maximum size of the stack.
 .IP "\fB\-t, \-\-cpu\fP[=limits]"
 CPU time, in seconds.
 .IP "\fB\-u, \-\-nproc\fP[=limits]"
-Maximum amount of processes.
+Maximum number of processes.
 .IP "\fB\-v, \-\-as\fP[=limits]"
 Address space limit.
 .IP "\fB\-x, \-\-locks\fP[=limits]"
-Maximum amount of file locks held.
+Maximum number of file locks held.
 .IP "\fB\-y, \-\-rttime\fP[=limits]"
 Timeout for real-time tasks.

@@ -86,12 +86,12 @@ Timeout for real-time tasks.
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.
 .IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
-Display the limits of the RSS and set the soft and hard limits for the amount
+Display the limits of the RSS and set the soft and hard limits for the number
 of open files to 1024 and 4095, respectively.
 .IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
-Modify only the soft limit for the amount of processes.
+Modify only the soft limit for the number of processes.
 .IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
-Set the amount of processes for both soft and ceiling values to unlimited.
+Set the number of processes for both soft and ceiling values to unlimited.

 .SH "SEE ALSO"
 .BR prlimit (2),
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index bcbfb5a..31fad76 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -71,16 +71,16 @@ static struct prlimit_desc prlimit_desc[] =
 	[CPU]        = { "CPU",        N_("CPU time"),                           N_("seconds"),   RLIMIT_CPU },
 	[DATA]       = { "DATA",       N_("max data size"),                      N_("bytes"),     RLIMIT_DATA },
 	[FSIZE]      = { "FSIZE",      N_("max file size"),                      N_("blocks"),    RLIMIT_FSIZE },
-	[LOCKS]      = { "LOCKS",      N_("max amount of file locks held"),      NULL,            RLIMIT_LOCKS },
+	[LOCKS]      = { "LOCKS",      N_("max number of file locks held"),      NULL,            RLIMIT_LOCKS },
 	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), N_("bytes"),     RLIMIT_MEMLOCK },
 	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         N_("bytes"),     RLIMIT_MSGQUEUE },
 	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     NULL,            RLIMIT_NICE },
-	[NOFILE]     = { "NOFILE",     N_("max amount of open files"),           NULL,            RLIMIT_NOFILE },
+	[NOFILE]     = { "NOFILE",     N_("max number of open files"),           NULL,            RLIMIT_NOFILE },
 	[NPROC]      = { "NPROC",      N_("max number of processes"),            NULL,            RLIMIT_NPROC },
 	[RSS]        = { "RSS",        N_("max resident set size"),              N_("pages"),     RLIMIT_RSS },
 	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             NULL,            RLIMIT_RTPRIO },
 	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        N_("microsecs"), RLIMIT_RTTIME },
-	[SIGPENDING] = { "SIGPENDING", N_("max amount of pending signals"),      NULL,            RLIMIT_SIGPENDING },
+	[SIGPENDING] = { "SIGPENDING", N_("max number of pending signals"),      NULL,            RLIMIT_SIGPENDING },
 	[STACK]      = { "STACK",      N_("max stack size"),                     N_("bytes"),     RLIMIT_STACK }
 };

@@ -168,10 +168,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" -d, --data             maximum size of a process's data segment\n"
 		" -e, --nice             maximum nice priority allowed to raise\n"
 		" -f, --fsize            maximum size of files written by the process\n"
-		" -i, --sigpending       maximum amount of pending signals\n"
+		" -i, --sigpending       maximum number of pending signals\n"
 		" -l, --memlock          maximum size a process may lock into memory\n"
 		" -m, --rss              maximum resident set size\n"
-		" -n, --nofile           maximum amount of open files\n"
+		" -n, --nofile           maximum number of open files\n"
 		" -q, --msgqueue         maximum bytes in POSIX message queues\n"
 		" -r, --rtprio           maximum real-time scheduling priority\n"
 		" -s, --stack            maximum stack size\n"
-- 
1.7.8.rc2
