Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:56029 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931Ab3DGIMN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Apr 2013 04:12:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri5.pp.htv.fi (Postfix) with ESMTP id C646E5A6C79
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:10 +0300 (EEST)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
	with ESMTP id imi8YrLjmwRF for <util-linux@vger.kernel.org>;
	Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id 1B59E5BC018
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] bash-completion: Don't offer short options where corresponding long one exists.
Date: Sun,  7 Apr 2013 11:12:08 +0300
Message-Id: <1365322328-1607-5-git-send-email-ville.skytta@iki.fi>
In-Reply-To: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
References: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Users who know the short options can just hit the short option instead
of tab, and it's not likely that it would be helpful to present a list
of single character options to users who don't know them, doing so
just unnecessarily trashes the list of suggestions.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 bash-completion/addpart      |  2 +-
 bash-completion/blkdiscard   |  2 +-
 bash-completion/cal          |  2 +-
 bash-completion/chcpu        | 16 ++++++------
 bash-completion/chfn         |  2 +-
 bash-completion/chrt         | 24 +++++++++---------
 bash-completion/chsh         |  2 +-
 bash-completion/col          | 16 ++++++------
 bash-completion/colcrt       |  8 +++---
 bash-completion/colrm        |  2 +-
 bash-completion/column       | 14 +++++------
 bash-completion/cytune       | 20 +++++++--------
 bash-completion/delpart      |  2 +-
 bash-completion/dmesg        | 48 ++++++++++++++++++------------------
 bash-completion/eject        | 40 +++++++++++++++---------------
 bash-completion/fallocate    |  2 +-
 bash-completion/fdformat     |  2 +-
 bash-completion/findmnt      | 58 ++++++++++++++++++++++----------------------
 bash-completion/flock        | 20 +++++++--------
 bash-completion/fsck.cramfs  |  2 +-
 bash-completion/fsck.minix   |  2 +-
 bash-completion/fsfreeze     |  2 +-
 bash-completion/fstrim       |  2 +-
 bash-completion/getopt       |  2 +-
 bash-completion/hwclock      | 46 +++++++++++++++++------------------
 bash-completion/ionice       |  2 +-
 bash-completion/ipcrm        | 20 +++++++--------
 bash-completion/ipcs         | 28 ++++++++++-----------
 bash-completion/isosize      |  2 +-
 bash-completion/ldattach     | 24 +++++++++---------
 bash-completion/logger       |  2 +-
 bash-completion/look         |  2 +-
 bash-completion/losetup      | 32 ++++++++++++------------
 bash-completion/lsblk        | 40 +++++++++++++++---------------
 bash-completion/lscpu        | 18 +++++++-------
 bash-completion/lslocks      | 14 +++++------
 bash-completion/mcookie      |  2 +-
 bash-completion/mesg         |  2 +-
 bash-completion/mkfs         |  2 +-
 bash-completion/mkfs.bfs     |  2 +-
 bash-completion/mkswap       |  2 +-
 bash-completion/mountpoint   |  2 +-
 bash-completion/namei        |  2 +-
 bash-completion/newgrp       |  2 +-
 bash-completion/nsenter      | 24 +++++++++---------
 bash-completion/partx        |  2 +-
 bash-completion/prlimit      | 46 +++++++++++++++++------------------
 bash-completion/raw          |  2 +-
 bash-completion/readprofile  | 24 +++++++++---------
 bash-completion/rename       |  2 +-
 bash-completion/renice       | 12 ++++-----
 bash-completion/resizepart   |  2 +-
 bash-completion/rev          |  2 +-
 bash-completion/rtcwake      | 20 +++++++--------
 bash-completion/script       | 18 +++++++-------
 bash-completion/scriptreplay | 10 ++++----
 bash-completion/setarch      | 30 +++++++++++------------
 bash-completion/setpriv      |  8 +++---
 bash-completion/setsid       |  2 +-
 bash-completion/sfdisk       | 50 +++++++++++++++++++-------------------
 bash-completion/su           | 21 ++++++++--------
 bash-completion/swaplabel    |  2 +-
 bash-completion/swapon       | 26 ++++++++++----------
 bash-completion/tailf        |  2 +-
 bash-completion/taskset      |  2 +-
 bash-completion/tunelp       | 26 ++++++++++----------
 bash-completion/ul           |  2 +-
 bash-completion/unshare      | 16 ++++++------
 bash-completion/utmpdump     |  2 +-
 bash-completion/uuidd        |  2 +-
 bash-completion/uuidgen      |  2 +-
 bash-completion/wall         |  2 +-
 bash-completion/wdctl        | 24 +++++++++---------
 bash-completion/wipefs       |  2 +-
 74 files changed, 461 insertions(+), 462 deletions(-)

diff --git a/bash-completion/addpart b/bash-completion/addpart
index b6f119a..2b1e6bb 100644
--- a/bash-completion/addpart
+++ b/bash-completion/addpart
@@ -7,7 +7,7 @@ _addpart_module()
 		1)
 			local DEVS=''
 			while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-			OPTS="-h --help -V --version $DEVS"
+			OPTS="--help --version $DEVS"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
diff --git a/bash-completion/blkdiscard b/bash-completion/blkdiscard
index d19ab05..310cdfb 100644
--- a/bash-completion/blkdiscard
+++ b/bash-completion/blkdiscard
@@ -15,7 +15,7 @@ _blkdiscard_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-o --offset -l --length -s --secure -v --verbose -h --help -V --version"
+			OPTS="--offset --length --secure --verbose --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/cal b/bash-completion/cal
index 6c7c174..9a90a2a 100644
--- a/bash-completion/cal
+++ b/bash-completion/cal
@@ -11,7 +11,7 @@ _cal_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-1 --one -3 --three -s --sunday -m --monday -j --julian -y --year -V --version -h --help"
+			OPTS="--one --three --sunday --monday --julian --year --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/chcpu b/bash-completion/chcpu
index d05b650..da9c6ca 100644
--- a/bash-completion/chcpu
+++ b/bash-completion/chcpu
@@ -33,14 +33,14 @@ _chcpu_module()
 			return 0
 			;;
 	esac
-	OPTS="-h --help
-		-e --enable
-		-d --disable
-		-c --configure
-		-g --deconfigure
-		-p --dispatch
-		-r --rescan
-		-V --version"
+	OPTS="--help
+		--enable
+		--disable
+		--configure
+		--deconfigure
+		--dispatch
+		--rescan
+		--version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/chfn b/bash-completion/chfn
index 01139e8..1ca0f72 100644
--- a/bash-completion/chfn
+++ b/bash-completion/chfn
@@ -11,7 +11,7 @@ _chfn_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-f --full-name -o --office -p --office-phone -h --home-phone -u --help -v --version"
+			OPTS="--full-name --office --office-phone --home-phone --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/chrt b/bash-completion/chrt
index b2e5216..388d298 100644
--- a/bash-completion/chrt
+++ b/bash-completion/chrt
@@ -14,18 +14,18 @@ _chrt_module()
 	# values.  Perhaps the command interface should be reconsidered.
 	case $cur in
 		-*)
-			OPTS="-b --batch
-				-f --fifo
-				-i --idle
-				-o --other
-				-r --rr
-				-R --reset-on-fork
-				-a --all-tasks
-				-h --help
-				-m --max
-				-p --pid
-				-v --verbose
-				-V --version"
+			OPTS="--batch
+				--fifo
+				--idle
+				--other
+				--rr
+				--reset-on-fork
+				--all-tasks
+				--help
+				--max
+				--pid
+				--verbose
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/chsh b/bash-completion/chsh
index 5b191e9..7064194 100644
--- a/bash-completion/chsh
+++ b/bash-completion/chsh
@@ -15,7 +15,7 @@ _chsh_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-s --shell -l --list-shells -V --version -u --help"
+			OPTS="--shell --list-shells --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/col b/bash-completion/col
index 41cac72..cea57b5 100644
--- a/bash-completion/col
+++ b/bash-completion/col
@@ -13,14 +13,14 @@ _col_module()
 			return 0
 			;;
 	esac
-	OPTS="-b --no-backspaces
-		-f --fine
-		-p --pass
-		-h --tabs
-		-x --spaces
-		-l --lines
-		-V --version
-		-H --help"
+	OPTS="--no-backspaces
+		--fine
+		--pass
+		--tabs
+		--spaces
+		--lines
+		--version
+		--help"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/colcrt b/bash-completion/colcrt
index 28093a8..f9e4c33 100644
--- a/bash-completion/colcrt
+++ b/bash-completion/colcrt
@@ -11,10 +11,10 @@ _colcrt_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="	-  --no-underlining
-				-2 --half-lines
-				-V --version
-				-h --help"
+			OPTS="	--no-underlining
+				--half-lines
+				--version
+				--help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/colrm b/bash-completion/colrm
index 54706b3..622dbaa 100644
--- a/bash-completion/colrm
+++ b/bash-completion/colrm
@@ -11,7 +11,7 @@ _colrm_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-V --version -h --help"
+			OPTS="--version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/column b/bash-completion/column
index 23d923f..f5cb86b 100644
--- a/bash-completion/column
+++ b/bash-completion/column
@@ -19,13 +19,13 @@ _column_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-c --columns
-				-t --table
-				-s --separator
-				-o --output-separator
-				-x --fillrows
-				-h --help
-				-V --version"
+			OPTS="--columns
+				--table
+				--separator
+				--output-separator
+				--fillrows
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/cytune b/bash-completion/cytune
index 7ded86c..4f42838 100644
--- a/bash-completion/cytune
+++ b/bash-completion/cytune
@@ -19,16 +19,16 @@ _cytune_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-s --set-threshold
-				-g --get-threshold
-				-S --set-default-threshold
-				-t --set-flush
-				-G --get-glush
-				-T --set-default-flush
-				-q --stats
-				-i --interval
-				-h --help
-				-V --version"
+			OPTS="--set-threshold
+				--get-threshold
+				--set-default-threshold
+				--set-flush
+				--get-glush
+				--set-default-flush
+				--stats
+				--interval
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/delpart b/bash-completion/delpart
index 70543f0..a4b20c8 100644
--- a/bash-completion/delpart
+++ b/bash-completion/delpart
@@ -15,7 +15,7 @@ _delpart_module()
 			while read DEV TYPE; do
 				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
 			done < <(lsblk -pnro name,type)
-			OPTS="-h --help -V --version $DEVICES"
+			OPTS="--help --version $DEVICES"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
diff --git a/bash-completion/dmesg b/bash-completion/dmesg
index f1189d2..60ecc1a 100644
--- a/bash-completion/dmesg
+++ b/bash-completion/dmesg
@@ -26,30 +26,30 @@ _dmesg_module()
 			return 0
 			;;
 	esac
-	OPTS="-C --clear
-		-c --read-clear
-		-D --console-off
-		-d --show-delta
-		-e --reltime
-		-E --console-on
-		-F --file
-		-f --facility
-		-H --human
-		-k --kernel
-		-L --color
-		-l --level
-		-n --console-level
-		-P --nopager
-		-r --raw
-		-S --syslog
-		-s --buffer-size
-		-T --ctime
-		-t --notime
-		-u --userspace
-		-w --follow
-		-x --decode
-		-h --help
-		-V --version"
+	OPTS="--clear
+		--read-clear
+		--console-off
+		--show-delta
+		--reltime
+		--console-on
+		--file
+		--facility
+		--human
+		--kernel
+		--color
+		--level
+		--console-level
+		--nopager
+		--raw
+		--syslog
+		--buffer-size
+		--ctime
+		--notime
+		--userspace
+		--follow
+		--decode
+		--help
+		--version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/eject b/bash-completion/eject
index 8c2d62f..bb7187f 100644
--- a/bash-completion/eject
+++ b/bash-completion/eject
@@ -24,26 +24,26 @@ _eject_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --auto
-			-c --changerslot
-			-d --default
-			-f --floppy
-			-F --force
-			-i --manualeject
-			-m --no-unmount
-			-M --no-partitions-unmount
-			-n --noop
-			-p --proc
-			-q --tape
-			-r --cdrom
-			-s --scsi
-			-t --trayclose
-			-T --traytoggle
-			-v --verbose
-			-x --cdspeed
-			-X --listspeed
-			-h --help
-			-V --version"
+			OPTS="--auto
+				--changerslot
+				--default
+				--floppy
+				--force
+				--manualeject
+				--no-unmount
+				--no-partitions-unmount
+				--noop
+				--proc
+				--tape
+				--cdrom
+				--scsi
+				--trayclose
+				--traytoggle
+				--verbose
+				--cdspeed
+				--listspeed
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/fallocate b/bash-completion/fallocate
index f3431b7..5007b60 100644
--- a/bash-completion/fallocate
+++ b/bash-completion/fallocate
@@ -15,7 +15,7 @@ _fallocate_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-n --keep-size -p --punch-hole -o --offset -l --length -h --help -V --version"
+			OPTS="--keep-size --punch-hole --offset --length --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/fdformat b/bash-completion/fdformat
index 376000a..d1b18fa 100644
--- a/bash-completion/fdformat
+++ b/bash-completion/fdformat
@@ -10,7 +10,7 @@ _fdformat_module()
 			;;
 	esac
 	DEVS=$(for I in echo /dev/fd*; do if [ -e $I ]; then echo $I; fi; done)
-	OPTS="-n --no-verify -h --help -V --version $DEVS"
+	OPTS="--no-verify --help --version $DEVS"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/findmnt b/bash-completion/findmnt
index a6d526f..9386d8f 100644
--- a/bash-completion/findmnt
+++ b/bash-completion/findmnt
@@ -83,35 +83,35 @@ _findmnt_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-s --fstab
-				-m --mtab
-				-k --kernel
-				-p --poll
-				-w --timeout
-				-A --all
-				-a --ascii
-				-c --canonicalize
-				-D --df
-				-d --direction
-				-e --evaluate
-				-F --tab-file
-				-f --first-only
-				-i --invert
-				-l --list
-				-N --task
-				-n --noheadings
-				-u --notruncate
-				-O --options
-				-o --output
-				-P --pairs
-				-r --raw
-				-t --types
-				-v --nofsroot
-				-R --submounts
-				-S --source
-				-T --target
-				-h --help
-				-V --version"
+			OPTS="--fstab
+				--mtab
+				--kernel
+				--poll
+				--timeout
+				--all
+				--ascii
+				--canonicalize
+				--df
+				--direction
+				--evaluate
+				--tab-file
+				--first-only
+				--invert
+				--list
+				--task
+				--noheadings
+				--notruncate
+				--options
+				--output
+				--pairs
+				--raw
+				--types
+				--nofsroot
+				--submounts
+				--source
+				--target
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/flock b/bash-completion/flock
index 918a7d8..8cd60d3 100644
--- a/bash-completion/flock
+++ b/bash-completion/flock
@@ -24,16 +24,16 @@ _flock_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-s --shared
-				-x --exclusive
-				-u --unlock
-				-n --nonblock
-				-w --timeout
-				-E --conflict-exit-code
-				-o --close
-				-c --command
-				-h --help
-				-V --version"
+			OPTS="--shared
+				--exclusive
+				--unlock
+				--nonblock
+				--timeout
+				--conflict-exit-code
+				--close
+				--command
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/fsck.cramfs b/bash-completion/fsck.cramfs
index bfc18ed..84f6f31 100644
--- a/bash-completion/fsck.cramfs
+++ b/bash-completion/fsck.cramfs
@@ -4,7 +4,6 @@ _fsck.cramfs_module()
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	OPTS='-v --verbose -x --destination -h --help -V --version file'
 	case $prev in
 		'-x'|'--destination')
 			compopt -o filenames
@@ -15,6 +14,7 @@ _fsck.cramfs_module()
 			return 0
 			;;
 	esac
+	OPTS='--verbose --destination --help --version file'
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -S ' ' -- $cur) )
 	return 0
 }
diff --git a/bash-completion/fsck.minix b/bash-completion/fsck.minix
index e702199..1ec9a78 100644
--- a/bash-completion/fsck.minix
+++ b/bash-completion/fsck.minix
@@ -10,7 +10,7 @@ _fsck.minix_module()
 			;;
 	esac
 	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
-	OPTS="-l -a -r -v -s -m -f -V --version"
+	OPTS="-l -a -r -v -s -m -f --version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]} $DEVS" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/fsfreeze b/bash-completion/fsfreeze
index ec29b1e..05bd68e 100644
--- a/bash-completion/fsfreeze
+++ b/bash-completion/fsfreeze
@@ -11,7 +11,7 @@ _fsfreeze_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-f --freeze -u --unfreeze -h --help -V --version"
+			OPTS="--freeze --unfreeze --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/fstrim b/bash-completion/fstrim
index 5427e72..9984eb6 100644
--- a/bash-completion/fstrim
+++ b/bash-completion/fstrim
@@ -15,7 +15,7 @@ _fstrim_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-o --offset -l --length -m --minimum -v --verbose -h --help -V --version"
+			OPTS="--offset --length --minimum --verbose --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/getopt b/bash-completion/getopt
index d18d2a1..5e3fca6 100644
--- a/bash-completion/getopt
+++ b/bash-completion/getopt
@@ -27,7 +27,7 @@ _getopt_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --alternative -h --help -l --longoptions -n --name -o --options -q --quiet -Q --quiet-output -s --shell -T --test -u --unquote -V --version"
+			OPTS="--alternative --help --longoptions --name --options --quiet --quiet-output --shell --test --unquoted --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/hwclock b/bash-completion/hwclock
index b09e63d..0c4ebaf 100644
--- a/bash-completion/hwclock
+++ b/bash-completion/hwclock
@@ -24,29 +24,29 @@ _hwclock_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-h --help
-				-r --show
-				   --set
-				-s --hctosys
-				-w --systohc
-				   --systz
-				   --adjust
-				-c --compare
-				   --getepoch
-				   --setepoch
-				   --predict
-				-V --version
-				-u --utc
-				   --localtime
-				-f --rtc
-				   --directisa
-				   --badyear
-				   --date
-				   --epoch
-				   --noadjfile
-				   --adjfile
-				   --test
-				-D --debug"
+			OPTS="--help
+				--show
+				--set
+				--hctosys
+				--systohc
+				--systz
+				--adjust
+				--compare
+				--getepoch
+				--setepoch
+				--predict
+				--version
+				--utc
+				--localtime
+				--rtc
+				--directisa
+				--badyear
+				--date
+				--epoch
+				--noadjfile
+				--adjfile
+				--test
+				--debug"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/ionice b/bash-completion/ionice
index 4d55968..3a01c51 100644
--- a/bash-completion/ionice
+++ b/bash-completion/ionice
@@ -25,7 +25,7 @@ _ionice_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-c --class -n --classdata -p --pid -t --ignore -V --version -h --help"
+			OPTS="--class --classdata --pid --ignore --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/ipcrm b/bash-completion/ipcrm
index 6e2aff0..1ed03f9 100644
--- a/bash-completion/ipcrm
+++ b/bash-completion/ipcrm
@@ -46,16 +46,16 @@ _ipcrm_module()
 			return 0
 			;;
 	esac
-	OPTS="	-m --shmem-id
-		-M --shmem-key
-		-q --queue-id
-		-Q --queue-key
-		-s --semaphore-id
-		-S --semaphore-key
-		-a= --all=
-		-v --verbose
-		-h --help
-		-V --version"
+	OPTS="	--shmem-id
+		--shmem-key
+		--queue-id
+		--queue-key
+		--semaphore-id
+		--semaphore-key
+		--all=
+		--verbose
+		--help
+		--version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/ipcs b/bash-completion/ipcs
index 2cb7e61..ce93e4d 100644
--- a/bash-completion/ipcs
+++ b/bash-completion/ipcs
@@ -13,20 +13,20 @@ _ipcs_module()
 			return 0
 			;;
 	esac
-	OPTS="-i --id
-		-h --help
-		-V --version
-		-m --shmems
-		-q --queues
-		-s --semaphores
-		-a --all
-		-t --time
-		-p --pid
-		-c --creator
-		-l --limits
-		-u --summary
-		   --human
-		-b --bytes"
+	OPTS="--id
+		--help
+		--version
+		--shmems
+		--queues
+		--semaphores
+		--all
+		--time
+		--pid
+		--creator
+		--limits
+		--summary
+		--human
+		--bytes"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/isosize b/bash-completion/isosize
index 487e40d..13d4d29 100644
--- a/bash-completion/isosize
+++ b/bash-completion/isosize
@@ -4,7 +4,6 @@ _isosize_module()
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	OPTS='-d --divisor -x --sectors -h --help -V --version'
 	case $prev in
 		'-d'|'--divisor')
 			COMPREPLY=( $(compgen -W "number" -- $cur) )
@@ -14,6 +13,7 @@ _isosize_module()
 			return 0
 			;;
 	esac
+	OPTS='--divisor --sectors --help --version'
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/ldattach b/bash-completion/ldattach
index a53329c..830142d 100644
--- a/bash-completion/ldattach
+++ b/bash-completion/ldattach
@@ -26,18 +26,18 @@ _ldattach_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-d --debug
-				-s --speed
-				-7 --sevenbits
-				-8 --eightbits
-				-n --noparity
-				-e --evenparity
-				-o --oddparity
-				-1 --onestopbit
-				-2 --twostopbits
-				-i --iflag
-				-h --help
-				-V --version"
+			OPTS="--debug
+				--speed
+				--sevenbits
+				--eightbits
+				--noparity
+				--evenparity
+				--oddparity
+				--onestopbit
+				--twostopbits
+				--iflag
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/logger b/bash-completion/logger
index 7a2b460..f46be8a 100644
--- a/bash-completion/logger
+++ b/bash-completion/logger
@@ -36,7 +36,7 @@ _logger_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-d --udp -i --id -f --file -h --help -n --server -P --port -p --priority -s --stderr -t --tag -u --socket -V --version"
+			OPTS="--udp --id --file --help --server --port --priority --stderr --tag --socket --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/look b/bash-completion/look
index daa5ecb..e8676ba 100644
--- a/bash-completion/look
+++ b/bash-completion/look
@@ -15,7 +15,7 @@ _look_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --alternative -d --alphanum -f --ignore-case -t --terminate -V --version -h --help"
+			OPTS="--alternative --alphanum --ignore-case --terminate --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/losetup b/bash-completion/losetup
index 4afcd3f..75240b8 100644
--- a/bash-completion/losetup
+++ b/bash-completion/losetup
@@ -40,22 +40,22 @@ _losetup_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --all
-				-d --detach
-				-D --detach-all
-				-f --find
-				-c --set-capacity
-				-j --associated
-				-l --list
-				-o --offset
-				-O --output
-				   --sizelimit
-				-P --partscan
-				-r --read-only
-				   --show
-				-v --verbose
-				-h --help
-				-V --version"
+			OPTS="--all
+				--detach
+				--detach-all
+				--find
+				--set-capacity
+				--associated
+				--list
+				--offset
+				--output
+				--sizelimit
+				--partscan
+				--read-only
+				--show
+				--verbose
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index e1e4dd7..07e9368 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -36,26 +36,26 @@ _lsblk_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --all
-				-b --bytes
-				-d --nodeps
-				-D --discard
-				-e --exclude
-				-I --include
-				-f --fs
-				-h --help
-				-i --ascii
-				-m --perms
-				-l --list
-				-n --noheadings
-				-o --output
-				-P --pairs
-				-r --raw
-				-s --inverse
-				-t --topology
-				-S --scsi
-				-h --help
-				-V --version"
+			OPTS="--all
+				--bytes
+				--nodeps
+				--discard
+				--exclude
+				--fs
+				--help
+				--include
+				--ascii
+				--list
+				--perms
+				--noheadings
+				--output
+				--pairs
+				--raw
+				--inverse
+				--topology
+				--scsi
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/lscpu b/bash-completion/lscpu
index 5df0f9f..bce07c4 100644
--- a/bash-completion/lscpu
+++ b/bash-completion/lscpu
@@ -28,15 +28,15 @@ _lscpu_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --all
-				-b --online
-				-c --offline
-				-e= --extended=
-				-p= --parse=
-				-s --sysroot
-				-x --hex
-				-h --help
-				-V --version"
+			OPTS="--all
+				--online
+				--offline
+				--extended=
+				--parse=
+				--sysroot
+				--hex
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/lslocks b/bash-completion/lslocks
index cde81b1..337d07e 100644
--- a/bash-completion/lslocks
+++ b/bash-completion/lslocks
@@ -27,13 +27,13 @@ _lslocks_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-p --pid
-				-o --output
-				-n --noheadings
-				-r --raw
-				-u --notruncate
-				-h --help
-				-V --version"
+			OPTS="--pid
+				--output
+				--noheadings
+				--raw
+				--notruncate
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mcookie b/bash-completion/mcookie
index ce5ee9c..eb3f54b 100644
--- a/bash-completion/mcookie
+++ b/bash-completion/mcookie
@@ -16,7 +16,7 @@ _mcookie_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-f --file -v --verbose -V --version -h --help"
+			OPTS="--file --verbose --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mesg b/bash-completion/mesg
index 8513c02..1f80bab 100644
--- a/bash-completion/mesg
+++ b/bash-completion/mesg
@@ -11,7 +11,7 @@ _mesg_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-v --verbose -V --version -h --help"
+			OPTS="--verbose --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mkfs b/bash-completion/mkfs
index 48684fe..4e6e175 100644
--- a/bash-completion/mkfs
+++ b/bash-completion/mkfs
@@ -16,7 +16,7 @@ _mkfs_module()
 	esac
 	case $cur in
 		-*)
-			OPTS='-t --type --verbose -h --help -V --version'
+			OPTS='--type --verbose --help --version'
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mkfs.bfs b/bash-completion/mkfs.bfs
index 44f15f3..8adbc60 100644
--- a/bash-completion/mkfs.bfs
+++ b/bash-completion/mkfs.bfs
@@ -19,7 +19,7 @@ _bfs_module()
 	esac
 	case $cur in
 		-*)
-			OPTS='-N --inodes --vname --fname -v --verbose -h --help -V --version'
+			OPTS='--inodes --vname --fname --verbose --help --version'
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mkswap b/bash-completion/mkswap
index 32bc533..c411b30 100644
--- a/bash-completion/mkswap
+++ b/bash-completion/mkswap
@@ -23,7 +23,7 @@ _mkswap_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-c --check -f --force -p --pagesize -L  --label -v --swapversion -U --uuid -V --version -h --help"
+			OPTS="--check --force --pagesize --label --swapversion --uuid --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/mountpoint b/bash-completion/mountpoint
index 308c4d6..8fe27b8 100644
--- a/bash-completion/mountpoint
+++ b/bash-completion/mountpoint
@@ -15,7 +15,7 @@ _mountpoint_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-q --quiet -d --fs-devno -x --devno -h --help -V --version"
+			OPTS="--quiet --fs-devno --devno --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/namei b/bash-completion/namei
index 561f45f..63fb37a 100644
--- a/bash-completion/namei
+++ b/bash-completion/namei
@@ -11,7 +11,7 @@ _namei_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-h --help -V --version -x --mountpoints -m --modes -o --owners -l --long -n --nosymlinks -v --vertical"
+			OPTS="--help --version --mountpoints --modes --owners --long --nosymlinks --vertical"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/newgrp b/bash-completion/newgrp
index 3e080df..1e39c0f 100644
--- a/bash-completion/newgrp
+++ b/bash-completion/newgrp
@@ -11,7 +11,7 @@ _newgrp_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-V --version -h --help"
+			OPTS="--version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/nsenter b/bash-completion/nsenter
index 7950eab..2970b8d 100644
--- a/bash-completion/nsenter
+++ b/bash-completion/nsenter
@@ -24,18 +24,18 @@ _nsenter_module()
 			cur=${cur#=}
 			;;
 		-*)
-			OPTS="-t --target
-				-m= --mount=
-				-u= --uts=
-				-i= --ipc=
-				-n= --net=
-				-p= --pid=
-				-U= --user=
-				-r= --root=
-				-w= --wd=
-				-F --no-fork
-				-h --help
-				-V --version"
+			OPTS="--target
+				--mount=
+				--uts=
+				--ipc=
+				--net=
+				--pid=
+				--user=
+				--root=
+				--wd=
+				--no-fork
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/partx b/bash-completion/partx
index b643dd8..7b08fa8 100644
--- a/bash-completion/partx
+++ b/bash-completion/partx
@@ -26,7 +26,7 @@ _partx_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --add -d --delete -s --show -u --update -b --bytes -g --noheadings -n --nr -o --output -P --pairs -r --raw -t --type -v --verbose -h --help -V --version"
+			OPTS="--add --delete --show --update --bytes --noheadings --nr --output --pairs --raw --type --verbose --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/prlimit b/bash-completion/prlimit
index 3c1a1ac..c680214 100644
--- a/bash-completion/prlimit
+++ b/bash-completion/prlimit
@@ -29,29 +29,29 @@ _prlimit_module()
 			# as limit value(s)
 			;;
 		-*)
-			OPTS="-p --pid
-				-o --output
-				   --noheadings
-				   --raw
-				   --verbose
-				-h --help
-				-V --version
-				-c= --core=
-				-d= --data=
-				-e= --nice=
-				-f= --fsize=
-				-i= --sigpending=
-				-l= --memlock=
-				-m= --rss=
-				-n= --nofile=
-				-q= --msgqueue=
-				-r= --rtprio=
-				-s= --stack=
-				-t= --cpu=
-				-u= --nproc=
-				-v= --as=
-				-x= --locks=
-				-y --rttime"
+			OPTS="--pid
+				--output
+				--noheadings
+				--raw
+				--verbose
+				--help
+				--version
+				--core=
+				--data=
+				--nice=
+				--fsize=
+				--sigpending=
+				--memlock=
+				--rss=
+				--nofile=
+				--msgqueue=
+				--rtprio=
+				--stack=
+				--cpu=
+				--nproc=
+				--as=
+				--locks=
+				--rttime="
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/raw b/bash-completion/raw
index 231f2cc..20c3261 100644
--- a/bash-completion/raw
+++ b/bash-completion/raw
@@ -12,7 +12,7 @@ _raw_module()
 	case $cur in
 		-*)
 			local OPTS
-			OPTS="-q --query -a --all -h --help -V --version"
+			OPTS="--query --all --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/readprofile b/bash-completion/readprofile
index 41454a3..a5f45f5 100644
--- a/bash-completion/readprofile
+++ b/bash-completion/readprofile
@@ -18,18 +18,18 @@ _readprofile_module()
 			return 0
 			;;
 	esac
-	OPTS="-m --mapfile
-		-p --profile
-		-M --multiplier
-		-i --info
-		-v --verbose
-		-a --all
-		-b --histbin
-		-s --counters
-		-r --reset
-		-n --no-auto
-		-h --help
-		-V --version"
+	OPTS="--mapfile
+		--profile
+		--multiplier
+		--info
+		--verbose
+		--all
+		--histbin
+		--counters
+		--reset
+		--no-auto
+		--help
+		--version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/rename b/bash-completion/rename
index b42d2d1..3842c4d 100644
--- a/bash-completion/rename
+++ b/bash-completion/rename
@@ -11,7 +11,7 @@ _rename_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-v --verbose -s --symlink  -h --help -V --version"
+			OPTS="--verbose --symlink --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/renice b/bash-completion/renice
index 9693590..c3e9331 100644
--- a/bash-completion/renice
+++ b/bash-completion/renice
@@ -29,12 +29,12 @@ _renice_module()
 			return 0
 			;;
 	esac
-	OPTS="-g --pgrp
-		-n --priority
-		-p --pid
-		-u --user
-		-h --help
-		-V --version"
+	OPTS="--pgrp
+		--priority
+		--pid
+		--user
+		--help
+		--version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/resizepart b/bash-completion/resizepart
index e55005a..c78af15 100644
--- a/bash-completion/resizepart
+++ b/bash-completion/resizepart
@@ -15,7 +15,7 @@ _resizepart_module()
 			while read DEV TYPE; do
 				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
 			done < <(lsblk -pnro name,type)
-			OPTS="-h --help -V --version $DEVICES"
+			OPTS="--help --version $DEVICES"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
diff --git a/bash-completion/rev b/bash-completion/rev
index 2ba5781..619c5c4 100644
--- a/bash-completion/rev
+++ b/bash-completion/rev
@@ -11,7 +11,7 @@ _rev_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-V --version -h --help"
+			OPTS="--version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/rtcwake b/bash-completion/rtcwake
index e54d105..d7d1427 100644
--- a/bash-completion/rtcwake
+++ b/bash-completion/rtcwake
@@ -27,16 +27,16 @@ _rtcwake_module()
 			return 0
 			;;
 	esac
-	OPTS="-d --device
-		-n --dry-run
-		-l --local
-		-m --mode
-		-s --seconds
-		-t --time
-		-u --utc
-		-v --verbose
-		-h --help
-		-V --version"
+	OPTS="--device
+		--dry-run
+		--local
+		--mode
+		--seconds
+		--time
+		--utc
+		--verbose
+		--help
+		--version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/script b/bash-completion/script
index c02f1be..329fc48 100644
--- a/bash-completion/script
+++ b/bash-completion/script
@@ -19,15 +19,15 @@ _script_module()
 			cur=${cur#=}
 			;;
 		-*)
-			OPTS="-a --append
-				-c --command
-				-e --return
-				-f --flush
-				   --force
-				-q --quiet
-				-t= --timing=
-				-V --version
-				-h --help"
+			OPTS="--append
+				--command
+				--return
+				--flush
+				--force
+				--quiet
+				--timing=
+				--version
+				--help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/scriptreplay b/bash-completion/scriptreplay
index 09b0d01..2ad7b11 100644
--- a/bash-completion/scriptreplay
+++ b/bash-completion/scriptreplay
@@ -15,11 +15,11 @@ _scriptreplay_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-t --timing
-				-s --typescript
-				-d --divisor
-				-V --version
-				-h --help"
+			OPTS="--timing
+				--typescript
+				--divisor
+				--version
+				--help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/setarch b/bash-completion/setarch
index 6224a11..80aabd5 100644
--- a/bash-completion/setarch
+++ b/bash-completion/setarch
@@ -22,21 +22,21 @@ _setarch_module()
 	fi
 	case $cur in
 		-*)
-			OPTS="-v, --verbose
-				-R, --addr-no-randomize
-				-F, --fdpic-funcptrs
-				-Z, --mmap-page-zero
-				-L, --addr-compat-layout
-				-X, --read-implies-exec
-				-B, --32bit
-				-I, --short-inode
-				-S, --whole-seconds
-				-T, --sticky-timeouts
-				-3, --3gb
-				    --4gb
-				    --uname-2.6
-				-h, --help
-				-V, --version"
+			OPTS="--verbose
+				--addr-no-randomize
+				--fdpic-funcptrs
+				--mmap-page-zero
+				--addr-compat-layout
+				--read-implies-exec
+				--32bit
+				--short-inode
+				--whole-seconds
+				--sticky-timeouts
+				--3gb
+				--4gb
+				--uname-2.6
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index 00f87af..3be5ccd 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -56,8 +56,8 @@ _setpriv_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-d --dump
-				--nnp --no-new-privs
+			OPTS="--dump
+				--no-new-privs
 				--inh-caps
 				--bounding-set
 				--ruid
@@ -72,8 +72,8 @@ _setpriv_module()
 				--securebits
 				--selinux-label
 				--apparmor-profile
-				-h --help
-				-V --version"
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/setsid b/bash-completion/setsid
index a14ae42..568159b 100644
--- a/bash-completion/setsid
+++ b/bash-completion/setsid
@@ -11,7 +11,7 @@ _setsid_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-c --ctty -h --help -V --version"
+			OPTS="--ctty --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index 102fd85..0226b04 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -27,35 +27,35 @@ _sfdisk_module()
 			cur=${cur#=}
 			;;
 		-*)
-			OPTS="-s --show-size
-				-c --id
+			OPTS="--show-size
+				--id
 				--change-id
 				--print-id
-				-l --list
-				-d --dump
-				-i --increment
-				-u --unit
-				-1 --one-only
-				-T --list-types
-				-D --DOS
-				-E --DOS-extended
-				-R --re-read
+				--list
+				--dump
+				--increment
+				--unit
+				--one-only
+				--list-types
+				--DOS
+				--DOS-extended
+				--re-read
 				-N
 				-n
 				-O
 				-I
-				-V --verify
-				-v --version
-				-h --help
-				-f --force
+				--verify
+				--version
+				--help
+				--force
 				--no-reread
-				-q --quiet
-				-L --Linux
-				-g --show-geometry
-				-G --show-pt-geometry
-				-A= --activate=
-				-U= --unhide=
-				-x --show-extended
+				--quiet
+				--Linux
+				--show-geometry
+				--show-pt-geometry
+				--activate=
+				--unhide=
+				--show-extended
 				--leave-last
 				--IBM
 				--in-order
@@ -65,9 +65,9 @@ _sfdisk_module()
 				--nested
 				--chained
 				--onesector
-				-C --cylinders
-				-H --heads
-				-S --sectors"
+				--cylinders
+				--heads
+				--sectors"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/su b/bash-completion/su
index dbd3d2f..e739b56 100644
--- a/bash-completion/su
+++ b/bash-completion/su
@@ -23,18 +23,17 @@ _su_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="	-
-				-u --user
-				-m -p --preserve-environment
-				-g --group
-				-G --supp-group
-				-l --login
-				-c --command
+			OPTS="	--user
+				--preserve-environment
+				--group
+				--supp-group
+				--login
+				--command
 				--session-command
-				-f --fast
-				-s --shell
-				-h --help
-				-V --version"
+				--fast
+				--shell
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/swaplabel b/bash-completion/swaplabel
index 5909941..093169e 100644
--- a/bash-completion/swaplabel
+++ b/bash-completion/swaplabel
@@ -19,7 +19,7 @@ _swaplabel_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-L --label -U --uuid -h --help -V --version"
+			OPTS="--label --uuid --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/swapon b/bash-completion/swapon
index 6e05b6e..e127153 100644
--- a/bash-completion/swapon
+++ b/bash-completion/swapon
@@ -25,19 +25,19 @@ _swapon_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --all
-				-d --discard
-				-e --ifexists
-				-f --fixpgsz
-				-p --priority
-				-s --summary
-				   --show
-				   --noheadings
-				   --raw
-				   --bytes
-				-v --verbose
-				-h --help
-				-V --version"
+			OPTS="--all
+				--discard
+				--ifexists
+				--fixpgsz
+				--priority
+				--summary
+				--show
+				--noheadings
+				--raw
+				--bytes
+				--verbose
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/tailf b/bash-completion/tailf
index 32214d9..e3dd295 100644
--- a/bash-completion/tailf
+++ b/bash-completion/tailf
@@ -15,7 +15,7 @@ _tailf_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-n --lines -number -V --version -h --help"
+			OPTS="--lines --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/taskset b/bash-completion/taskset
index c7d819b..dd1ef1f 100644
--- a/bash-completion/taskset
+++ b/bash-completion/taskset
@@ -29,7 +29,7 @@ _taskset_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --all-tasks -p --pid -c --cpu-list -h --help -V --version"
+			OPTS="--all-tasks --pid --cpu-list --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/tunelp b/bash-completion/tunelp
index e45cbec..614b235 100644
--- a/bash-completion/tunelp
+++ b/bash-completion/tunelp
@@ -27,19 +27,19 @@ _tunelp_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-i --irq
-				-t --time
-				-c --chars
-				-w --wait
-				-a --abort
-				-o --check-status
-				-C --careful
-				-s --status
-				-T --trust-irq
-				-r --reset
-				-q --print-irq
-				-h --help
-				-V --version"
+			OPTS="--irq
+				--time
+				--chars
+				--wait
+				--abort
+				--check-status
+				--careful
+				--status
+				--trust-irq
+				--reset
+				--print-irq
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/ul b/bash-completion/ul
index be3529d..c00e510 100644
--- a/bash-completion/ul
+++ b/bash-completion/ul
@@ -20,7 +20,7 @@ _ul_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-t --terminal -i --indicated -V --version -h --help"
+			OPTS="--terminal --indicated --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/unshare b/bash-completion/unshare
index 5342961..86a4af4 100644
--- a/bash-completion/unshare
+++ b/bash-completion/unshare
@@ -11,14 +11,14 @@ _unshare_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-m --mount
-				-u --uts
-				-i --ipc
-				-n --net
-				-p --pid
-				-U --user
-				-h --help
-				-V --version"
+			OPTS="--mount
+				--uts
+				--ipc
+				--net
+				--pid
+				--user
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/utmpdump b/bash-completion/utmpdump
index bf18638..3b868ce 100644
--- a/bash-completion/utmpdump
+++ b/bash-completion/utmpdump
@@ -11,7 +11,7 @@ _utmpdump_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-f --follow -r --reverse -V --version -h --help"
+			OPTS="--follow --reverse --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/uuidd b/bash-completion/uuidd
index c69a7c1..c45b067 100644
--- a/bash-completion/uuidd
+++ b/bash-completion/uuidd
@@ -26,7 +26,7 @@ _uuidd_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-p --pid -s --socket -T --timeout -k --kill -r --random -t --time -n --uuids -P --no-pid -F --no-fork -S --socket-activation -d --debug -q --quiet -V --version -h --help"
+			OPTS="--pid --socket --timeout --kill --random --time --uuids --no-pid --no-fork --socket-activation --debug --quiet --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/uuidgen b/bash-completion/uuidgen
index 2cf30a2..42d95d4 100644
--- a/bash-completion/uuidgen
+++ b/bash-completion/uuidgen
@@ -11,7 +11,7 @@ _uuidgen_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-r --random -t --time -V --version -h --help"
+			OPTS="--random --time --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/wall b/bash-completion/wall
index 4086ffe..55d9658 100644
--- a/bash-completion/wall
+++ b/bash-completion/wall
@@ -15,7 +15,7 @@ _wall_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-n --nobanner -t --timeout -V --version -h --help"
+			OPTS="--nobanner --timeout --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/wdctl b/bash-completion/wdctl
index 01d19a0..33b4e1f 100644
--- a/bash-completion/wdctl
+++ b/bash-completion/wdctl
@@ -40,18 +40,18 @@ _wdctl_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-f --flags
-				-F --noflags
-				-I --noident
-				-n --noheadings
-				-O --oneline
-				-o --output
-				-r --raw
-				-T --notimeouts
-				-s --settimeout
-				-x --flags-only
-				-h --help
-				-V --version"
+			OPTS="--flags
+				--noflags
+				--noident
+				--noheadings
+				--oneline
+				--output
+				--raw
+				--notimeouts
+				--settimeout
+				--flags-only
+				--help
+				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/wipefs b/bash-completion/wipefs
index 20dd40d..e0e3286 100644
--- a/bash-completion/wipefs
+++ b/bash-completion/wipefs
@@ -21,7 +21,7 @@ _wipefs_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="-a --all -f --force -h --help -n --no-actn -o --offset -p --parsable -q --quiet -t --types -V --version"
+			OPTS="--all --force --help --no-act --offset --parsable --quiet --types --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
-- 
1.7.11.7

