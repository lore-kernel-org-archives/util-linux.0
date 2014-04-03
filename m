Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54901 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932735AbaDCC23 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 22:28:29 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s332SRf8025146
	for <util-linux@vger.kernel.org>; Thu, 3 Apr 2014 02:28:27 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s332SRZ6025145
	for util-linux@vger.kernel.org; Thu, 3 Apr 2014 02:28:27 GMT
Date: Thu, 3 Apr 2014 02:28:27 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] mkfs.minix(8): Some typographical changes in the manual
Message-ID: <20140403022826.GA25127@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.24.1
Severity: minor
File: disk-utils/mkfs.minix.8
Tags: patch

  Changes:

  - between numbers changed to \(en if it is a range

  Patch:

--- mkfs.minix.8	2013-02-27 16:46:29.000000000 +0000
+++ mkfs.minix.8.new	2014-04-03 01:06:45.000000000 +0000
@@ -24,10 +24,10 @@ is usually of the following form:
 
 .nf
 .RS
-/dev/hda[1-8] (IDE disk 1)
-/dev/hdb[1-8] (IDE disk 2)
-/dev/sda[1-8] (SCSI disk 1)
-/dev/sdb[1-8] (SCSI disk 2)
+/dev/hda[1\(en8] (IDE disk 1)
+/dev/hdb[1\(en8] (IDE disk 2)
+/dev/sda[1\(en8] (SCSI disk 1)
+/dev/sdb[1\(en8] (SCSI disk 2)
 .RE
 .fi
 

-- 
Bjarni I. Gislason
