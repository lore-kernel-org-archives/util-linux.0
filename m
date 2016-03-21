Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58427 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466AbcCUNEt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 09:04:49 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LviG8-1ZjFZr2kcW-017YWB for
 <util-linux@vger.kernel.org>; Mon, 21 Mar 2016 14:04:47 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] ipcs: consolidate output header printing
Date: Mon, 21 Mar 2016 14:04:45 +0100
Message-Id: <1458565485-27856-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
References: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Print a warning (instead of header) if --limits fails, like we did
it in past (2.20.1) and like we are still doing for --summary. Note
in past we were printing the same message like for --summary
"kernel not configured for ...", but actually this message is not
really correct.

This patch simply consolidates the current behavior. Probably we
should refactor it regarding warnings (stderr) and exit codes.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/ipcs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 0ebcc4c..10ce238 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -199,9 +199,11 @@ static void do_shm (char format, int unit)
 	{
 		struct ipc_limits lim;
 
-		printf (_("------ Shared Memory Limits --------\n"));
-		if (ipc_shm_get_limits(&lim))
+		if (ipc_shm_get_limits(&lim)) {
+			printf (_("unable to fetch shared memory limits\n"));
 			return;
+		}
+		printf (_("------ Shared Memory Limits --------\n"));
 		printf (_("max number of segments = %ju\n"), lim.shmmni);
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB : unit,
 			       _("max seg size"), lim.shmmax, "\n", 0);
@@ -351,9 +353,11 @@ static void do_sem (char format)
 	{
 		struct ipc_limits lim;
 
-		printf (_("------ Semaphore Limits --------\n"));
-		if (ipc_sem_get_limits(&lim))
+		if (ipc_sem_get_limits(&lim)) {
+			printf (_("unable to fetch semaphore limits\n"));
 			return;
+		}
+		printf (_("------ Semaphore Limits --------\n"));
 		printf (_("max number of arrays = %d\n"), lim.semmni);
 		printf (_("max semaphores per array = %d\n"), lim.semmsl);
 		printf (_("max semaphores system wide = %d\n"), lim.semmns);
@@ -451,8 +455,10 @@ static void do_msg (char format, int unit)
 	{
 		struct ipc_limits lim;
 
-		if (ipc_msg_get_limits(&lim))
+		if (ipc_msg_get_limits(&lim)) {
+			printf (_("unable to fetch message limits\n"));
 			return;
+		}
 		printf (_("------ Messages Limits --------\n"));
 		printf (_("max queues system wide = %d\n"), lim.msgmni);
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_BYTES : unit,
-- 
1.8.4.5

