Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58830 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575AbaGNJDb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 05:03:31 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] libmount: adjust the ordering of a #define and tweak some comments
Date: Mon, 14 Jul 2014 11:03:00 +0200
Message-Id: <1405328581-2202-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
References: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libmount/src/libmount.h.in |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index ac0c790..d54e876 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -773,29 +773,28 @@ extern int mnt_context_set_syscall_status(struct libmnt_context *cxt, int status
 #define MS_REC		0x4000	/* 16384: Recursive loopback */
 #endif
 #ifndef MS_SILENT
-#define MS_SILENT	0x8000	/* 32768 */
-#endif
-#ifndef MS_RELATIME
-#define MS_RELATIME	0x200000 /* 200000: Update access times relative
-                                  to mtime/ctime */
+#define MS_SILENT	0x8000	/* 32768: Don't emit certain kernel messages */
 #endif
 #ifndef MS_UNBINDABLE
-#define MS_UNBINDABLE	(1<<17)	/* 131072 unbindable*/
+#define MS_UNBINDABLE	(1<<17)	/* 131072: Make unbindable */
 #endif
 #ifndef MS_PRIVATE
-#define MS_PRIVATE	(1<<18)	/* 262144 Private*/
+#define MS_PRIVATE	(1<<18)	/* 262144: Make private */
 #endif
 #ifndef MS_SLAVE
-#define MS_SLAVE	(1<<19)	/* 524288 Slave*/
+#define MS_SLAVE	(1<<19)	/* 524288: Make slave */
 #endif
 #ifndef MS_SHARED
-#define MS_SHARED	(1<<20)	/* 1048576 Shared*/
+#define MS_SHARED	(1<<20)	/* 1048576: Make shared */
+#endif
+#ifndef MS_RELATIME
+#define MS_RELATIME	(1<<21) /* 2097152: Update atime relative to mtime/ctime */
 #endif
 #ifndef MS_I_VERSION
-#define MS_I_VERSION	(1<<23)	/* update inode I_version field */
+#define MS_I_VERSION	(1<<23)	/* Update the inode I_version field */
 #endif
 #ifndef MS_STRICTATIME
-#define MS_STRICTATIME	(1<<24) /* strict atime semantics */
+#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
 #endif
 
 /*
-- 
1.7.0.4

