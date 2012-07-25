Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2GYTPt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:49 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] tests: look: add words file
Date: Wed, 25 Jul 2012 21:15:20 +0200
Message-Id: <1343243745-1172-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Archlinux words 2.0-4 package does not have 'apple-pie' in words file.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/look/separator | 4 +---
 tests/ts/look/words     | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 tests/ts/look/words

diff --git a/tests/ts/look/separator b/tests/ts/look/separator
index 17d68db..51e96c9 100755
--- a/tests/ts/look/separator
+++ b/tests/ts/look/separator
@@ -34,8 +34,6 @@ TS_DESC="separator"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-[ -f "/usr/share/dict/words" ] || ts_skip "/usr/share/dict/words not such file"
-
-$TS_CMD_LOOK apple-pie >> $TS_OUTPUT
+$TS_CMD_LOOK apple-pie $TS_TOPDIR/ts/look/words >> $TS_OUTPUT
 ts_finalize
 
diff --git a/tests/ts/look/words b/tests/ts/look/words
new file mode 100644
index 0000000..b67ba9a
--- /dev/null
+++ b/tests/ts/look/words
@@ -0,0 +1,3 @@
+apple
+apple-pie
+oranges
-- 
1.7.11.3

