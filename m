Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:56544 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040Ab2EVOd0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 May 2012 10:33:26 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH] misc-utils: cleanup unused strings.h includes
Date: Tue, 22 May 2012 16:33:23 +0200
Message-Id: <1337697203-4812-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Noticed on klibc building.

Signed-off-by: maximilian attems <max@stro.at>
---
 misc-utils/kill.c   |    1 -
 misc-utils/logger.c |    1 -
 misc-utils/namei.c  |    1 -
 3 files changed, 3 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index da7c8ab..c592f52 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -45,7 +45,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <strings.h>
 #include <ctype.h>		/* for isdigit() */
 #include <unistd.h>
 #include <signal.h>
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index db3469c..9805a7d 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -43,7 +43,6 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
-#include <strings.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index b15d4f7..fc1689d 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -24,7 +24,6 @@
 #include <unistd.h>
 #include <getopt.h>
 #include <string.h>
-#include <strings.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/types.h>
-- 
1.7.10

