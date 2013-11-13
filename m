Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:41217 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab3KMPax (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Nov 2013 10:30:53 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Remove cruft from mkswap man page
Date: Wed, 13 Nov 2013 10:30:52 -0500
Message-Id: <1384356652-27468-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I don't think there's any reason to continue to mention behavior
of kernels older than 10 years.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 disk-utils/mkswap.8 | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index 68cc40b..e08aa03 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -103,21 +103,13 @@ Display version information and exit.
 .SH NOTES
 The maximum useful size of a swap area depends on the architecture and
 the kernel version.
-It is roughly 2GiB on i386, PPC, m68k and ARM, 1GiB on sparc, 512MiB on mips,
-128GiB on alpha, and 3TiB on sparc64.  For kernels after 2.3.3 (May 1999) there is no
-such limitation.
 
 The maximum number of the pages that is possible to address by swap area header
 is 4294967295 (UINT_MAX). The remaining space on the swap device is ignored.
 
-Note that before version 2.1.117 the kernel allocated one byte for each page,
-while it now allocates two bytes, so that taking into use a swap area of 2 GiB
-might require 2 MiB of kernel memory.
-
-Presently, Linux allows 32 swap areas (this was 8 before Linux 2.4.10 (Sep 2001)).
+Presently, Linux allows 32 swap areas.
 The areas in use can be seen in the file
 .I /proc/swaps
-(since 2.1.25 (Sep 1997)).
 
 .B mkswap
 refuses areas smaller than 10 pages.
-- 
1.8.3.2

