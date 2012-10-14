Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:65277 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab2JNUWn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:43 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1316198wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/13] ipcs: make individual message queue id printing to use /proc
Date: Sun, 14 Oct 2012 21:22:22 +0100
Message-Id: <1350246145-10600-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And reindent the print_msg() function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 57 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index cd3d14d..33759fe 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -403,6 +403,10 @@ static int msgctl_info_wrapper(int maxid, int id, struct msg_data **msgds,
 			       &(msgdsp->q_rtime),
 			       &(msgdsp->q_ctime)
 			    );
+			if (-1 < id && id != msgdsp->msg_perm.id) {
+				i--;
+				continue;
+			}
 			if (id < 0) {
 				msgdsp->next = xmalloc(sizeof(struct msg_data));
 				msgdsp = msgdsp->next;
@@ -562,7 +566,7 @@ static void do_shm (char format, int use_proc);
 static void do_sem (char format, int use_proc);
 static void do_msg (char format, int use_proc);
 static void print_shm (int id, int use_proc);
-void print_msg (int id);
+static void print_msg (int id, int use_proc);
 void print_sem (int id);
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -671,7 +675,7 @@ int main (int argc, char **argv)
 		if (sem)
 			print_sem (id);
 		if (msg)
-			print_msg (id);
+			print_msg (id, use_proc);
 		if (!shm && !sem && !msg )
 			usage (stderr);
 	} else {
@@ -1107,33 +1111,34 @@ static void print_shm(int shmid, int use_proc)
 	return;
 }
 
-
-void print_msg (int msqid)
+static void print_msg(int msqid, int use_proc)
 {
-	struct msqid_ds buf;
-	struct ipc_perm *ipcp = &buf.msg_perm;
+	struct msg_data *msgdata;
 
-	if (msgctl (msqid, IPC_STAT, &buf) == -1)
-		err(EXIT_FAILURE, _("msgctl failed"));
+	if (msgctl_info_wrapper(-1, msqid, &msgdata, use_proc) < 1) {
+		warnx(_("id %d not found"), msqid);
+		return;
+	}
 
-	printf (_("\nMessage Queue msqid=%d\n"), msqid);
-	printf (_("uid=%u\tgid=%u\tcuid=%u\tcgid=%u\tmode=%#o\n"),
-		ipcp->uid, ipcp->gid, ipcp->cuid, ipcp->cgid, ipcp->mode);
-	printf (_("cbytes=%ld\tqbytes=%ld\tqnum=%ld\tlspid=%d\tlrpid=%d\n"),
-		/*
-		 * glibc-2.1.3 and earlier has unsigned short. glibc-2.1.91
-		 * has variation between unsigned short, unsigned long.
-		 * Austin has msgqnum_t (for msg_qbytes)
-		 */
-		(long) buf.msg_cbytes, (long) buf.msg_qbytes,
-		(long) buf.msg_qnum, buf.msg_lspid, buf.msg_lrpid);
-	printf (_("send_time=%-26.24s\n"),
-		buf.msg_stime ? ctime (&buf.msg_stime) : _("Not set"));
-	printf (_("rcv_time=%-26.24s\n"),
-		buf.msg_rtime ? ctime (&buf.msg_rtime) : _("Not set"));
-	printf (_("change_time=%-26.24s\n"),
-		buf.msg_ctime ? ctime (&buf.msg_ctime) : _("Not set"));
-	printf ("\n");
+	printf(_("\nMessage Queue msqid=%d\n"), msqid);
+	printf(_("uid=%u\tgid=%u\tcuid=%u\tcgid=%u\tmode=%#o\n"),
+	       msgdata->msg_perm.uid, msgdata->msg_perm.uid,
+	       msgdata->msg_perm.cuid, msgdata->msg_perm.cgid,
+	       msgdata->msg_perm.mode & 0777);
+	printf(_("cbytes=%ld\tqbytes=%ld\tqnum=%ld\tlspid=%d\tlrpid=%d\n"),
+	       /* Old msqid_ds.msg_lqbytes is the same as
+		* msgdata->q_cbytes.  See copy_msqid_to_user() from
+		* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=ipc/msg.c */
+	       msgdata->q_cbytes, msgdata->q_cbytes,
+	       msgdata->q_qnum, msgdata->q_lspid, msgdata->q_lrpid);
+	printf(_("send_time=%-26.24s\n"),
+	       msgdata->q_stime ? ctime(&msgdata->q_stime) : _("Not set"));
+	printf(_("rcv_time=%-26.24s\n"),
+	       msgdata->q_rtime ? ctime(&msgdata->q_rtime) : _("Not set"));
+	printf(_("change_time=%-26.24s\n"),
+	       msgdata->q_ctime ? ctime(&msgdata->q_ctime) : _("Not set"));
+	printf("\n");
+	free(msgdata);
 	return;
 }
 
-- 
1.7.12.3

