Return-Path: util-linux-owner@vger.kernel.org
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:49028 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750737Ab3FGEIl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Jun 2013 00:08:41 -0400
Received: from mail192-tx2 (localhost [127.0.0.1])	by
 mail192-tx2-R.bigfish.com (Postfix) with ESMTP id 8DCA54C06E5	for
 <util-linux@vger.kernel.org>; Fri,  7 Jun 2013 04:08:40 +0000 (UTC)
Received: from TX2EHSMHS041.bigfish.com (unknown [10.9.14.230])	by
 mail192-tx2.bigfish.com (Postfix) with ESMTP id 224512E0047	for
 <util-linux@vger.kernel.org>; Fri,  7 Jun 2013 04:08:39 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <nathan.rossi@xilinx.com>)	id 1Uknyg-0002Lt-J3	for
 util-linux@vger.kernel.org; Thu, 06 Jun 2013 21:08:38 -0700
From: Nathan Rossi <nathan.rossi@xilinx.com>
To: <util-linux@vger.kernel.org>
CC: Nathan Rossi <nathan.rossi@xilinx.com>
Subject: [PATCH] fdisk: add support for the MicroBlaze architecture
Date: Fri, 7 Jun 2013 14:08:06 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f2659884-36d1-4011-9485-e2dda08b5a6d@TX2EHSMHS041.ehs.local>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add support to fdisk for the MicroBlaze architecture.

Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
---
 fdisks/fdiskbsdlabel.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fdisks/fdiskbsdlabel.h b/fdisks/fdiskbsdlabel.h
index 8c4e4e7..69f1065 100644
--- a/fdisks/fdiskbsdlabel.h
+++ b/fdisks/fdiskbsdlabel.h
@@ -49,7 +49,8 @@
 #if defined (__i386__) || defined (__sparc__) || defined (__arm__) || \
     defined (__mips__) || defined (__s390__) || defined (__sh__) || \
     defined (__aarch64__) || defined(__xtensa__) || \
-    defined(__x86_64__) || defined (__avr32__) || defined(__cris__)
+    defined (__x86_64__) || defined (__avr32__) || defined(__cris__) || \
+    defined (__microblaze__)
 #define BSD_LABELSECTOR   1
 #define BSD_LABELOFFSET   0
 #elif defined (__alpha__) || defined (__powerpc__) || defined (__ia64__) || defined (__hppa__)
-- 
1.7.5.4


