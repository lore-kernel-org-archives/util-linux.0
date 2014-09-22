Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:60801 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754593AbaIVUQR (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:16:17 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/10] textual: there may be no space between option and optional =arg
Date: Mon, 22 Sep 2014 22:15:40 +0200
Message-Id: <1411416940-3249-10-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/nsenter.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 7da44e7..c54d63f 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -67,16 +67,16 @@ static void usage(int status)
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -t, --target <pid>     target process to get namespaces from\n"), out);
-	fputs(_(" -m, --mount [=<file>]  enter mount namespace\n"), out);
-	fputs(_(" -u, --uts   [=<file>]  enter UTS namespace (hostname etc)\n"), out);
-	fputs(_(" -i, --ipc   [=<file>]  enter System V IPC namespace\n"), out);
-	fputs(_(" -n, --net   [=<file>]  enter network namespace\n"), out);
-	fputs(_(" -p, --pid   [=<file>]  enter pid namespace\n"), out);
-	fputs(_(" -U, --user  [=<file>]  enter user namespace\n"), out);
+	fputs(_(" -m, --mount[=<file>]   enter mount namespace\n"), out);
+	fputs(_(" -u, --uts[=<file>]     enter UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc[=<file>]     enter System V IPC namespace\n"), out);
+	fputs(_(" -n, --net[=<file>]     enter network namespace\n"), out);
+	fputs(_(" -p, --pid[=<file>]     enter pid namespace\n"), out);
+	fputs(_(" -U, --user[=<file>]    enter user namespace\n"), out);
 	fputs(_(" -S, --setuid <uid>     set uid in entered namespace\n"), out);
 	fputs(_(" -G, --setgid <gid>     set gid in entered namespace\n"), out);
-	fputs(_(" -r, --root  [=<dir>]   set the root directory\n"), out);
-	fputs(_(" -w, --wd    [=<dir>]   set the working directory\n"), out);
+	fputs(_(" -r, --root[=<dir>]     set the root directory\n"), out);
+	fputs(_(" -w, --wd[=<dir>]       set the working directory\n"), out);
 	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-- 
1.7.0.4

