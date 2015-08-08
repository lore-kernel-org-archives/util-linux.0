Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35397 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbHHHOk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Aug 2015 03:14:40 -0400
Received: by wibxm9 with SMTP id xm9so84334518wib.0
        for <util-linux@vger.kernel.org>; Sat, 08 Aug 2015 00:14:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] tools: stop checkmans.sh validating libtool builds
Date: Sat,  8 Aug 2015 08:14:32 +0100
Message-Id: <1439018073-5592-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The checkmans.sh tried to validate shared libraries, such as
./.libs/libsmartcols.so.1, causing the check output to a have
lot of pointless garbage.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/checkmans.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index 618f8ba..9a13778 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -70,7 +70,7 @@ remove_repeats()
 cd $(git rev-parse --show-toplevel)
 
 for I in $(
-	find -path './autom4te.cache' -prune -o -name '*[[:alpha:]].[1-8]' -print
+	find -path './autom4te.cache' -prune -o -path './.libs' -prune -o -name '*[[:alpha:]].[1-8]' -print
 ); do
 	MAN_FILE=${I##*/}
 	MAN_LIST[${MAN_FILE%%.[0-9]}]=1
-- 
2.5.0

