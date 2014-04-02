Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54655 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161068AbaDBXh1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 19:37:27 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s32NbQiN023492
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 23:37:26 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s32NbQP3023491
	for util-linux@vger.kernel.org; Wed, 2 Apr 2014 23:37:26 GMT
Date: Wed, 2 Apr 2014 23:37:26 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] isosize(8): A few typographical changes to the manual
Message-ID: <20140402233724.GA23478@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/isosize.8
Tags: patch

  Changes:

  A full stop (.), that begins or ends a string, protected with \&

  A space between a number and an unit changed to an unpaddable space
"\ "

  Patch:

--- isosize.8	2013-09-18 13:50:12.000000000 +0000
+++ isosize.8.new	2014-04-02 00:47:06.000000000 +0000
@@ -8,9 +8,9 @@ isosize \- output the length of an iso96
 .PP
 This command outputs the length of an iso9660 filesystem that
 is contained in the specified file.  This file may be a normal file or
-a block device (e.g. /dev/hdd or /dev/sr0).  In the absence of
+a block device (e.g.\& /dev/hdd or /dev/sr0).  In the absence of
 any options (and errors), it will output the size of the iso9660
-filesystem in bytes.  This can now be a large number (>> 4 GB).
+filesystem in bytes.  This can now be a large number (>> 4\ GB).
 .SH OPTIONS
 .TP
 .BR \-x , " \-\-sectors"


-- 
Bjarni I. Gislason
