Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:64289 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab2JNUWa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:30 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680717wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/13] ipcs: add data structures to read state from /proc & /sys
Date: Sun, 14 Oct 2012 21:22:13 +0100
Message-Id: <1350246145-10600-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 2fbca08..ca10c3d 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -106,6 +106,67 @@ union semun {
 #define TIME 4
 #define PID 5
 
+/* Structures that are populated by using /proc and /sys data.  The
+ * struct type names are aligned with with kernel similar structures in
+ * kernel code. */
+struct ipc_stat {
+	int		id;
+	key_t		key;
+	uid_t		uid;		/* current uid */
+	gid_t		gid;		/* current gid */
+	uid_t		cuid;		/* creator uid */
+	gid_t		cgid;		/* creator gid */
+	unsigned int	mode;
+};
+struct sem_data {
+	struct ipc_stat	sem_perm;
+	time_t		sem_otime;
+	time_t		sem_ctime;
+	unsigned long	sem_nsems;
+	struct sem_data	*next;
+};
+struct shm_data {
+	struct ipc_stat	shm_perm;
+	unsigned long	shm_nattch;
+	unsigned long	shm_segsz;
+	time_t		shm_atim;
+	time_t		shm_dtim;
+	time_t		shm_ctim;
+	pid_t		shm_cprid;
+	pid_t		shm_lprid;
+	unsigned long	shm_rss;
+	unsigned long	shm_swp;
+	struct shm_data	*next;
+};
+struct msg_data {
+	struct ipc_stat	msg_perm;
+	time_t		q_stime;
+	time_t		q_rtime;
+	time_t		q_ctime;
+	unsigned long	q_qnum;
+	unsigned long	q_cbytes;
+	pid_t		q_lspid;
+	pid_t		q_lrpid;
+	struct msg_data	*next;
+};
+struct proc_limits {
+	int		shmmni;		/* max number of segments */
+	size_t		shmmax;		/* max segment size (constant) */
+	size_t		shmall;		/* max total shared memory */
+	size_t		shmmin;		/* min segment size (constant) */
+
+	int		semmni;		/* max number of arrays */
+	int		semmsl;		/* max semaphores per array */
+	int		semmns;		/* max semaphores system wide */
+	int		semopm;		/* max ops per semop call */
+	unsigned int	semvmx;		/* semaphore max value (constant) */
+
+	int		msgmni;		/* max queues system wide*/
+	size_t		msgmax;		/* max size of message */
+	int		msgmnb;		/* default max size of queue */
+};
+/* End of the /proc & /sys structures */
+
 void do_shm (char format);
 void do_sem (char format);
 void do_msg (char format);
-- 
1.7.12.3

