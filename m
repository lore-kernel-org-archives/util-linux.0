Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38335 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab2JNUWl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:41 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so705001wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/13] ipcs: make individual shared memory id printing to use /proc
Date: Sun, 14 Oct 2012 21:22:21 +0100
Message-Id: <1350246145-10600-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And reindent the print_shm() function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 960039e..cd3d14d 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -308,6 +308,10 @@ static int shmctl_info_wrapper(int maxid, int id, struct shm_data **shmds,
 			       &(shmdsp->shm_rss),
 			       &(shmdsp->shm_swp)
 			    );
+			if (-1 < id && id != shmdsp->shm_perm.id) {
+				i--;
+				continue;
+			}
 			if (id < 0) {
 				shmdsp->next = xmalloc(sizeof(struct shm_data));
 				shmdsp = shmdsp->next;
@@ -557,7 +561,7 @@ static int test_ipc_proc_paths(void)
 static void do_shm (char format, int use_proc);
 static void do_sem (char format, int use_proc);
 static void do_msg (char format, int use_proc);
-void print_shm (int id);
+static void print_shm (int id, int use_proc);
 void print_msg (int id);
 void print_sem (int id);
 
@@ -663,7 +667,7 @@ int main (int argc, char **argv)
 
 	if  (print) {
 		if (shm)
-			print_shm (id);
+			print_shm (id, use_proc);
 		if (sem)
 			print_sem (id);
 		if (msg)
@@ -1075,28 +1079,31 @@ static void do_msg (char format, int use_proc)
 	return;
 }
 
-void print_shm (int shmid)
+static void print_shm(int shmid, int use_proc)
 {
-	struct shmid_ds shmds;
-	struct ipc_perm *ipcp = &shmds.shm_perm;
+	struct shm_data *shmdata;
 
-	if (shmctl (shmid, IPC_STAT, &shmds) == -1)
-		err(EXIT_FAILURE, _("shmctl failed"));
+	if (shmctl_info_wrapper(-1, shmid, &shmdata, use_proc) < 1) {
+		warnx(_("id %d not found"), shmid);
+		return;
+	}
 
-	printf (_("\nShared memory Segment shmid=%d\n"), shmid);
-	printf (_("uid=%u\tgid=%u\tcuid=%u\tcgid=%u\n"),
-		ipcp->uid, ipcp->gid, ipcp->cuid, ipcp->cgid);
-	printf (_("mode=%#o\taccess_perms=%#o\n"),
-		ipcp->mode, ipcp->mode & 0777);
-	printf (_("bytes=%lu\tlpid=%d\tcpid=%d\tnattch=%ld\n"),
-		(unsigned long) shmds.shm_segsz, shmds.shm_lpid, shmds.shm_cpid,
-		(long) shmds.shm_nattch);
-	printf (_("att_time=%-26.24s\n"),
-		shmds.shm_atime ? ctime (&shmds.shm_atime) : _("Not set"));
-	printf (_("det_time=%-26.24s\n"),
-		shmds.shm_dtime ? ctime (&shmds.shm_dtime) : _("Not set"));
-	printf (_("change_time=%-26.24s\n"), ctime (&shmds.shm_ctime));
-	printf ("\n");
+	printf(_("\nShared memory Segment shmid=%d\n"), shmid);
+	printf(_("uid=%u\tgid=%u\tcuid=%u\tcgid=%u\n"),
+	       shmdata->shm_perm.uid, shmdata->shm_perm.uid,
+	       shmdata->shm_perm.cuid, shmdata->shm_perm.cgid);
+	printf(_("mode=%#o\taccess_perms=%#o\n"), shmdata->shm_perm.mode,
+	       shmdata->shm_perm.mode & 0777);
+	printf(_("bytes=%lu\tlpid=%d\tcpid=%d\tnattch=%ld\n"),
+	       shmdata->shm_segsz, shmdata->shm_lprid, shmdata->shm_cprid,
+	       shmdata->shm_nattch);
+	printf(_("att_time=%-26.24s\n"),
+	       shmdata->shm_atim ? ctime(&(shmdata->shm_atim)) : _("Not set"));
+	printf(_("det_time=%-26.24s\n"),
+	       shmdata->shm_dtim ? ctime(&shmdata->shm_dtim) : _("Not set"));
+	printf(_("change_time=%-26.24s\n"), ctime(&shmdata->shm_ctim));
+	printf("\n");
+	free(shmdata);
 	return;
 }
 
-- 
1.7.12.3

