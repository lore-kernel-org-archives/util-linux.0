Return-Path: util-linux-owner@vger.kernel.org
Received: from [64.56.207.219] ([64.56.207.219]:54684 "EHLO
	mail.alpinelinux.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab1H3MAP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 30 Aug 2011 08:00:15 -0400
From: Natanael Copa <ncopa@alpinelinux.org>
To: util-linux@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] script: fix building with --disable-nls
Date: Tue, 30 Aug 2011 11:50:28 +0000
Message-Id: <1314705028-5781-1-git-send-email-ncopa@alpinelinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We should only include the libintl.h when NLS is requested.

This fixes issue when building util-linux with uClibc.

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 term-utils/script.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index d96ca2f..99748a1 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -55,7 +55,9 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <fcntl.h>
+#ifdef ENABLE_NLS
 #include <libintl.h>
+#endif
 #include <limits.h>
 #include <locale.h>
 #include <stddef.h>
-- 
1.7.6.1

