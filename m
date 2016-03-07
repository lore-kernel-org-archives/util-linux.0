Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:54779 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932743AbcCGXMN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:13 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MTBsk-1aSiye1ETm-00SAmm for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:06 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 11/12] tests: improve getopt loop error case
Date: Tue,  8 Mar 2016 00:12:01 +0100
Message-Id: <1457392322-4974-12-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Avoid exit 1 in test scripts. Simplify and complete redirection
to TS_OUPUT.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/misc/getopt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/ts/misc/getopt b/tests/ts/misc/getopt
index 715ec36..460f8a8 100755
--- a/tests/ts/misc/getopt
+++ b/tests/ts/misc/getopt
@@ -31,17 +31,18 @@ eval set -- "$TEMP"
 
 while true ; do
 	case "$1" in
-		-a|--a-long) echo "Option a" >> $TS_OUTPUT 2>&1; shift ;;
-		-b|--b-long) echo "Option b, argument \`$2'" >> $TS_OUTPUT 2>&1; shift 2 ;;
+		-a|--a-long) echo "Option a"; shift ;;
+		-b|--b-long) echo "Option b, argument \`$2'"; shift 2 ;;
 		-c|--c-long)
 			case "$2" in
-				"") echo "Option c, no argument" >> $TS_OUTPUT 2>&1; shift 2 ;;
-				*)  echo "Option c, argument \`$2'" >> $TS_OUTPUT 2>&1; shift 2 ;;
+				"") echo "Option c, no argument"; shift 2 ;;
+				*)  echo "Option c, argument \`$2'"; shift 2 ;;
 			esac ;;
 		--) shift ; break ;;
-		*) echo "Internal error!" >> $TS_OUTPUT 2>&1; exit 1 ;;
+		*) echo "Internal error!"; break;;
 	esac
-done
+done >> $TS_OUTPUT 2>&1
+
 echo "Remaining arguments:" >> $TS_OUTPUT 2>&1
 for arg do echo '--> '"\`$arg'" >> $TS_OUTPUT 2>&1; done
 
-- 
1.9.1

