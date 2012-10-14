Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38335 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab2JNUWj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:39 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so705001wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/13] ipsc: read semaphore values from /proc
Date: Sun, 14 Oct 2012 21:22:19 +0100
Message-Id: <1350246145-10600-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add semctl_info_wrapper(), which does the job and take it in use.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 148 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 29 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index db1919b..373e85e 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -453,6 +453,92 @@ static int msgctl_info_wrapper(int maxid, int id, struct msg_data **msgds,
 	return i;
 }
 
+static int semctl_info_wrapper(int maxid, int id, struct sem_data **semds,
+			       int use_proc)
+{
+	char skipheader[1024];
+	int i, semid;
+	struct sem_data *semdsp;
+
+	struct semid_ds semary;
+	struct ipc_perm *ipcp = &semary.sem_perm;
+	struct seminfo seminfo;
+	union semun arg;
+
+	*semds = xmalloc(sizeof(struct sem_data));
+	semdsp = *semds;
+	semdsp->next = NULL;
+	if (use_proc) {
+		FILE *f;
+		if ((f = fopen(_PATH_PROC_IPCSEM, "r")) == NULL)
+			return -1;
+		fgets(skipheader, 1024, f);
+		for (i = 0; !feof(f); i++) {
+			fscanf(f,
+			       "%10d %10d  %4o %10u %5u %5u %5u %5u %10lu %10lu\n",
+			       &(semdsp->sem_perm.key),
+			       &(semdsp->sem_perm.id),
+			       &(semdsp->sem_perm.mode),
+			       &(semdsp->sem_nsems),
+			       &(semdsp->sem_perm.uid),
+			       &(semdsp->sem_perm.gid),
+			       &(semdsp->sem_perm.cuid),
+			       &(semdsp->sem_perm.cgid),
+			       &(semdsp->sem_otime),
+			       &(semdsp->sem_ctime)
+			    );
+			if (id < 0) {
+				semdsp->next = xmalloc(sizeof(struct sem_data));
+				semdsp = semdsp->next;
+				semdsp->next = NULL;
+			}
+		}
+		if (i == 0)
+			free(*semds);
+		fclose(f);
+		return i;
+	}
+
+	/* Fallback; /proc or /sys file(s) missing. */
+	if (id < 0)
+		i = 0;
+	else
+		i = id;
+	arg.array = (ushort *) (void *)&seminfo;
+	arg.buf = (struct semid_ds *)&semary;
+	while (i <= maxid) {
+		semid = semctl(id, 0, SEM_STAT, arg);
+		if (semid < 0) {
+			if (-1 < semid) {
+				free(*semds);
+				return 0;
+			}
+			i++;
+			continue;
+		}
+		semdsp->sem_perm.key = ipcp->KEY;
+		semdsp->sem_perm.id = semid;
+		semdsp->sem_perm.mode = ipcp->mode;
+		semdsp->sem_nsems = semary.sem_nsems;
+		semdsp->sem_perm.uid = semary.sem_perm.uid;
+		semdsp->sem_perm.gid = semary.sem_perm.gid;
+		semdsp->sem_perm.cuid = semary.sem_perm.cuid;
+		semdsp->sem_perm.cgid = semary.sem_perm.cgid;
+		semdsp->sem_otime = semary.sem_otime;
+		semdsp->sem_ctime = semary.sem_ctime;
+
+		if (id < 0) {
+			semdsp->next = xmalloc(sizeof(struct sem_data));
+			semdsp = semdsp->next;
+			semdsp->next = NULL;
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
@@ -469,7 +555,7 @@ static int test_ipc_proc_paths(void)
 }
 
 static void do_shm (char format, int use_proc);
-void do_sem (char format, int use_proc);
+static void do_sem (char format, int use_proc);
 static void do_msg (char format, int use_proc);
 void print_shm (int id);
 void print_msg (int id);
@@ -796,13 +882,22 @@ static void do_shm (char format, int use_proc)
 	return;
 }
 
-void do_sem (char format, int use_proc)
+static void freesems(struct sem_data *semds)
 {
-	int maxid, semid, id;
-	struct semid_ds semary;
+	while (semds) {
+		struct sem_data *next = semds->next;
+		free(semds);
+		semds = next;
+	}
+	return;
+}
+
+static void do_sem (char format, int use_proc)
+{
+	int maxid;
 	struct seminfo seminfo;
-	struct ipc_perm *ipcp = &semary.sem_perm;
 	struct passwd *pw;
+	struct sem_data *semds, *semdsp;
 	union semun arg;
 	struct proc_limits lim;
 
@@ -853,48 +948,43 @@ void do_sem (char format, int use_proc)
 		break;
 	}
 
-	for (id = 0; id <= maxid; id++) {
-		arg.buf = (struct semid_ds *) &semary;
-		semid = semctl (id, 0, SEM_STAT, arg);
-		if (semid < 0)
-			continue;
+	if (semctl_info_wrapper (maxid, -1, &semds, use_proc) < 1)
+		return;
+
+	for (semdsp = semds; semdsp->next != NULL; semdsp = semdsp->next) {
 		if (format == CREATOR)  {
-			print_perms (semid, ipcp);
+			FIXED_print_perms (&(semdsp->sem_perm));
 			continue;
 		}
-		pw = getpwuid(ipcp->uid);
+		pw = getpwuid(semdsp->sem_perm.uid);
 		switch (format) {
 		case TIME:
 			if (pw)
-				printf ("%-8d %-10.10s", semid, pw->pw_name);
+				printf ("%-8d %-10.10s", semdsp->sem_perm.id, pw->pw_name);
 			else
-				printf ("%-8d %-10u", semid, ipcp->uid);
-			printf ("  %-26.24s", semary.sem_otime
-				? ctime(&semary.sem_otime) : _("Not set"));
-			printf (" %-26.24s\n", semary.sem_ctime
-				? ctime(&semary.sem_ctime) : _("Not set"));
+				printf ("%-8d %-10u", semdsp->sem_perm.id, semdsp->sem_perm.uid);
+			printf ("  %-26.24s", semdsp->sem_otime
+				? ctime(&semdsp->sem_otime) : _("Not set"));
+			printf (" %-26.24s\n", semdsp->sem_ctime
+				? ctime(&semdsp->sem_ctime) : _("Not set"));
 			break;
 		case PID:
 			break;
 
 		default:
-			printf("0x%08x ", ipcp->KEY);
+			printf("0x%08x ", semdsp->sem_perm.key);
 			if (pw)
-				printf ("%-10d %-10.10s", semid, pw->pw_name);
+				printf ("%-10d %-10.10s", semdsp->sem_perm.id, pw->pw_name);
 			else
-				printf ("%-10d %-10u", semid, ipcp->uid);
+				printf ("%-10d %-10u", semdsp->sem_perm.id, semdsp->sem_perm.uid);
 			printf (" %-10o %-10ld\n",
-				ipcp->mode & 0777,
-				/*
-				 * glibc-2.1.3 and earlier has unsigned
-				 * short. glibc-2.1.91 has variation between
-				 * unsigned short and unsigned long. Austin
-				 * prescribes unsigned short.
-				 */
-				(long) semary.sem_nsems);
+				semdsp->sem_perm.mode & 0777,
+				semdsp->sem_nsems);
 			break;
 		}
 	}
+	freesems(semds);
+	return;
 }
 
 static void freemsgs(struct msg_data *msgds)
-- 
1.7.12.3

