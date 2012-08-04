Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:48938 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2HDHdg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2012 03:33:36 -0400
Received: by weyx8 with SMTP id x8so880698wey.19
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2012 00:33:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/5] docs: ftp server does no longer support util-linux-ng
Date: Sat,  4 Aug 2012 09:33:36 +0200
Message-Id: <1344065620-17480-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A symlink was probably removed from
  ftp://ftp.kernel.org/pub/linux/utils/

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/releases/v2.13-ReleaseNotes |  2 +-
 Documentation/releases/v2.14-ReleaseNotes | 10 ++++----
 Documentation/releases/v2.15-ReleaseNotes | 10 ++++----
 Documentation/releases/v2.16-ReleaseNotes |  6 ++---
 Documentation/releases/v2.17-ReleaseNotes | 12 ++++-----
 Documentation/releases/v2.18-ReleaseNotes | 12 ++++-----
 NEWS                                      | 42 +++++++++++++++----------------
 7 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/Documentation/releases/v2.13-ReleaseNotes b/Documentation/releases/v2.13-ReleaseNotes
index e3dc9f7..327894d 100644
--- a/Documentation/releases/v2.13-ReleaseNotes
+++ b/Documentation/releases/v2.13-ReleaseNotes
@@ -61,7 +61,7 @@ Changelog:
 ---------
 
  For more details see ChangeLog files at:
- ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/
+ ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/
 
 
 agetty:
diff --git a/Documentation/releases/v2.14-ReleaseNotes b/Documentation/releases/v2.14-ReleaseNotes
index 1c92a82..4b7c5af 100644
--- a/Documentation/releases/v2.14-ReleaseNotes
+++ b/Documentation/releases/v2.14-ReleaseNotes
@@ -69,20 +69,20 @@ Stable maintenance releases between v2.13 and v2.14
 
 util-linux-ng 2.13.1.1 [22-Apr-2008]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13.1.1-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13.1.1-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13.1.1-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13.1.1-ChangeLog
 
 util-linux-ng 2.13.1 [16-Jan-2008]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13.1-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13.1-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13.1-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13.1-ChangeLog
 
 
 ChangeLog between v2.13 and v2.14
 ---------------------------------
 
  For more details see ChangeLog files at:
- ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/
+ ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/
 
 agetty:
    - cleanup MAXHOSTNAMELEN  [Karel Zak]
diff --git a/Documentation/releases/v2.15-ReleaseNotes b/Documentation/releases/v2.15-ReleaseNotes
index 56b10b6..98d9741 100644
--- a/Documentation/releases/v2.15-ReleaseNotes
+++ b/Documentation/releases/v2.15-ReleaseNotes
@@ -111,20 +111,20 @@ Stable maintenance releases between v2.14 and v2.15
 
 util-linux-ng 2.14.1 [10-Aug-2008]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14.1-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14.1-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14.1-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14.1-ChangeLog
 
 util-linux-ng 2.14.2 [09-Feb-2009]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14.2-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14.2-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14.2-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14.2-ChangeLog
 
 
 ChangeLog between v2.14 and v2.15
 ---------------------------------
 
  For more details see ChangeLog files at:
- ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/
+ ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.15/
 
 addpart:
    - 512-byte sectors in code, bytes in man-page  [Karel Zak]
diff --git a/Documentation/releases/v2.16-ReleaseNotes b/Documentation/releases/v2.16-ReleaseNotes
index b204c64..b7337e8 100644
--- a/Documentation/releases/v2.16-ReleaseNotes
+++ b/Documentation/releases/v2.16-ReleaseNotes
@@ -24,15 +24,15 @@ Stable maintenance releases between v2.15 and v2.16
 
 util-linux-ng 2.15.1 [10-Jun-2009]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/v2.15.1-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/v2.15.1-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.15/v2.15.1-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.15/v2.15.1-ChangeLog
 
 
 ChangeLog between v2.15 and v2.16
 ---------------------------------
 
  For more details see ChangeLog files at:
- ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/
+ ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/
 
 
 build-sys:
diff --git a/Documentation/releases/v2.17-ReleaseNotes b/Documentation/releases/v2.17-ReleaseNotes
index 874622b..d4221b1 100644
--- a/Documentation/releases/v2.17-ReleaseNotes
+++ b/Documentation/releases/v2.17-ReleaseNotes
@@ -33,7 +33,7 @@ libblkid:
     functionality is designed for mkfs programs, DeviceKits, [k]partx or so.
 
   - libblkid API documentation is available at
-    http://ftp.kernel.org/pub/linux/utils/util-linux-ng/libblkid-docs/
+    http://ftp.kernel.org/pub/linux/utils/util-linux/libblkid-docs/
 
 blockdev:
    - supports all new topology ioctls
@@ -51,20 +51,20 @@ Stable maintenance releases between v2.16 and v2.17
 
 util-linux-ng 2.16.1 [07-Sep-2009]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16.1-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16.1-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16.1-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16.1-ChangeLog
 
 util-linux-ng 2.16.2 [30-Nov-2009]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16.2-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16.2-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16.2-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16.2-ChangeLog
 
 
 ChangeLog between v2.16 and v2.17
 ---------------------------------
 
  For more details see ChangeLog files at:
- ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/
+ ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/
 
 addpart:
    - addpart.8 formatting  [Peter Breitenlohner]
diff --git a/Documentation/releases/v2.18-ReleaseNotes b/Documentation/releases/v2.18-ReleaseNotes
index b027804..36e0b2c 100644
--- a/Documentation/releases/v2.18-ReleaseNotes
+++ b/Documentation/releases/v2.18-ReleaseNotes
@@ -20,7 +20,7 @@ libmount:
     fstab, mtab and mountinfo parser, routines for work with parsed 
     data and mount options, mtab locking, etc. The high-level API for 
     mount(2) is planned for the next major release. For more details see:
-    http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3239
+    http://thread.gmane.org/gmane.linux.utilities.util-linux/3239
 
   - the utils like mount(8) or umount(8) are not linked with the library
     yet. This change is planned for util-linux-ng-2.19.
@@ -73,20 +73,20 @@ Stable maintenance releases between v2.17 and v2.18
 
 util-linux-ng 2.17.1 [22-Feb-2010]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17.1-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17.1-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17.1-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17.1-ChangeLog
 
 util-linux-ng 2.17.2 [22-Mar-2010]
 
- * ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17.2-ReleaseNotes
-   ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17.2-ChangeLog
+ * ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17.2-ReleaseNotes
+   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17.2-ChangeLog
 
 
 Changes between v2.17 and v2.18
 -------------------------------
 
  For more details see ChangeLog files at:
- ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.18/
+ ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.18/
 
 addpart:
    - use atoll() for parsing command line arguments  [Thomas Fehr]
diff --git a/NEWS b/NEWS
index 5114ffc..dace8d6 100644
--- a/NEWS
+++ b/NEWS
@@ -44,91 +44,91 @@ util-linux 2.19-rc1: Jan 05 2011
 
 util-linux-ng 2.18: Jun 30 2010
 * see Documentation/releases/v2.18-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.18/v2.18-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.18/v2.18-ChangeLog
 
 util-linux-ng 2.18-rc2: Jun 18 2010
 * see Documentation/releases/v2.18-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.18/v2.18-rc2-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.18/v2.18-rc2-ChangeLog
 
 util-linux-ng 2.18-rc1: Jun 7 2010
 * see Documentation/releases/v2.18-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.18/v2.18-rc1-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.18/v2.18-rc1-ChangeLog
 
 util-linux-ng 2.17: Jan 8 2010
 * see Documentation/releases/v2.17-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17-ChangeLog
 
 util-linux-ng 2.17-rc3: Dec 10 2009
 * see Documentation/releases/v2.17-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17-rc3-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17-rc3-ChangeLog
 
 util-linux-ng 2.17-rc2: Dec 9 2009
 * see Documentation/releases/v2.17-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17-rc2-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17-rc2-ChangeLog
 
 util-linux-ng 2.17-rc1: Nov 20 2009
 * see Documentation/releases/v2.17-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.17/v2.17-rc1-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.17/v2.17-rc1-ChangeLog
 
 util-linux-ng 2.16: Jul  2009
 * see Documentation/releases/v2.16-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16-ChangeLog
 
 util-linux-ng 2.16-rc2: Jul 2 2009
 * see Documentation/releases/v2.16-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16-rc2-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16-rc2-ChangeLog
 
 util-linux-ng 2.16-rc1: Jun 28 2009
 * see Documentation/releases/v2.16-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.16/v2.16-rc1-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.16/v2.16-rc1-ChangeLog
 
 util-linux-ng 2.15: May 5 2009
 * see Documentation/releases/v2.15-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/v2.15-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.15/v2.15-ChangeLog
 
 util-linux-ng 2.15-rc2: Apr 17 2009
 * see Documentation/releases/v2.15-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/v2.15-rc2-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.15/v2.15-rc2-ChangeLog
 
 util-linux-ng 2.15-rc1: Mar 18 2009
 * see Documentation/releases/v2.15-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/v2.15-rc1-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.15/v2.15-rc1-ChangeLog
 
 util-linux-ng 2.14: Jun 9 2008
 * see Documentation/releases/v2.14-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14-ChangeLog
 
 util-linux-ng 2.14-rc3
 * see Documentation/releases/v2.14-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14-rc3-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14-rc3-ChangeLog
 
 util-linux-ng 2.14-rc2
 * see Documentation/releases/v2.14-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14-rc2-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14-rc2-ChangeLog
 
 util-linux-ng 2.14-rc1
 * see Documentation/releases/v2.14-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/v2.14-rc1-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.14/v2.14-rc1-ChangeLog
 
 util-linux-ng 2.13
 
 * see Documentation/releases/v2.13-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13-ChangeLog
 
 util-linux-ng 2.13-rc3
 
 * see Documentation/releases/v2.13-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13-rc3-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13-rc3-ChangeLog
 
 util-linux-ng 2.13-rc2
 
 * see Documentation/releases/v2.13-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13-rc2-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13-rc2-ChangeLog
 
 util-linux-ng 2.13-rc1
 
 * see Documentation/releases/v2.13-ReleaseNotes or complete changelog at
-  ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/v2.13-rc1-ChangeLog
+  ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.13/v2.13-rc1-ChangeLog
 
 util-linux 2.13-pre7
 
-- 
1.7.11.4

