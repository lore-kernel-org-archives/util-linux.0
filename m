Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 09/13] fdisk: remove bugus space after header includes
Date: Tue, 22 Jul 2014 16:44:53 -0700
Message-Id: <1406072697-20912-10-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/fdisk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index e9b4fec..abb64a3 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -45,8 +45,6 @@
 # include <linux/blkpg.h>
 #endif
 
-
-
 int get_user_reply(struct fdisk_context *cxt, const char *prompt,
 			  char *buf, size_t bufsz)
 {
-- 
1.8.1.4
