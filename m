Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38957 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaBPPXN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 10:23:13 -0500
Received: by mail-wi0-f181.google.com with SMTP id hi5so1685596wib.14
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 07:23:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] tools: make config-gen to require build target argument
Date: Sun, 16 Feb 2014 15:22:55 +0000
Message-Id: <1392564176-11596-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
References: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When argument is not supplied help user by telling what arguments can be
used.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/config-gen | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/config-gen b/tools/config-gen
index b7ccadd..5febdc4 100755
--- a/tools/config-gen
+++ b/tools/config-gen
@@ -12,6 +12,15 @@ test -f sys-utils/mount.c || {
 
 . tools/config-gen-functions.sh
 
+if [ $# -eq 0 ]; then
+	echo "This script requires at least one of the folloving arguments:"
+	cd tools/config-gen.d
+	for i in *.conf; do
+		echo "  ${i%%.conf}"
+	done
+	exit 1
+fi
+
 while [ -n "$1" ]; do
 	opts="$opts $(ul_get_configuration tools/config-gen.d/$1.conf)"
 	shift
-- 
1.8.5.5

