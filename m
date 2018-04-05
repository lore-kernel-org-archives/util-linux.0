Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41461 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeDET5C (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2018 15:57:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id s12so19752665wrc.8
        for <util-linux@vger.kernel.org>; Thu, 05 Apr 2018 12:57:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] bash-completion: fix few bash set -u issues
Date: Thu,  5 Apr 2018 20:56:53 +0100
Message-Id: <20180405195656.4946-2-kerolasa@iki.fi>
In-Reply-To: <20180405195656.4946-1-kerolasa@iki.fi>
References: <20180405195656.4946-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is the same fix as in reference commit, and the same reason.  Just
correct few files missed earlier.

Reference: abbcec4fc9c8d7fb835b4eafd1bc9d82acbf0056
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/chcpu    |  4 ++--
 bash-completion/lsblk    | 10 +++++-----
 bash-completion/lscpu    |  2 +-
 bash-completion/lslogins |  2 +-
 bash-completion/lsns     |  2 +-
 bash-completion/mount    |  2 +-
 bash-completion/setpriv  |  2 +-
 bash-completion/taskset  |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/bash-completion/chcpu b/bash-completion/chcpu
index 33991f4a8..0d96c2532 100644
--- a/bash-completion/chcpu
+++ b/bash-completion/chcpu
@@ -12,7 +12,7 @@ _chcpu_module()
 			CPULIST_ALL=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/offline)
 			for WORD in $(eval echo $CPULIST_ALL); do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					CPULIST="$WORD $CPULIST"
+					CPULIST="$WORD ${CPULIST:-""}"
 				fi
 			done
 			compopt -o nospace
@@ -26,7 +26,7 @@ _chcpu_module()
 			CPULIST_ALL=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
 			for WORD in $(eval echo $CPULIST_ALL); do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					CPULIST="$WORD $CPULIST"
+					CPULIST="$WORD ${CPULIST:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 4fef8fc84..bd86f9f79 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -20,15 +20,15 @@ _lsblk_module()
 			prefix="${cur%$realcur}"
 			for I in /sys/dev/block/*; do
 				J=${I##*/}
-				MAJOR_ALL="$MAJOR_ALL ${J%%:*}"
+				MAJOR_ALL="${MAJOR_ALL:-""} ${J%%:*}"
 			done
-			for WORD in $MAJOR_ALL; do
+			for WORD in ${MAJOR_ALL:-""}; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					MAJOR="$WORD $MAJOR"
+					MAJOR="$WORD ${MAJOR:-""}"
 				fi
 			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -P "$prefix" -W "$MAJOR" -S ',' -- $realcur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "${MAJOR:-""}" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-o'|'--output')
@@ -37,7 +37,7 @@ _lsblk_module()
 			prefix="${cur%$realcur}"
 			for WORD in $LSBLK_COLS_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					LSBLK_COLS="$WORD $LSBLK_COLS"
+					LSBLK_COLS="$WORD ${LSBLK_COLS:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lscpu b/bash-completion/lscpu
index d16af350f..69337acef 100644
--- a/bash-completion/lscpu
+++ b/bash-completion/lscpu
@@ -15,7 +15,7 @@ _lscpu_module()
 				CONFIGURED ONLINE MAXMHZ MINMHZ"
 			for WORD in $OPTS_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					OPTS="$WORD $OPTS"
+					OPTS="$WORD ${OPTS:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lslogins b/bash-completion/lslogins
index 967b644ca..795b5d848 100755
--- a/bash-completion/lslogins
+++ b/bash-completion/lslogins
@@ -35,7 +35,7 @@ _lslogins_module()
 			prefix="${cur%$realcur}"
 			for WORD in $LSLOGINS_COLS_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					LSLOGINS_COLS="$WORD $LSLOGINS_COLS"
+					LSLOGINS_COLS="$WORD ${LSLOGINS_COLS:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/lsns b/bash-completion/lsns
index 8cf0a31f9..035f43b2a 100644
--- a/bash-completion/lsns
+++ b/bash-completion/lsns
@@ -14,7 +14,7 @@ _lsns_module()
 			prefix="${cur%$realcur}"
 			for WORD in $LSNS_COLS_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					LSNS_COLS="$WORD $LSNS_COLS"
+					LSNS_COLS="$WORD ${LSNS_COLS:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/mount b/bash-completion/mount
index 9a3391339..c7e4bead6 100644
--- a/bash-completion/mount
+++ b/bash-completion/mount
@@ -15,7 +15,7 @@ _mount_module()
 			prefix="${cur%$realcur}"
 			for WORD in $TYPES; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					TYPE_COLS="$WORD $TYPE_COLS"
+					TYPE_COLS="$WORD ${TYPE_COLS:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index 8ab9e0722..bf4737a3a 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -38,7 +38,7 @@ _setpriv_module()
 			GIDS_ALL=$(getent group | awk -F: '{print $3}')
 			for WORD in $GIDS_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					GIDS="$WORD $GIDS"
+					GIDS="$WORD ${GIDS:-""}"
 				fi
 			done
 			compopt -o nospace
diff --git a/bash-completion/taskset b/bash-completion/taskset
index 453b17b4a..7c9a7bd54 100644
--- a/bash-completion/taskset
+++ b/bash-completion/taskset
@@ -12,7 +12,7 @@ _taskset_module()
 			CPULIST_ALL=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
 			for WORD in $(eval echo $CPULIST_ALL); do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					CPULIST="$WORD $CPULIST"
+					CPULIST="$WORD ${CPULIST:-""}"
 				fi
 			done
 			compopt -o nospace
-- 
2.17.0

