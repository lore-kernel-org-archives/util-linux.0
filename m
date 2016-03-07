Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:60182 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932996AbcCGXMI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:08 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhAVV-1aHQpz1n2P-00MLMt for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:06 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/12] getopt: fix -n name for BSD
Date: Tue,  8 Mar 2016 00:12:02 +0100
Message-Id: <1457392322-4974-13-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

BSD gets the program name for warnings from getprogname() and not
from argv. Thus we use setprogname() there.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/getopt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index c166fd7..c4144f6 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -62,6 +62,9 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <getopt.h>
+#ifdef HAVE_SYS_PARAM_H
+# include <sys/param.h> /* BSD */
+#endif
 
 #include "closestream.h"
 #include "nls.h"
@@ -447,9 +450,13 @@ int main(int argc, char *argv[])
 			optind++;
 		}
 	}
-	if (name)
+
+	if (name) {
 		argv[optind - 1] = name;
-	else
+#if defined (BSD) || defined (__APPLE__)
+		setprogname(name);
+#endif
+	} else
 		argv[optind - 1] = argv[0];
 
 	return generate_output(&ctl, argv + optind - 1, argc - optind + 1);
-- 
1.9.1

