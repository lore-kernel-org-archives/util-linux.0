Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:54891 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512AbaDCCXH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Apr 2014 22:23:07 -0400
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s332N5s4025087
	for <util-linux@vger.kernel.org>; Thu, 3 Apr 2014 02:23:05 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s332N45r025086
	for util-linux@vger.kernel.org; Thu, 3 Apr 2014 02:23:04 GMT
Date: Thu, 3 Apr 2014 02:23:04 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] mkfs.bfs(8): One typographical correction to the manual
Message-ID: <20140403022303.GA25075@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Package: util-linux
Version: 2.24.1
Severity: minor
Tags: patch

  Change:

  - between numbers changed to \(en  (an en-dash)

  Patch:

--- mkfs.bfs.8	2013-10-15 10:50:43.000000000 +0000
+++ mkfs.bfs.8.new	2014-04-02 23:45:11.000000000 +0000
@@ -19,7 +19,7 @@ If nothing is specified, the entire part
 .TP
 .BR \-N , " \-\-inodes " \fInumber\fR
 Specify the desired \fInumber\fR of inodes (at most 512).
-If nothing is specified, some default number in the range 48-512 is picked
+If nothing is specified, some default number in the range 48\(en512 is picked
 depending on the size of the partition.
 .TP
 .BR \-V , " \-\-vname " \fIlabel\fR

-- 
Bjarni I. Gislason
