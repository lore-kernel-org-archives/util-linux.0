Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33492 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbcBWTXj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 23 Feb 2016 14:23:39 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so215199710wme.0
        for <util-linux@vger.kernel.org>; Tue, 23 Feb 2016 11:23:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] logger: always update header when writing stdin line
Date: Tue, 23 Feb 2016 19:23:34 +0000
Message-Id: <1456255414-6757-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier separate inputs got the same timestamp even when input arrival was
ensured to happen at different second.

$ (echo foo; sleep 1.1; echo bar) | logger -t baz --no-act -s
<13>Feb 23 19:21:08 baz: foo
<13>Feb 23 19:21:08 baz: bar

Addresses: http://bugs.debian.org/798239
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index e439266..105426c 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -949,6 +949,7 @@ static void logger_stdin(struct logger_ctl *ctl)
 			c = getchar();
 		}
 		buf[i] = '\0';
+		generate_syslog_header(ctl);
 
 		if (i > 0 || !ctl->skip_empty_lines)
 			write_output(ctl, buf);
-- 
2.7.1

