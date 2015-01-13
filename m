Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55446 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbbAMTAE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Jan 2015 14:00:04 -0500
Message-ID: <54B56B23.7080305@gmx.com>
Date: Tue, 13 Jan 2015 13:59:47 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/4] tools: checkmans.sh clean up 'let'
References: <54B56822.40805@gmx.com>
In-Reply-To: <54B56822.40805@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Clean up 'let' issues and loop iteration.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 tools/checkmans.sh | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index 513a750..bd2bc43 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -42,7 +42,8 @@ done
 # Try to find missing manuals matching build targets with manual files.
 declare -A MAN_LIST BIN_LIST
 
-COUNT_ERRORS=0
+declare -i ITER
+declare -i COUNT_ERRORS=0
 declare -a REPEATS
 declare -A KNOWN_REPEATS
 KNOWN_REPEATS[mount.8]='foo'
@@ -111,21 +112,14 @@ for I in $(
 		sed  -e 's/\s\+/\n/g; /^$/d' |
 		awk 'BEGIN { p="" } { if (0 < length($0)) { if (p == $0) { print } } p = $0 }') )
 	if [ 0 -lt "${#REPEATS[@]}" ]; then
-		ITER=${#REPEATS[@]}
-		while [ -1 -lt ${ITER} ]; do
+		ITER=${#REPEATS[@]}+1
+		while ((ITER--)); do
 			remove_repeats ${ITER}
-			# The 'let' may cause exit on error.
-			# When ITER == 0 -> let returns 1, bash bug?
-			let ITER=${ITER}-1 || true
 		done
 		if [ 0 -lt "${#REPEATS[@]}" ]; then
 			echo "warning: ${I} has repeating words: ${REPEATS[@]}"
 		fi
 	fi
-	# The 'let' may cause exit on error.
-	# COUNT_ERRORS=0; let COUNT_ERRORS=$COUNT_ERRORS+0; echo $?
-	# Is this a bash bug?
-	let COUNT_ERRORS=$COUNT_ERRORS+$I_ERR || true
 done
 
 # Create a list of build targets.
