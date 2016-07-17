Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36193 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbcGQNAf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so8717753wma.3
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/13] syspriv: flip inverted logic [oclint]
Date: Sun, 17 Jul 2016 14:00:09 +0100
Message-Id: <20160717130015.31760-8-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setpriv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 3b99a17..977ccd1 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -175,10 +175,10 @@ static int print_caps(FILE *f, capng_type_t which)
 static void dump_one_secbit(int *first, int *bits, int bit, const char *name)
 {
 	if (*bits & bit) {
-		if (!*first)
-			printf(",");
-		else
+		if (*first)
 			*first = 0;
+		else
+			printf(",");
 		fputs(name, stdout);
 		*bits &= ~bit;
 	}
@@ -206,10 +206,10 @@ static void dump_securebits(void)
 	dump_one_secbit(&first, &bits, SECBIT_KEEP_CAPS_LOCKED,
 			"keep_caps_locked");
 	if (bits) {
-		if (!first)
-			printf(",");
-		else
+		if (first)
 			first = 0;
+		else
+			printf(",");
 		printf("0x%x", (unsigned)bits);
 	}
 
-- 
2.9.0

