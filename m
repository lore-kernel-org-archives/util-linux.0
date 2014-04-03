Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54905 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932713AbaDCC3t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 22:29:49 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s332Tmkr025162
	for <util-linux@vger.kernel.org>; Thu, 3 Apr 2014 02:29:48 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s332TmD0025161
	for util-linux@vger.kernel.org; Thu, 3 Apr 2014 02:29:48 GMT
Date: Thu, 3 Apr 2014 02:29:48 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] mkswap(8): Some minor typographical corrections to the
 manual
Message-ID: <20140403022948.GA25150@rhi.hi.is>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/mkswap.8
Tags: patch

  Changes:

  -- changed to \(en (an en-dash) if it is a dash (pause, separation)

  - changed to \- if it indicates an option

  A full stop (.), that begins or ends a string, protected with \&

  Space between sentences corrected to two word spaces

  -- changed to \-\- if it indicates an option

  Patch is in the attachment

-- 
Bjarni I. Gislason

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkswap.8.diff"

--- mkswap.8	2014-01-14 11:46:09.000000000 +0000
+++ mkswap.8.new	2014-04-03 01:37:13.000000000 +0000
@@ -32,14 +32,14 @@ parameter is superfluous but retained fo
 (It specifies the desired size of the swap area in 1024-byte blocks.
 .B mkswap
 will use the entire partition or file if it is omitted.
-Specifying it is unwise -- a typo may destroy your disk.)
+Specifying it is unwise \(en a typo may destroy your disk.)
 
 After creating the swap area, you need the
 .B swapon
 command to start using it.  Usually swap areas are listed in
 .I /etc/fstab
 so that they can be taken into use at boot time by a
-.B swapon -a
+.B swapon \-a
 command in some boot script.
 
 .SH WARNING
@@ -54,7 +54,7 @@ like many others mkfs-like utils,
 However,
 .B mkswap
 refuses to erase the first block on a device with a disk
-label (SUN, BSD, ...).
+label (SUN, BSD, \&...\&).
 
 .SH OPTIONS
 .TP
@@ -105,7 +105,7 @@ The maximum useful size of a swap area d
 the kernel version.
 
 The maximum number of the pages that is possible to address by swap area header
-is 4294967295 (UINT_MAX). The remaining space on the swap device is ignored.
+is 4294967295 (UINT_MAX).  The remaining space on the swap device is ignored.
 
 Presently, Linux allows 32 swap areas.
 The areas in use can be seen in the file
@@ -115,17 +115,17 @@ The areas in use can be seen in the file
 refuses areas smaller than 10 pages.
 
 If you don't know the page size that your machine uses, you may be
-able to look it up with "cat /proc/cpuinfo" (or you may not --
+able to look it up with "cat /proc/cpuinfo" (or you may not \(en
 the contents of this file depend on architecture and kernel version).
 
 To set up a swap file, it is necessary to create that file before
 initializing it with
 .BR mkswap ,
-e.g. using a command like
+e.g.\& using a command like
 
 .nf
 .RS
-# fallocate --length 8GiB swapfile
+# fallocate \-\-length 8GiB swapfile
 .RE
 .fi
 

--Nq2Wo0NMKNjxTN9z--
