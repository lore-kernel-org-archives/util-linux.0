Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54624 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161055AbaDBXXf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 19:23:35 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s32NNXFj023315
	for <util-linux@vger.kernel.org>; Wed, 2 Apr 2014 23:23:33 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s32NNWJp023314
	for util-linux@vger.kernel.org; Wed, 2 Apr 2014 23:23:32 GMT
Date: Wed, 2 Apr 2014 23:23:32 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] blockdev(8): Some minor corrections to the manual
Message-ID: <20140402232331.GA23303@rhi.hi.is>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/blockdev.8
Tags: patch

  Changes:

  Macro, that alternately changes the input between two font styles,
changed to the macro for one font style change, if there is only one
argument

 Text string, that begins or ends with a full stop (.) protected with \&

 -- changed to \-\- if it is an option

 - changed to \(en if it is a dash (pause, seperation)

  Patch is in the attachment

-- 
Bjarni I. Gislason

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blockdev.8.diff"

--- blockdev.8	2013-10-15 10:50:43.000000000 +0000
+++ blockdev.8.new	2014-04-01 19:15:33.000000000 +0000
@@ -10,14 +10,14 @@ blockdev \- call block device ioctls fro
 .B blockdev
 .RB [ \-q ]
 .RB [ \-v ]
-.IR command
-.RI [ command ...]
-.IR device
-.RI [ device ...]
+.I command
+.RI [ command \&...\&]
+.I device
+.RI [ device \&...\&]
 .br
 .B blockdev
 .B \-\-report
-.RI [ device ...]
+.RI [ device \&...\&]
 .SH DESCRIPTION
 The utility
 .B blockdev
@@ -60,9 +60,9 @@ Get read-only. Print 1 if the device is
 .IP "\fB\-\-getsize64\fP"
 Print device size in bytes.
 .IP "\fB\-\-getsize\fP"
-Print device size (32-bit!) in sectors. Deprecated in favor of the --getsz option.
+Print device size (32-bit!) in sectors. Deprecated in favor of the \-\-getsz option.
 .IP "\fB\-\-getss\fP"
-Print sectorsize in bytes - usually 512.
+Print sectorsize in bytes \(en usually 512.
 .IP "\fB\-\-getsz\fP"
 Get size in 512-byte sectors.
 .IP "\fB\-\-rereadpt\fP"
@@ -72,7 +72,7 @@ Set blocksize. Note that the block size
 descriptor opening the block device, so the change of block size only persists
 for as long as blockdev has the device open, and is lost once blockdev exits.
 .IP "\fB\-\-setfra\fP \fIsectors\fP"
-Set filesystem readahead (same like --setra on 2.6 kernels).
+Set filesystem readahead (same like \-\-setra on 2.6 kernels).
 .IP "\fB\-\-setra\fP \fIsectors\fP"
 Set readahead (in 512-byte sectors).
 .IP "\fB\-\-setro\fP"
@@ -80,7 +80,7 @@ Set read-only.
 .IP "\fB\-\-setrw\fP"
 Set read-write.
 .SH AUTHOR
-blockdev was written by Andries E. Brouwer and rewritten by Karel Zak.
+blockdev was written by Andries E.\& Brouwer and rewritten by Karel Zak.
 .SH AVAILABILITY
 The blockdev command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.

--45Z9DzgjV8m4Oswq--
