Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:46624 "EHLO
	resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932080AbbLOT5A (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Dec 2015 14:57:00 -0500
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] lsns: Fix "lowers" -> "lowest" typo in --help for COL_PID
Date: Tue, 15 Dec 2015 11:46:25 -0800
Message-Id: <6f39368494ffaa0d34810182e583543ed4ae7980.1450208687.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The process-selection logic is in add_process_to_namespace:

  if (!ns->proc || ns->proc->pid > proc->pid)
    ns->proc = proc;

so it's just selecting the lowest PID.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/lsns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 7918934..725d8a4 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -84,7 +84,7 @@ static const struct colinfo infos[] = {
 	[COL_TYPE]    = { "TYPE",    5, 0, N_("kind of namespace") },
 	[COL_PATH]    = { "PATH",    0, 0, N_("path to the namespace")},
 	[COL_NPROCS]  = { "NPROCS",  5, SCOLS_FL_RIGHT, N_("number of processes in the namespace") },
-	[COL_PID]     = { "PID",     5, SCOLS_FL_RIGHT, N_("lowers PID in the namespace") },
+	[COL_PID]     = { "PID",     5, SCOLS_FL_RIGHT, N_("lowest PID in the namespace") },
 	[COL_PPID]    = { "PPID",    5, SCOLS_FL_RIGHT, N_("PPID of the PID") },
 	[COL_COMMAND] = { "COMMAND", 0, SCOLS_FL_TRUNC, N_("command line of the PID")},
 	[COL_UID]     = { "UID",     0, SCOLS_FL_RIGHT, N_("UID of the PID")},
-- 
2.1.0.60.g85f0837

