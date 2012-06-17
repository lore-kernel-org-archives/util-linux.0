Return-Path: dave@gnu.org
Subject: [PATCH 8/9] fdisk: mark dos compatibility/CHS options deprecated
 in manpage
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:28 +0200
Message-ID: <1339949428.2668.20.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.8 |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fdisk/fdisk.8 b/fdisk/fdisk.8
index 2b3c822..5233f0f 100644
--- a/fdisk/fdisk.8
+++ b/fdisk/fdisk.8
@@ -1,7 +1,8 @@
 .\" Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
 .\" Copyright 1998 Andries E. Brouwer (aeb@cwi.nl)
+.\" Copyright 2012 Davidlohr Bueso <dave@gnu.org>
 .\" May be distributed under the GNU General Public License
-.TH FDISK 8 "June 2010" "util-linux" "System Administration"
+.TH FDISK 8 "June 2012" "util-linux" "System Administration"
 .SH NAME
 fdisk \- manipulate disk partition table
 .SH SYNOPSIS
@@ -194,22 +195,22 @@ Specify the compatibility mode, 'dos' or 'nondos'.  The default is non-DOS
 mode.  For backward compatibility, it is possible to use the option without
 the <mode> argument -- then the default is used.  Note that the optional
 <mode> argument cannot be separated from the -c option by a space, the correct
-form is for example '-c=dos'.
+form is for example '-c=dos'. This option is DEPRECATED.
 .TP
 .BI "\-C " cyls
 Specify the number of cylinders of the disk.
-I have no idea why anybody would want to do so.
+I have no idea why anybody would want to do so. This option is DEPRECATED.
 .TP
 .BI "\-H " heads
 Specify the number of heads of the disk.  (Not the physical number,
 of course, but the number used for partition tables.)
-Reasonable values are 255 and 16.
+Reasonable values are 255 and 16. This option is DEPRECATED.
 .TP
 .BI "\-S " sects
 Specify the number of sectors per track of the disk.
 (Not the physical number, of course, but the number used for
 partition tables.)
-A reasonable value is 63.
+A reasonable value is 63. This option is DEPRECATED.
 .TP
 .BI \-h
 Print help and then exit.
-- 
1.7.4.1
