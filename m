Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:57165 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbaHCOR6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:17:58 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so6511422wes.30
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:17:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/7] zramctl: improve error message
Date: Sun,  3 Aug 2014 15:17:41 +0100
Message-Id: <1407075463-19586-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 85dc30c..9c5b6ed 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -498,7 +498,7 @@ int main(int argc, char **argv)
 		act = find ? A_FINDONLY : A_STATUS;
 
 	if (act != A_RESET && optind + 1 < argc)
-		usage(stderr);		/* only --reset holds more devices */
+		errx(EXIT_FAILURE, _("only one <device> at a time is allowed"));
 
 	switch (act) {
 	case A_STATUS:
-- 
2.0.3

