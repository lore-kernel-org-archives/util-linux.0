Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:20240 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab2CBM7f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Mar 2012 07:59:35 -0500
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M09009G1AM2PS80@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 02 Mar 2012 12:58:50 +0100 (CET)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M0900A1ZAM23FA0@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 02 Mar 2012 12:58:50 +0100 (CET)
Date: Fri, 02 Mar 2012 14:00:06 +0100
From: Davidlohr Bueso <dbueso@aomail.uab.es>
Subject: [PATCH] lslocks: add personality column
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1330693206.23371.0.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

By knowing the lock's personality (flock or posix), the user can have more information
about the lock and how it was created.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/lslocks.8 |    5 +++++
 misc-utils/lslocks.c |   30 ++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 3257d79..86aac47 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -37,6 +37,9 @@ The command name of the process holding the lock.
 .IP "PID"
 Process ID which holds the lock.
 
+.IP "PERSONALITY"
+Type of lock, can be FLOCK (created with flock(2)) or POSIX (created with fcntl(2) and lockf(2))
+
 .IP "SIZE"
 Size of the locked file.
 
@@ -71,6 +74,8 @@ Davidlohr Bueso <dave@gnu.org>
 
 .SH "SEE ALSO"
 .BR flock (1)
+.BR fcntl (2)
+.BR lockf (2)
 
 .SH AVAILABILITY
 The lslocks command is part of the util-linux package and is available from
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 39ab18d..aed94c4 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -45,6 +45,7 @@
 enum {
 	COL_SRC = 0,
 	COL_PID,
+	COL_PERSONALITY,
 	COL_SIZE,
 	COL_ACCESS,
 	COL_M,
@@ -63,14 +64,15 @@ struct colinfo {
 
 /* columns descriptions */
 static struct colinfo infos[] = {
-	[COL_SRC]     = { "COMMAND", 15, 0, N_("command of the process holding the lock") },
-	[COL_PID]     = { "PID",     5,  TT_FL_RIGHT, N_("PID of the process holding the lock") },
-	[COL_SIZE]    = { "SIZE",    4,  TT_FL_RIGHT, N_("size of the lock") },
-	[COL_ACCESS]  = { "ACCESS",  5,  0, N_("lock access type") },
-	[COL_M]       = { "M",       1,  0, N_("mandatory state of the lock: 0 (none), 1 (set)")},
-	[COL_START]   = { "START",   10, TT_FL_RIGHT, N_("relative byte offset of the lock")},
-	[COL_END]     = { "END",     10, TT_FL_RIGHT, N_("ending offset of the lock")},
-	[COL_PATH]    = { "PATH",    0,  TT_FL_TRUNC, N_("path of the locked file")},
+	[COL_SRC]         = { "COMMAND",     15, 0, N_("command of the process holding the lock") },
+	[COL_PID]         = { "PID",         5,  TT_FL_RIGHT, N_("PID of the process holding the lock") },
+	[COL_PERSONALITY] = { "PERSONALITY", 5,  TT_FL_RIGHT, N_("kind of lock: FL_FLOCK or FL_POSIX.") },
+	[COL_SIZE]        = { "SIZE",        4,  TT_FL_RIGHT, N_("size of the lock") },
+	[COL_ACCESS]      = { "ACCESS",      5,  0, N_("lock access type") },
+	[COL_M]           = { "M",           1,  0, N_("mandatory state of the lock: 0 (none), 1 (set)")},
+	[COL_START]       = { "START",       10, TT_FL_RIGHT, N_("relative byte offset of the lock")},
+	[COL_END]         = { "END",         10, TT_FL_RIGHT, N_("ending offset of the lock")},
+	[COL_PATH]        = { "PATH",        0,  TT_FL_TRUNC, N_("path of the locked file")},
 };
 #define NCOLS ARRAY_SIZE(infos)
 static int columns[NCOLS], ncolumns;
@@ -84,6 +86,7 @@ struct lock {
 	char *cmdname;
 	pid_t pid;
 	char *path;
+	char *personality;
 	char *type;
 	off_t start;
 	off_t end;
@@ -248,8 +251,9 @@ static int get_local_locks(struct list_head *locks)
 			 * separated by ' ' - check <kernel>/fs/locks.c
 			 */
 			switch (i) {
-			case 0:
-			case 1: /* not intereted! */
+			case 0: /* not intereted! */
+			case 1: /* posix, flock, etc */
+				l->personality = xstrdup(tok);
 				break;
 
 			case 2: /* is this a mandatory lock? other values are advisory or noinode */
@@ -310,6 +314,7 @@ static int get_local_locks(struct list_head *locks)
 			free(l->size);
 			free(l->type);
 			free(l->cmdname);
+			free(l->personality);
 			free(l);
 
 			continue;
@@ -362,6 +367,7 @@ static void rem_lock(struct lock *lock)
 	free(lock->size);
 	free(lock->type);
 	free(lock->cmdname);
+	free(lock->personality);
 	list_del(&lock->locks);
 	free(lock);
 }
@@ -397,6 +403,9 @@ static void add_tt_line(struct tt *tt, struct lock *l)
 		case COL_PID:
 			rc = asprintf(&str, "%d", l->pid);
 			break;
+		case COL_PERSONALITY:
+			rc = asprintf(&str, "%s", l->personality);
+			break;
 		case COL_SIZE:
 			rc = asprintf(&str, "%s", l->size);
 			break;
@@ -546,6 +555,7 @@ int main(int argc, char *argv[])
 		/* default columns */
 		columns[ncolumns++] = COL_SRC;
 		columns[ncolumns++] = COL_PID;
+		columns[ncolumns++] = COL_PERSONALITY;
 		columns[ncolumns++] = COL_SIZE;
 		columns[ncolumns++] = COL_ACCESS;
 		columns[ncolumns++] = COL_M;
-- 
1.7.8.3



