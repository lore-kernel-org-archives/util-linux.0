Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:53644 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbaL2KRu (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:50 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/11] ipc*: use customary fputs() instead of fprintf() with the usage macros
Date: Mon, 29 Dec 2014 11:17:06 +0100
Message-Id: <1419848226-2533-10-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also use the clearer word <number> with the --semaphore option.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ipcmk.c |   11 ++++++-----
 sys-utils/ipcrm.c |   10 ++++++----
 sys-utils/ipcs.c  |   13 ++++++++-----
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index eae4935..ff768c7 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -62,7 +62,7 @@ static int create_sem(int nsems, int permission)
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fprintf(out, USAGE_HEADER);
+	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -70,14 +70,15 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -M, --shmem <size>       create shared memory segment of size <size>\n"), out);
-	fputs(_(" -S, --semaphore <nsems>  create semaphore array with <nsems> elements\n"), out);
+	fputs(_(" -S, --semaphore <number> create semaphore array with <number> elements\n"), out);
 	fputs(_(" -Q, --queue              create message queue\n"), out);
 	fputs(_(" -p, --mode <mode>        permission for the resource (default is 0644)\n"), out);
 
-	fprintf(out, USAGE_SEPARATOR);
-	fprintf(out, USAGE_HELP);
-	fprintf(out, USAGE_VERSION);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("ipcmk(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index a877f0c..85de05a 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -46,7 +46,7 @@ static int verbose = 0;
 /* print the usage */
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fprintf(out, USAGE_HEADER);
+	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"
 		       " %s shm|msg|sem <id>...\n"), program_invocation_short_name);
 
@@ -62,10 +62,12 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -S, --semaphore-key <key>  remove semaphore by key\n"), out);
 	fputs(_(" -a, --all[=shm|msg|sem]    remove all (in the specified category)\n"), out);
 	fputs(_(" -v, --verbose              explain what is being done\n"), out);
-	fprintf(out, USAGE_SEPARATOR);
-	fprintf(out, USAGE_HELP);
-	fprintf(out, USAGE_VERSION);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("ipcrm(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 6029451..74d8766 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -49,7 +49,7 @@ static void print_msg (int id, int unit);
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fprintf(out, USAGE_HEADER);
+	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %1$s [resource-option...] [output-option]\n"
 		       " %1$s -m|-q|-s -i <id>\n"), program_invocation_short_name);
 
@@ -58,15 +58,17 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -i, --id <id>  print details on resource identified by <id>\n"), out);
-	fprintf(out, USAGE_HELP);
-	fprintf(out, USAGE_VERSION);
-	fprintf(out, USAGE_SEPARATOR);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+
+	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Resource options:\n"), out);
 	fputs(_(" -m, --shmems      shared memory segments\n"), out);
 	fputs(_(" -q, --queues      message queues\n"), out);
 	fputs(_(" -s, --semaphores  semaphores\n"), out);
 	fputs(_(" -a, --all         all (default)\n"), out);
-	fprintf(out, USAGE_SEPARATOR);
+
+	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Output options:\n"), out);
 	fputs(_(" -t, --time        show attach, detach and change times\n"), out);
 	fputs(_(" -p, --pid         show PIDs of creator and last operator\n"), out);
@@ -76,6 +78,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("     --human       show sizes in human-readable format\n"), out);
 	fputs(_(" -b, --bytes       show sizes in bytes\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("ipcs(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
1.7.0.4

