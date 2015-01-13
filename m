Return-Path: elseifthen@gmx.com
Message-ID: <54B56AAC.8000302@gmx.com>
Date: Tue, 13 Jan 2015 13:57:48 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/4] tools: checkman.sh portability lexgrog
References: <54B56822.40805@gmx.com>
In-Reply-To: <54B56822.40805@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

checkman.sh depends upon the man-db package:
   Add using grog when lexgrog not installed.

   /dev/null some troff noise.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 tools/checkmans.sh | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index 6b80853..513a750 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -90,11 +90,23 @@ for I in $(
 	echo "From: cat ${I} | troff -mandoc -ww -z"
 	echo "=================================================="
 	fi
-	if ! lexgrog ${I} >/dev/null; then
-		echo "error: run: lexgrog ${I}" >&2
-		I_ERR=1
+	GROG=1
+	if command -v lexgrog &> /dev/null; then
+		if ! lexgrog ${I} >/dev/null; then
+			echo "error: run: lexgrog ${I}"
+			echo "=================================================="
+			((++COUNT_ERRORS))
+		fi
+	elif command -v grog &> /dev/null; then
+		if ! grog ${I} | grep man >/dev/null; then
+			echo "error: grog ${I} is not a man file"
+			echo "=================================================="
+			((++COUNT_ERRORS))
+		fi
+	else
+	GROG=0
 	fi
-	REPEATS=( $(cat ${I} | troff -mandoc -ww -Tascii | grotty |
+	REPEATS=( $(cat ${I} | troff -mandoc -Tascii 2>/dev/null | grotty |
 		col -b |
 		sed  -e 's/\s\+/\n/g; /^$/d' |
 		awk 'BEGIN { p="" } { if (0 < length($0)) { if (p == $0) { print } } p = $0 }') )
@@ -147,8 +159,12 @@ for I in ${!BIN_LIST[@]}; do
 done
 set -u
 
+if [ ${GROG} = 0 ]; then
+echo "warning: neither grog nor lexgrog commands were found"
+fi
+
 if [ ${COUNT_ERRORS} -ne 0 ]; then
-	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_ERRORS} manuals failed" >&2
+	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_ERRORS} manuals failed"
 	exit 1
 fi
 
