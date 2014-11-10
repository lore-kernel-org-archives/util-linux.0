Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51072 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbaKJVuQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Nov 2014 16:50:16 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so10013472wgh.1
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 13:50:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/6] tests: skip kill -SEGV test when running AddressSanitizer
Date: Mon, 10 Nov 2014 21:49:54 +0000
Message-Id: <1415656195-20458-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sending signal indicating invalid memory reference makes AddressSanitizer
to report false positive test failure.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/kill/name_to_number | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/ts/kill/name_to_number b/tests/ts/kill/name_to_number
index 9a370bb..cde55c9 100755
--- a/tests/ts/kill/name_to_number
+++ b/tests/ts/kill/name_to_number
@@ -33,6 +33,9 @@ for SIG in $($TS_CMD_KILL -L); do
 		EXPECTED=$SIG
 		continue
 	fi
+	if [ -f "$ASAN_SYMBOLIZER_PATH" ] && [ "x$SIG" = "xSEGV" ]; then
+		continue
+	fi
 	if [ "x$SIG" = "xSTOP" ] || [ "x$SIG" = "xKILL" ]; then
 		continue
 	fi
-- 
2.1.3

