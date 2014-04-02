Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54647 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208AbaDBXfb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 19:35:31 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s32NZT48023466
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 23:35:29 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s32NZTGN023465
	for util-linux@vger.kernel.org; Wed, 2 Apr 2014 23:35:29 GMT
Date: Wed, 2 Apr 2014 23:35:29 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] fsck.minix(8): A few typographical corrections to the
 manual
Message-ID: <20140402233528.GA23454@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/fsck.minix.8
Tags: patch

  Changes:

  - between numbers changed to \(en if it means a range

  A full stop (.), that begins or ends a string, protected with \&

  Patch:

--- fsck.minix.8	2013-09-18 13:50:12.000000000 +0000
+++ fsck.minix.8.new	2014-04-01 23:45:31.000000000 +0000
@@ -23,10 +23,10 @@ searches for files).
 The \fIdevice\fR name will usually have the following form:
 .nf
 .RS
-/dev/hda[1-63] (IDE disk 1)
-/dev/hdb[1-63] (IDE disk 2)
-/dev/sda[1-15] (SCSI disk 1)
-/dev/sdb[1-15] (SCSI disk 2)
+/dev/hda[1\(en63] (IDE disk 1)
+/dev/hdb[1\(en63] (IDE disk 2)
+/dev/sda[1\(en15] (SCSI disk 1)
+/dev/sdb[1\(en15] (SCSI disk 2)
 .RE
 .fi
 
@@ -118,7 +118,7 @@ Linus Torvalds (torvalds@cs.helsinki.fi)
 .br
 Error code values by Rik Faith (faith@cs.unc.edu)
 .br
-Added support for filesystem valid flag: Dr. Wettstein
+Added support for filesystem valid flag: Dr.\& Wettstein
 (greg%wind.uucp@plains.nodak.edu)
 .br
 Check to prevent fsck of mounted filesystem added by Daniel Quinlan

-- 
Bjarni I. Gislason
