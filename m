Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:44373 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab3AIThK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 14:37:10 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so763375wib.10
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 11:37:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] ipcmk: allow user to create more ipc resources at a time
Date: Wed,  9 Jan 2013 19:36:55 +0000
Message-Id: <1357760216-4068-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
References: <1357760216-4068-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no reason why 'ipcmk -Q -Q' would should not work, so allow that
and any other combination of switches such as:

ipcmk -Q -Q -p 700 -M 42 -Q -S 13

The behavior of '-p' changed in this commit.  Permissions affect the
resources mentioned after the permission option.  Earlier the last
permission option took effect across different resources.  Notice that
formerly user could create one of each shm, msg, and sem simultaneously.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcmk.1 |   3 +-
 sys-utils/ipcmk.c | 110 ++++++++++++++++++++++++++++--------------------------
 2 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index 0900a19..b9775a4 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -29,7 +29,8 @@ Message queue.
 .SH "ADDITIONAL OPTIONS"
 .TP
 \fB\-p\fR, \fB\-\-mode\fR [\fImode\fR]
-Permission for the resource. Default is 0644.
+Access permissions for the resource.  The mode will take effect for
+resources that are defined after the option.  Default mode is 0644.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display a short help message and exit.
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index 9b943b7..8d15028 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -36,22 +36,49 @@
 #include "closestream.h"
 #include "randutils.h"
 
-static int create_shm(size_t size, int permission)
+enum res_types {
+	SHM = 0,
+	MSG,
+	SEM
+};
+
+const char *res_messages[] = {
+	[SHM] = N_("shared memory"),
+	[MSG] = N_("message queue"),
+	[SEM] = N_("semaphore")
+};
+
+struct ipc_res {
+	int type;
+	int perm;
+	size_t size;
+	int nsems;
+	struct ipc_res *next;
+};
+
+static int create_res(struct ipc_res *res)
 {
+	int ret;
 	key_t key = random();
-	return shmget(key, size, permission | IPC_CREAT);
-}
-
-static int create_msg(int permission)
-{
-	key_t key = random();
-	return msgget(key, permission | IPC_CREAT);
-}
-
-static int create_sem(int nsems, int permission)
-{
-	key_t key = random();
-	return semget(key, nsems, permission | IPC_CREAT);
+	switch (res->type) {
+	case SHM:
+		ret = shmget(key, res->size, res->perm | IPC_CREAT);
+		break;
+	case MSG:
+		ret = msgget(key, res->perm | IPC_CREAT);
+		break;
+	case SEM:
+		ret = semget(key, res->nsems, res->perm | IPC_CREAT);
+		break;
+	default:
+		abort();
+	}
+	if (ret == -1) {
+		warn(_("create %s failed"), res_messages[res->type]);
+		return 1;
+	}
+	printf(_("%s id: %d\n"), res_messages[res->type], ret);
+	return 0;
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -74,11 +101,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 int main(int argc, char **argv)
 {
-	int permission = 0644;
+	struct ipc_res res;
 	int opt;
-	size_t size = 0;
-	int nsems = 0;
-	int ask_shm = 0, ask_msg = 0, ask_sem = 0;
+	int ret = EXIT_SUCCESS;
 	static const struct option longopts[] = {
 		{"shmem", required_argument, NULL, 'M'},
 		{"semaphore", required_argument, NULL, 'S'},
@@ -93,23 +118,29 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
+	if (argc < 2)
+		usage(stderr);
 	seed_random();
 
+	res.perm = 0644;
 	while((opt = getopt_long(argc, argv, "hM:QS:p:Vh", longopts, NULL)) != -1) {
 		switch(opt) {
 		case 'M':
-			size = strtou64_or_err(optarg, _("failed to parse size"));
-			ask_shm = 1;
+			res.type = SHM;
+			res.size = strtou64_or_err(optarg, _("failed to parse size"));
+			ret |= create_res(&res);
 			break;
 		case 'Q':
-			ask_msg = 1;
+			res.type = MSG;
+			ret |= create_res(&res);
 			break;
 		case 'S':
-			nsems = strtos32_or_err(optarg, _("failed to parse elements"));
-			ask_sem = 1;
+			res.type = SEM;
+			res.nsems = strtos32_or_err(optarg, _("failed to parse elements"));
+			ret |= create_res(&res);
 			break;
 		case 'p':
-			permission = strtoul(optarg, NULL, 8);
+			res.perm = strtoul(optarg, NULL, 8);
 			break;
 		case 'h':
 			usage(stdout);
@@ -118,37 +149,10 @@ int main(int argc, char **argv)
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		default:
-			ask_shm = ask_msg = ask_sem = 0;
+			usage(stderr);
 			break;
 		}
 	}
 
-	if(!ask_shm && !ask_msg && !ask_sem)
-		usage(stderr);
-
-	if (ask_shm) {
-		int shmid;
-		if (-1 == (shmid = create_shm(size, permission)))
-			err(EXIT_FAILURE, _("create share memory failed"));
-		else
-			printf(_("Shared memory id: %d\n"), shmid);
-	}
-
-	if (ask_msg) {
-		int msgid;
-		if (-1 == (msgid = create_msg(permission)))
-			err(EXIT_FAILURE, _("create message queue failed"));
-		else
-			printf(_("Message queue id: %d\n"), msgid);
-	}
-
-	if (ask_sem) {
-		int semid;
-		if (-1 == (semid = create_sem(nsems, permission)))
-			err(EXIT_FAILURE, _("create semaphore failed"));
-		else
-			printf(_("Semaphore id: %d\n"), semid);
-	}
-
-	return EXIT_SUCCESS;
+	return ret;
 }
-- 
1.8.1

