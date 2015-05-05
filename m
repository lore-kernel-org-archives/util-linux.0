Return-Path: util-linux-owner@vger.kernel.org
Received: from hofr.at ([212.69.189.236]:46638 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933129AbbEELTw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 May 2015 07:19:52 -0400
Date: Tue, 5 May 2015 13:19:51 +0200
From: Georg Schiesser <georg.schiesser@opentech.at>
To: util-linux@vger.kernel.org
Subject: [PATCH] build-sys: support unshare.static
Message-ID: <20150505111951.GA17943@opentech.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds support for building a static version of unshare.
We need to add unshare to the list of possible static programs, and
provide build flags for the compiler and linker, which are equivalent to
the flags of the non-static program, except additional static linking.
See also: commit 2fa60c5 build-sys: support nsenter.static

Signed-off-by: Georg Schiesser <georg.schiesser@opentech.at>
---
 configure.ac            | 2 +-
 sys-utils/Makemodule.am | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6bc9efd..52c531e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -442,7 +442,7 @@ AC_LINK_IFELSE([AC_LANG_PROGRAM([extern char *__progname;],
 	   AC_MSG_RESULT([no]))
 
 dnl Static compilation
-m4_define([UL_STATIC_PROGRAMS], [losetup, mount, umount, fdisk, sfdisk, blkid, nsenter])
+m4_define([UL_STATIC_PROGRAMS], [losetup, mount, umount, fdisk, sfdisk, blkid, nsenter, unshare])
 
 AC_ARG_ENABLE([static-programs],
   [AS_HELP_STRING([--enable-static-programs=LIST],
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 15d0a95..93b1644 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -350,6 +350,14 @@ dist_man_MANS += sys-utils/unshare.1
 unshare_SOURCES = sys-utils/unshare.c
 unshare_LDADD = $(LDADD) libcommon.la
 unshare_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
+
+if HAVE_STATIC_UNSHARE
+usrbin_exec_PROGRAMS += unshare.static
+unshare_static_SOURCES = $(unshare_SOURCES)
+unshare_static_LDFLAGS = -all-static
+unshare_static_LDADD = $(unshare_LDADD)
+unshare_static_CFLAGS = $(unshare_CFLAGS)
+endif
 endif
 
 if BUILD_NSENTER
-- 
2.1.4

