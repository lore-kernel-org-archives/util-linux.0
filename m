Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:33495 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab2JNUWb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:31 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680722wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/13] ipcs: add /proc and /sys path definitions
Date: Sun, 14 Oct 2012 21:22:14 +0100
Message-Id: <1350246145-10600-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The necessary proc and sysfs files are tested to be present.  When
information files are missing the ipcs will use obsolted systems, and
data structures, as fallback.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h | 11 +++++++++++
 sys-utils/ipcs.c    | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/pathnames.h b/include/pathnames.h
index d0ed7a1..99b8417 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -150,5 +150,16 @@
 /* wdctl path */
 #define _PATH_WATCHDOG_DEV	"/dev/watchdog"
 
+/* ipc paths */
+#define _PATH_PROC_IPCMSG	"/proc/sysvipc/msg"
+#define _PATH_PROC_IPCSEM	"/proc/sysvipc/sem"
+#define _PATH_PROC_IPCSHM	"/proc/sysvipc/shm"
+#define _PATH_PROC_IPC_MSGMAX	"/proc/sys/kernel/msgmax"
+#define _PATH_PROC_IPC_MSGMNB	"/proc/sys/kernel/msgmnb"
+#define _PATH_PROC_IPC_MSGMNI	"/proc/sys/kernel/msgmni"
+#define _PATH_PROC_IPC_MSG	"/proc/sys/kernel/sem"
+#define _PATH_PROC_IPC_SHMALL	"/proc/sys/kernel/shmall"
+#define _PATH_PROC_IPC_SHMMNI	"/proc/sys/kernel/shmmni"
+
 #endif /* PATHNAMES_H */
 
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index ca10c3d..900fc65 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -34,6 +34,7 @@
 #include "c.h"
 #include "nls.h"
 #include "closestream.h"
+#include "pathnames.h"
 
 /*
  * SHM_DEST and SHM_LOCKED are defined in kernel headers, but inside
@@ -167,6 +168,21 @@ struct proc_limits {
 };
 /* End of the /proc & /sys structures */
 
+static int test_ipc_proc_paths(void)
+{
+	if (access(_PATH_PROC_IPCMSG, F_OK) == 0 &&
+	    access(_PATH_PROC_IPCSEM, F_OK) == 0 &&
+	    access(_PATH_PROC_IPCSHM, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_MSGMAX, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_MSGMNB, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_MSGMNI, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_MSG, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_SHMALL, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_SHMMNI, F_OK) == 0)
+		return 1;
+	return 0;
+}
+
 void do_shm (char format);
 void do_sem (char format);
 void do_msg (char format);
@@ -203,6 +219,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 int main (int argc, char **argv)
 {
 	int opt, msg = 0, sem = 0, shm = 0, id=0, print=0;
+	int use_proc = 0;
 	char format = 0;
 	static const struct option longopts[] = {
 		{"id", required_argument, NULL, 'i'},
@@ -269,6 +286,10 @@ int main (int argc, char **argv)
 		}
 	}
 
+	use_proc = test_ipc_proc_paths();
+	if (!use_proc)
+		warnx(_("using unreliable syscalls"));
+
 	if  (print) {
 		if (shm)
 			print_shm (id);
-- 
1.7.12.3

