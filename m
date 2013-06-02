Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:49571 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab3FBRwF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:05 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so2567685wgh.29
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/19] rev: stop adding new line at the end when input does not have it
Date: Sun,  2 Jun 2013 18:51:16 +0100
Message-Id: <1370195485-27907-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When the rev(1) is executed twice outcome is expected to be exactly what
it was originally.  That includes not adding new line at the end of the
output.  The oneliner below demonstrates earlier issue.

$ printf "abc\n123" | rev | rev

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/misc/rev | 4 +++-
 tests/ts/misc/rev       | 2 ++
 text-utils/rev.c        | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/expected/misc/rev b/tests/expected/misc/rev
index 263923f..41fdf4c 100644
--- a/tests/expected/misc/rev
+++ b/tests/expected/misc/rev
@@ -1,2 +1,4 @@
 53bbf0d98205319cee2ba589e205c68b  -
-b407c257ed73b43cb992e778f925f7a3  -
+35484965b7a2fd45a471c0d80cb9752c  -
+cba
+321
\ No newline at end of file
diff --git a/tests/ts/misc/rev b/tests/ts/misc/rev
index f36a799..035ce82 100755
--- a/tests/ts/misc/rev
+++ b/tests/ts/misc/rev
@@ -23,4 +23,6 @@ for I in {0..512}; do printf "%s " {a..z}; done | md5sum >> $TS_OUTPUT 2>&1
 for I in {0..512}; do printf "%s " {a..z}; done | \
 				    $TS_CMD_REV | md5sum >> $TS_OUTPUT 2>&1
 
+printf "abc\n123" | $TS_CMD_REV >> $TS_OUTPUT 2>&1
+
 ts_finalize
diff --git a/text-utils/rev.c b/text-utils/rev.c
index 9554506..0456c2b 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -159,7 +159,8 @@ int main(int argc, char *argv[])
 				if (*t != 0)
 					putwchar(*t);
 			}
-			putwchar('\n');
+			if (!feof(fp))
+				putwchar('\n');
 		}
 
 		fflush(fp);
-- 
1.8.3

