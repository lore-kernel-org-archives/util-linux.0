Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:58791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755444AbcCUNEt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 09:04:49 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LinyL-1a55r12s3B-00cuZm for
 <util-linux@vger.kernel.org>; Mon, 21 Mar 2016 14:04:46 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] build-sys: pylibmount, mount context is Linux only
Date: Mon, 21 Mar 2016 14:04:42 +0100
Message-Id: <1458565485-27856-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
References: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <rudi@localhost>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libmount/python/Makemodule.am | 6 ++++--
 libmount/python/pylibmount.c  | 2 ++
 libmount/python/pylibmount.h  | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/libmount/python/Makemodule.am b/libmount/python/Makemodule.am
index 367d324..9964e31 100644
--- a/libmount/python/Makemodule.am
+++ b/libmount/python/Makemodule.am
@@ -12,8 +12,10 @@ pylibmount_la_SOURCES = \
 	libmount/python/pylibmount.c \
 	libmount/python/pylibmount.h \
 	libmount/python/fs.c \
-	libmount/python/tab.c \
-	libmount/python/context.c
+	libmount/python/tab.c
+if LINUX
+pylibmount_la_SOURCES += libmount/python/context.c
+endif
 
 pylibmount_la_LIBADD = libmount.la $(PYTHON_LIBS)
 
diff --git a/libmount/python/pylibmount.c b/libmount/python/pylibmount.c
index c538bb5..54d7dfa 100644
--- a/libmount/python/pylibmount.c
+++ b/libmount/python/pylibmount.c
@@ -229,7 +229,9 @@ PyMODINIT_FUNC initpylibmount(void)
 
 	FS_AddModuleObject(m);
 	Table_AddModuleObject(m);
+#ifdef __linux__
 	Context_AddModuleObject(m);
+#endif
 
 	/*
 	 * mount(8) userspace options masks (MNT_MAP_USERSPACE map)
diff --git a/libmount/python/pylibmount.h b/libmount/python/pylibmount.h
index 1a08796..7a37014 100644
--- a/libmount/python/pylibmount.h
+++ b/libmount/python/pylibmount.h
@@ -94,6 +94,8 @@ extern void Table_AddModuleObject(PyObject *mod);
 
 extern int pymnt_table_parser_errcb(struct libmnt_table *tb, const char *filename, int line);
 
+#ifdef __linux__
+
 /*
  * context.c
  */
@@ -108,6 +110,8 @@ typedef struct {
 extern PyTypeObject ContextType;
 extern void Context_AddModuleObject(PyObject *mod);
 
+#endif /* __linux__ */
+
 /*
  * misc
  */
-- 
1.8.4.5

