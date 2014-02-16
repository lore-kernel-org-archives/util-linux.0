Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41253 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBPXyl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:41 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm4so1884428wib.2
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:40 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/9] tools: add usage information to checkconfig.sh
Date: Sun, 16 Feb 2014 23:54:16 +0000
Message-Id: <1392594862-15807-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/checkconfig.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/checkconfig.sh b/tools/checkconfig.sh
index 91f7b1c..5f2063a 100755
--- a/tools/checkconfig.sh
+++ b/tools/checkconfig.sh
@@ -16,6 +16,17 @@ die() {
 	exit 1
 }
 
+usage() {
+	echo "Usage:"
+	echo " $0 <top_srcdir> <srcfile> [<srcfile> ...]"
+	echo "Example:"
+	echo " find . -name '*.c' | xargs $0 \$(git rev-parse --show-toplevel)"
+}
+
+if [ $# -eq 0 ]; then
+	usage
+	exit 1
+fi
 srcdir=$1
 config="$srcdir/config.h.in"
 
-- 
1.9.0

