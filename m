Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64631 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbAMSzZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Jan 2015 13:55:25 -0500
Message-ID: <54B56A16.8010906@gmx.com>
Date: Tue, 13 Jan 2015 13:55:18 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] tools: checkman.sh portability
References: <54B56822.40805@gmx.com>
In-Reply-To: <54B56822.40805@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

checkman.sh fails if 'git' or 'lib' are
anywhere in the tested file's path:
   Change to using relative paths.
   Improve the 'find' command call.

checkman.sh depends upon the man-db package:
   Remove all instants of the man command and
   use troff directly to improve portability.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 tools/checkmans.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index bc3ba8f..6b80853 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -39,10 +39,6 @@ while getopts vVh OPTIONS; do
 	esac
 done
 
-ERROR_FILE=$(mktemp ${SCRIPT_INVOCATION_SHORT_NAME}.XXXXXXXXXX)
-# remove tmp file at exit
-trap "rm -f ${ERROR_FILE}" 0
-
 # Try to find missing manuals matching build targets with manual files.
 declare -A MAN_LIST BIN_LIST
 
@@ -68,9 +64,10 @@ remove_repeats()
 	set -u
 }
 
+cd $(git rev-parse --show-toplevel)
+
 for I in $(
-	find $(git rev-parse --show-toplevel) -name '*.[1-8]' |
-	egrep -v '(Documentation|.git|/.libs/|autom4te.cache)'
+	find -path './autom4te.cache' -prune -o -name '*[[:alpha:]].[1-8]' -print
 ); do
 	MAN_FILE=${I##*/}
 	MAN_LIST[${MAN_FILE%%.[0-9]}]=1
@@ -78,7 +75,7 @@ for I in $(
 		# Some manuals, such as x86_64, call inclusion and they
 		# should not be tested any further.
 		if ${VERBOSE}; then
-			printf "skipping: ${I##*util-linux/}: includes "
+			printf "skipping: ${I}: includes "
 			awk '{print $2}' ${I}
 		fi
 		continue
@@ -87,16 +84,17 @@ for I in $(
 	if ${VERBOSE}; then
 		echo "testing: ${I}"
 	fi
-	MANWIDTH=80 man --warnings=all ${I} >/dev/null 2>| ${ERROR_FILE}
-	if [ -s ${ERROR_FILE} ]; then
-		echo "error: run: man --warnings=all ${I##*util-linux/} >/dev/null" >&2
-		I_ERR=1
+	RET=1
+	cat ${I} | troff -mandoc -ww -z |& grep "<" && RET=$?
+	if [ $RET = 0 ]; then
+	echo "From: cat ${I} | troff -mandoc -ww -z"
+	echo "=================================================="
 	fi
 	if ! lexgrog ${I} >/dev/null; then
-		echo "error: run: lexgrog ${I##*util-linux/}" >&2
+		echo "error: run: lexgrog ${I}" >&2
 		I_ERR=1
 	fi
-	REPEATS=( $(MANWIDTH=2000 man -l ${I} |
+	REPEATS=( $(cat ${I} | troff -mandoc -ww -Tascii | grotty |
 		col -b |
 		sed  -e 's/\s\+/\n/g; /^$/d' |
 		awk 'BEGIN { p="" } { if (0 < length($0)) { if (p == $0) { print } } p = $0 }') )
@@ -109,7 +107,7 @@ for I in $(
 			let ITER=${ITER}-1 || true
 		done
 		if [ 0 -lt "${#REPEATS[@]}" ]; then
-			echo "warning: ${I##*util-linux/} has repeating words: ${REPEATS[@]}"
+			echo "warning: ${I} has repeating words: ${REPEATS[@]}"
 		fi
 	fi
 	# The 'let' may cause exit on error.
