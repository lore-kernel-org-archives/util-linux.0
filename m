Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:46951 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab3EHWMD (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 8 May 2013 18:12:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id C2C3533DF3D
	for <util-linux-ng@vger.kernel.org>; Wed,  8 May 2013 22:12:01 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] standard SEE ALSO section of man pages
Date: Wed,  8 May 2013 18:12:04 -0400
Message-Id: <1368051124-11407-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The standard format is to seperate each entry with a comma, and
for each one to be on a line by itself.  Most util-linux pages
follow this, but a few do not.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 disk-utils/mkfs.bfs.8   | 2 +-
 libblkid/libblkid.3     | 2 +-
 misc-utils/blkid.8      | 4 ++--
 misc-utils/findfs.8     | 3 +--
 misc-utils/lslocks.8    | 4 ++--
 misc-utils/wipefs.8     | 3 +--
 sys-utils/setpriv.1     | 2 +-
 sys-utils/switch_root.8 | 6 +++---
 text-utils/tailf.1      | 3 ++-
 9 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/disk-utils/mkfs.bfs.8 b/disk-utils/mkfs.bfs.8
index c1794e5..c8ddfa9 100644
--- a/disk-utils/mkfs.bfs.8
+++ b/disk-utils/mkfs.bfs.8
@@ -52,7 +52,7 @@ The exit code returned by
 .B mkfs.bfs
 is 0 when all went well, and 1 when something went wrong.
 .SH "SEE ALSO"
-.BR mkfs (8).
+.BR mkfs (8)
 .SH AVAILABILITY
 The mkfs.bfs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
index c96bc87..a0288bf 100644
--- a/libblkid/libblkid.3
+++ b/libblkid/libblkid.3
@@ -72,7 +72,7 @@ The low-level probing code was rewritten by Karel Zak.
 is available under the terms of the GNU Library General Public License (LGPL),
 version 2 (or at your discretion any later version).
 .SH "SEE ALSO"
-.BR blkid (8)
+.BR blkid (8),
 .BR findfs (8)
 .SH AVAILABILITY
 libblkid is part of the util-linux package since version 2.15 and is available from
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 82d6ed6..a974b8e 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -300,8 +300,8 @@ and Karel Zak.
 .SH ENVIRONMENT
 .IP "Setting LIBBLKID_DEBUG=0xffff enables debug output."
 .SH SEE ALSO
-.BR libblkid (3)
-.BR findfs (8)
+.BR libblkid (3),
+.BR findfs (8),
 .BR wipefs (8)
 .SH AVAILABILITY
 The blkid command is part of the util-linux package and is available from
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 530f186..8a6bca1 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -29,9 +29,8 @@ the util-linux package by Karel Zak (kzak@redhat.com).
 .IP LIBBLKID_DEBUG=0xffff
 enables debug output.
 .SH SEE ALSO
-.BR blkid (8)
+.BR blkid (8),
 .BR fsck (8)
 .SH AVAILABILITY
 The findfs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index f8d072b..4612201 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -86,8 +86,8 @@ Davidlohr Bueso <dave@gnu.org>
 .fi
 
 .SH "SEE ALSO"
-.BR flock (1)
-.BR fcntl (2)
+.BR flock (1),
+.BR fcntl (2),
 .BR lockf (2)
 
 .SH AVAILABILITY
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index fee9aaf..0c34b0f 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -92,9 +92,8 @@ Karel Zak <kzak@redhat.com>
 .SH ENVIRONMENT
 .IP "Setting LIBBLKID_DEBUG=0xffff enables debug output."
 .SH SEE ALSO
-.BR blkid (8)
+.BR blkid (8),
 .BR findfs (8)
 .SH AVAILABILITY
 The wipefs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index c05473c..89cd60c 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -136,7 +136,7 @@ For example, setting no_\:new_\:privs and then execing a program that is
 SELinux\-\:confined (as this tool would do) may prevent the SELinux
 restrictions from taking effect.
 .SH SEE ALSO
-.BR prctl (2)
+.BR prctl (2),
 .BR capability (7)
 .SH AUTHOR
 .MT luto@amacapital.net
diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
index 34ab0d0..debf0c8 100644
--- a/sys-utils/switch_root.8
+++ b/sys-utils/switch_root.8
@@ -46,9 +46,9 @@ mount --bind $DIR $DIR
 .fi
 
 .SH "SEE ALSO"
-.BR mount (8)
-.BR chroot (2)
-.BR init (8)
+.BR mount (8),
+.BR chroot (2),
+.BR init (8),
 .BR mkinitrd (8)
 .SH AUTHORS
 .nf
diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
index d64d2ca..49eda0b 100644
--- a/text-utils/tailf.1
+++ b/text-utils/tailf.1
@@ -62,7 +62,8 @@ NO WARRANTY for this program.
 
 The latest inotify based implementation was written by Karel Zak (kzak@redhat.com).
 .SH "SEE ALSO"
-.BR tail "(1), " less "(1)"
+.BR tail (1),
+.BR less (1)
 .SH AVAILABILITY
 The tailf command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.8.2.1

