Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:55522 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932993AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LaoHI-1aAdKd3abw-00kOj0 for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:03 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/12] wipefs, sfdisk: include libgen.h for basename(3p)
Date: Tue,  8 Mar 2016 00:11:51 +0100
Message-Id: <1457392322-4974-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/sfdisk.c | 1 +
 misc-utils/wipefs.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 81371eb..14c7cc0 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -35,6 +35,7 @@
 #ifdef HAVE_LIBREADLINE
 # include <readline/readline.h>
 #endif
+#include <libgen.h>
 
 #include "c.h"
 #include "xalloc.h"
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 5948944..abcf5eb 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -29,6 +29,7 @@
 #include <getopt.h>
 #include <string.h>
 #include <limits.h>
+#include <libgen.h>
 
 #include <blkid.h>
 
@@ -378,9 +379,12 @@ do_wipe(struct wipe_desc *wp, const char *devname, int flags)
 
 	if (zap && (flags & WP_FL_BACKUP)) {
 		const char *home = getenv ("HOME");
+		char *tmp = xstrdup(devname);
+
 		if (!home)
 			errx(EXIT_FAILURE, _("failed to create a signature backup, $HOME undefined"));
-		xasprintf (&backup, "%s/wipefs-%s-", home, basename(devname));
+		xasprintf (&backup, "%s/wipefs-%s-", home, basename(tmp));
+		free(tmp);
 	}
 
 	wp0 = clone_offset(wp);
-- 
1.9.1

