Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57419 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTdz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:55 -0400
Received: by mail-wg0-f42.google.com with SMTP id k13so4125844wgh.1
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Peter Schiffer <pschiffe@redhat.com>
Subject: [PATCH 08/14] tools: add checks to manual page test script
Date: Mon,  8 Apr 2013 20:32:53 +0100
Message-Id: <1365449579-13238-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change includes

- better way to detect manual page inclusion
- man -k header test, which uses lexgrog
- repeated word detection
- static declaration to known repeated words

Most of the  changes are based on man-page-day-1.sh, that is in use at
RedHat Quality Assurance, and wrote by Peter Schiffer.

CC: Peter Schiffer <pschiffe@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/checkmans.sh | 98 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 24 deletions(-)

diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index 4b149d0..a987f41 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -13,15 +13,21 @@ SCRIPT_INVOCATION_SHORT_NAME=$(basename ${0})
 trap 'echo "${SCRIPT_INVOCATION_SHORT_NAME}: exit on error"; exit 1' ERR
 
 usage() {
-	echo "Usage: ${0} [-ph]"
-	echo " -p   print file names before checking"
+	echo "Usage: ${0} [-vVh]"
+	echo " -v  verbose messaging"
+	echo " -V  print version and exit"
+	echo " -h  print this help and exit"
 }
 
-PRINT_FILE_NAMES='false'
-while getopts ph OPTIONS; do
+VERBOSE='false'
+while getopts vVh OPTIONS; do
 	case ${OPTIONS} in
-		p)
-			PRINT_FILE_NAMES='true'
+		v)
+			VERBOSE='true'
+			;;
+		V)
+			echo "util-linux: ${SCRIPT_INVOCATION_SHORT_NAME}: 2"
+			exit 0
 			;;
 		h)
 			usage
@@ -37,39 +43,83 @@ ERROR_FILE=$(mktemp ${SCRIPT_INVOCATION_SHORT_NAME}.XXXXXXXXXX)
 # remove tmp file at exit
 trap "rm -f ${ERROR_FILE}" 0
 
+COUNT_ERRORS=0
+declare -a REPEATS
+declare -A KNOWN_REPEATS
+KNOWN_REPEATS[mount.8]='foo'
+KNOWN_REPEATS[sfdisk.8]="0 <c,h,s>"
+KNOWN_REPEATS[flock.1]='"$0"'
+KNOWN_REPEATS[switch_root.8]='$DIR'
+
+remove_repeats()
+{
+	set +u
+	for KN in ${KNOWN_REPEATS[${I##*/}]}; do
+		if [ "${KN}" = "${REPEATS[$1]}" ]; then
+			if $VERBOSE; then
+				echo "info: ${I} removing repeat: ${REPEATS[$1]}"
+			fi
+			unset REPEATS[$1]
+		fi
+	done
+	set -u
+}
+
 for I in $(
 	find $(git rev-parse --show-toplevel) -name '*.[1-8]' |
 	egrep -v '(Documentation|.git|/.libs/|autom4te.cache)'
 ); do
-	# FIXME: the determination whether a manual does include
-	# should probably be somewhat smarter.
-	IS_INCLUDE=$(wc -w ${I} | awk '{print $1}')
-	if [ ${IS_INCLUDE} -eq 2 ]; then
-		# Some manuals, such as x86_64, call include which
-		# will read system manual.  Testing what comes from
-		# package does not make much sense, so skip doing it.
-		if ${PRINT_FILE_NAMES}; then
-			echo "skipping: ${I}"
+	if awk '{if (1 < NR) {exit 1}; if ($1 ~ /^.so$/) {exit 0}}' ${I}; then
+		# Some manuals, such as x86_64, call inclusion and they
+		# should not be tested any further.
+		if ${VERBOSE}; then
+			printf "skipping: ${I}: includes "
+			awk '{print $2}' ${I}
 		fi
 		continue
 	fi
-	if ${PRINT_FILE_NAMES}; then
+	I_ERR=0
+	if ${VERBOSE}; then
 		echo "testing: ${I}"
-		man --warnings=all ${I} >/dev/null
-	else
-		man --warnings=all ${I} >/dev/null 2>> ${ERROR_FILE}
 	fi
+	MANWIDTH=80 man --warnings=all ${I} >/dev/null 2>| ${ERROR_FILE}
+	if [ -s ${ERROR_FILE} ]; then
+		echo "error: run: man --warnings=all ${I} >/dev/null" >&2
+		I_ERR=1
+	fi
+	if ! lexgrog ${I} >/dev/null; then
+		echo "error: run: lexgrog ${I}" >&2
+		I_ERR=1
+	fi
+	REPEATS=( $(MANWIDTH=2000 man -l ${I} |
+		col -b |
+		sed  -e 's/\s\+/\n/g; /^$/d' |
+		awk 'BEGIN { p="" } { if (0 < length($0)) { if (p == $0) { print } } p = $0 }') )
+	if [ 0 -lt "${#REPEATS[@]}" ]; then
+		ITER=${#REPEATS[@]}
+		while [ -1 -lt ${ITER} ]; do
+			remove_repeats ${ITER}
+			# The 'let' may cause exit on error.
+			# When ITER == 0 -> let returns 1, bash bug?
+			let ITER=${ITER}-1 || true
+		done
+		if [ 0 -lt "${#REPEATS[@]}" ]; then
+			echo "warning: ${I} has repeating words: ${REPEATS[@]}"
+		fi
+	fi
+	# The 'let' may cause exit on error.
+	# COUNT_ERRORS=0; let COUNT_ERRORS=$COUNT_ERRORS+0; echo $?
+	# Is this a bash bug?
+	let COUNT_ERRORS=$COUNT_ERRORS+$I_ERR || true
 done
 
-COUNT_ERRORS=$(awk 'END {print NR}' ${ERROR_FILE})
 if [ ${COUNT_ERRORS} -ne 0 ]; then
-	echo "${SCRIPT_INVOCATION_SHORT_NAME}: failed"
-	echo "use: $(readlink -f ${0}) -p"
-	echo "     to find where the problems are."
+	echo "error: ${SCRIPT_INVOCATION_SHORT_NAME}: ${COUNT_ERRORS} manuals failed" >&2
 	exit 1
 fi
 
-if ! ${PRINT_FILE_NAMES}; then
+if ! ${VERBOSE}; then
 	echo "${SCRIPT_INVOCATION_SHORT_NAME}: success"
 fi
+
 exit 0
-- 
1.8.2.1

