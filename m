Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33662 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab3AVX1Y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:24 -0500
Received: by mail-wi0-f172.google.com with SMTP id o1so189660wic.5
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:23 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/14] nsenter: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:01 +0000
Message-Id: <1358897233-6676-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/nsenter.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 0a4985c..c16b8d1 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -64,17 +64,17 @@ static void usage(int status)
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -t, --target <pid>     target process to get namespaces from\n"
-		" -m, --mount [=<file>]  enter mount namespace\n"
-		" -u, --uts   [=<file>]  enter UTS namespace (hostname etc)\n"
-		" -i, --ipc   [=<file>]  enter System V IPC namespace\n"
-		" -n, --net   [=<file>]  enter network namespace\n"
-		" -p, --pid   [=<file>]  enter pid namespace\n"
-		" -U, --user  [=<file>]  enter user namespace\n"
-		" -r, --root  [=<dir>]   set the root directory\n"
-		" -w, --wd    [=<dir>]   set the working directory\n"
-		" -a, --all              set root and cwd and enter namespaces listed above\n"
-		" -F, --no-fork          don't fork before exec'ing <program>\n"), out);
+	fputs(_(" -t, --target <pid>     target process to get namespaces from\n"), out);
+	fputs(_(" -m, --mount [=<file>]  enter mount namespace\n"), out);
+	fputs(_(" -u, --uts   [=<file>]  enter UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc   [=<file>]  enter System V IPC namespace\n"), out);
+	fputs(_(" -n, --net   [=<file>]  enter network namespace\n"), out);
+	fputs(_(" -p, --pid   [=<file>]  enter pid namespace\n"), out);
+	fputs(_(" -U, --user  [=<file>]  enter user namespace\n"), out);
+	fputs(_(" -r, --root  [=<dir>]   set the root directory\n"), out);
+	fputs(_(" -w, --wd    [=<dir>]   set the working directory\n"), out);
+	fputs(_(" -a, --all              set root and cwd and enter namespaces listed above\n"), out);
+	fputs(_(" -F, --no-fork          do not fork before exec'ing <program>\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
-- 
1.8.1.1

