Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:63315 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3ATSFH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:07 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so2031956wge.22
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:06 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/6] build-sys: add nsenter to gitignore
Date: Sun, 20 Jan 2013 18:04:52 +0000
Message-Id: <1358705096-21092-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
References: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index e85eb07..dbcf0b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -127,6 +127,7 @@ tests/run.sh.trs
 /mountpoint
 /namei
 /newgrp
+/nsenter
 /partx
 /pg
 /pivot_root
-- 
1.8.1.1

