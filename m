Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33606 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbcGRUtw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2016 16:49:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so248722wme.0
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2016 13:49:38 -0700 (PDT)
Received: from imuri (host-92-2-141-235.as43234.net. [92.2.141.235])
        by smtp.gmail.com with ESMTPSA id c139sm18510131wme.4.2016.07.18.13.49.37
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2016 13:49:37 -0700 (PDT)
Date: Mon, 18 Jul 2016 21:49:27 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: remove trailing spaces when outputing to
 journal
In-Reply-To: <20160718203457.3911-1-kerolasa@iki.fi>
Message-ID: <alpine.LNX.2.20.1607182146130.10723@imuri>
References: <20160718203457.3911-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 18 Jul 2016, Sami Kerola wrote:

> Signed-off-by: Sami Kerola <kerolasa@iki.fi>

Hi Sami, no repeat 100 time: do not send patches before testing them.

Let me try again, and also available from

https://github.com/kerolasa/lelux-utiliteetit/commit/076ce184fea4591bd364d77474fcfffdcad73a5b

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 18 Jul 2016 21:15:54 +0100
Subject: [PATCH] logger: remove trailing spaces when outputing to journal

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
 misc-utils/logger.c            | 7 ++-----
 tests/expected/logger/journald | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 9f2940c..70fac68 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -341,14 +341,11 @@ static int journald_entry(struct logger_ctl *ctl, FILE *fp)
 	for (lines = 0; /* nothing */ ; lines++) {
 		buf = NULL;
 		sz = getline(&buf, &dummy, fp);
-		if (sz == -1) {
+		if (sz == -1 ||
+		   (sz = rtrim_whitespace((unsigned char *) buf)) == 0) {
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
diff --git a/tests/expected/logger/journald b/tests/expected/logger/journald
index 75bd0f3..354628d 100644
--- a/tests/expected/logger/journald
+++ b/tests/expected/logger/journald
@@ -1,4 +1,3 @@
 MESSAGE_ID=b8f74e14bc714bfc8040a5106dc9376a
 MESSAGE=a b c 1 2 3
-
 ret: 0
-- 
2.9.0

