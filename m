Return-Path: elseifthen@gmx.com
Message-ID: <54B56BBC.5000602@gmx.com>
Date: Tue, 13 Jan 2015 14:02:20 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] tools: checkmans.sh add stats
References: <54B56822.40805@gmx.com>
In-Reply-To: <54B56822.40805@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Add test results statistics.
Fix-up 'KNOWN_REPEATS'.
Version bump.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 tools/checkmans.sh | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index bd2bc43..618f8ba 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -26,7 +26,7 @@ while getopts vVh OPTIONS; do
 			VERBOSE='true'
 			;;
 		V)
-			echo "util-linux: ${SCRIPT_INVOCATION_SHORT_NAME}: 2"
+			echo "util-linux: ${SCRIPT_INVOCATION_SHORT_NAME}: v2.1"
 			exit 0
 			;;
 		h)
@@ -43,11 +43,13 @@ done
 declare -A MAN_LIST BIN_LIST
 
 declare -i ITER
-declare -i COUNT_ERRORS=0
+declare -i COUNT_GROG=0
+declare -i COUNT_TROFF=0
+declare -i COUNT_REPEATS=0
 declare -a REPEATS
 declare -A KNOWN_REPEATS
-KNOWN_REPEATS[mount.8]='foo'
-KNOWN_REPEATS[sfdisk.8]="0 <c,h,s>"
+KNOWN_REPEATS[mount.8]='foo l2 l c'
+KNOWN_REPEATS[hexdump.1]='l'
 KNOWN_REPEATS[flock.1]='"$0"'
 KNOWN_REPEATS[switch_root.8]='$DIR'
 
@@ -81,7 +83,6 @@ for I in $(
 		fi
 		continue
 	fi
-	I_ERR=0
 	if ${VERBOSE}; then
 		echo "testing: ${I}"
 	fi
@@ -90,22 +91,23 @@ for I in $(
 	if [ $RET = 0 ]; then
 	echo "From: cat ${I} | troff -mandoc -ww -z"
 	echo "=================================================="
+	((++COUNT_TROFF))
 	fi
 	GROG=1
 	if command -v lexgrog &> /dev/null; then
 		if ! lexgrog ${I} >/dev/null; then
 			echo "error: run: lexgrog ${I}"
 			echo "=================================================="
-			((++COUNT_ERRORS))
+			((++COUNT_GROG))
 		fi
 	elif command -v grog &> /dev/null; then
 		if ! grog ${I} | grep man >/dev/null; then
 			echo "error: grog ${I} is not a man file"
 			echo "=================================================="
-			((++COUNT_ERRORS))
+			((++COUNT_GROG))
 		fi
 	else
-	GROG=0
+		GROG=0
 	fi
 	REPEATS=( $(cat ${I} | troff -mandoc -Tascii 2>/dev/null | grotty |
 		col -b |
@@ -118,6 +120,8 @@ for I in $(
 		done
 		if [ 0 -lt "${#REPEATS[@]}" ]; then
 			echo "warning: ${I} has repeating words: ${REPEATS[@]}"
+			echo "=================================================="
+			((++COUNT_REPEATS))
 		fi
 	fi
 done
@@ -148,17 +152,24 @@ done
 set +u
 for I in ${!BIN_LIST[@]}; do
 	if [ -v ${MAN_LIST[$I]} ]; then
-		echo "warning: ${I} does not have man page"
+		echo "warning: ${SCRIPT_INVOCATION_SHORT_NAME}: ${I} does not have man page"
 	fi
 done
 set -u
 
+echo "${SCRIPT_INVOCATION_SHORT_NAME}: ${#BIN_LIST[*]} build targets were found"
+echo "${SCRIPT_INVOCATION_SHORT_NAME}: ${#MAN_LIST[*]} files were tested"
+
 if [ ${GROG} = 0 ]; then
 echo "warning: neither grog nor lexgrog commands were found"
 fi
 
-if [ ${COUNT_ERRORS} -ne 0 ]; then
-	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_ERRORS} manuals failed"
+if [ ${COUNT_GROG} -ne 0 -o ${COUNT_TROFF} -ne 0 -o ${COUNT_REPEATS} -ne 0 ]; then
+	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_GROG} files failed (lex)grog man-page test"
+	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_TROFF} files failed troff parsing test"
+	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_REPEATS} files have repeating words"
+	ITER=${#MAN_LIST[*]}-${COUNT_GROG}-${COUNT_TROFF}-${COUNT_REPEATS}
+	echo "${SCRIPT_INVOCATION_SHORT_NAME}: ${ITER} man-pages approved"
 	exit 1
 fi
 
