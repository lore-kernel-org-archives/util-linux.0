Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:61353 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbaEDPvB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:51:01 -0400
Received: by mail-we0-f176.google.com with SMTP id q59so4180908wes.35
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:51:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/15] cytune: update copyright
Date: Sun,  4 May 2014 16:49:56 +0100
Message-Id: <1399218596-21321-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Take the blame of bugs I (hopefully did not) introduce.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index d9bc900..95db9c9 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -35,6 +35,8 @@
   * - added Native Language Support
   * Sun Mar 21 1999 - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   * - fixed strerr(errno) in gettext calls
+  * May 2014 - Sami Kerola <kerolasa@iki.fi>
+  * - more than 50% rewrite of the code
   */
 
 #include <getopt.h>
-- 
1.9.2

