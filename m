Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33428 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcBVFK4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Feb 2016 00:10:56 -0500
Received: by mail-pa0-f53.google.com with SMTP id fl4so84870151pad.0
        for <util-linux@vger.kernel.org>; Sun, 21 Feb 2016 21:10:56 -0800 (PST)
Date: Sun, 21 Feb 2016 21:10:24 -0800
From: Hushan Jia <hushan.jia@gmail.com>
To: util-linux@vger.kernel.org
Cc: hushan.jia@gmail.com
Subject: [PATCH] ipcs: show gid instead of uid
Message-ID: <20160222051024.GE23038@sfo-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Hushan Jia <hushan.jia@gmail.com>

ipcs -i incorrectly used uid where it should be gid

Signed-off-by: Hushan Jia <hushan.jia@gmail.com>
---
 sys-utils/ipcs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index eaab922..5877c46 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -572,7 +572,7 @@ static void print_shm(int shmid, int unit)
 
 	printf(_("\nShared memory Segment shmid=%d\n"), shmid);
 	printf(_("uid=%u\tgid=%u\tcuid=%u\tcgid=%u\n"),
-	       shmdata->shm_perm.uid, shmdata->shm_perm.uid,
+	       shmdata->shm_perm.uid, shmdata->shm_perm.gid,
 	       shmdata->shm_perm.cuid, shmdata->shm_perm.cgid);
 	printf(_("mode=%#o\taccess_perms=%#o\n"), shmdata->shm_perm.mode,
 	       shmdata->shm_perm.mode & 0777);
@@ -602,7 +602,7 @@ void print_msg(int msgid, int unit)
 
 	printf(_("\nMessage Queue msqid=%d\n"), msgid);
 	printf(_("uid=%u\tgid=%u\tcuid=%u\tcgid=%u\tmode=%#o\n"),
-	       msgdata->msg_perm.uid, msgdata->msg_perm.uid,
+	       msgdata->msg_perm.uid, msgdata->msg_perm.gid,
 	       msgdata->msg_perm.cuid, msgdata->msg_perm.cgid,
 	       msgdata->msg_perm.mode);
 	ipc_print_size(unit, unit == IPC_UNIT_HUMAN ? _("csize=") : _("cbytes="),
@@ -635,7 +635,7 @@ static void print_sem(int semid)
 
 	printf(_("\nSemaphore Array semid=%d\n"), semid);
 	printf(_("uid=%u\t gid=%u\t cuid=%u\t cgid=%u\n"),
-	       semdata->sem_perm.uid, semdata->sem_perm.uid,
+	       semdata->sem_perm.uid, semdata->sem_perm.gid,
 	       semdata->sem_perm.cuid, semdata->sem_perm.cgid);
 	printf(_("mode=%#o, access_perms=%#o\n"),
 	       semdata->sem_perm.mode, semdata->sem_perm.mode & 0777);
-- 
2.4.3

