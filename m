Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:51782 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab1KAP3n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Nov 2011 11:29:43 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8A13389994
	for <util-linux@vger.kernel.org>; Tue,  1 Nov 2011 16:29:42 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] dmesg: fix printing of multibyte characters
Date: Tue,  1 Nov 2011 16:29:42 +0100
Message-Id: <1320161382-12677-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also make it compile if HAVE_WIDECHAR is not defined.

Addresses: https://bugzilla.novell.com/show_bug.cgi?id=725993
Reported-by: Harald Koenig <koenig@linux.de>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/dmesg.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index c6e242f..793b1c4 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -429,10 +429,11 @@ static void safe_fwrite(const char *buf, size_t size, FILE *out)
 	for (i = 0; i < size; i++) {
 		const char *p = buf + i;
 		int rc, hex = 0;
+        size_t len = 1;
 
 #ifdef HAVE_WIDECHAR
 		wchar_t wc;
-		size_t len = mbrtowc(&wc, p, size - i, &s);
+		len = mbrtowc(&wc, p, size - i, &s);
 
 		if (len == 0)				/* L'\0' */
 			return;
@@ -440,16 +441,15 @@ static void safe_fwrite(const char *buf, size_t size, FILE *out)
 		if (len == (size_t)-1 || len == (size_t)-2) {		/* invalid sequence */
 			memset(&s, 0, sizeof (s));
 			len = hex = 1;
-
 		} else if (len > 1 && !iswprint(wc)) {	/* non-printable multibyte */
 			hex = 1;
-		} else
-#endif
-		{
-			if (!isprint((unsigned int) *p) &&
-			    !isspace((unsigned int) *p))		/* non-printable */
-				hex = 1;
 		}
+		i += len - 1;
+#else
+		if (!isprint((unsigned int) *p) &&
+			!isspace((unsigned int) *p))        /* non-printable */
+			hex = 1;
+#endif
 		if (hex)
 			rc = fwrite_hex(p, len, out);
 		else
-- 
1.7.3.4

