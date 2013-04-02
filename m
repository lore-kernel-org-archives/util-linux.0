Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38167 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:16 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so844567wgg.0
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/13] fsfreeze: tell user when mandatory option is not specified
Date: Tue,  2 Apr 2013 20:42:49 +0100
Message-Id: <1364931777-2645-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit also removes use of internal magic values by replacing them
with a enum definition.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fsfreeze.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index 122d95c..961f8c1 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -27,6 +27,12 @@
 #include "closestream.h"
 #include "optutils.h"
 
+enum fs_operation {
+	NOOP,
+	FREEZE,
+	UNFREEZE
+};
+
 static int freeze_f(int fd)
 {
 	return ioctl(fd, FIFREEZE, 0);
@@ -56,7 +62,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 int main(int argc, char **argv)
 {
 	int fd = -1, c;
-	int freeze = -1, rc = EXIT_FAILURE;
+	int action = NOOP, rc = EXIT_FAILURE;
 	char *path;
 	struct stat sb;
 
@@ -88,10 +94,10 @@ int main(int argc, char **argv)
 			usage(stdout);
 			break;
 		case 'f':
-			freeze = TRUE;
+			action = FREEZE;
 			break;
 		case 'u':
-			freeze = FALSE;
+			action = UNFREEZE;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -102,8 +108,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (freeze == -1)
-		usage(stderr);
+	if (action == NOOP)
+		errx(EXIT_FAILURE, _("neither --freeze or --unfreeze specified"));
 	if (optind == argc)
 		errx(EXIT_FAILURE, _("no filename specified"));
 	path = argv[optind++];
@@ -127,16 +133,21 @@ int main(int argc, char **argv)
 		goto done;
 	}
 
-	if (freeze) {
+	switch (action) {
+	case FREEZE:
 		if (freeze_f(fd)) {
 			warn(_("%s: freeze failed"), path);
 			goto done;
 		}
-	} else {
+		break;
+	case UNFREEZE:
 		if (unfreeze_f(fd)) {
 			warn(_("%s: unfreeze failed"), path);
 			goto done;
 		}
+		break;
+	default:
+		abort();
 	}
 
 	rc = EXIT_SUCCESS;
-- 
1.8.2

