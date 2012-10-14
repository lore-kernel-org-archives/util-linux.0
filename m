Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:39673 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab2JNUVf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:35 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680278wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/19] tailf: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 21:21:04 +0100
Message-Id: <1350246070-10544-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/tailf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 9571645..d76d53d 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -39,10 +39,10 @@
 #ifdef HAVE_INOTIFY_INIT
 #include <sys/inotify.h>
 #endif
+#include <time.h>
 
 #include "nls.h"
 #include "xalloc.h"
-#include "usleep.h"
 #include "strutils.h"
 #include "c.h"
 #include "closestream.h"
@@ -133,8 +133,11 @@ static void
 watch_file(const char *filename, off_t *size)
 {
 	do {
+		struct timespec waittime;
+		waittime.tv_sec = 0;
+		waittime.tv_nsec = 250000000;
 		roll_file(filename, size);
-		usleep(250000);
+		nanosleep(&waittime, NULL);
 	} while(1);
 }
 
-- 
1.7.12.2

