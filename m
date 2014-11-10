Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:55294 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbaKJVuK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:10 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so12033958wiv.2
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/6] tests: add mkswap size printout to expected output
Date: Mon, 10 Nov 2014 21:49:52 +0000
Message-Id: <1415656195-20458-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit 9a83b03c changed mkswap final printout, that made test to
fail.  This change updates test expectation with mentioned commit.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/misc/swaplabel | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/expected/misc/swaplabel b/tests/expected/misc/swaplabel
index fd442af..d54d559 100644
--- a/tests/expected/misc/swaplabel
+++ b/tests/expected/misc/swaplabel
@@ -1,6 +1,6 @@
 mkswap: error: swap area needs to be at least 10 pages
 mkswap: Label was truncated.
-Setting up swapspace version 1, size = 9 pages
+Setting up swapspace version 1, size = 9 pages (36864 bytes)
 LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
 LABEL: 1234567890abcde
 UUID:  12345678-abcd-abcd-abcd-1234567890ab
-- 
2.1.3

