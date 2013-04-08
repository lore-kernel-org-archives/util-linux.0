Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:58349 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935764Ab3DHTeN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:34:13 -0400
Received: by mail-we0-f177.google.com with SMTP id o45so4748605wer.36
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:34:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Peter Schiffer <pschiffe@redhat.com>
Subject: [PATCH 12/14] tools: make checkmans.sh to find missing manuals
Date: Mon,  8 Apr 2013 20:32:57 +0100
Message-Id: <1365449579-13238-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Finding missing manuals is loosely based on ideas in man-page-day-1.sh,
wrote by Peter Schiffer.

CC: Peter Schiffer <pschiffe@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/checkmans.sh | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index a987f41..bc3ba8f 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -43,6 +43,9 @@ ERROR_FILE=$(mktemp ${SCRIPT_INVOCATION_SHORT_NAME}.XXXXXXXXXX)
 # remove tmp file at exit
 trap "rm -f ${ERROR_FILE}" 0
 
+# Try to find missing manuals matching build targets with manual files.
+declare -A MAN_LIST BIN_LIST
+
 COUNT_ERRORS=0
 declare -a REPEATS
 declare -A KNOWN_REPEATS
@@ -69,11 +72,13 @@ for I in $(
 	find $(git rev-parse --show-toplevel) -name '*.[1-8]' |
 	egrep -v '(Documentation|.git|/.libs/|autom4te.cache)'
 ); do
+	MAN_FILE=${I##*/}
+	MAN_LIST[${MAN_FILE%%.[0-9]}]=1
 	if awk '{if (1 < NR) {exit 1}; if ($1 ~ /^.so$/) {exit 0}}' ${I}; then
 		# Some manuals, such as x86_64, call inclusion and they
 		# should not be tested any further.
 		if ${VERBOSE}; then
-			printf "skipping: ${I}: includes "
+			printf "skipping: ${I##*util-linux/}: includes "
 			awk '{print $2}' ${I}
 		fi
 		continue
@@ -84,11 +89,11 @@ for I in $(
 	fi
 	MANWIDTH=80 man --warnings=all ${I} >/dev/null 2>| ${ERROR_FILE}
 	if [ -s ${ERROR_FILE} ]; then
-		echo "error: run: man --warnings=all ${I} >/dev/null" >&2
+		echo "error: run: man --warnings=all ${I##*util-linux/} >/dev/null" >&2
 		I_ERR=1
 	fi
 	if ! lexgrog ${I} >/dev/null; then
-		echo "error: run: lexgrog ${I}" >&2
+		echo "error: run: lexgrog ${I##*util-linux/}" >&2
 		I_ERR=1
 	fi
 	REPEATS=( $(MANWIDTH=2000 man -l ${I} |
@@ -104,7 +109,7 @@ for I in $(
 			let ITER=${ITER}-1 || true
 		done
 		if [ 0 -lt "${#REPEATS[@]}" ]; then
-			echo "warning: ${I} has repeating words: ${REPEATS[@]}"
+			echo "warning: ${I##*util-linux/} has repeating words: ${REPEATS[@]}"
 		fi
 	fi
 	# The 'let' may cause exit on error.
@@ -113,6 +118,37 @@ for I in $(
 	let COUNT_ERRORS=$COUNT_ERRORS+$I_ERR || true
 done
 
+# Create a list of build targets.
+for I in $(find $(git rev-parse --show-toplevel) -name 'Make*.am' | xargs awk '
+$1 ~ /_SOURCES/ {
+	if ($1 ~ /^test/ ||
+	    $1 ~ /^no(inst|dist)/ ||
+	    $1 ~ /^sample/ ||
+	    $1 ~ /^BUILT/) {
+		next
+	}
+	sub(/_SOURCES/, "")
+	if ($1 ~ /^lib.*_la/) {
+		next
+	}
+	sub(/_static/, "")
+	gsub(/_/, ".")
+	sub(/switch.root/, "switch_root")
+	sub(/pivot.root/, "pivot_root")
+	print $1
+}'); do
+	BIN_LIST[$I]=1
+done
+
+# Find if build target does not have manual.
+set +u
+for I in ${!BIN_LIST[@]}; do
+	if [ -v ${MAN_LIST[$I]} ]; then
+		echo "warning: ${I} does not have man page"
+	fi
+done
+set -u
+
 if [ ${COUNT_ERRORS} -ne 0 ]; then
 	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_ERRORS} manuals failed" >&2
 	exit 1
-- 
1.8.2.1

