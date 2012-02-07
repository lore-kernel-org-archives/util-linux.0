Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:47795 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755661Ab2BGWmF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 17:42:05 -0500
Subject: [PATCH 2/4] lslocks: add build rules
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 23:41:57 +0100
Message-ID: <1328654517.3500.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/.gitignore  |    2 ++
 misc-utils/Makefile.am |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/misc-utils/.gitignore b/misc-utils/.gitignore
index 897e6d1..bde3ab8 100644
--- a/misc-utils/.gitignore
+++ b/misc-utils/.gitignore
@@ -17,3 +17,5 @@ blkid
 wipefs
 findmnt
 lsblk
+lslocks
+
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index 540416e..75b22f1 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -6,7 +6,7 @@ bin_PROGRAMS =
 sbin_PROGRAMS =
 usrsbin_exec_PROGRAMS =
 
-usrbin_exec_PROGRAMS = cal logger look mcookie namei whereis
+usrbin_exec_PROGRAMS = cal logger look mcookie namei whereis lslocks
 
 logger_SOURCES = logger.c $(top_srcdir)/lib/strutils.c
 mcookie_SOURCES = mcookie.c $(top_srcdir)/lib/md5.c
@@ -16,10 +16,15 @@ usrbin_exec_SCRIPTS = chkdupexe
 CLEANFILES = chkdupexe
 
 dist_man_MANS = cal.1 chkdupexe.1 logger.1 look.1 mcookie.1 \
-		namei.1 whereis.1
+		namei.1 whereis.1 lslocks.8
 
 namei_SOURCES = namei.c $(top_srcdir)/lib/strutils.c
 
+lslocks_SOURCES = lslocks.c \
+		$(top_srcdir)/lib/strutils.c \
+		$(top_srcdir)/lib/tt.c \
+		$(top_srcdir)/lib/mbsalign.c
+
 if BUILD_DDATE
 usrbin_exec_PROGRAMS += ddate
 dist_man_MANS += ddate.1
-- 
1.7.4.1




