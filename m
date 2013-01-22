Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:65271 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:50 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so190185wib.4
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:48 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/14] unshare: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:11 +0000
Message-Id: <1358897233-6676-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/unshare.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index c891cb5..804c882 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -39,12 +39,12 @@ static void usage(int status)
 	      _(" %s [options] <program> [args...]\n"),	program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -m, --mount       unshare mounts namespace\n"
-		" -u, --uts         unshare UTS namespace (hostname etc)\n"
-		" -i, --ipc         unshare System V IPC namespace\n"
-		" -n, --net         unshare network namespace\n"
-		" -p, --pid         unshare pid namespace\n"
-		" -U, --user        unshare user namespace\n"), out);
+	fputs(_(" -m, --mount       unshare mounts namespace\n"), out);
+	fputs(_(" -u, --uts         unshare UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc         unshare System V IPC namespace\n"), out);
+	fputs(_(" -n, --net         unshare network namespace\n"), out);
+	fputs(_(" -p, --pid         unshare pid namespace\n"), out);
+	fputs(_(" -U, --user        unshare user namespace\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
1.8.1.1

