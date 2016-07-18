Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33406 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbcGRUfC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2016 16:35:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so203799wme.0
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2016 13:35:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] logger: remove trailing spaces when outputing to journal
Date: Mon, 18 Jul 2016 21:34:57 +0100
Message-Id: <20160718203457.3911-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Issues:
1. Whitespace-ish \r is not stripped, while it should be.
2. In journal \r is considered unprintable.

Lennart: "it is the duty of the client side to drop the trailing whitespace,
which "logger" doesn't do".

Reported-by: Ivan Babrou <ibobrik@gmail.com>
Explained-by: Lennart Poettering <lennart@poettering.net>
Reference: https://github.com/systemd/systemd/issues/3416
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 9f2940c..6251f96 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -341,14 +341,10 @@ static int journald_entry(struct logger_ctl *ctl, FILE *fp)
 	for (lines = 0; /* nothing */ ; lines++) {
 		buf = NULL;
 		sz = getline(&buf, &dummy, fp);
-		if (sz == -1) {
+		if (sz == -1 && (sz = rtrim_whitespace(buf)) != 0) {
 			free(buf);
 			break;
 		}
-		if (0 < sz && buf[sz - 1] == '\n') {
-			sz--;
-			buf[sz] = '\0';
-		}
 		if (lines == vectors) {
 			vectors *= 2;
 			if (IOV_MAX < vectors)
-- 
2.9.0

