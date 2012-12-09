Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34889 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759009Ab2LIVJq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Dec 2012 16:09:46 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so857405wib.1
        for <util-linux@vger.kernel.org>; Sun, 09 Dec 2012 13:09:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] ipcs: add --human readable size conversion option
Date: Sun,  9 Dec 2012 21:08:34 +0000
Message-Id: <1355087316-12422-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.1 |   3 ++
 sys-utils/ipcs.c | 155 ++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 121 insertions(+), 37 deletions(-)

diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 7c094c8..3c6b8c3 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -65,6 +65,9 @@ Show resource limits.
 .TP
 \fB\-u\fR, \fB\-\-summary\fR
 Show status summary.
+.TP
+.B \-\-human
+Show print sizes in human readable format (e.g., 1K 234M 2G).
 .SH SEE ALSO
 .BR ipcrm (1),
 .BR ipcmk (1),
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 6ef0bbe..9fe24ac 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -22,6 +22,7 @@
 #include "c.h"
 #include "nls.h"
 #include "closestream.h"
+#include "strutils.h"
 
 #include "ipcutils.h"
 
@@ -31,13 +32,21 @@
 #define TIME 4
 #define PID 5
 
-static void do_shm (char format);
-static void print_shm (int id);
+static void do_shm (char format, int unit);
+static void print_shm (int id, int unit);
 static void do_sem (char format);
 static void print_sem (int id);
-static void do_msg (char format);
+static void do_msg (char format, int unit);
+static void print_msg (int id, int unit);
 
-void print_msg (int id);
+enum {
+	OPT_HUMAN = CHAR_MAX + 1
+};
+
+enum {
+	UNIT_DEFAULT,
+	UNIT_HUMAN
+};
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -61,6 +70,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -c, --creator     show creator and owner\n"), out);
 	fputs(_(" -l, --limits      show resource limits\n"), out);
 	fputs(_(" -u, --summary     show status summary\n"), out);
+	fputs(_("     --human       show sizes in human readable format\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("ipcs(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -69,6 +79,7 @@ int main (int argc, char **argv)
 {
 	int opt, msg = 0, sem = 0, shm = 0, id=0, print=0;
 	char format = 0;
+	int unit = UNIT_DEFAULT;
 	static const struct option longopts[] = {
 		{"id", required_argument, NULL, 'i'},
 		{"shmems", no_argument, NULL, 'm'},
@@ -80,6 +91,7 @@ int main (int argc, char **argv)
 		{"creator", no_argument, NULL, 'c'},
 		{"limits", no_argument, NULL, 'l'},
 		{"summary", no_argument, NULL, 'u'},
+		{"human", no_argument, NULL, OPT_HUMAN},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -124,6 +136,9 @@ int main (int argc, char **argv)
 		case 'u':
 			format = STATUS;
 			break;
+		case OPT_HUMAN:
+			unit = UNIT_HUMAN;
+			break;
 		case 'h':
 			usage(stdout);
 		case 'V':
@@ -136,11 +151,11 @@ int main (int argc, char **argv)
 
 	if  (print) {
 		if (shm)
-			print_shm (id);
+			print_shm (id, unit);
 		if (sem)
 			print_sem (id);
 		if (msg)
-			print_msg (id);
+			print_msg (id, unit);
 		if (!shm && !sem && !msg )
 			usage (stderr);
 	} else {
@@ -149,7 +164,7 @@ int main (int argc, char **argv)
 		printf ("\n");
 
 		if (shm) {
-			do_shm (format);
+			do_shm (format, unit);
 			printf ("\n");
 		}
 		if (sem) {
@@ -157,14 +172,14 @@ int main (int argc, char **argv)
 			printf ("\n");
 		}
 		if (msg) {
-			do_msg (format);
+			do_msg (format, unit);
 			printf ("\n");
 		}
 	}
 	return EXIT_SUCCESS;
 }
 
-static void do_shm (char format)
+static void do_shm (char format, int unit)
 {
 	struct passwd *pw;
 	struct shm_data *shmds, *shmdsp;
@@ -177,11 +192,28 @@ static void do_shm (char format)
 		printf (_("------ Shared Memory Limits --------\n"));
 		if (ipc_shm_get_limits(&lim))
 			return;
-		printf (_("max number of segments = %ju\n"), lim.shmmni);
-		printf (_("max seg size (kbytes) = %ju\n"), lim.shmmax / 1024);
-		printf (_("max total shared memory (kbytes) = %ju\n"),
-					(lim.shmall / 1024) * getpagesize());
-		printf (_("min seg size (bytes) = %ju\n"), lim.shmmin);
+		printf(_("max number of segments = %ju\n"), lim.shmmni);
+		if (unit == UNIT_DEFAULT)
+			printf(_("max seg size (kbytes) = %ju\n"),
+			       lim.shmmax / 1024);
+		else if (unit == UNIT_HUMAN)
+			printf(_("max seg size = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    lim.shmmax));
+		if (unit == UNIT_DEFAULT)
+			printf(_("max total shared memory (kbytes) = %ju\n"),
+			       (lim.shmall / 1024) * getpagesize());
+		else if (unit == UNIT_HUMAN)
+			printf(_("max total shared memory = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    lim.shmall *
+						    getpagesize()));
+		if (unit == UNIT_DEFAULT)
+			printf(_("min seg size (bytes) = %ju\n"), lim.shmmin);
+		else if (unit == UNIT_HUMAN)
+			printf(_("min seg size = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    lim.shmmin));
 		return;
 	}
 	case STATUS:
@@ -245,7 +277,8 @@ static void do_shm (char format)
 	default:
 		printf (_("------ Shared Memory Segments --------\n"));
 		printf ("%-10s %-10s %-10s %-10s %-10s %-10s %-12s\n",
-			_("key"),_("shmid"),_("owner"),_("perms"),_("bytes"),
+			_("key"),_("shmid"),_("owner"),_("perms"),
+			unit == UNIT_HUMAN ? _("size") : _("bytes"),
 			_("nattch"),_("status"));
 		break;
 	}
@@ -292,12 +325,18 @@ static void do_shm (char format)
 				printf ("%-10d %-10.10s", shmdsp->shm_perm.id, pw->pw_name);
 			else
 				printf ("%-10d %-10u", shmdsp->shm_perm.id, shmdsp->shm_perm.uid);
-			printf (" %-10o %-10lu %-10ld %-6s %-6s\n",
-				shmdsp->shm_perm.mode & 0777,
-				shmdsp->shm_segsz,
-				shmdsp->shm_nattch,
-				shmdsp->shm_perm.mode & SHM_DEST ? _("dest") : " ",
-				shmdsp->shm_perm.mode & SHM_LOCKED ? _("locked") : " ");
+			printf(" %-10o", shmdsp->shm_perm.mode & 0777);
+			if (unit == UNIT_DEFAULT)
+				printf(" %-10lu", shmdsp->shm_segsz);
+			else if (unit == UNIT_HUMAN)
+				printf(" %-10s",
+				       size_to_human_string(SIZE_SUFFIX_1LETTER,
+							    shmdsp->shm_segsz));
+			printf(" %-10ld %-6s %-6s\n", shmdsp->shm_nattch,
+			       shmdsp->shm_perm.
+			       mode & SHM_DEST ? _("dest") : " ",
+			       shmdsp->shm_perm.
+			       mode & SHM_LOCKED ? _("locked") : " ");
 			break;
 		}
 	}
@@ -407,7 +446,7 @@ static void do_sem (char format)
 	return;
 }
 
-static void do_msg (char format)
+static void do_msg (char format, int unit)
 {
 	struct passwd *pw;
 	struct msg_data *msgds, *msgdsp;
@@ -421,8 +460,20 @@ static void do_msg (char format)
 			return;
 		printf (_("------ Messages Limits --------\n"));
 		printf (_("max queues system wide = %d\n"), lim.msgmni);
-		printf (_("max size of message (bytes) = %zu\n"), lim.msgmax);
-		printf (_("default max size of queue (bytes) = %d\n"), lim.msgmnb);
+		if (unit == UNIT_DEFAULT)
+			printf(_("max size of message (bytes) = %zu\n"),
+			       lim.msgmax);
+		else if (unit == UNIT_HUMAN)
+			printf(_("max size of message = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    lim.msgmax));
+		if (unit == UNIT_DEFAULT)
+			printf(_("default max size of queue (bytes) = %d\n"),
+			       lim.msgmnb);
+		else if (unit == UNIT_HUMAN)
+			printf(_("default max size of queue = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    lim.msgmnb));
 		return;
 	}
 	case STATUS:
@@ -434,8 +485,18 @@ static void do_msg (char format)
 		}
 		printf (_("------ Messages Status --------\n"));
 		printf (_("allocated queues = %d\n"), msginfo.msgpool);
-		printf (_("used headers = %d\n"), msginfo.msgmap);
-		printf (_("used space = %d bytes\n"), msginfo.msgtql);
+		if (unit == UNIT_DEFAULT)
+			printf(_("used headers = %d\n"), msginfo.msgmap);
+		else if (unit == UNIT_HUMAN)
+			printf(_("used headers = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    msginfo.msgmap));
+		if (unit == UNIT_DEFAULT)
+			printf(_("used space = %d bytes\n"), msginfo.msgtql);
+		else if (unit == UNIT_HUMAN)
+			printf(_("used space = %s\n"),
+			       size_to_human_string(SIZE_SUFFIX_1LETTER,
+						    msginfo.msgtql));
 		return;
 	}
 	case CREATOR:
@@ -460,7 +521,8 @@ static void do_msg (char format)
 		printf (_("------ Message Queues --------\n"));
 		printf ("%-10s %-10s %-10s %-10s %-12s %-12s\n",
 			_("key"), _("msqid"), _("owner"), _("perms"),
-			_("used-bytes"), _("messages"));
+			unit == UNIT_HUMAN ? _("size") : _("used-bytes"),
+			_("messages"));
 		break;
 	}
 
@@ -505,10 +567,14 @@ static void do_msg (char format)
 				printf ("%-10d %-10.10s", msgdsp->msg_perm.id, pw->pw_name);
 			else
 				printf ("%-10d %-10u", msgdsp->msg_perm.id, msgdsp->msg_perm.uid);
-			printf (" %-10o %-12ld %-12ld\n",
-				msgdsp->msg_perm.mode & 0777,
-				msgdsp->q_cbytes,
-				msgdsp->q_qnum);
+			printf(" %-10o", msgdsp->msg_perm.mode & 0777);
+			if (unit == UNIT_DEFAULT)
+				printf(" %-12ld", msgdsp->q_cbytes);
+			else if (unit == UNIT_HUMAN)
+				printf(" %-12s",
+				       size_to_human_string(SIZE_SUFFIX_1LETTER,
+							    msgdsp->q_cbytes));
+			printf(" %-12ld\n", msgdsp->q_qnum);
 			break;
 		}
 	}
@@ -517,7 +583,7 @@ static void do_msg (char format)
 	return;
 }
 
-static void print_shm(int shmid)
+static void print_shm(int shmid, int unit)
 {
 	struct shm_data *shmdata;
 
@@ -532,8 +598,14 @@ static void print_shm(int shmid)
 	       shmdata->shm_perm.cuid, shmdata->shm_perm.cgid);
 	printf(_("mode=%#o\taccess_perms=%#o\n"), shmdata->shm_perm.mode,
 	       shmdata->shm_perm.mode & 0777);
-	printf(_("bytes=%ju\tlpid=%u\tcpid=%u\tnattch=%jd\n"),
-	       shmdata->shm_segsz, shmdata->shm_lprid, shmdata->shm_cprid,
+	if (unit == UNIT_DEFAULT)
+		printf(_("bytes=%ju\t"), shmdata->shm_segsz);
+	else if (unit == UNIT_HUMAN)
+		printf(_("size=%s\t"),
+		       size_to_human_string(SIZE_SUFFIX_1LETTER,
+					    shmdata->shm_segsz));
+	printf(_("lpid=%u\tcpid=%u\tnattch=%jd\n"),
+	       shmdata->shm_lprid, shmdata->shm_cprid,
 	       shmdata->shm_nattch);
 	printf(_("att_time=%-26.24s\n"),
 	       shmdata->shm_atim ? ctime(&(shmdata->shm_atim)) : _("Not set"));
@@ -546,7 +618,7 @@ static void print_shm(int shmid)
 }
 
 
-void print_msg(int msgid)
+void print_msg(int msgid, int unit)
 {
 	struct msg_data *msgdata;
 
@@ -560,8 +632,17 @@ void print_msg(int msgid)
 	       msgdata->msg_perm.uid, msgdata->msg_perm.uid,
 	       msgdata->msg_perm.cuid, msgdata->msg_perm.cgid,
 	       msgdata->msg_perm.mode);
-	printf(_("cbytes=%jd\tqbytes=%jd\tqnum=%jd\tlspid=%d\tlrpid=%d\n"),
-	       msgdata->q_cbytes, msgdata->q_qbytes, msgdata->q_qnum,
+	if (unit == UNIT_DEFAULT)
+		printf(_("cbytes=%jd\tqbytes=%jd"), msgdata->q_cbytes,
+		       msgdata->q_qbytes);
+	else if (unit == UNIT_HUMAN)
+		printf(_("csize=%s\tqsize=%s"),
+		       size_to_human_string(SIZE_SUFFIX_1LETTER,
+					    msgdata->q_cbytes),
+		       size_to_human_string(SIZE_SUFFIX_1LETTER,
+					    msgdata->q_qbytes));
+	printf(_("\tqnum=%jd\tlspid=%d\tlrpid=%d\n"),
+	       msgdata->q_qnum,
 	       msgdata->q_lspid, msgdata->q_lrpid);
 	printf(_("send_time=%-26.24s\n"),
 	       msgdata->q_stime ? ctime(&msgdata->q_stime) : _("Not set"));
-- 
1.8.0.1

