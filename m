Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36278 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdBMWGx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so541701wmd.3
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:53 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/7] findmnt: fix couple memory leaks [cppcheck]
Date: Mon, 13 Feb 2017 22:06:41 +0000
Message-Id: <20170213220641.1395-8-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In both cases FILE *f was leaked.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/findmnt-verify.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/findmnt-verify.c b/misc-utils/findmnt-verify.c
index b2a88c5f6..e3fb391d4 100644
--- a/misc-utils/findmnt-verify.c
+++ b/misc-utils/findmnt-verify.c
@@ -328,14 +328,15 @@ static int read_proc_filesystems(struct verify_context *vfy)
 
 		rc = add_filesystem(vfy, cp);
 		if (rc)
-			return rc;
+			break;
 	}
 	fclose(f);
-	return 0;
+	return rc;
 }
 
 static int read_kernel_filesystems(struct verify_context *vfy)
 {
+	int rc = 0;
 #ifdef __linux__
 	struct utsname uts;
 	FILE *f;
@@ -351,7 +352,6 @@ static int read_kernel_filesystems(struct verify_context *vfy)
 
 	while (!feof(f)) {
 		char *p, *name;
-		int rc;
 
 		if (!fgets(buf, sizeof(buf), f))
 			break;
@@ -377,11 +377,11 @@ static int read_kernel_filesystems(struct verify_context *vfy)
 
 		rc = add_filesystem(vfy, name);
 		if (rc)
-			return rc;
+			break;
 	}
 	fclose(f);
 #endif /* __linux__ */
-	return 0;
+	return rc;
 }
 
 static int verify_fstype(struct verify_context *vfy)
-- 
2.11.1

