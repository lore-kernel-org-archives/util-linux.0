Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33222 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758137Ab3AIWoN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 17:44:13 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so869665wib.4
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 14:44:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] build-sys: add files to distribution
Date: Wed,  9 Jan 2013 22:44:04 +0000
Message-Id: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To fix 'make distcheck' compilation.  The fdisks/Makemodule.am has one
new entry 'dos_part_types.h', the rest is about sorting the list.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/Makemodule.am  | 7 ++++---
 include/Makemodule.am | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fdisks/Makemodule.am b/fdisks/Makemodule.am
index 0723f50..e03ccbe 100644
--- a/fdisks/Makemodule.am
+++ b/fdisks/Makemodule.am
@@ -4,24 +4,25 @@ if !ARCH_M68K
 sbin_PROGRAMS += fdisk
 dist_man_MANS += fdisks/fdisk.8
 fdisk_SOURCES = \
-	fdisks/utils.c \
+	fdisks/dos_part_types.h \
 	fdisks/fdisk.c \
 	fdisks/fdisk.h \
 	fdisks/fdiskaixlabel.c \
 	fdisks/fdiskaixlabel.h \
 	fdisks/fdiskbsdlabel.c \
 	fdisks/fdiskbsdlabel.h \
+	fdisks/fdiskdoslabel.c \
+	fdisks/fdiskdoslabel.h \
 	fdisks/fdiskmaclabel.c \
 	fdisks/fdiskmaclabel.h \
 	fdisks/fdisksgilabel.c \
 	fdisks/fdisksgilabel.h \
 	fdisks/fdisksunlabel.c \
 	fdisks/fdisksunlabel.h \
-	fdisks/fdiskdoslabel.c \
-	fdisks/fdiskdoslabel.h \
 	fdisks/gpt.c \
 	fdisks/gpt.h \
 	fdisks/partname.c \
+	fdisks/utils.c \
 	fdisks/common.h
 
 fdisk_LDADD = $(LDADD) libcommon.la
diff --git a/include/Makemodule.am b/include/Makemodule.am
index bef118f..5538570 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -8,6 +8,7 @@ dist_noinst_HEADERS += \
 	include/canonicalize.h \
 	include/carefulputc.h \
 	include/closestream.h \
+	include/colors.h \
 	include/cpuset.h \
 	include/crc32.h \
 	include/env.h \
-- 
1.8.1

