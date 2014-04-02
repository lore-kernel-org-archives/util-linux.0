Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54660 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932662AbaDBXmH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 19:42:07 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s32Ng6Wt023555
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 23:42:06 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s32Ng6OQ023554
	for util-linux@vger.kernel.org; Wed, 2 Apr 2014 23:42:06 GMT
Date: Wed, 2 Apr 2014 23:42:06 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] mkfs(8): Some typographical changes to the manual
Message-ID: <20140402234205.GA23536@rhi.hi.is>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/mkfs.8
Tags: patch

  - changed to \- if it means an option

  A full stop (.), that begins or ends a string, protected with \&

  No line adjustment used for section "SEE ALSO" (.na/.ad)

  Patch is in the attachment

-- 
Bjarni I. Gislason

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkfs.8.diff"

--- mkfs.8	2013-10-15 10:50:43.000000000 +0000
+++ mkfs.8.new	2014-04-02 01:03:20.000000000 +0000
@@ -74,7 +74,7 @@ Display help text and exit.
 All generic options must precede and not be combined with
 filesystem-specific options.
 Some filesystem-specific programs do not support the
-.B -V
+.B \-V
 (verbose) option, nor return meaningful exit codes.
 Also, some filesystem-specific programs do not automatically
 detect the device size and require the
@@ -83,13 +83,14 @@ parameter to be specified.
 .SH AUTHORS
 David Engel (david@ods.com)
 .br
-Fred N. van Kempen (waltje@uwalt.nl.mugnet.org)
+Fred N.\& van Kempen (waltje@uwalt.nl.mugnet.org)
 .br
 Ron Sommeling (sommel@sci.kun.nl)
 .br
 The manual page was shamelessly adapted from Remy Card's version
 for the ext2 filesystem.
 .SH SEE ALSO
+.na
 .BR fs (5),
 .BR badblocks (8),
 .BR fsck (8),
@@ -104,6 +105,7 @@ for the ext2 filesystem.
 .BR mkfs.vfat (8),
 .BR mkfs.xfs (8),
 .BR mkfs.xiafs (8)
+.ad
 .SH AVAILABILITY
 The mkfs command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.

--6c2NcOVqGQ03X4Wi--
