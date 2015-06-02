Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f43.google.com ([209.85.215.43]:35686 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759814AbbFBR7S (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Jun 2015 13:59:18 -0400
Received: by labko7 with SMTP id ko7so128082489lab.2
        for <util-linux@vger.kernel.org>; Tue, 02 Jun 2015 10:59:16 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 1/3] bash-completion: handle comma-separated options
Date: Tue,  2 Jun 2015 23:59:01 +0600
Message-Id: <1433267943-2276-2-git-send-email-egorov@linux.com>
In-Reply-To: <1433267943-2276-1-git-send-email-egorov@linux.com>
References: <1433267943-2276-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This solution can become messy when you have too many options listed,
because it repeats all of them. For example, after invoking completion
with this input:

    $ partx --output END,SECTORS,SCHEME,START,

You got these completions:

    END,SECTORS,SCHEME,START,FLAGS,  END,SECTORS,SCHEME,START,NR,
    END,SECTORS,SCHEME,START,TYPE,
    END,SECTORS,SCHEME,START,NAME,   END,SECTORS,SCHEME,START,SIZE,
    END,SECTORS,SCHEME,START,UUID,

Nevertheless, it works even with numbers (listed options properly
excluded from completion). Try to invoke completion after
'chcpu --disable ' or 'lsblk --exclude ' to see it in action.

Few issues remained:

    * completion interrupts after encountering ':' in listed option,
    like in 'MAJ:MIN' in lsblk, losetup.
    * lscpu completion is broken: it inserts space after '--extended',
    but lscpu assumes there is no space after this option. It also
    doesn't complete '--parse' option.
    * some completion options are outdated (for example, lscpu MMHZ). We
    need to sync them with code. Fix for lscpu follows.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 bash-completion/chcpu   | 32 ++++++++++++++++++++++----------
 bash-completion/findmnt | 16 ++++++++++++----
 bash-completion/losetup | 14 ++++++++++----
 bash-completion/lsblk   | 30 +++++++++++++++++++++---------
 bash-completion/lscpu   | 33 ++++++++++++++++-----------------
 bash-completion/lslocks | 14 ++++++++++----
 bash-completion/partx   | 15 +++++++++++----
 bash-completion/prlimit | 14 ++++++++++----
 bash-completion/setpriv | 28 ++++++++++++++++++++--------
 bash-completion/swapon  | 14 ++++++++++----
 bash-completion/taskset | 16 +++++++++++-----
 bash-completion/wdctl   | 14 ++++++++++----
 bash-completion/zramctl | 14 ++++++++++----
 13 files changed, 173 insertions(+), 81 deletions(-)

diff --git a/bash-completion/chcpu b/bash-completion/chcpu
index da9c6ca..33991f4 100644
--- a/bash-completion/chcpu
+++ b/bash-completion/chcpu
@@ -6,19 +6,31 @@ _chcpu_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-e'|'--enable')
-			local CPULIST
-			# FIXME: will propose only binding to a cpu.
-			# Maybe this should add comma, and continue?
-			CPULIST=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/offline)
-			COMPREPLY=( $(compgen -W "$(eval echo $CPULIST)" -- $cur) )
+			local prefix realcur CPULIST_ALL CPULIST
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			CPULIST_ALL=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/offline)
+			for WORD in $(eval echo $CPULIST_ALL); do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					CPULIST="$WORD $CPULIST"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$CPULIST" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-d'|'--disable')
-			local CPULIST
-			# FIXME: will propose only binding to a cpu.
-			# Maybe this should add comma, and continue?
-			CPULIST=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
-			COMPREPLY=( $(compgen -W "$(eval echo $CPULIST)" -- $cur) )
+			local prefix realcur CPULIST_ALL CPULIST
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			CPULIST_ALL=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
+			for WORD in $(eval echo $CPULIST_ALL); do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					CPULIST="$WORD $CPULIST"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$CPULIST" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-c'|'--configure'|'-g'|'--deconfigure')
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index cf66565..3ad9147 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -43,15 +43,23 @@ _findmnt_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="SOURCE TARGET FSTYPE OPTIONS VFS-OPTIONS
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+
+			OUTPUT_ALL="SOURCE TARGET FSTYPE OPTIONS VFS-OPTIONS
 				FS-OPTIONS LABEL UUID PARTLABEL PARTUUID
 				MAJ\:MIN ACTION OLD-TARGET OLD-OPTIONS
 				SIZE AVAIL USED USE% FSROOT TID ID
 				OPT-FIELDS PROPAGATION FREQ PASSNO"
+
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-t'|'--types')
diff --git a/bash-completion/losetup b/bash-completion/losetup
index d2b7418..629d34b 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -25,13 +25,19 @@ _losetup_module()
 			return 0
 			;;
 		'-O'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="NAME AUTOCLEAR BACK-FILE BACK-INO
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="NAME AUTOCLEAR BACK-FILE BACK-INO
 				BACK-MAJ:MIN MAJ:MIN OFFSET PARTSCAN RO
 				SIZELIMIT"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index af8b9ad..1692dad 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -5,7 +5,7 @@ _lsblk_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 
-	LSBLK_COLS="NAME KNAME MAJ:MIN FSTYPE MOUNTPOINT
+	LSBLK_COLS_ALL="NAME KNAME MAJ:MIN FSTYPE MOUNTPOINT
 		LABEL UUID PARTTYPE PARTLABEL PARTUUID PARTFLAGS
 		RA RO RM
 		MODEL SIZE STATE OWNER GROUP MODE
@@ -16,26 +16,38 @@ _lsblk_module()
 
 	case $prev in
 		'-e'|'--exclude'|'-I'|'--include')
-			local MAJOR I J
-			MAJOR=''
+			local realcur prefix MAJOR_ALL MAJOR I J
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
 			for I in /sys/dev/block/*; do
 				J=${I##*/}
-				MAJOR="$MAJOR ${J%%:*}"
+				MAJOR_ALL="$MAJOR_ALL ${J%%:*}"
+			done
+			for WORD in $MAJOR_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					MAJOR="$WORD $MAJOR"
+				fi
 			done
-			# FIXME: how to append to a string with compgen?
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$MAJOR" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$MAJOR" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
+			local prefix realcur LSBLK_COLS
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in $LSBLK_COLS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					LSBLK_COLS="$WORD $LSBLK_COLS"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$LSBLK_COLS" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$LSBLK_COLS" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-x'|'--sort')
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$LSBLK_COLS"  -- $cur) )
+			COMPREPLY=( $(compgen -W "$LSBLK_COLS_ALL"  -- $cur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
diff --git a/bash-completion/lscpu b/bash-completion/lscpu
index 7e189ee..ecadd24 100644
--- a/bash-completion/lscpu
+++ b/bash-completion/lscpu
@@ -1,26 +1,25 @@
 _lscpu_module()
 {
-	local cur OPTS
+	local cur OPTS_ALL
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'--extended'|'=')
+		'--extended='|'=')
+			local prefix realcur OPTS
 			cur=${cur#=}
-			# FIXME: how to append to a string with compgen?
-			OPTS="CPU,
-				CORE,
-				SOCKET,
-				NODE,
-				BOOK,
-				CACHE,
-				POLARIZATION,
-				ADDRESS,
-				CONFIGURED,
-				ONLINE,
-				MMHZ"
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OPTS_ALL="CPU CORE SOCKET NODE
+				BOOK CACHE POLARIZATION ADDRESS
+				CONFIGURED ONLINE MMHZ"
+			for WORD in $OPTS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OPTS="$WORD $OPTS"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OPTS" -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OPTS" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
@@ -29,7 +28,7 @@ _lscpu_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--all
+			OPTS_ALL="--all
 				--online
 				--offline
 				--extended=
@@ -38,7 +37,7 @@ _lscpu_module()
 				--hex
 				--help
 				--version"
-			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			COMPREPLY=( $(compgen -W "${OPTS_ALL[*]}" -- $cur) )
 			return 0
 			;;
 	esac
diff --git a/bash-completion/lslocks b/bash-completion/lslocks
index c9cff2c..6ad6c05 100644
--- a/bash-completion/lslocks
+++ b/bash-completion/lslocks
@@ -14,11 +14,17 @@ _lslocks_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="COMMAND PID TYPE SIZE MODE M START END PATH BLOCKER"
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="COMMAND PID TYPE SIZE MODE M START END PATH BLOCKER"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
diff --git a/bash-completion/partx b/bash-completion/partx
index 5d662fc..804787f 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -1,8 +1,8 @@
 _partx_module()
 {
-	local cur prev OPTS OUTPUT
+	local cur prev OPTS OUTPUT_ALL
 	COMPREPLY=()
-	OUTPUT="NR START END SECTORS SIZE NAME UUID TYPE FLAGS SCHEME"
+	OUTPUT_ALL="NR START END SECTORS SIZE NAME UUID TYPE FLAGS SCHEME"
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
@@ -10,9 +10,16 @@ _partx_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
+			local realcur prefix OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-t'|'--type')
diff --git a/bash-completion/prlimit b/bash-completion/prlimit
index c680214..fff7a85 100644
--- a/bash-completion/prlimit
+++ b/bash-completion/prlimit
@@ -11,11 +11,17 @@ _prlimit_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="DESCRIPTION RESOURCE SOFT HARD UNITS"
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="DESCRIPTION RESOURCE SOFT HARD UNITS"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-h'|'--help'|'-V'|'--version')
diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index 7c21dee..bdd3b7d 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -6,11 +6,17 @@ _setpriv_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'--inh-caps'|'--bounding-set')
-			# FIXME: how to append to a string with compgen?
-			local INHERIT
-			INHERIT=$($1 --list-caps| awk '{print $1, "-" $1}')
+			local prefix realcur INHERIT_ALL INHERIT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			INHERIT_ALL=$($1 --list-caps| awk '{print $1, "-" $1}')
+			for WORD in $INHERIT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					INHERIT="$WORD $INHERIT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "all $INHERIT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$INHERIT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'--ruid'|'--euid'|'--reuid')
@@ -26,11 +32,17 @@ _setpriv_module()
 			return 0
 			;;
 		'--groups')
-			# FIXME: how to append to a string with compgen?
-			local GIDS
-			GIDS=$(getent group | awk -F: '{print $3}')
+			local prefix realcur GIDS_ALL GIDS
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			GIDS_ALL=$(getent group | awk -F: '{print $3}')
+			for WORD in $GIDS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					GIDS="$WORD $GIDS"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$GIDS" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$GIDS" -S ',' -- $realcur) )
 			return 0
 			;;
 		'--securebits')
diff --git a/bash-completion/swapon b/bash-completion/swapon
index f471e07..fc80af5 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -12,11 +12,17 @@ _swapon_module()
 			return 0
 			;;
 		'--show')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="NAME TYPE SIZE USED PRIO UUID LABEL"
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="NAME TYPE SIZE USED PRIO UUID LABEL"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-U')
diff --git a/bash-completion/taskset b/bash-completion/taskset
index dd1ef1f..8e62a3b 100644
--- a/bash-completion/taskset
+++ b/bash-completion/taskset
@@ -6,11 +6,17 @@ _taskset_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-c'|'--cpu-list')
-			local CPULIST
-			# FIXME: will propose only binding to a cpu.
-			# Maybe this should add comma, and continue?
-			CPULIST=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
-			COMPREPLY=( $(compgen -W "$(eval echo $CPULIST)" -- $cur) )
+			local prefix realcur CPULIST_ALL CPULIST
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			CPULIST_ALL=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
+			for WORD in $(eval echo $CPULIST_ALL); do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					CPULIST="$WORD $CPULIST"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$CPULIST" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-p'|'--pid')
diff --git a/bash-completion/wdctl b/bash-completion/wdctl
index 4f16e76..811b5e3 100644
--- a/bash-completion/wdctl
+++ b/bash-completion/wdctl
@@ -23,11 +23,17 @@ _wdctl_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="FLAG DESCRIPTION STATUS BOOT-STATUS DEVICE"
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="FLAG DESCRIPTION STATUS BOOT-STATUS DEVICE"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-s'|'--settimeout')
diff --git a/bash-completion/zramctl b/bash-completion/zramctl
index 90ed608..a4ef536 100644
--- a/bash-completion/zramctl
+++ b/bash-completion/zramctl
@@ -10,11 +10,17 @@ _zramctl_module()
 			return 0
 			;;
 		'-o'|'--output')
-			# FIXME: how to append to a string with compgen?
-			local OUTPUT
-			OUTPUT="NAME DISKSIZE DATA COMPR ALGORITHM STREAMS ZERO-PAGES TOTAL MOUNTPOINT"
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="NAME DISKSIZE DATA COMPR ALGORITHM STREAMS ZERO-PAGES TOTAL MOUNTPOINT"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD $OUTPUT"
+				fi
+			done
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
 			return 0
 			;;
 		'-s'|'--size')
-- 
2.1.4

