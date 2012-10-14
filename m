Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56691 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab2JNUWd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:33 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908587wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/13] ipcs: determine ipc limits from /proc
Date: Sun, 14 Oct 2012 21:22:15 +0100
Message-Id: <1350246145-10600-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 156 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 122 insertions(+), 34 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 900fc65..4737f28 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -46,6 +46,16 @@
 # define SHM_LOCKED	02000	/* segment will not be swapped */
 #endif
 
+#ifndef SEMVMX
+# define SEMVMX	32767		/* <= 32767 semaphore maximum value */
+#endif
+#ifndef SHMMAX
+# define SHMMAX 0x2000000	/* max shared segment size in bytes */
+#endif
+#ifndef SHMMIN
+# define SHMMIN 1		/* min shared segment size in bytes */
+#endif
+
 /* For older kernels the same holds for the defines below */
 #ifndef MSG_STAT
 # define MSG_STAT	11
@@ -168,6 +178,90 @@ struct proc_limits {
 };
 /* End of the /proc & /sys structures */
 
+static int msgctl_limits_wrapper(struct proc_limits *lim, int use_proc)
+{
+	struct msginfo msginfo;
+	if (use_proc) {
+		FILE *f;
+		if ((f = fopen(_PATH_PROC_IPC_MSGMNI, "r")) == NULL)
+			return 1;
+		fscanf(f, "%d", &(lim->msgmni));
+		fclose(f);
+		if ((f = fopen(_PATH_PROC_IPC_MSGMNB, "r")) == NULL)
+			return 1;
+		fscanf(f, "%d", &(lim->msgmnb));
+		fclose(f);
+		if ((f = fopen(_PATH_PROC_IPC_MSGMAX, "r")) == NULL)
+			return 1;
+		fscanf(f, "%zu", &(lim->msgmax));
+		fclose(f);
+		return 0;
+	}
+
+	/* proc not in use */
+	if ((msgctl(0, IPC_INFO, (struct msqid_ds *)(void *)&msginfo)) < 0)
+		return 1;
+	lim->msgmni = (int)msginfo.msgmni;
+	lim->msgmnb = (int)msginfo.msgmnb;
+	lim->msgmax = (size_t)msginfo.msgmax;
+	return 0;
+}
+
+static int semctl_limits_wrapper(struct proc_limits *lim, int use_proc)
+{
+	struct seminfo seminfo;
+	union semun arg;
+
+	lim->semvmx = SEMVMX;
+
+	if (use_proc) {
+		FILE *f;
+		if ((f = fopen(_PATH_PROC_IPC_MSG, "r")) == NULL)
+			return 1;
+		fscanf(f, "%d\t%d\t%d\t%d",
+		       &(lim->semmsl),
+		       &(lim->semmns), &(lim->semopm), &(lim->semmni));
+		fclose(f);
+		return 0;
+	}
+
+	/* proc not in use */
+	arg.array = (ushort *) (void *)&seminfo;	/* damn union */
+	if ((semctl(0, 0, IPC_INFO, arg)) < 0)
+		return 1;
+	lim->semmni = (int)seminfo.semmni;
+	lim->semmsl = (int)seminfo.semmsl;
+	lim->semmns = (int)seminfo.semmns;
+	lim->semopm = (int)seminfo.semopm;
+	return 0;
+}
+
+static int shmctl_limits_wrapper(struct proc_limits *lim, int use_proc)
+{
+	struct shminfo shminfo;
+	lim->shmmax = SHMMAX;
+	lim->shmmin = SHMMIN;
+	if (use_proc) {
+		FILE *f;
+		if ((f = fopen(_PATH_PROC_IPC_SHMMNI, "r")) == NULL)
+			return 1;
+		fscanf(f, "%d", &(lim->shmmni));
+		fclose(f);
+		if ((f = fopen(_PATH_PROC_IPC_SHMALL, "r")) == NULL)
+			return 1;
+		fscanf(f, "%zu", &(lim->shmall));
+		fclose(f);
+		return 0;
+	}
+
+	/* proc not in use */
+	if ((shmctl(0, IPC_INFO, (struct shmid_ds *)(void *)&shminfo)) < 0)
+		return 1;
+	lim->shmmni = (int)shminfo.shmmni;
+	lim->shmall = (size_t)shminfo.shmall;
+	return 0;
+}
+
 static int test_ipc_proc_paths(void)
 {
 	if (access(_PATH_PROC_IPCMSG, F_OK) == 0 &&
@@ -183,9 +277,9 @@ static int test_ipc_proc_paths(void)
 	return 0;
 }
 
-void do_shm (char format);
-void do_sem (char format);
-void do_msg (char format);
+void do_shm (char format, int use_proc);
+void do_sem (char format, int use_proc);
+void do_msg (char format, int use_proc);
 void print_shm (int id);
 void print_msg (int id);
 void print_sem (int id);
@@ -305,15 +399,15 @@ int main (int argc, char **argv)
 		printf ("\n");
 
 		if (shm) {
-			do_shm (format);
+			do_shm (format, use_proc);
 			printf ("\n");
 		}
 		if (sem) {
-			do_sem (format);
+			do_sem (format, use_proc);
 			printf ("\n");
 		}
 		if (msg) {
-			do_msg (format);
+			do_msg (format, use_proc);
 			printf ("\n");
 		}
 	}
@@ -346,14 +440,14 @@ static void print_perms (int id, struct ipc_perm *ipcp)
 		printf(" %-10u\n", ipcp->gid);
 }
 
-void do_shm (char format)
+void do_shm (char format, int use_proc)
 {
 	int maxid, shmid, id;
 	struct shmid_ds shmseg;
 	struct shm_info shm_info;
-	struct shminfo shminfo;
 	struct ipc_perm *ipcp = &shmseg.shm_perm;
 	struct passwd *pw;
+	struct proc_limits lim;
 
 	maxid = shmctl (0, SHM_INFO, (struct shmid_ds *) (void *) &shm_info);
 	if (maxid < 0) {
@@ -364,20 +458,13 @@ void do_shm (char format)
 	switch (format) {
 	case LIMITS:
 		printf (_("------ Shared Memory Limits --------\n"));
-		if ((shmctl (0, IPC_INFO, (struct shmid_ds *) (void *) &shminfo)) < 0 )
+		if (shmctl_limits_wrapper(&lim, use_proc))
 			return;
-		/*
-		 * glibc 2.1.3 and all earlier libc's have ints as fields of
-		 * struct shminfo; glibc 2.1.91 has unsigned long; ach
-		 */
-		printf (_("max number of segments = %lu\n"),
-			(unsigned long) shminfo.shmmni);
-		printf (_("max seg size (kbytes) = %lu\n"),
-			(unsigned long) (shminfo.shmmax >> 10));
-		printf (_("max total shared memory (kbytes) = %llu\n"),
-			getpagesize() / 1024 * (unsigned long long) shminfo.shmall);
-		printf (_("min seg size (bytes) = %lu\n"),
-			(unsigned long) shminfo.shmmin);
+		printf (_("max number of segments = %d\n"), lim.shmmni);
+		printf (_("max seg size (kbytes) = %zu\n"), lim.shmmax / 1024);
+		/* FIXME: is use of getpagesize() as multiplier correct? */
+		printf (_("max total shared memory (kbytes) = %zu\n"), (lim.shmall / 1024) * getpagesize());
+		printf (_("min seg size (bytes) = %zu\n"), lim.shmmin);
 		return;
 
 	case STATUS:
@@ -489,7 +576,7 @@ void do_shm (char format)
 	return;
 }
 
-void do_sem (char format)
+void do_sem (char format, int use_proc)
 {
 	int maxid, semid, id;
 	struct semid_ds semary;
@@ -497,6 +584,7 @@ void do_sem (char format)
 	struct ipc_perm *ipcp = &semary.sem_perm;
 	struct passwd *pw;
 	union semun arg;
+	struct proc_limits lim;
 
 	arg.array = (ushort *)  (void *) &seminfo;
 	maxid = semctl (0, 0, SEM_INFO, arg);
@@ -508,14 +596,13 @@ void do_sem (char format)
 	switch (format) {
 	case LIMITS:
 		printf (_("------ Semaphore Limits --------\n"));
-		arg.array = (ushort *) (void *) &seminfo; /* damn union */
-		if ((semctl (0, 0, IPC_INFO, arg)) < 0 )
+		if (semctl_limits_wrapper(&lim, use_proc))
 			return;
-		printf (_("max number of arrays = %d\n"), seminfo.semmni);
-		printf (_("max semaphores per array = %d\n"), seminfo.semmsl);
-		printf (_("max semaphores system wide = %d\n"), seminfo.semmns);
-		printf (_("max ops per semop call = %d\n"), seminfo.semopm);
-		printf (_("semaphore max value = %d\n"), seminfo.semvmx);
+		printf (_("max number of arrays = %d\n"), lim.semmni);
+		printf (_("max semaphores per array = %d\n"), lim.semmsl);
+		printf (_("max semaphores system wide = %d\n"), lim.semmns);
+		printf (_("max ops per semop call = %d\n"), lim.semopm);
+		printf (_("semaphore max value = %d\n"), lim.semvmx);
 		return;
 
 	case STATUS:
@@ -590,13 +677,14 @@ void do_sem (char format)
 	}
 }
 
-void do_msg (char format)
+void do_msg (char format, int use_proc)
 {
 	int maxid, msqid, id;
 	struct msqid_ds msgque;
 	struct msginfo msginfo;
 	struct ipc_perm *ipcp = &msgque.msg_perm;
 	struct passwd *pw;
+	struct proc_limits lim;
 
 	maxid = msgctl (0, MSG_INFO, (struct msqid_ds *) (void *) &msginfo);
 	if (maxid < 0) {
@@ -606,12 +694,12 @@ void do_msg (char format)
 
 	switch (format) {
 	case LIMITS:
-		if ((msgctl (0, IPC_INFO, (struct msqid_ds *) (void *) &msginfo)) < 0 )
+		if (msgctl_limits_wrapper(&lim, use_proc))
 			return;
 		printf (_("------ Messages Limits --------\n"));
-		printf (_("max queues system wide = %d\n"), msginfo.msgmni);
-		printf (_("max size of message (bytes) = %d\n"), msginfo.msgmax);
-		printf (_("default max size of queue (bytes) = %d\n"), msginfo.msgmnb);
+		printf (_("max queues system wide = %d\n"), lim.msgmni);
+		printf (_("max size of message (bytes) = %zu\n"), lim.msgmax);
+		printf (_("default max size of queue (bytes) = %d\n"), lim.msgmnb);
 		return;
 
 	case STATUS:
-- 
1.7.12.3

