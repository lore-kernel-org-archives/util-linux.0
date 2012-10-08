Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56748 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab2JHHJJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:09:09 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3493411wgb.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:09:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/14] swapon: remove loop declaration [smatch scan]
Date: Mon,  8 Oct 2012 08:08:20 +0100
Message-Id: <1349680100-18120-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/swapon.c:677:2: error: 'for' loop initial declarations are
only allowed in C99 mode

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 3fe6592..f080080 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -642,6 +642,7 @@ static int swapon_all(void)
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
+	size_t i;
 	fputs(USAGE_HEADER, out);
 
 	fprintf(out, _(" %s [options] [<spec>]\n"), program_invocation_short_name);
@@ -674,7 +675,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" <file>                 name of file to be used\n"), out);
 
 	fputs(_("\nAvailable columns (for --show):\n"), out);
-	for (size_t i = 0; i < NCOLS; i++)
+	for (i = 0; i < NCOLS; i++)
 		fprintf(out, " %4s  %s\n", infos[i].name, _(infos[i].help));
 
 	fprintf(out, USAGE_MAN_TAIL("swapon(8)"));
-- 
1.7.12.2

