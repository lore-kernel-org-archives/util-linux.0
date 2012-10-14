Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56691 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab2JNUWo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:44 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908587wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/13] ipcs: make individual semaphore id printing to use /proc
Date: Sun, 14 Oct 2012 21:22:23 +0100
Message-Id: <1350246145-10600-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And reindent the print_sem() function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 67 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 33759fe..a380718 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -495,6 +495,10 @@ static int semctl_info_wrapper(int maxid, int id, struct sem_data **semds,
 			       &(semdsp->sem_otime),
 			       &(semdsp->sem_ctime)
 			    );
+			if (-1 < id && id != semdsp->sem_perm.id) {
+				i--;
+				continue;
+			}
 			if (id < 0) {
 				semdsp->next = xmalloc(sizeof(struct sem_data));
 				semdsp = semdsp->next;
@@ -567,7 +571,7 @@ static void do_sem (char format, int use_proc);
 static void do_msg (char format, int use_proc);
 static void print_shm (int id, int use_proc);
 static void print_msg (int id, int use_proc);
-void print_sem (int id);
+static void print_sem (int id, int use_proc);
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -673,7 +677,7 @@ int main (int argc, char **argv)
 		if (shm)
 			print_shm (id, use_proc);
 		if (sem)
-			print_sem (id);
+			print_sem (id, use_proc);
 		if (msg)
 			print_msg (id, use_proc);
 		if (!shm && !sem && !msg )
@@ -1142,42 +1146,53 @@ static void print_msg(int msqid, int use_proc)
 	return;
 }
 
-void print_sem (int semid)
+static void print_sem(int semid, int use_proc)
 {
 	struct semid_ds semds;
-	struct ipc_perm *ipcp = &semds.sem_perm;
 	union semun arg;
+	struct sem_data *semdata;
 	size_t i;
 
+	if (semctl_info_wrapper(-1, semid, &semdata, use_proc) < 1) {
+		warnx(_("id %d not found"), semid);
+		return;
+	}
+
+	printf(_("\nSemaphore Array semid=%d\n"), semid);
+	printf(_("uid=%u\t gid=%u\t cuid=%u\t cgid=%u\n"),
+	       semdata->sem_perm.uid, semdata->sem_perm.uid,
+	       semdata->sem_perm.cuid, semdata->sem_perm.cgid);
+	printf(_("mode=%#o, access_perms=%#o\n"),
+	       semdata->sem_perm.mode, semdata->sem_perm.mode & 0777);
+	printf(_("nsems = %ld\n"), semdata->sem_nsems);
+	printf(_("otime = %-26.24s\n"),
+	       semdata->sem_otime ? ctime(&semdata->sem_otime) : _("Not set"));
+	printf(_("ctime = %-26.24s\n"), ctime(&semdata->sem_ctime));
+
+	printf("%-10s %-10s %-10s %-10s %-10s\n",
+	       _("semnum"), _("value"), _("ncount"), _("zcount"), _("pid"));
+
+	/* FIXME (in future): The following are missing from proc.  A
+	 * kernel change is needed, which will add to
+	 * /proc/sysvipc/sem the four data items semctl() is used below.
+	 * Meanwhile ipcs has to this old fashioned way.  */
 	arg.buf = &semds;
-	if (semctl (semid, 0, IPC_STAT, arg) < 0)
+	if (semctl(semid, 0, IPC_STAT, arg) < 0)
 		err(EXIT_FAILURE, _("semctl failed"));
-
-	printf (_("\nSemaphore Array semid=%d\n"), semid);
-	printf (_("uid=%u\t gid=%u\t cuid=%u\t cgid=%u\n"),
-		ipcp->uid, ipcp->gid, ipcp->cuid, ipcp->cgid);
-	printf (_("mode=%#o, access_perms=%#o\n"),
-		ipcp->mode, ipcp->mode & 0777);
-	printf (_("nsems = %ld\n"), (long) semds.sem_nsems);
-	printf (_("otime = %-26.24s\n"),
-		semds.sem_otime ? ctime (&semds.sem_otime) : _("Not set"));
-	printf (_("ctime = %-26.24s\n"), ctime (&semds.sem_ctime));
-
-	printf ("%-10s %-10s %-10s %-10s %-10s\n",
-		_("semnum"),_("value"),_("ncount"),_("zcount"),_("pid"));
 	arg.val = 0;
-	for (i=0; i< semds.sem_nsems; i++) {
+	for (i = 0; i < semds.sem_nsems; i++) {
 		int val, ncnt, zcnt, pid;
-		val = semctl (semid, i, GETVAL, arg);
-		ncnt = semctl (semid, i, GETNCNT, arg);
-		zcnt = semctl (semid, i, GETZCNT, arg);
-		pid = semctl (semid, i, GETPID, arg);
+		val = semctl(semid, i, GETVAL, arg);
+		ncnt = semctl(semid, i, GETNCNT, arg);
+		zcnt = semctl(semid, i, GETZCNT, arg);
+		pid = semctl(semid, i, GETPID, arg);
 		if (val < 0 || ncnt < 0 || zcnt < 0 || pid < 0)
 			err(EXIT_FAILURE, _("semctl failed"));
 
-		printf ("%-10zd %-10d %-10d %-10d %-10d\n",
-			i, val, ncnt, zcnt, pid);
+		printf("%-10zd %-10d %-10d %-10d %-10d\n",
+		       i, val, ncnt, zcnt, pid);
 	}
-	printf ("\n");
+	printf("\n");
+	free(semdata);
 	return;
 }
-- 
1.7.12.3

