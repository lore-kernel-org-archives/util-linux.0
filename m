Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51627 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758201Ab2EYSOC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:14:02 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz1V-0007ZU-FM from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:14:01 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH] test_pager: Repair build for non-Linux.
Date: Fri, 25 May 2012 20:13:41 +0200
Message-Id: <1337969621-3052-2-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 lib/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index aed0ecd..01b59dc 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,6 +27,7 @@ test_blkdev_SOURCES = blkdev.c
 test_ismounted_SOURCES = ismounted.c
 test_wholedisk_SOURCES = wholedisk.c
 test_mangle_SOURCES = mangle.c
+test_pager_SOURCES = pager.c
 
 test_at_SOURCES = at.c
 test_at_CFLAGS = -DTEST_PROGRAM_AT
@@ -38,7 +39,6 @@ test_procutils_SOURCES = procutils.c
 if LINUX
 test_cpuset_SOURCES = cpuset.c
 test_sysfs_SOURCES = sysfs.c at.c
-test_pager_SOURCES = pager.c
 test_sysfs_CFLAGS = -DTEST_PROGRAM_SYSFS
 
 test_loopdev_SOURCES = \
-- 
1.7.9

