Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2GYTQK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:10 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/5] ddate: russian manual missing from package
Date: Wed, 25 Jul 2012 21:15:41 +0200
Message-Id: <1343243745-1172-24-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This manpage causes more trouble than its worth.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Makefile.am              | 2 +-
 misc-utils/Makemodule.am | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 63ff205..112a4fb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -46,7 +46,7 @@ UNINSTALL_HOOKS =
 INSTALL_DATA_HOOKS =
 CLEAN_LOCALS =
 
-EXTRA_DIST =
+EXTRA_DIST = man/ru/ddate.1
 CLEANFILES =
 
 SUBDIRS = po
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 75b2e90..e2faea6 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -57,7 +57,6 @@ usrbin_exec_PROGRAMS += ddate
 dist_man_MANS += misc-utils/ddate.1
 ddate_SOURCES = misc-utils/ddate.c
 ruman1_DATA += man/ru/ddate.1
-EXTRA_DIST += $(ruman1_DATA)
 endif
 
 if BUILD_LSLOCKS
-- 
1.7.11.3

