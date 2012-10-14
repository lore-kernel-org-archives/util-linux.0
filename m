Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56691 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab2JNUWf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:35 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908587wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/13] ipcs: read shared memory values from /proc
Date: Sun, 14 Oct 2012 21:22:17 +0100
Message-Id: <1350246145-10600-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add shmctl_info_wrapper(), which does the job and take it in use.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 179 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 142 insertions(+), 37 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 8ac7e1c..b2d4649 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -35,6 +35,7 @@
 #include "nls.h"
 #include "closestream.h"
 #include "pathnames.h"
+#include "xalloc.h"
 
 /*
  * SHM_DEST and SHM_LOCKED are defined in kernel headers, but inside
@@ -262,6 +263,106 @@ static int shmctl_limits_wrapper(struct proc_limits *lim, int use_proc)
 	return 0;
 }
 
+#if BITS_PER_LONG <= 32		/* FIXME: autotools needs to determine this */
+# define SIZE_SPEC "%10lu"
+#else
+# define SIZE_SPEC "%21lu"
+#endif
+static int shmctl_info_wrapper(int maxid, int id, struct shm_data **shmds,
+			       int use_proc)
+{
+	char skipheader[1024];
+	int i, shmid;
+	struct shm_data *shmdsp;
+
+	struct shmid_ds shmseg;
+	struct ipc_perm *ipcp = &shmseg.shm_perm;
+
+	*shmds = xmalloc(sizeof(struct shm_data));
+	shmdsp = *shmds;
+	shmdsp->next = NULL;
+	if (use_proc) {
+		FILE *f;
+		if ((f = fopen(_PATH_PROC_IPCSHM, "r")) == NULL)
+			return -1;
+		fgets(skipheader, 1024, f);
+		for (i = 0; !feof(f); i++) {
+			fscanf(f,
+			       "%10d %10d  %4o " SIZE_SPEC
+			       " %5lu %5lu  %5lu %5u %5u %5u %5u %10lu %10lu %10lu "
+			       SIZE_SPEC " " SIZE_SPEC "\n",
+			       &(shmdsp->shm_perm.key),
+			       &(shmdsp->shm_perm.id),
+			       &(shmdsp->shm_perm.mode),
+			       &(shmdsp->shm_segsz),
+			       &(shmdsp->shm_cprid),
+			       &(shmdsp->shm_lprid),
+			       &(shmdsp->shm_nattch),
+			       &(shmdsp->shm_perm.uid),
+			       &(shmdsp->shm_perm.gid),
+			       &(shmdsp->shm_perm.cuid),
+			       &(shmdsp->shm_perm.cgid),
+			       &(shmdsp->shm_atim),
+			       &(shmdsp->shm_dtim),
+			       &(shmdsp->shm_ctim),
+			       &(shmdsp->shm_rss),
+			       &(shmdsp->shm_swp)
+			    );
+			if (id < 0) {
+				shmdsp->next = xmalloc(sizeof(struct shm_data));
+				shmdsp = shmdsp->next;
+				shmdsp->next = NULL;
+			}
+		}
+		if (i == 0)
+			free(*shmds);
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
+		shmid = shmctl(i, SHM_STAT, &shmseg);
+		if (shmid < 0) {
+			if (-1 < id) {
+				free(*shmds);
+				return 0;
+			}
+			i++;
+			continue;
+		}
+		shmdsp->shm_perm.key = ipcp->KEY;
+		shmdsp->shm_perm.id = shmid;
+		shmdsp->shm_perm.mode = ipcp->mode;
+		shmdsp->shm_segsz = shmseg.shm_segsz;
+		shmdsp->shm_cprid = shmseg.shm_cpid;
+		shmdsp->shm_lprid = shmseg.shm_lpid;
+		shmdsp->shm_nattch = shmseg.shm_nattch;
+		shmdsp->shm_perm.uid = ipcp->uid;
+		shmdsp->shm_perm.gid = ipcp->gid;
+		shmdsp->shm_perm.cuid = ipcp->cuid;
+		shmdsp->shm_perm.cgid = ipcp->cuid;
+		shmdsp->shm_atim = shmseg.shm_atime;
+		shmdsp->shm_dtim = shmseg.shm_dtime;
+		shmdsp->shm_ctim = shmseg.shm_ctime;
+		shmdsp->shm_rss = 0xdead;
+		shmdsp->shm_swp = 0xdead;
+		if (id < 0) {
+			shmdsp->next = xmalloc(sizeof(struct shm_data));
+			shmdsp = shmdsp->next;
+			shmdsp->next = NULL;
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
@@ -277,7 +378,7 @@ static int test_ipc_proc_paths(void)
 	return 0;
 }
 
-void do_shm (char format, int use_proc);
+static void do_shm (char format, int use_proc);
 void do_sem (char format, int use_proc);
 void do_msg (char format, int use_proc);
 void print_shm (int id);
@@ -465,13 +566,22 @@ static void FIXED_print_perms(struct ipc_stat *is)
 		printf(" %-10u\n", is->gid);
 }
 
-void do_shm (char format, int use_proc)
+static void freeshms(struct shm_data *shmds)
 {
-	int maxid, shmid, id;
-	struct shmid_ds shmseg;
+	while (shmds) {
+		struct shm_data *next = shmds->next;
+		free(shmds);
+		shmds = next;
+	}
+	return;
+}
+
+static void do_shm (char format, int use_proc)
+{
+	int maxid;
 	struct shm_info shm_info;
-	struct ipc_perm *ipcp = &shmseg.shm_perm;
 	struct passwd *pw;
+	struct shm_data *shmds, *shmdsp;
 	struct proc_limits lim;
 
 	maxid = shmctl (0, SHM_INFO, (struct shmid_ds *) (void *) &shm_info);
@@ -544,60 +654,55 @@ void do_shm (char format, int use_proc)
 		break;
 	}
 
-	for (id = 0; id <= maxid; id++) {
-		shmid = shmctl (id, SHM_STAT, &shmseg);
-		if (shmid < 0)
-			continue;
+	if (shmctl_info_wrapper (maxid, -1, &shmds, use_proc) < 1)
+		return;
+	shmdsp = shmds;
+
+	for (shmdsp = shmds; shmdsp->next != NULL; shmdsp = shmdsp->next) {
 		if (format == CREATOR)  {
-			print_perms (shmid, ipcp);
+			FIXED_print_perms (&(shmdsp->shm_perm));
 			continue;
 		}
-		pw = getpwuid(ipcp->uid);
+		pw = getpwuid(shmdsp->shm_perm.uid);
 		switch (format) {
 		case TIME:
 			if (pw)
-				printf ("%-10d %-10.10s", shmid, pw->pw_name);
+				printf ("%-10d %-10.10s", shmdsp->shm_perm.id, pw->pw_name);
 			else
-				printf ("%-10d %-10u", shmid, ipcp->uid);
+				printf ("%-10d %-10u", shmdsp->shm_perm.id, shmdsp->shm_perm.uid);
 			/* ctime uses static buffer: use separate calls */
-			printf(" %-20.16s", shmseg.shm_atime
-			       ? ctime(&shmseg.shm_atime) + 4 : _("Not set"));
-			printf(" %-20.16s", shmseg.shm_dtime
-			       ? ctime(&shmseg.shm_dtime) + 4 : _("Not set"));
-			printf(" %-20.16s\n", shmseg.shm_ctime
-			       ? ctime(&shmseg.shm_ctime) + 4 : _("Not set"));
+			printf(" %-20.16s", shmdsp->shm_atim
+			       ? ctime(&(shmdsp->shm_atim)) + 4 : _("Not set"));
+			printf(" %-20.16s", shmdsp->shm_dtim
+			       ? ctime(&(shmdsp->shm_dtim)) + 4 : _("Not set"));
+			printf(" %-20.16s\n", shmdsp->shm_ctim
+			       ? ctime(&(shmdsp->shm_ctim)) + 4 : _("Not set"));
 			break;
 		case PID:
 			if (pw)
-				printf ("%-10d %-10.10s", shmid, pw->pw_name);
+				printf ("%-10d %-10.10s", shmdsp->shm_perm.id, pw->pw_name);
 			else
-				printf ("%-10d %-10u", shmid, ipcp->uid);
+				printf ("%-10d %-10u", shmdsp->shm_perm.id, shmdsp->shm_perm.uid);
 			printf (" %-10d %-10d\n",
-				shmseg.shm_cpid, shmseg.shm_lpid);
+				shmdsp->shm_cprid, shmdsp->shm_lprid);
 			break;
 
 		default:
-			printf("0x%08x ",ipcp->KEY );
+			printf("0x%08x ", shmdsp->shm_perm.key);
 			if (pw)
-				printf ("%-10d %-10.10s", shmid, pw->pw_name);
+				printf ("%-10d %-10.10s", shmdsp->shm_perm.id, pw->pw_name);
 			else
-				printf ("%-10d %-10u", shmid, ipcp->uid);
+				printf ("%-10d %-10u", shmdsp->shm_perm.id, shmdsp->shm_perm.uid);
 			printf (" %-10o %-10lu %-10ld %-6s %-6s\n",
-				ipcp->mode & 0777,
-				/*
-				 * earlier: int, Austin has size_t
-				 */
-				(unsigned long) shmseg.shm_segsz,
-				/*
-				 * glibc-2.1.3 and earlier has unsigned short;
-				 * Austin has shmatt_t
-				 */
-				(long) shmseg.shm_nattch,
-				ipcp->mode & SHM_DEST ? _("dest") : " ",
-				ipcp->mode & SHM_LOCKED ? _("locked") : " ");
+				shmdsp->shm_perm.mode & 0777,
+				shmdsp->shm_segsz,
+				shmdsp->shm_nattch,
+				shmdsp->shm_perm.mode & SHM_DEST ? _("dest") : " ",
+				shmdsp->shm_perm.mode & SHM_LOCKED ? _("locked") : " ");
 			break;
 		}
 	}
+	freeshms(shmds);
 	return;
 }
 
-- 
1.7.12.3

