Return-Path: util-linux-owner@vger.kernel.org
Received: from tygrysek.juszkiewicz.com.pl ([178.33.81.99]:55114 "EHLO
	tygrysek.juszkiewicz.com.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997Ab2JCJk5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Oct 2012 05:40:57 -0400
Message-ID: <506C05E7.50400@linaro.org>
Date: Wed, 03 Oct 2012 10:31:19 +0100
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: linaro-dev@lists.linaro.org
Subject: Add AArch64 support into util-linux
Content-Type: multipart/mixed;
 boundary="------------030606090603050708060401"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030606090603050708060401
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Attached patch fixed build problem when util-linux is built for AArch64
architecture.

--------------030606090603050708060401
Content-Type: text/x-patch;
 name="add-aarch64-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="add-aarch64-support.patch"

---
 fdisk/fdiskbsdlabel.h |    1 +
 1 file changed, 1 insertion(+)

--- util-linux-2.21.2.orig/fdisk/fdiskbsdlabel.h
+++ util-linux-2.21.2/fdisk/fdiskbsdlabel.h
@@ -46,10 +46,11 @@
 
 #define BSD_LINUX_BOOTDIR "/usr/ucb/mdec"
 
 #if defined (__i386__) || defined (__sparc__) || defined (__arm__) || \
     defined (__mips__) || defined (__s390__) || defined (__sh__) || \
+    defined (__aarch64__) || \
     defined(__x86_64__) || defined (__avr32__) || defined(__cris__)
 #define BSD_LABELSECTOR   1
 #define BSD_LABELOFFSET   0
 #elif defined (__alpha__) || defined (__powerpc__) || defined (__ia64__) || defined (__hppa__)
 #define BSD_LABELSECTOR   0

--------------030606090603050708060401--
