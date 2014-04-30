Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:63493 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385AbaD3CGM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 22:06:12 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 6/7] libblkid/libblkid.3: Improve the typsetting of the manual
Date: Wed, 30 Apr 2014 02:04:59 +0000
Message-Id: <1398823500-19737-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

   Correct space between sentences to two space characters
 (or begin each sentence on a new line).

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 libblkid/libblkid.3 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
index a0288bf..58ca91c 100644
--- a/libblkid/libblkid.3
+++ b/libblkid/libblkid.3
@@ -37,11 +37,11 @@ environment variable BLKID_FILE.
 .P
 In situations where one is getting information about a single known device, it
 does not impact performance whether the cache is used or not (unless you are
-not able to read the block device directly). 
+not able to read the block device directly).
 .P
 The high-level part of the library supports two methods to evaluate LABEL/UUID.
 It reads information directly from a block device or read information from
-/dev/disk/by-* udev symlinks. The udev is preferred method by default.
+/dev/disk/by-* udev symlinks.  The udev is preferred method by default.
 .P
 If you are dealing with
 multiple devices, use of the cache is highly recommended (even if empty) as
@@ -57,7 +57,7 @@ in this situation.
 .SH CONFIGURATION FILE
 The standard location of the
 .I /etc/blkid.conf
-config file can be overridden by the environment variable BLKID_CONF. For more
+config file can be overridden by the environment variable BLKID_CONF.  For more
 details about the config file see
 .BR blkid (8)
 man page.
-- 
1.9.0

