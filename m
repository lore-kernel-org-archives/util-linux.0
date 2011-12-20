Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57181 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab1LTNgK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 20 Dec 2011 08:36:10 -0500
Received: by mail-qw0-f46.google.com with SMTP id c12so2981786qad.19
        for <util-linux@vger.kernel.org>; Tue, 20 Dec 2011 05:36:10 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/3] lscpu: use xalloc libs
Date: Tue, 20 Dec 2011 08:36:03 -0500
Message-Id: <1324388164-2112-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
References: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/lscpu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 72b56d2..0a7841d 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -363,9 +363,9 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	if (desc->flags) {
 		snprintf(buf, sizeof(buf), " %s ", desc->flags);
 		if (strstr(buf, " svm "))
-			desc->virtflag = strdup("svm");
+			desc->virtflag = xstrdup("svm");
 		else if (strstr(buf, " vmx "))
-			desc->virtflag = strdup("vmx");
+			desc->virtflag = xstrdup("vmx");
 		if (strstr(buf, " lm "))
 			desc->mode |= MODE_32BIT | MODE_64BIT;		/* x86_64 */
 		if (strstr(buf, " zarch "))
-- 
1.7.8

