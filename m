Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f53.google.com ([209.85.210.53]:43817 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab3CYJeZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 25 Mar 2013 05:34:25 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so2011861dal.26
        for <util-linux@vger.kernel.org>; Mon, 25 Mar 2013 02:34:25 -0700 (PDT)
From: Daniel Stodden <daniel.stodden@googlemail.com>
To: util-linux@vger.kernel.org
Cc: Daniel Stodden <daniel.stodden@gmail.com>
Subject: [PATCH] schedutils: don't apply -a without -p
Date: Mon, 25 Mar 2013 02:33:59 -0700
Message-Id: <1364204039-18148-1-git-send-email-daniel.stodden@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The unsuspecting user might use taskset -a mask command. Behavior then
is to exec with no affinity applied at all. Better handled by ignoring
all_tasks if no pid was given.

Signed-off-by: Daniel Stodden <daniel.stodden@gmail.com>
---
 schedutils/taskset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index aba0b6f..c2b9ab6 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 		     argv[optind]);
 	}
 
-	if (all_tasks) {
+	if (all_tasks && pid) {
 		struct proc_tasks *tasks = proc_open_tasks(pid);
 		while (!proc_next_tid(tasks, &ts.pid))
 			do_taskset(&ts, new_setsize, new_set);
-- 
1.7.10.4

