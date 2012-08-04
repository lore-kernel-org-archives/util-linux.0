Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41375 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab2HDHdh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2012 03:33:37 -0400
Received: by wgbfm10 with SMTP id fm10so189191wgb.1
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2012 00:33:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/5] docs: update TODO
Date: Sat,  4 Aug 2012 09:33:37 +0200
Message-Id: <1344065620-17480-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove tasks that are done.

dmesg: --follow option
Reference: 0fd12a9697c2e01e3c2e1e558ff027cd2947ee94

build-sys: recursive build
Reference: 8772f8d7eeeb922bccee3376552c59d7148df7b4

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index 38a3c30..a646127 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -15,9 +15,6 @@ losetup
 dmesg
 -----
 
- - add --follow option
-   http://www.spinics.net/lists/util-linux-ng/msg04453.html
-
  - add --color to colorize err and panic messages
 
 hwclock
@@ -117,12 +114,6 @@ docs
  - (!) add API documentation to libuuid
 
 
-build-sys
---------
-
- - use non-recursive build-sys, see
-   http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297
-
 lib/tt.c
 --------
 
-- 
1.7.11.4

