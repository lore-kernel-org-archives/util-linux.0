Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54897 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512AbaDCCZ7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 22:25:59 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s332PwWZ025116
	for <util-linux@vger.kernel.org>; Thu, 3 Apr 2014 02:25:58 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s332PwWC025115
	for util-linux@vger.kernel.org; Thu, 3 Apr 2014 02:25:58 GMT
Date: Thu, 3 Apr 2014 02:25:58 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] mkfs.cramfs(8): Some typographical corrections to the
 manual
Message-ID: <20140403022556.GA25091@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/mkfs.cramfs.8
Tags: patch

  The unit "MB" is ambigous.  Use "MiB" if "M" does not mean 10^6. 
Otherwise add "(M = 10^6)" after it.

  Changes:

  Unpaddable space (\ ) added between a number and an unit.  A nuber
and a unit are not one word.  Is "16MB" written "sixteenmegabytes"?

  Patch:

--- mkfs.cramfs.8	2013-09-18 13:50:12.000000000 +0000
+++ mkfs.cramfs.8.new	2014-04-02 23:58:50.000000000 +0000
@@ -15,10 +15,10 @@ The file system is intentionally read-on
 write access for compressed files is difficult to implement.  cramfs
 ships with a utility (mkcramfs) to pack files into new cramfs images.
 .PP
-File sizes are limited to less than 16MB.
+File sizes are limited to less than 16\ MB.
 .PP
-Maximum file system size is a little under 272MB.  (The last file on the
-file system must begin before the 256MB block, but can extend past it.)
+Maximum file system size is a little under 272\ MB.  (The last file on the
+file system must begin before the 256\ MB block, but can extend past it.)
 .SH ARGUMENTS
 The
 .I directory

-- 
Bjarni I. Gislason
