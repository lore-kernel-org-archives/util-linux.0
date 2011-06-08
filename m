Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37449 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab1FHWxk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:40 -0400
Received: by iyb14 with SMTP id 14so837342iyb.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:39 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 2/6] fsck, checktty, flock: Use more portable includes.
Date: Wed,  8 Jun 2011 16:52:44 -0600
Message-Id: <1307573568-23643-3-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Josiah Worcester <josiahw@gmail.com>
---
 fsck/fsck.c            |    2 +-
 login-utils/checktty.c |    3 +++
 sys-utils/flock.c      |    2 ++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0d5feda..9153367 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -29,7 +29,7 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <sys/signal.h>
+#include <signal.h>
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <fcntl.h>
diff --git a/login-utils/checktty.c b/login-utils/checktty.c
index f849057..518b701 100644
--- a/login-utils/checktty.c
+++ b/login-utils/checktty.c
@@ -22,7 +22,10 @@
 #include <malloc.h>
 #include <netdb.h>
 #include <sys/syslog.h>
+#include <sys/socket.h>
 #include <ctype.h>
+#include <limits.h>
+#include <netinet/in.h>
 #include "nls.h"
 
 #include <sys/sysmacros.h>
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 20004ca..c7fb70e 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -39,6 +39,8 @@
 #include <sys/file.h>
 #include <sys/time.h>
 #include <sys/wait.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "nls.h"
 
-- 
1.7.5.3

