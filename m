Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:54694 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753192Ab2IDN6L (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Sep 2012 09:58:11 -0400
Subject: [PATCH 1/2] blkid: document LIBBLKID_DEBUG users
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Sep 2012 15:58:02 +0200
Message-ID: <1346767082.2668.3.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Update the manpages of programs that use this environment variable for
extra debugging information.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/fsck.8      |    3 +++
 disk-utils/mkswap.8    |    3 +++
 disk-utils/partx.8     |    3 +++
 disk-utils/swaplabel.8 |    3 +++
 misc-utils/blkid.8     |    3 +++
 misc-utils/findfs.8    |    3 +++
 misc-utils/wipefs.8    |    3 +++
 7 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 4cfeb1f..1c89cfe 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -442,6 +442,9 @@ to override the standard location of the
 .B /etc/fstab
 file.  It is also useful for developers who are testing
 .BR fsck .
+.TP
+.B LIBBLKID_DEBUG=0xffff
+enables debug output.
 .SH SEE ALSO
 .BR fstab (5),
 .BR mkfs (8),
diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index c653171..ad9b4b9 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -139,6 +139,9 @@ Note that a swap file must not contain any holes (so, using
 .BR cp (1)
 to create the file is not acceptable).
 
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=0xffff
+enables debug output.
 
 .SH "SEE ALSO"
 .BR fdisk (8),
diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index be1608d..6142bd0 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -166,6 +166,9 @@ The original version was written by
 .MT aeb@cwi.nl
 Andries E. Brouwer
 .ME .
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=0xffff
+enables debug output.
 .SH AVAILABILITY
 The partx command is part of the util-linux package and is available from
 .UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index 0d47456..4e655ef 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -58,6 +58,9 @@ must be in the standard 8-4-4-4-12 character format, such as is output by
 .SH AUTHOR
 .B swaplabel
 was written by Jason Borden <jborden@bluehost.com> and Karel Zak <kzak@redhat.com>.
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=0xffff
+enables debug output.
 .SH AVAILABILITY
 The swaplabel command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index dc1e68f..93f0367 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -290,6 +290,9 @@ file.
 .B blkid
 was written by Andreas Dilger for libblkid and improved by Theodore Ts'o
 and Karel Zak.
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=0xffff
+enables debug output.
 .SH AVAILABILITY
 The blkid command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index b754903..8b6b395 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -25,6 +25,9 @@ be printed on stdout.
 .B findfs
 was originally written by Theodore Ts'o (tytso@mit.edu) and re-written for
 the util-linux package by Karel Zak (kzak@redhat.com).
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=0xffff
+enables debug output.
 .SH AVAILABILITY
 The findfs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index cecdc44..05a5496 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -65,6 +65,9 @@ taken. For more details see mount(8).
 Output version information and exit.
 .SH AUTHOR
 Karel Zak <kzak@redhat.com>.
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=0xffff
+enables debug output.
 .SH AVAILABILITY
 The wipefs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.4.1




