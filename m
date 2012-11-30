Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:60474 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757114Ab2K3QOd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 30 Nov 2012 11:14:33 -0500
Message-ID: <50B8DB65.60505@bernhard-voelker.de>
Date: Fri, 30 Nov 2012 17:14:29 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] libmount: avoid endless loop in, mnt_get_kernel_cmdline_option
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From 4ddf21607847570e1da3b692276f2a8242bd5af6 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Fri, 30 Nov 2012 17:12:12 +0100
Subject: [PATCH] libmount: avoid endless loop in
 mnt_get_kernel_cmdline_option

The above function infloops when the name to search for can only
be found at the beginning of /proc/cmdline but doesn't match,
e.g. when searching for "ro" in "root=/dev/sda1 quiet vga=0x31a".

* libmount/src/utils.c (mnt_get_kernel_cmdline_option): Replace
while by for loop to ensure the pointer p is incremented.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 libmount/src/utils.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 74c3ad5..be242d0 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -947,9 +947,7 @@ char *mnt_get_kernel_cmdline_option(const char *name)
 	if (len && *(name + len - 1) == '=')
 		val = 1;

-	while (p && *p) {
-		if (p != buf)
-			p++;
+	for ( ; p && *p; p++) {
 		if (!(p = strstr(p, name)))
 			break;			/* not found the option */
 		if (p != buf && !isblank(*(p - 1)))
-- 
1.7.7

