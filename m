Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36711 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdCEUww (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:52 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so19448955wrc.3
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/13] lib/colors: assert rathen than overflow
Date: Sun,  5 Mar 2017 20:52:32 +0000
Message-Id: <20170305205232.24030-14-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lib/colors.c: In function 'colors_read_schemes':
lib/colors.c:412:7: warning: potential null pointer dereference [-Wnull-dereference]
  *out = '\0';
  ~~~~~^~~~~~

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/colors.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/colors.c b/lib/colors.c
index 4b280fe27..baafe0a90 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -342,6 +342,7 @@ static char *colors_get_homedir(char *buf, size_t bufsz)
 static int cn_sequence(const char *str, char **seq)
 {
 	char *in, *out;
+	int len;
 
 	if (!str)
 		return -EINVAL;
@@ -357,7 +358,7 @@ static int cn_sequence(const char *str, char **seq)
 	}
 
 	/* convert xx;yy sequences to "\033[xx;yy" */
-	if (asprintf(seq, "\033[%sm", str) < 1)
+	if ((len = asprintf(seq, "\033[%sm", str)) < 1)
 		return -ENOMEM;
 
 	for (in = *seq, out = *seq; in && *in; in++) {
@@ -409,6 +410,7 @@ static int cn_sequence(const char *str, char **seq)
 		}
 		in++;
 	}
+	assert (len < (out - *seq));
 	*out = '\0';
 
 	return 0;
-- 
2.12.0

