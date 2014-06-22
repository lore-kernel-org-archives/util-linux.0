Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48843 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbaFVKcP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 06:32:15 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so2677294wib.5
        for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 03:32:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/6] tests: add function to change directory reliable way
Date: Sun, 22 Jun 2014 11:31:53 +0100
Message-Id: <1403433117-32652-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Without arguments bash cd will move to $HOME. Ensure also that when
directory is assumed to be changed the current directory and intented
destination are the same location.

Reference: http://www.spinics.net/lists/util-linux-ng/msg09509.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/functions.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 2a50de7..6998343 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -31,6 +31,20 @@ function ts_canonicalize {
 	fi
 }
 
+function ts_cd {
+	if [ $# -eq 0 ]; then
+		ts_failed "ul_cd: not enough arguments"
+	fi
+	DEST=$(readlink -f "$1" 2>/dev/null)
+	if [ "x$DEST" = "x" ] || [ ! -d "$DEST" ]; then
+		ts_failed "ul_cd: $1: no such directory"
+	fi
+	cd "$DEST" 2>/dev/null || ts_failed "ul_cd: $1: cannot change directory"
+	if [ "$PWD" != "$DEST" ]; then
+		ts_failed "ul_cd: $PWD is not $DEST"
+	fi
+}
+
 function ts_report {
 	if [ "$TS_PARALLEL" == "yes" ]; then
 		echo "$TS_TITLE $1"
-- 
2.0.0

