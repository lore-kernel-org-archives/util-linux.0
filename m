Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:49507 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbaI1TwN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:13 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so3462923wib.2
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/23] flock: add error message to translations
Date: Sun, 28 Sep 2014 20:51:38 +0100
Message-Id: <1411933916-30576-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And remove type casting.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index f160eac..810a061 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -218,7 +218,7 @@ int main(int argc, char *argv[])
 
 	} else if (optind < argc) {
 		/* Use provided file descriptor */
-		fd = (int)strtol_or_err(argv[optind], "bad number");
+		fd = strtos32_or_err(argv[optind], _("bad file descriptor"));
 	} else {
 		/* Bad options */
 		errx(EX_USAGE, _("requires file descriptor, file or directory"));
-- 
2.1.1

