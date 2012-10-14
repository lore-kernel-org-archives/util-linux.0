Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64919 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab2JNUVb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:31 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1296035wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/19] rtcwake: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 21:21:02 +0100
Message-Id: <1350246070-10544-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index a1fd6dc..08f1c11 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -38,7 +38,6 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "pathnames.h"
-#include "usleep.h"
 #include "strutils.h"
 #include "c.h"
 #include "closestream.h"
@@ -390,6 +389,7 @@ int main(int argc, char **argv)
 	int		t;
 	int		fd;
 	time_t		alarm = 0;
+	struct timespec	waittime;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -550,7 +550,9 @@ int main(int argc, char **argv)
 				program_invocation_short_name, suspend, devname,
 				ctime(&alarm));
 		fflush(stdout);
-		usleep(10 * 1000);
+		waittime.tv_sec = 0;
+		waittime.tv_nsec = 10000000;
+		nanosleep(&waittime, NULL);
 	}
 
 	if (strcmp(suspend, "no") == 0) {
-- 
1.7.12.2

