Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35930 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab2CRDgj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Mar 2012 23:36:39 -0400
Received: by qcqw6 with SMTP id w6so680053qcq.19
        for <util-linux@vger.kernel.org>; Sat, 17 Mar 2012 20:36:38 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/5] tunelp: remove old, now unneeded header
Date: Sat, 17 Mar 2012 23:36:30 -0400
Message-Id: <1332041793-7919-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
References: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

malloc and friends are provided by stdlib.h.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/tunelp.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 700fe65..98b00f6 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -52,7 +52,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <malloc.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
1.7.9.4

