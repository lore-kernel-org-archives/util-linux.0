Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36166 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbLNVzH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:07 -0500
Received: by mail-wm0-f52.google.com with SMTP id n186so138797558wmn.1
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:55:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/8] isosize: stop unmeaningful printing errno message
Date: Mon, 14 Dec 2015 21:54:49 +0000
Message-Id: <1450130093-12108-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier printout had strange looking 'Success'.

$ isosize --sectors /dev/urandom
isosize: /dev/urandom: might not be an ISO filesystem
isosize: 733error: le=-1971599244 be=1633181607: Success
...

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index fb35764..4fb3386 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -84,7 +84,7 @@ static int isonum_733(unsigned char *p, int xflag)
 	int be = isonum_732(p + 4);
 	if (xflag && le != be)
 		/* translation is useless */
-		warn("733error: le=%d be=%d", le, be);
+		warnx("733error: le=%d be=%d", le, be);
 	return (le);
 }
 
-- 
2.6.4

