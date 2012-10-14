Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56691 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab2JNUWh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:37 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908587wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/13] ipcs: read message queue values from /proc
Date: Sun, 14 Oct 2012 21:22:18 +0100
Message-Id: <1350246145-10600-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add msgctl_info_wrapper(), which does the job and take it in use.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 160 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 126 insertions(+), 34 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index b2d4649..db1919b 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -363,6 +363,96 @@ static int shmctl_info_wrapper(int maxid, int id, struct shm_data **shmds,
 	return i;
 }
 
+static int msgctl_info_wrapper(int maxid, int id, struct msg_data **msgds,
+			       int use_proc)
+{
+	char skipheader[1024];
+	int i, msgid;
+	struct msg_data *msgdsp;
+
+	struct msqid_ds msgque;
+	struct ipc_perm *ipcp = &msgque.msg_perm;
+
+	*msgds = xmalloc(sizeof(struct msg_data));
+	msgdsp = *msgds;
+	msgdsp->next = NULL;
+	if (use_proc) {
+		FILE *f;
+		if ((f = fopen(_PATH_PROC_IPCMSG, "r")) == NULL)
+			return -1;
+		fgets(skipheader, 1024, f);
+		for (i = 0; !feof(f); i++) {
+			fscanf(f,
+			       "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
+			       &(msgdsp->msg_perm.key),
+			       &(msgdsp->msg_perm.id),
+			       &(msgdsp->msg_perm.mode),
+			       &(msgdsp->q_cbytes),
+			       &(msgdsp->q_qnum),
+			       &(msgdsp->q_lspid),
+			       &(msgdsp->q_lrpid),
+			       &(msgdsp->msg_perm.uid),
+			       &(msgdsp->msg_perm.gid),
+			       &(msgdsp->msg_perm.cuid),
+			       &(msgdsp->msg_perm.cgid),
+			       &(msgdsp->q_stime),
+			       &(msgdsp->q_rtime),
+			       &(msgdsp->q_ctime)
+			    );
+			if (id < 0) {
+				msgdsp->next = xmalloc(sizeof(struct msg_data));
+				msgdsp = msgdsp->next;
+				msgdsp->next = NULL;
+			}
+		}
+		if (i == 0)
+			free(*msgds);
+		fclose(f);
+		return i;
+	}
+
+	/* Fallback; /proc or /sys file(s) missing. */
+	if (id < 0)
+		i = 0;
+	else
+		i = id;
+	while (i <= maxid) {
+		msgid = msgctl(id, MSG_STAT, &msgque);
+		if (msgid < 0) {
+			if (-1 < id) {
+				free(*msgds);
+				return 0;
+			}
+			i++;
+			continue;
+		}
+		msgdsp->msg_perm.key = ipcp->KEY;
+		msgdsp->msg_perm.id = msgid;
+		msgdsp->msg_perm.mode = ipcp->mode;
+		msgdsp->q_cbytes = msgque.msg_cbytes;
+		msgdsp->q_qnum = msgque.msg_qnum;
+		msgdsp->q_lspid = msgque.msg_lspid;
+		msgdsp->q_lrpid = msgque.msg_lrpid;
+		msgdsp->msg_perm.uid = ipcp->uid;
+		msgdsp->msg_perm.gid = ipcp->gid;
+		msgdsp->msg_perm.cuid = ipcp->cuid;
+		msgdsp->msg_perm.cgid = ipcp->cgid;
+		msgdsp->q_stime = msgque.msg_stime;
+		msgdsp->q_rtime = msgque.msg_rtime;
+		msgdsp->q_ctime = msgque.msg_ctime;
+
+		if (id < 0) {
+			msgdsp->next = xmalloc(sizeof(struct msg_data));
+			msgdsp = msgdsp->next;
+			msgdsp->next = NULL;
+			i++;
+		} else {
+			return 1;
+		}
+	}
+	return i;
+}
+
 static int test_ipc_proc_paths(void)
 {
 	if (access(_PATH_PROC_IPCMSG, F_OK) == 0 &&
@@ -380,7 +470,7 @@ static int test_ipc_proc_paths(void)
 
 static void do_shm (char format, int use_proc);
 void do_sem (char format, int use_proc);
-void do_msg (char format, int use_proc);
+static void do_msg (char format, int use_proc);
 void print_shm (int id);
 void print_msg (int id);
 void print_sem (int id);
@@ -807,13 +897,22 @@ void do_sem (char format, int use_proc)
 	}
 }
 
-void do_msg (char format, int use_proc)
+static void freemsgs(struct msg_data *msgds)
 {
-	int maxid, msqid, id;
-	struct msqid_ds msgque;
+	while (msgds) {
+		struct msg_data *next = msgds->next;
+		free(msgds);
+		msgds = next;
+	}
+	return;
+}
+
+static void do_msg (char format, int use_proc)
+{
+	int maxid;
 	struct msginfo msginfo;
-	struct ipc_perm *ipcp = &msgque.msg_perm;
 	struct passwd *pw;
+	struct msg_data *msgds, *msgdsp;
 	struct proc_limits lim;
 
 	maxid = msgctl (0, MSG_INFO, (struct msqid_ds *) (void *) &msginfo);
@@ -865,56 +964,49 @@ void do_msg (char format, int use_proc)
 		break;
 	}
 
-	for (id = 0; id <= maxid; id++) {
-		msqid = msgctl (id, MSG_STAT, &msgque);
-		if (msqid < 0)
-			continue;
+	if (msgctl_info_wrapper (maxid, -1, &msgds, use_proc) < 1)
+		return;
+
+	for (msgdsp = msgds; msgdsp->next != NULL; msgdsp = msgdsp->next) {
 		if (format == CREATOR)  {
-			print_perms (msqid, ipcp);
+			FIXED_print_perms (&(msgdsp->msg_perm));
 			continue;
 		}
-		pw = getpwuid(ipcp->uid);
+		pw = getpwuid(msgdsp->msg_perm.uid);
 		switch (format) {
 		case TIME:
 			if (pw)
-				printf ("%-8d %-10.10s", msqid, pw->pw_name);
+				printf ("%-8d %-10.10s", msgdsp->msg_perm.id, pw->pw_name);
 			else
-				printf ("%-8d %-10u", msqid, ipcp->uid);
-			printf (" %-20.16s", msgque.msg_stime
-				? ctime(&msgque.msg_stime) + 4 : _("Not set"));
-			printf (" %-20.16s", msgque.msg_rtime
-				? ctime(&msgque.msg_rtime) + 4 : _("Not set"));
-			printf (" %-20.16s\n", msgque.msg_ctime
-				? ctime(&msgque.msg_ctime) + 4 : _("Not set"));
+				printf ("%-8d %-10u", msgdsp->msg_perm.id, msgdsp->msg_perm.uid);
+			printf (" %-20.16s", msgdsp->q_stime
+				? ctime(&(msgdsp->q_stime)) + 4 : _("Not set"));
+			printf (" %-20.16s", msgdsp->q_rtime
+				? ctime(&(msgdsp->q_rtime)) + 4 : _("Not set"));
+			printf (" %-20.16s\n", msgdsp->q_ctime
+				? ctime(&(msgdsp->q_ctime)) + 4 : _("Not set"));
 			break;
 		case PID:
 			if (pw)
-				printf ("%-8d %-10.10s", msqid, pw->pw_name);
+				printf ("%-8d %-10.10s", msgdsp->msg_perm.id, pw->pw_name);
 			else
-				printf ("%-8d %-10u", msqid, ipcp->uid);
+				printf ("%-8d %-10u", msgdsp->msg_perm.id, msgdsp->msg_perm.uid);
 			printf ("  %5d     %5d\n",
-				msgque.msg_lspid, msgque.msg_lrpid);
+				msgdsp->q_lspid, msgdsp->q_lrpid);
 			break;
 
 		default:
-			printf( "0x%08x ",ipcp->KEY );
+			printf( "0x%08x ", msgdsp->msg_perm.key );
 			if (pw)
-				printf ("%-10d %-10.10s", msqid, pw->pw_name);
+				printf ("%-10d %-10.10s", msgdsp->msg_perm.id, pw->pw_name);
 			else
-				printf ("%-10d %-10u", msqid, ipcp->uid);
+				printf ("%-10d %-10u", msgdsp->msg_perm.id, msgdsp->msg_perm.uid);
 			printf (" %-10o %-12ld %-12ld\n",
-				ipcp->mode & 0777,
-				/*
-				 * glibc-2.1.3 and earlier has unsigned
-				 * short. glibc-2.1.91 has variation between
-				 * unsigned short, unsigned long. Austin has
-				 * msgqnum_t
-				 */
-				(long) msgque.msg_cbytes,
-				(long) msgque.msg_qnum);
+				msgdsp->msg_perm.mode & 0777, msgdsp->q_cbytes, msgdsp->q_qnum);
 			break;
 		}
 	}
+	freemsgs(msgds);
 	return;
 }
 
-- 
1.7.12.3

