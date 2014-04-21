Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:47482 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbaDUAcD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Apr 2014 20:32:03 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 2/4] raw.8: Improve the typesetting of the manual
Date: Mon, 21 Apr 2014 00:30:25 +0000
Message-Id: <1398040227-14535-2-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
References: <1398040227-14535-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Remove space at end of lines

  Change '-' to '\-', if it indicates an option

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 disk-utils/raw.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disk-utils/raw.8 b/disk-utils/raw.8
index d0c4137..74c15a9 100644
--- a/disk-utils/raw.8
+++ b/disk-utils/raw.8
@@ -34,10 +34,10 @@ device numbers, or as a path name
 .I /dev/<blockdev>
 to an existing block device file.
 .PP
-The bindings already in existence can be queried with the 
+The bindings already in existence can be queried with the
 .I \-q
 option, which is used either with a raw device filename to query that one
-device, or with the 
+device, or with the
 .I \-a
 option to query all bound raw devices.
 .PP
@@ -67,7 +67,7 @@ will query an existing binding instead of setting a new one.
 .TP
 \fB\-a\fR, \fB\-\-all\fR
 With
-.B -q
+.B \-q
 , specify that all bound raw devices should be queried.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
-- 
1.9.0

