Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61830 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756909AbcLAIwR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:17 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MdoR7-1cLwxO371R-00PeNh for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:15 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/11] login: re-add lastlog.h header
Date: Thu,  1 Dec 2016 09:52:09 +0100
Message-Id: <1480582332-17407-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This include was removed in a365953a but we will need it again
when we move from utmp.h to utmpx.h.

On Linux (glibc, musl) the struct lastlog is defined in utmp.h
and lastlog.h just includes utmp.h.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>

Conflicts:
	login-utils/login.c

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac        | 1 +
 login-utils/login.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index dddc6a9..73c1b29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -207,6 +207,7 @@ AC_CHECK_HEADERS([ \
 	fcntl.h \
 	getopt.h \
 	inttypes.h \
+	lastlog.h \
 	linux/btrfs.h \
 	linux/cdrom.h \
 	linux/falloc.h \
diff --git a/login-utils/login.c b/login-utils/login.c
index 043fce1..3430448 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -46,6 +46,9 @@
 #include <grp.h>
 #include <pwd.h>
 #include <utmp.h>
+#ifdef HAVE_LASTLOG_H
+# include <lastlog.h>
+#endif
 #include <stdlib.h>
 #include <sys/syslog.h>
 #ifdef HAVE_LINUX_MAJOR_H
-- 
1.8.5.6

