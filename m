Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:60936 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbdF1QlG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:06 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lv8hi-1dpw9h2isk-010NUw for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:40:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] tools: add segfault detection for checkusage.sh
Date: Wed, 28 Jun 2017 18:40:55 +0200
Message-Id: <1498668057-8256-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tools/checkusage.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/checkusage.sh b/tools/checkusage.sh
index 6cde8fb..69d69fd 100755
--- a/tools/checkusage.sh
+++ b/tools/checkusage.sh
@@ -61,8 +61,8 @@ function exec_option {
 	# hardcoded ... nologin should always return false
 	if test "$cmdb" = "nologin" &&
 			test "$opt" = "--help" -o "$opt" = "--version"; then
-		if test "$ret" = "0"; then
-			echo "$cmdb, $opt, should return false"
+		if test "$ret" -eq 0 -o "$ret" -ge 128; then
+			echo "$cmdb, $opt, should return false: $ret"
 		fi
 		ret=0
 	fi
@@ -123,6 +123,8 @@ function check_unknownopt {
 
 	if test $ret = 0; then
 		echo "$cb: $opt, returns no error"
+	elif test $ret -ge 128; then
+		echo "$cb: $opt, abnormal exit: $ret"
 	fi
 	if test -n "$out"; then
 		echo "$cb: $opt, non-empty stdout"
-- 
1.8.5.6

