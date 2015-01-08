Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63962 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbbAHEN3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 23:13:29 -0500
Message-ID: <54AE03E1.7020103@gmx.com>
Date: Wed, 07 Jan 2015 23:13:21 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 1/4] hwclock: enable --directisa for x86_64
References: <54AE031C.30907@gmx.com>
In-Reply-To: <54AE031C.30907@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Currently only x86 and Alpha can use --directisa.
This patch allows x86_64 machines to use it as well.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index ca6ab1c..8d68808 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -55,7 +55,7 @@
 #include "c.h"
 #include "nls.h"
 
-#if defined(__i386__)
+#if defined(__i386__) || defined(__x86_64__)
 # ifdef HAVE_SYS_IO_H
 #  include <sys/io.h>
 # elif defined(HAVE_ASM_IO_H)
@@ -66,6 +66,7 @@
  * not export that header.
  */
 #undef __i386__
+#undef __x86_64__
 void outb(int a __attribute__ ((__unused__)),
 	  int b __attribute__ ((__unused__)))
 {
@@ -75,7 +76,7 @@ int inb(int c __attribute__ ((__unused__)))
 {
 	return 0;
 }
-#endif				/* __i386__ */
+#endif				/* __i386__ __x86_64__ */
 
 #elif defined(__alpha__)
 /* <asm/io.h> fails to compile, probably because of u8 etc */
@@ -603,7 +604,7 @@ static int set_hardware_clock_cmos(const struct tm *new_broken_time)
 	return 0;
 }
 
-#if defined(__i386__) || defined(__alpha__)
+#if defined(__i386__) || defined(__alpha__) || defined(__x86_64__)
 # if defined(HAVE_IOPL)
 static int i386_iopl(const int level)
 {
@@ -663,7 +664,7 @@ static struct clock_ops cmos = {
 struct clock_ops *probe_for_cmos_clock(void)
 {
 	int have_cmos =
-#if defined(__i386__) || defined(__alpha__)
+#if defined(__i386__) || defined(__alpha__) || defined(__x86_64__)
 	    TRUE;
 #else
 	    FALSE;

