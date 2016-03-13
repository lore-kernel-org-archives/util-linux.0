Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36491 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcCMKcA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:32:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so9996461wml.3
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:32:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/10] isosize: stop unmeaningful printing errno message
Date: Sun, 13 Mar 2016 10:31:43 +0000
Message-Id: <1457865109-2881-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
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
index 43569ae..0f676ca 100644
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
2.7.2

