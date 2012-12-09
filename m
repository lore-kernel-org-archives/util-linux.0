Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34081 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759012Ab2LIVJv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Dec 2012 16:09:51 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so842263wib.1
        for <util-linux@vger.kernel.org>; Sun, 09 Dec 2012 13:09:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] ipcs: add --bytes size output option
Date: Sun,  9 Dec 2012 21:08:36 +0000
Message-Id: <1355087316-12422-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
References: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes the command being a little closer standard compliant.  See
IEEE Std 1003.1 referral link below for more information.

References: http://pubs.opengroup.org/onlinepubs/009696799/utilities/ipcs.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 9fe24ac..4b0c51c 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -45,7 +45,8 @@ enum {
 
 enum {
 	UNIT_DEFAULT,
-	UNIT_HUMAN
+	UNIT_HUMAN,
+	UNIT_BYTES
 };
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -71,6 +72,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -l, --limits      show resource limits\n"), out);
 	fputs(_(" -u, --summary     show status summary\n"), out);
 	fputs(_("     --human       show sizes in human readable format\n"), out);
+	fputs(_(" -b, --bytes       show sizes in bytes\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("ipcs(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -92,11 +94,12 @@ int main (int argc, char **argv)
 		{"limits", no_argument, NULL, 'l'},
 		{"summary", no_argument, NULL, 'u'},
 		{"human", no_argument, NULL, OPT_HUMAN},
+		{"bytes", no_argument, NULL, 'b'},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
-	char options[] = "i:mqsatpcluVh";
+	char options[] = "i:mqsatpclubVh";
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -139,6 +142,9 @@ int main (int argc, char **argv)
 		case OPT_HUMAN:
 			unit = UNIT_HUMAN;
 			break;
+		case 'b':
+			unit = UNIT_BYTES;
+			break;
 		case 'h':
 			usage(stdout);
 		case 'V':
@@ -200,6 +206,9 @@ static void do_shm (char format, int unit)
 			printf(_("max seg size = %s\n"),
 			       size_to_human_string(SIZE_SUFFIX_1LETTER,
 						    lim.shmmax));
+		else /* UNIT_BYTES */
+			printf(_("max seg size (bytes) = %ju\n"),
+			       lim.shmmax);
 		if (unit == UNIT_DEFAULT)
 			printf(_("max total shared memory (kbytes) = %ju\n"),
 			       (lim.shmall / 1024) * getpagesize());
@@ -208,7 +217,10 @@ static void do_shm (char format, int unit)
 			       size_to_human_string(SIZE_SUFFIX_1LETTER,
 						    lim.shmall *
 						    getpagesize()));
-		if (unit == UNIT_DEFAULT)
+		else /* UNIT_BYTES */
+			printf(_("max total shared memory (bytes) = %ju\n"),
+			       lim.shmall * getpagesize());
+		if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 			printf(_("min seg size (bytes) = %ju\n"), lim.shmmin);
 		else if (unit == UNIT_HUMAN)
 			printf(_("min seg size = %s\n"),
@@ -326,7 +338,7 @@ static void do_shm (char format, int unit)
 			else
 				printf ("%-10d %-10u", shmdsp->shm_perm.id, shmdsp->shm_perm.uid);
 			printf(" %-10o", shmdsp->shm_perm.mode & 0777);
-			if (unit == UNIT_DEFAULT)
+			if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 				printf(" %-10lu", shmdsp->shm_segsz);
 			else if (unit == UNIT_HUMAN)
 				printf(" %-10s",
@@ -460,14 +472,14 @@ static void do_msg (char format, int unit)
 			return;
 		printf (_("------ Messages Limits --------\n"));
 		printf (_("max queues system wide = %d\n"), lim.msgmni);
-		if (unit == UNIT_DEFAULT)
+		if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 			printf(_("max size of message (bytes) = %zu\n"),
 			       lim.msgmax);
 		else if (unit == UNIT_HUMAN)
 			printf(_("max size of message = %s\n"),
 			       size_to_human_string(SIZE_SUFFIX_1LETTER,
 						    lim.msgmax));
-		if (unit == UNIT_DEFAULT)
+		if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 			printf(_("default max size of queue (bytes) = %d\n"),
 			       lim.msgmnb);
 		else if (unit == UNIT_HUMAN)
@@ -485,13 +497,13 @@ static void do_msg (char format, int unit)
 		}
 		printf (_("------ Messages Status --------\n"));
 		printf (_("allocated queues = %d\n"), msginfo.msgpool);
-		if (unit == UNIT_DEFAULT)
+		if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 			printf(_("used headers = %d\n"), msginfo.msgmap);
 		else if (unit == UNIT_HUMAN)
 			printf(_("used headers = %s\n"),
 			       size_to_human_string(SIZE_SUFFIX_1LETTER,
 						    msginfo.msgmap));
-		if (unit == UNIT_DEFAULT)
+		if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 			printf(_("used space = %d bytes\n"), msginfo.msgtql);
 		else if (unit == UNIT_HUMAN)
 			printf(_("used space = %s\n"),
@@ -568,7 +580,7 @@ static void do_msg (char format, int unit)
 			else
 				printf ("%-10d %-10u", msgdsp->msg_perm.id, msgdsp->msg_perm.uid);
 			printf(" %-10o", msgdsp->msg_perm.mode & 0777);
-			if (unit == UNIT_DEFAULT)
+			if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 				printf(" %-12ld", msgdsp->q_cbytes);
 			else if (unit == UNIT_HUMAN)
 				printf(" %-12s",
@@ -598,7 +610,7 @@ static void print_shm(int shmid, int unit)
 	       shmdata->shm_perm.cuid, shmdata->shm_perm.cgid);
 	printf(_("mode=%#o\taccess_perms=%#o\n"), shmdata->shm_perm.mode,
 	       shmdata->shm_perm.mode & 0777);
-	if (unit == UNIT_DEFAULT)
+	if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 		printf(_("bytes=%ju\t"), shmdata->shm_segsz);
 	else if (unit == UNIT_HUMAN)
 		printf(_("size=%s\t"),
@@ -632,7 +644,7 @@ void print_msg(int msgid, int unit)
 	       msgdata->msg_perm.uid, msgdata->msg_perm.uid,
 	       msgdata->msg_perm.cuid, msgdata->msg_perm.cgid,
 	       msgdata->msg_perm.mode);
-	if (unit == UNIT_DEFAULT)
+	if (unit == UNIT_DEFAULT || unit == UNIT_BYTES)
 		printf(_("cbytes=%jd\tqbytes=%jd"), msgdata->q_cbytes,
 		       msgdata->q_qbytes);
 	else if (unit == UNIT_HUMAN)
-- 
1.8.0.1

