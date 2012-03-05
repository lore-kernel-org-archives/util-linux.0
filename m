Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62060 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757509Ab2CETjJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:09 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565217eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/17] docs: TODO removal, login-utils error printing
Date: Mon,  5 Mar 2012 20:38:39 +0100
Message-Id: <1330976334-10751-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Error printing was fixed at November 2010.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO |    1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index 10980d1..6b8c2cc 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -151,7 +151,6 @@ lib/tt.c
 login-utils:
 -----------
 
- - use err() and warn() macros rather than fprintf(stderr, ...)
  - (!) merge newgrp from shadow-utils
  - (!) enable login utils by default
 
-- 
1.7.9.2

