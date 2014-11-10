Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50450 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbaKJVuE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:04 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so9955830wgh.25
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:02 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/6] build-sys: make scanf_cv_alloc_modifier to work [AddressSanitizer]
Date: Mon, 10 Nov 2014 21:49:50 +0000
Message-Id: <1415656195-20458-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The tests failed with following message in config.log

ERROR: LeakSanitizer: detected memory leaks

Direct leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x49a40e in realloc (/home/src/util-linux/conftest+0x49a40e)
    #1 0x7fbe48633e69 in __GI__IO_vfscanf (/usr/lib/libc.so.6+0x56e69)
    #2 0x7fbe48649786 in _IO_vsscanf (/usr/lib/libc.so.6+0x6c786)

which knocked out libmount from build, and commands depending on it.

The reason this change makes sense is that AddressSanitizer seems like a
good addition to set of tools that util-linux package can use, when and
if needed.

Reference: https://code.google.com/p/address-sanitizer/wiki/AddressSanitizer
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 1336f8d..b8a6627 100644
--- a/configure.ac
+++ b/configure.ac
@@ -461,6 +461,7 @@ int main()
 	int i;
 	char *s;
 	i = sscanf("x", $1, &s);
+	free(s);
 	if (i == 1)
 		return 0;
 	return 1;
-- 
2.1.3

