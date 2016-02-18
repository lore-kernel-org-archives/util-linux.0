Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:54169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426387AbcBRNMx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:53 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LdpcB-1a6ABk2xeN-00j0rY for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/15] tests: fix ts_option helpers
Date: Thu, 18 Feb 2016 14:12:45 +0100
Message-Id: <1455801169-10470-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

These two problems should be fixed now:
  - BSD awk only accepts 1-char field seperator
  - ts_has_option() did not returned "yes" if an option was given
    multiple times

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/functions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index d3367e1..e639e73 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -158,13 +158,15 @@ function ts_has_option {
 	fi
 
 	# or just check the global command line options
-	echo -n $ALL | sed 's/ //g' | awk 'BEGIN { FS="="; RS="--" } /('$NAME'$|'$NAME'=)/ { print "yes" }'
+	if [[ $ALL =~ ([$' \t\n']|^)--$NAME([$'= \t\n']|$) ]]; then echo yes; fi
 }
 
 function ts_option_argument {
 	NAME="$1"
 	ALL="$2"
-	echo -n $ALL | sed 's/ //g' | awk 'BEGIN { FS="="; RS="--" } /'$NAME'=/ { print $2 }'
+
+	# last option wins!
+	echo "$ALL" | sed -n "s/.*[ \t\n]--$NAME=\([^ \t\n]*\).*/\1/p" | tail -n 1
 }
 
 function ts_init_core_env {
-- 
1.8.4.5

