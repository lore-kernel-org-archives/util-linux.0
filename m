Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:44447 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3KJUGT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 15:06:19 -0500
Received: by mail-we0-f170.google.com with SMTP id u57so3889779wes.29
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 12:06:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] docs: update links to http://git.kernel.org/ web repository views
Date: Sun, 10 Nov 2013 20:06:10 +0000
Message-Id: <1384113970-2558-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1384113970-2558-1-git-send-email-kerolasa@iki.fi>
References: <1384113970-2558-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-contribute.txt | 2 +-
 README                             | 2 +-
 include/blkdev.h                   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 5f4531e..a638a1d 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -82,7 +82,7 @@ Coding style
 	* the preferred coding style is based on the linux kernel
 	  Documentation/CodingStyle. For more details see:
 
-	  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/CodingStyle
+	  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/CodingStyle
 
 	* Use `FIXME:' and a good description if want to inform others
 	  something is not quite right, and you are unwilling to fix the
diff --git a/README b/README
index 6dc5199..431c81b 100644
--- a/README
+++ b/README
@@ -19,7 +19,7 @@ DOWNLOAD:
 SOURCE CODE:
 
       Web interface:
-          http://git.kernel.org/?p=utils/util-linux/util-linux.git
+          http://git.kernel.org/cgit/utils/util-linux/util-linux.git
           https://github.com/karelzak/util-linux
       Checkout:
           git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
diff --git a/include/blkdev.h b/include/blkdev.h
index ade0887..5a5777b 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -122,7 +122,7 @@ int blkdev_is_cdrom(int fd);
 int blkdev_get_geometry(int fd, unsigned int *h, unsigned int *s);
 
 /* SCSI device types.  Copied almost as-is from kernel header.
- * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=include/scsi/scsi.h */
+ * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/scsi/scsi.h */
 #define SCSI_TYPE_DISK			0x00
 #define SCSI_TYPE_TAPE			0x01
 #define SCSI_TYPE_PRINTER		0x02
-- 
1.8.4.2

