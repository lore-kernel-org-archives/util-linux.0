Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50927 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923Ab3DGIMM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Apr 2013 04:12:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id E9B9219BDCE
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id wTxo1zni0RHH for <util-linux@vger.kernel.org>;
	Sun,  7 Apr 2013 11:12:08 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id CB4605BC012
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:08 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] bash-completion: Don't offer any more completions after help or version.
Date: Sun,  7 Apr 2013 11:12:04 +0300
Message-Id: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 bash-completion/blkdiscard   |  3 +++
 bash-completion/blkid        |  3 +++
 bash-completion/cal          |  8 +++++++-
 bash-completion/cfdisk       |  3 +++
 bash-completion/chcpu        |  3 +++
 bash-completion/chfn         |  8 +++++++-
 bash-completion/chrt         |  8 +++++++-
 bash-completion/chsh         |  3 +++
 bash-completion/col          |  3 +++
 bash-completion/colcrt       |  8 +++++++-
 bash-completion/colrm        |  8 +++++++-
 bash-completion/column       |  3 +++
 bash-completion/ctrlaltdel   | 10 ++++++++--
 bash-completion/cytune       |  3 +++
 bash-completion/delpart      |  5 +++++
 bash-completion/dmesg        |  3 +++
 bash-completion/eject        |  3 +++
 bash-completion/fallocate    |  3 +++
 bash-completion/fdformat     |  8 +++++++-
 bash-completion/fdisk        |  3 +++
 bash-completion/findmnt      |  3 +++
 bash-completion/flock        |  3 +++
 bash-completion/fsck         |  3 +++
 bash-completion/fsck.cramfs  |  3 +++
 bash-completion/fsck.minix   |  8 +++++++-
 bash-completion/fsfreeze     |  8 +++++++-
 bash-completion/fstrim       |  3 +++
 bash-completion/getopt       |  3 +++
 bash-completion/hexdump      |  3 +++
 bash-completion/hwclock      |  3 +++
 bash-completion/ionice       |  3 +++
 bash-completion/ipcrm        |  3 +++
 bash-completion/ipcs         |  3 +++
 bash-completion/isosize      |  3 +++
 bash-completion/ldattach     |  3 +++
 bash-completion/logger       |  3 +++
 bash-completion/look         |  3 +++
 bash-completion/losetup      |  3 +++
 bash-completion/lsblk        |  3 +++
 bash-completion/lscpu        |  3 +++
 bash-completion/lslocks      |  4 +++-
 bash-completion/mcookie      |  3 +++
 bash-completion/mesg         |  8 +++++++-
 bash-completion/mkfs         |  3 +++
 bash-completion/mkfs.bfs     |  3 +++
 bash-completion/mkfs.cramfs  |  3 +++
 bash-completion/mkfs.minix   |  3 +++
 bash-completion/mkswap       |  2 +-
 bash-completion/more         |  8 +++++++-
 bash-completion/mountpoint   |  3 +++
 bash-completion/namei        |  6 ++++++
 bash-completion/newgrp       |  6 ++++++
 bash-completion/nsenter      |  3 +++
 bash-completion/partx        |  3 +++
 bash-completion/pg           |  3 +++
 bash-completion/pivot_root   |  8 +++++++-
 bash-completion/prlimit      |  3 +++
 bash-completion/raw          |  8 +++++++-
 bash-completion/readprofile  |  3 +++
 bash-completion/rename       |  6 ++++++
 bash-completion/renice       |  3 +++
 bash-completion/resizepart   |  6 ++++++
 bash-completion/rev          |  8 +++++++-
 bash-completion/rtcwake      |  3 +++
 bash-completion/script       |  3 +++
 bash-completion/scriptreplay |  3 +++
 bash-completion/setarch      |  8 +++++++-
 bash-completion/setpriv      |  3 +++
 bash-completion/setsid       |  8 +++++++-
 bash-completion/setterm      |  3 +++
 bash-completion/sfdisk       |  3 +++
 bash-completion/su           |  3 +++
 bash-completion/swaplabel    |  3 +++
 bash-completion/swapon       |  3 +++
 bash-completion/tailf        |  3 +++
 bash-completion/taskset      |  3 +++
 bash-completion/tunelp       |  3 +++
 bash-completion/ul           |  3 +++
 bash-completion/unshare      |  8 +++++++-
 bash-completion/utmpdump     |  6 ++++++
 bash-completion/uuidd        |  3 +++
 bash-completion/uuidgen      |  8 +++++++-
 bash-completion/wall         |  3 +++
 bash-completion/wdctl        |  3 +++
 bash-completion/whereis      |  3 +++
 bash-completion/wipefs       |  4 +++-
 bash-completion/write        |  8 +++++++-
 87 files changed, 353 insertions(+), 23 deletions(-)

diff --git a/bash-completion/blkdiscard b/bash-completion/blkdiscard
index 757480c..d19ab05 100644
--- a/bash-completion/blkdiscard
+++ b/bash-completion/blkdiscard
@@ -9,6 +9,9 @@ _blkdiscard_module()
 			COMPREPLY=( $(compgen -W "num" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/blkid b/bash-completion/blkid
index 14222a4..b439328 100644
--- a/bash-completion/blkid
+++ b/bash-completion/blkid
@@ -46,6 +46,9 @@ _blkid_module()
 			COMPREPLY=( $(compgen -W "$(awk '{print $NF}' /proc/filesystems)" -- $cur) )
 			return 0
 			;;
+		'-h'|'-V')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/cal b/bash-completion/cal
index d50c8bb..6c7c174 100644
--- a/bash-completion/cal
+++ b/bash-completion/cal
@@ -1,8 +1,14 @@
 _cal_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-1 --one -3 --three -s --sunday -m --monday -j --julian -y --year -V --version -h --help"
diff --git a/bash-completion/cfdisk b/bash-completion/cfdisk
index 4be5186..6cd9d6f 100644
--- a/bash-completion/cfdisk
+++ b/bash-completion/cfdisk
@@ -17,6 +17,9 @@ _cfdisk_module()
 			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
 			return 0
 			;;
+		'-v')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/chcpu b/bash-completion/chcpu
index 19386e2..d05b650 100644
--- a/bash-completion/chcpu
+++ b/bash-completion/chcpu
@@ -29,6 +29,9 @@ _chcpu_module()
 			COMPREPLY=( $(compgen -W "horizontal vertical" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-h --help
 		-e --enable
diff --git a/bash-completion/chfn b/bash-completion/chfn
index a8eaee5..01139e8 100644
--- a/bash-completion/chfn
+++ b/bash-completion/chfn
@@ -1,8 +1,14 @@
 _chfn_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-u'|'--help'|'-v'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-f --full-name -o --office -p --office-phone -h --home-phone -u --help -v --version"
diff --git a/bash-completion/chrt b/bash-completion/chrt
index b85775a..b2e5216 100644
--- a/bash-completion/chrt
+++ b/bash-completion/chrt
@@ -1,8 +1,14 @@
 _chrt_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	# FIXME: -p is ambiguous, it takes either pid or priority as an
 	# argument depending on whether user wanted to get or set the
 	# values.  Perhaps the command interface should be reconsidered.
diff --git a/bash-completion/chsh b/bash-completion/chsh
index c0a194c..5b191e9 100644
--- a/bash-completion/chsh
+++ b/bash-completion/chsh
@@ -9,6 +9,9 @@ _chsh_module()
 			COMPREPLY=( $(compgen -W "$(chsh -l)" -- $cur) )
 			return 0
 			;;
+		'-u'|'--help'|'-v'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/col b/bash-completion/col
index 9ad3a67..41cac72 100644
--- a/bash-completion/col
+++ b/bash-completion/col
@@ -9,6 +9,9 @@ _col_module()
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
 			return 0
 			;;
+		'-H'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-b --no-backspaces
 		-f --fine
diff --git a/bash-completion/colcrt b/bash-completion/colcrt
index 628416e..28093a8 100644
--- a/bash-completion/colcrt
+++ b/bash-completion/colcrt
@@ -1,8 +1,14 @@
 _colcrt_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="	-  --no-underlining
diff --git a/bash-completion/colrm b/bash-completion/colrm
index aa57c02..54706b3 100644
--- a/bash-completion/colrm
+++ b/bash-completion/colrm
@@ -1,8 +1,14 @@
 _colrm_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-V --version -h --help"
diff --git a/bash-completion/column b/bash-completion/column
index 94e1a51..23d923f 100644
--- a/bash-completion/column
+++ b/bash-completion/column
@@ -13,6 +13,9 @@ _column_module()
 			COMPREPLY=( $(compgen -W "string" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/ctrlaltdel b/bash-completion/ctrlaltdel
index e725752..bc8a943 100644
--- a/bash-completion/ctrlaltdel
+++ b/bash-completion/ctrlaltdel
@@ -1,8 +1,14 @@
 _ctrlaltdel_module()
 {
-	local cur
-	cur="${COMP_WORDS[COMP_CWORD]}"
+	local cur prev
 	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	if [ $COMP_CWORD -eq 1 ]; then
 		COMPREPLY=( $(compgen -W "hard soft" -- $cur) )
 	fi
diff --git a/bash-completion/cytune b/bash-completion/cytune
index 9a90d34..7ded86c 100644
--- a/bash-completion/cytune
+++ b/bash-completion/cytune
@@ -13,6 +13,9 @@ _cytune_module()
 			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/delpart b/bash-completion/delpart
index e3ee406..70543f0 100644
--- a/bash-completion/delpart
+++ b/bash-completion/delpart
@@ -4,6 +4,11 @@ _delpart_module()
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $COMP_CWORD in
 		1)
 			local DEV TYPE DEVICES=''
diff --git a/bash-completion/dmesg b/bash-completion/dmesg
index 18ee59f..f1189d2 100644
--- a/bash-completion/dmesg
+++ b/bash-completion/dmesg
@@ -22,6 +22,9 @@ _dmesg_module()
 			COMPREPLY=( $(compgen -W "size" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-C --clear
 		-c --read-clear
diff --git a/bash-completion/eject b/bash-completion/eject
index b767e81..8c2d62f 100644
--- a/bash-completion/eject
+++ b/bash-completion/eject
@@ -18,6 +18,9 @@ _eject_module()
 			COMPREPLY=( $(compgen -W "$(eject -X)" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/fallocate b/bash-completion/fallocate
index 132858c..f3431b7 100644
--- a/bash-completion/fallocate
+++ b/bash-completion/fallocate
@@ -9,6 +9,9 @@ _fallocate_module()
 			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/fdformat b/bash-completion/fdformat
index 4ad1c3d..376000a 100644
--- a/bash-completion/fdformat
+++ b/bash-completion/fdformat
@@ -1,8 +1,14 @@
 _fdformat_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	DEVS=$(for I in echo /dev/fd*; do if [ -e $I ]; then echo $I; fi; done)
 	OPTS="-n --no-verify -h --help -V --version $DEVS"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
diff --git a/bash-completion/fdisk b/bash-completion/fdisk
index ae94f10..b800f8d 100644
--- a/bash-completion/fdisk
+++ b/bash-completion/fdisk
@@ -29,6 +29,9 @@ _fdisk_module()
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
 			return 0
 			;;
+		'-h'|'-v')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index c2dfa21..cdc4861 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -77,6 +77,9 @@ _findmnt_module()
 			COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/flock b/bash-completion/flock
index cfa9b66..3f094e3 100644
--- a/bash-completion/flock
+++ b/bash-completion/flock
@@ -18,6 +18,9 @@ _flock_module()
 			COMPREPLY=( $(compgen -c -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/fsck b/bash-completion/fsck
index 40b9a13..04899a0 100644
--- a/bash-completion/fsck
+++ b/bash-completion/fsck
@@ -21,6 +21,9 @@ _fsck_module()
 			COMPREPLY=( $(compgen -W "bad_blocks_file" -- $cur) )
 			return 0
 			;;
+		'-?')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/fsck.cramfs b/bash-completion/fsck.cramfs
index 410b084..bfc18ed 100644
--- a/bash-completion/fsck.cramfs
+++ b/bash-completion/fsck.cramfs
@@ -11,6 +11,9 @@ _fsck.cramfs_module()
 			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/"}) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -S ' ' -- $cur) )
 	return 0
diff --git a/bash-completion/fsck.minix b/bash-completion/fsck.minix
index 6239ae4..e702199 100644
--- a/bash-completion/fsck.minix
+++ b/bash-completion/fsck.minix
@@ -1,8 +1,14 @@
 _fsck.minix_module()
 {
-	local cur OPTS DEVS
+	local cur prev OPTS DEVS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-V'|'--version')
+			return 0
+			;;
+	esac
 	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	OPTS="-l -a -r -v -s -m -f -V --version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]} $DEVS" -- $cur) )
diff --git a/bash-completion/fsfreeze b/bash-completion/fsfreeze
index 7933c15..ec29b1e 100644
--- a/bash-completion/fsfreeze
+++ b/bash-completion/fsfreeze
@@ -1,8 +1,14 @@
 _fsfreeze_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-f --freeze -u --unfreeze -h --help -V --version"
diff --git a/bash-completion/fstrim b/bash-completion/fstrim
index 6587d57..5427e72 100644
--- a/bash-completion/fstrim
+++ b/bash-completion/fstrim
@@ -9,6 +9,9 @@ _fstrim_module()
 			COMPREPLY=( $(compgen -W "num" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/getopt b/bash-completion/getopt
index ea8c8e2..d18d2a1 100644
--- a/bash-completion/getopt
+++ b/bash-completion/getopt
@@ -21,6 +21,9 @@ _getopt_module()
 			COMPREPLY=( $(compgen -W "sh bash csh tcsh" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/hexdump b/bash-completion/hexdump
index 1a6786b..0c91187 100644
--- a/bash-completion/hexdump
+++ b/bash-completion/hexdump
@@ -17,6 +17,9 @@ _hexdump_module()
 			COMPREPLY=( $(compgen -W "offset" -- $cur) )
 			return 0
 			;;
+		'-V')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/hwclock b/bash-completion/hwclock
index 855e885..b09e63d 100644
--- a/bash-completion/hwclock
+++ b/bash-completion/hwclock
@@ -18,6 +18,9 @@ _hwclock_module()
 			COMPREPLY=( $(compgen -W "year" -- $cur) )
 			return 0
 			;;
+		'-h'|'-?'|'--help'|'-v'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/ionice b/bash-completion/ionice
index 2180718..e7a8ac8 100644
--- a/bash-completion/ionice
+++ b/bash-completion/ionice
@@ -19,6 +19,9 @@ _ionice_module()
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/ipcrm b/bash-completion/ipcrm
index fd85091..6e2aff0 100644
--- a/bash-completion/ipcrm
+++ b/bash-completion/ipcrm
@@ -35,6 +35,9 @@ _ipcrm_module()
 			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		'=')
diff --git a/bash-completion/ipcs b/bash-completion/ipcs
index 51502bb..2cb7e61 100644
--- a/bash-completion/ipcs
+++ b/bash-completion/ipcs
@@ -9,6 +9,9 @@ _ipcs_module()
 			COMPREPLY=( $(compgen -W "id" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-i --id
 		-h --help
diff --git a/bash-completion/isosize b/bash-completion/isosize
index 2b4a499..487e40d 100644
--- a/bash-completion/isosize
+++ b/bash-completion/isosize
@@ -10,6 +10,9 @@ _isosize_module()
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
diff --git a/bash-completion/ldattach b/bash-completion/ldattach
index dc83dfc..a53329c 100644
--- a/bash-completion/ldattach
+++ b/bash-completion/ldattach
@@ -20,6 +20,9 @@ _ldattach_module()
 			COMPREPLY=( $(compgen -W "$IFLAGS" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/logger b/bash-completion/logger
index f572302..1f89e2d 100644
--- a/bash-completion/logger
+++ b/bash-completion/logger
@@ -30,6 +30,9 @@ _logger_module()
 			COMPREPLY=( $(compgen -W "$(awk '$NF ~ /^\// {print $NF}' /proc/net/unix)" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/look b/bash-completion/look
index 68cea56..daa5ecb 100644
--- a/bash-completion/look
+++ b/bash-completion/look
@@ -9,6 +9,9 @@ _look_module()
 			COMPREPLY=( $(compgen -W "char" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/losetup b/bash-completion/losetup
index 329bb05..4afcd3f 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -34,6 +34,9 @@ _losetup_module()
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 5498199..e1e4dd7 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -30,6 +30,9 @@ _lsblk_module()
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/lscpu b/bash-completion/lscpu
index 14926ec..5df0f9f 100644
--- a/bash-completion/lscpu
+++ b/bash-completion/lscpu
@@ -22,6 +22,9 @@ _lscpu_module()
 			COMPREPLY=( $(compgen -W "$OPTS" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/lslocks b/bash-completion/lslocks
index f55c17e..cde81b1 100644
--- a/bash-completion/lslocks
+++ b/bash-completion/lslocks
@@ -21,7 +21,9 @@ _lslocks_module()
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
 			;;
-
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/mcookie b/bash-completion/mcookie
index 1c01a55..ce5ee9c 100644
--- a/bash-completion/mcookie
+++ b/bash-completion/mcookie
@@ -10,6 +10,9 @@ _mcookie_module()
 			COMPREPLY=( $(compgen -f -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/mesg b/bash-completion/mesg
index 62c98ca..8513c02 100644
--- a/bash-completion/mesg
+++ b/bash-completion/mesg
@@ -1,8 +1,14 @@
 _mesg_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-v --verbose -V --version -h --help"
diff --git a/bash-completion/mkfs b/bash-completion/mkfs
index 1947119..48684fe 100644
--- a/bash-completion/mkfs
+++ b/bash-completion/mkfs
@@ -10,6 +10,9 @@ _mkfs_module()
 			COMPREPLY=( $(compgen -W "$FSTYPES" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/mkfs.bfs b/bash-completion/mkfs.bfs
index 7a47a76..44f15f3 100644
--- a/bash-completion/mkfs.bfs
+++ b/bash-completion/mkfs.bfs
@@ -13,6 +13,9 @@ _bfs_module()
 			COMPREPLY=( $(compgen -W "name" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/mkfs.cramfs b/bash-completion/mkfs.cramfs
index 65ee988..38ab3b6 100644
--- a/bash-completion/mkfs.cramfs
+++ b/bash-completion/mkfs.cramfs
@@ -25,6 +25,9 @@ _mkfs.cramfs_module()
 			COMPREPLY=( $(compgen -W "name" -- $cur) )
 			return 0
 			;;
+		'-h'|'-V')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/mkfs.minix b/bash-completion/mkfs.minix
index 085a058..78c986f 100644
--- a/bash-completion/mkfs.minix
+++ b/bash-completion/mkfs.minix
@@ -17,6 +17,9 @@ _mkfs.minix_module()
 			COMPREPLY=( $(compgen -W "14 30" -- $cur) )
 			return 0
 			;;
+		'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/mkswap b/bash-completion/mkswap
index 30d517c..32bc533 100644
--- a/bash-completion/mkswap
+++ b/bash-completion/mkswap
@@ -17,7 +17,7 @@ _mkswap_module()
 			COMPREPLY=( $(compgen -W "1" -- $cur) )
 			return 0
 			;;
-		'-U'|--uuid)
+		'-U'|'--uuid'|'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
 	esac
diff --git a/bash-completion/more b/bash-completion/more
index f32770d..945c7b3 100644
--- a/bash-completion/more
+++ b/bash-completion/more
@@ -1,8 +1,14 @@
 _more_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-V')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-d -f -l -p -c -u -s -number -V"
diff --git a/bash-completion/mountpoint b/bash-completion/mountpoint
index e2f1d56..308c4d6 100644
--- a/bash-completion/mountpoint
+++ b/bash-completion/mountpoint
@@ -9,6 +9,9 @@ _mountpoint_module()
 			COMPREPLY=( $(compgen -W "fixme" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/namei b/bash-completion/namei
index c44821c..561f45f 100644
--- a/bash-completion/namei
+++ b/bash-completion/namei
@@ -3,6 +3,12 @@ _namei_module()
 	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-h --help -V --version -x --mountpoints -m --modes -o --owners -l --long -n --nosymlinks -v --vertical"
diff --git a/bash-completion/newgrp b/bash-completion/newgrp
index 567c08c..3e080df 100644
--- a/bash-completion/newgrp
+++ b/bash-completion/newgrp
@@ -3,6 +3,12 @@ _newgrp_module()
 	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-V --version -h --help"
diff --git a/bash-completion/nsenter b/bash-completion/nsenter
index b8296b6..7950eab 100644
--- a/bash-completion/nsenter
+++ b/bash-completion/nsenter
@@ -11,6 +11,9 @@ _nsenter_module()
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		'=')
diff --git a/bash-completion/partx b/bash-completion/partx
index db2eded..b643dd8 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -20,6 +20,9 @@ _partx_module()
 			COMPREPLY=( $(compgen -W "aix bsd dos gpt mac minix sgi solaris_x86 sun ultrix unixware" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/pg b/bash-completion/pg
index 4ae8887..9b1bad9 100644
--- a/bash-completion/pg
+++ b/bash-completion/pg
@@ -9,6 +9,9 @@ _pg_module()
 			COMPREPLY=( $(compgen -W "prompt" -- $cur) )
 			return 0
 			;;
+		'-h'|'-V')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/pivot_root b/bash-completion/pivot_root
index 54f1734..961c883 100644
--- a/bash-completion/pivot_root
+++ b/bash-completion/pivot_root
@@ -1,8 +1,14 @@
 _pivot_root_module()
 {
-	local cur
+	local cur prev
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $COMP_CWORD in
 		1|2)
 			compopt -o filenames
diff --git a/bash-completion/prlimit b/bash-completion/prlimit
index bf5ff2f..3c1a1ac 100644
--- a/bash-completion/prlimit
+++ b/bash-completion/prlimit
@@ -18,6 +18,9 @@ _prlimit_module()
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		'=')
diff --git a/bash-completion/raw b/bash-completion/raw
index 27f0354..231f2cc 100644
--- a/bash-completion/raw
+++ b/bash-completion/raw
@@ -1,8 +1,14 @@
 _raw_module()
 {
-	local cur
+	local cur prev
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			local OPTS
diff --git a/bash-completion/readprofile b/bash-completion/readprofile
index c1eb514..41454a3 100644
--- a/bash-completion/readprofile
+++ b/bash-completion/readprofile
@@ -14,6 +14,9 @@ _readprofile_module()
 			COMPREPLY=( $(compgen -W "multiplier" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-m --mapfile
 		-p --profile
diff --git a/bash-completion/rename b/bash-completion/rename
index 0fe4cc6..b42d2d1 100644
--- a/bash-completion/rename
+++ b/bash-completion/rename
@@ -3,6 +3,12 @@ _rename_module()
 	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-v --verbose -s --symlink  -h --help -V --version"
diff --git a/bash-completion/renice b/bash-completion/renice
index aba00d7..deb9793 100644
--- a/bash-completion/renice
+++ b/bash-completion/renice
@@ -25,6 +25,9 @@ _renice_module()
 			COMPREPLY=( $(compgen -u -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-g --pgrp
 		-n --priority
diff --git a/bash-completion/resizepart b/bash-completion/resizepart
index b178b52..e55005a 100644
--- a/bash-completion/resizepart
+++ b/bash-completion/resizepart
@@ -3,6 +3,12 @@ _resizepart_module()
 	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $COMP_CWORD in
 		1)
 			local DEV TYPE DEVICES=''
diff --git a/bash-completion/rev b/bash-completion/rev
index f891f19..2ba5781 100644
--- a/bash-completion/rev
+++ b/bash-completion/rev
@@ -1,8 +1,14 @@
 _rev_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-V --version -h --help"
diff --git a/bash-completion/rtcwake b/bash-completion/rtcwake
index 1f38df8..e54d105 100644
--- a/bash-completion/rtcwake
+++ b/bash-completion/rtcwake
@@ -23,6 +23,9 @@ _rtcwake_module()
 			COMPREPLY=( $(compgen -W "time_t" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	OPTS="-d --device
 		-n --dry-run
diff --git a/bash-completion/script b/bash-completion/script
index 48f50c3..c02f1be 100644
--- a/bash-completion/script
+++ b/bash-completion/script
@@ -10,6 +10,9 @@ _script_module()
 			COMPREPLY=( $(compgen -c -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		'=')
diff --git a/bash-completion/scriptreplay b/bash-completion/scriptreplay
index 78e5b23..09b0d01 100644
--- a/bash-completion/scriptreplay
+++ b/bash-completion/scriptreplay
@@ -9,6 +9,9 @@ _scriptreplay_module()
 			COMPREPLY=( $(compgen -W "digit" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/setarch b/bash-completion/setarch
index b84d399..6224a11 100644
--- a/bash-completion/setarch
+++ b/bash-completion/setarch
@@ -1,8 +1,14 @@
 _setarch_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	if [ $COMP_CWORD -eq 1 ]; then
 		COMPREPLY=( $(compgen -W "linux32 linux64 ppc32 ppc ppc64
 					  ppc64pseries ppc64iseries i386
diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index b05affe..00f87af 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -50,6 +50,9 @@ _setpriv_module()
 			COMPREPLY=( $(compgen -W "profile" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/setsid b/bash-completion/setsid
index dcefc2f..a14ae42 100644
--- a/bash-completion/setsid
+++ b/bash-completion/setsid
@@ -1,8 +1,14 @@
 _setsid_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-c --ctty -h --help -V --version"
diff --git a/bash-completion/setterm b/bash-completion/setterm
index 33d2e56..ae07d1e 100644
--- a/bash-completion/setterm
+++ b/bash-completion/setterm
@@ -69,6 +69,9 @@ _setterm_module()
 			COMPREPLY=( $(compgen -W "freqnumber" -- $cur) )
 			return 0
 			;;
+		'-help'|'-version')
+			return 0
+			;;
 	esac
 	OPTS="	-term
 		-reset
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index 5498b0e..102fd85 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -18,6 +18,9 @@ _sfdisk_module()
 			COMPREPLY=( $(compgen -f -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-v'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		'=')
diff --git a/bash-completion/su b/bash-completion/su
index c72f6a1..dbd3d2f 100644
--- a/bash-completion/su
+++ b/bash-completion/su
@@ -17,6 +17,9 @@ _su_module()
 			COMPREPLY=( $(compgen -W "$(chsh -l)" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/swaplabel b/bash-completion/swaplabel
index c857d15..5909941 100644
--- a/bash-completion/swaplabel
+++ b/bash-completion/swaplabel
@@ -13,6 +13,9 @@ _swaplabel_module()
 			COMPREPLY=( $(compgen -W '$(uuidgen)' -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/swapon b/bash-completion/swapon
index 83e7e24..0e7c200 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -19,6 +19,9 @@ _swapon_module()
 			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/tailf b/bash-completion/tailf
index 29c5bed..32214d9 100644
--- a/bash-completion/tailf
+++ b/bash-completion/tailf
@@ -9,6 +9,9 @@ _tailf_module()
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/taskset b/bash-completion/taskset
index 5311316..c7d819b 100644
--- a/bash-completion/taskset
+++ b/bash-completion/taskset
@@ -23,6 +23,9 @@ _taskset_module()
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/tunelp b/bash-completion/tunelp
index 0f04842..e45cbec 100644
--- a/bash-completion/tunelp
+++ b/bash-completion/tunelp
@@ -21,6 +21,9 @@ _tunelp_module()
 			COMPREPLY=( $(compgen -W "off on" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/ul b/bash-completion/ul
index 07d0731..be3529d 100644
--- a/bash-completion/ul
+++ b/bash-completion/ul
@@ -14,6 +14,9 @@ _ul_module()
 			COMPREPLY=( $(compgen -W "$TERM_LIST" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/unshare b/bash-completion/unshare
index 295d02f..5342961 100644
--- a/bash-completion/unshare
+++ b/bash-completion/unshare
@@ -1,8 +1,14 @@
 _unshare_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-m --mount
diff --git a/bash-completion/utmpdump b/bash-completion/utmpdump
index e306ef8..bf18638 100644
--- a/bash-completion/utmpdump
+++ b/bash-completion/utmpdump
@@ -3,6 +3,12 @@ _utmpdump_module()
 	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-f --follow -r --reverse -V --version -h --help"
diff --git a/bash-completion/uuidd b/bash-completion/uuidd
index 23c1a49..c69a7c1 100644
--- a/bash-completion/uuidd
+++ b/bash-completion/uuidd
@@ -20,6 +20,9 @@ _uuidd_module()
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/uuidgen b/bash-completion/uuidgen
index d9edde9..2cf30a2 100644
--- a/bash-completion/uuidgen
+++ b/bash-completion/uuidgen
@@ -1,8 +1,14 @@
 _uuidgen_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $cur in
 		-*)
 			OPTS="-r --random -t --time -V --version -h --help"
diff --git a/bash-completion/wall b/bash-completion/wall
index d3cbbd5..4086ffe 100644
--- a/bash-completion/wall
+++ b/bash-completion/wall
@@ -9,6 +9,9 @@ _wall_module()
 			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/wdctl b/bash-completion/wdctl
index 42889ac..01d19a0 100644
--- a/bash-completion/wdctl
+++ b/bash-completion/wdctl
@@ -34,6 +34,9 @@ _wdctl_module()
 			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
 			return 0
 			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/whereis b/bash-completion/whereis
index 96e4117..2273a07 100644
--- a/bash-completion/whereis
+++ b/bash-completion/whereis
@@ -10,6 +10,9 @@ _whereis_module()
 			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/"}) )
 			return 0
 			;;
+		'-h'|'-V')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/wipefs b/bash-completion/wipefs
index db9426e..20dd40d 100644
--- a/bash-completion/wipefs
+++ b/bash-completion/wipefs
@@ -15,7 +15,9 @@ _wipefs_module()
 			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
 			return 0
 			;;
-
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
 	esac
 	case $cur in
 		-*)
diff --git a/bash-completion/write b/bash-completion/write
index d41159b..1fe0807 100644
--- a/bash-completion/write
+++ b/bash-completion/write
@@ -1,8 +1,14 @@
 _write_module()
 {
-	local cur
+	local cur prev
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
 	case $COMP_CWORD in
 		1)
 			COMPREPLY=( $(compgen -u -- $cur) )
-- 
1.7.11.7

