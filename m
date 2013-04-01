Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Mon, 1 Apr 2013 16:44:16 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/10] [pull] bash-completion
Message-ID: <20130401154353.GA20549@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <20130328093754.GA24678@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130328093754.GA24678@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 28, 2013 at 10:37:54AM +0100, Karel Zak wrote:
> On Wed, Mar 27, 2013 at 10:07:42PM +0000, Sami Kerola wrote:
> > > Some FIXME's are slightly more difficult to fix.  For example I do not
> > > know how to get list of possible TERM values distribution agnostic way. 
> 
>  Well, I think we can start with some nice hardcoded list..
> 
> > > And with 'wdctl' I have no how to determine flags.  Same goes for SELinux
> 
>     wdctl --flags-only -o FLAG 
>     
>  returns currently supported flags (by the device), the complete list of 
>  the flags is:
> 
> 	CARDRESET
> 	EXTERN1
> 	EXTERN2
> 	FANFAULT
> 	KEEPALIVEPING
> 	MAGICCLOSE
> 	OVERHEAT
> 	POWEROVER
> 	POWERUNDER
> 	PRETIMEOUT
> 	SETTIMEOUT
> 	ALARMONLY
> 
> I think it's fine to use this hardcoded list.

Hard coded list is in use for wdctl, and I have done few other changes
which are collectively in my remote repository.

git://github.com/kerolasa/lelux-utiliteetit.git shell-completion

To be a bit less vague here are the changes since the previous
submission.


diff --git a/shell-completion/Makemodule.am b/shell-completion/Makemodule.am
index 0bb8652..b657604 100644
--- a/shell-completion/Makemodule.am
+++ b/shell-completion/Makemodule.am
@@ -90,10 +90,6 @@ if BUILD_LAST
 dist_bashcompletion_DATA += \
 	shell-completion/last
 endif
-if BUILD_LOGIN
-dist_bashcompletion_DATA += \
-	shell-completion/login
-endif
 if BUILD_NEWGRP
 dist_bashcompletion_DATA += \
 	shell-completion/newgrp
@@ -102,10 +98,6 @@ if BUILD_SU
 dist_bashcompletion_DATA += \
 	shell-completion/su
 endif
-if BUILD_SULOGIN
-dist_bashcompletion_DATA += \
-	shell-completion/sulogin
-endif
 if BUILD_UTMPDUMP
 dist_bashcompletion_DATA += \
 	shell-completion/utmpdump
@@ -222,10 +214,6 @@ endif
 # ...sys-utils
 
 # term-utils...
-if BUILD_AGETTY
-dist_bashcompletion_DATA += \
-	shell-completion/agetty
-endif
 if BUILD_MESG
 dist_bashcompletion_DATA += \
 	shell-completion/mesg
diff --git a/shell-completion/addpart b/shell-completion/addpart
index 07ebf5e..b6f119a 100644
--- a/shell-completion/addpart
+++ b/shell-completion/addpart
@@ -1,17 +1,17 @@
 _addpart_module()
 {
-	local cur
+	local cur prev
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
 		1)
-			local DEVS
-			DEVS="$(lsblk -o NAME -n -r)"
+			local DEVS=''
+			while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 			OPTS="-h --help -V --version $DEVS"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
-			COMPREPLY=( $(compgen -W "$((1 + $(ls $prev?* 2>/dev/null | wc -l)))" -- $cur) )
+			# FIXME: how to determine next free partition number
 			;;
 		3)
 			COMPREPLY=( $(compgen -W "start" -- $cur) )
diff --git a/shell-completion/agetty b/shell-completion/agetty
deleted file mode 100644
index dc37a68..0000000
--- a/shell-completion/agetty
+++ /dev/null
@@ -1,70 +0,0 @@
-_agetty_module()
-{
-	local cur prev OPTS
-	COMPREPLY=()
-	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-a'|'--autologin')
-			COMPREPLY=( $(compgen -u -- $cur) )
-			return 0
-			;;
-		'-o'|'--issue-file'|'-I'|'--login-program')
-			compopt -o filenames
-			COMPREPLY=( $(compgen -f -- $cur) )
-			return 0
-			;;
-		'-I'|'--init-string'|'--erase-chars'|'--kill-chars')
-			compopt -o filenames
-			COMPREPLY=( $(compgen -W "string" -- $cur) )
-			return 0
-			;;
-		'-o'|'--login-options')
-			COMPREPLY=( $(compgen -W "login-options" -- $cur) )
-			return 0
-			;;
-		'-t'|'--timeout')
-			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS="-8 --8bits
-				-a --autologin
-				-c --noreset
-				-f --issue-file
-				-h --flow-control
-				-H --host
-				-i --noissue
-				-I --init-string
-				-l --login-program
-				-L --local-line
-				-m --extract-baud
-				-n --skip-login
-				-o --login-options
-				-p --loginpause
-				-R --hangup
-				-s --keep-baud
-				-t --timeout
-				-U --detect-case
-				-w --wait-cr
-				   --nocleardo
-				   --nohintsdo
-				   --nonewlinedo
-				   --no-hostnameno
-				   --long-hostnameshow
-				   --erase-chars
-				   --kill-chars
-				-h --help
-				-V --version"
-			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
-			return 0
-			;;
-	esac
-	local BAUD_RATES
-	BAUD_RATES="75 110 300 1200 2400 4800 9600 19200 38400 57600 115200"
-	COMPREPLY=( $(compgen -W "$BAUD_RATES $(echo /dev/tty*)" -- $cur) )
-	return 0
-}
-complete -F _agetty_module agetty
diff --git a/shell-completion/blkdiscard b/shell-completion/blkdiscard
index e907a1b..757480c 100644
--- a/shell-completion/blkdiscard
+++ b/shell-completion/blkdiscard
@@ -18,7 +18,7 @@ _blkdiscard_module()
 			;;
 	esac
 	local DEVS
-	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
+	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/blkid b/shell-completion/blkid
index dce41e0..14222a4 100644
--- a/shell-completion/blkid
+++ b/shell-completion/blkid
@@ -23,11 +23,11 @@ _blkid_module()
 			return 0
 			;;
 		'-L')
-			COMPREPLY=( $(compgen -W "$(\ls /dev/disk/by-label/ 2>/dev/null)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(cd /dev/disk/by-label/ 2>/dev/null && echo *)" -- $cur) )
 			return 0
 			;;
 		'-U')
-			COMPREPLY=( $(compgen -W "$(\ls /dev/disk/by-uuid/ 2>/dev/null)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(cd /dev/disk/by-uuid/ 2>/dev/null && echo *)" -- $cur) )
 			return 0
 			;;
 		'-s')
@@ -54,9 +54,11 @@ _blkid_module()
 			return 0
 			;;
 	esac
-	local PARTITIONS
-	PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/'; DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
-	COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
+	local DEV TYPE DEVICES=''
+	while read DEV TYPE; do
+		[ $TYPE = 'part' ] && DEVICES+="$DEV "
+	done < <(lsblk -pnro name,type)
+	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
 complete -F _blkid_module blkid
diff --git a/shell-completion/blockdev b/shell-completion/blockdev
index 82ac6c1..ce986cb 100644
--- a/shell-completion/blockdev
+++ b/shell-completion/blockdev
@@ -4,7 +4,7 @@ _blockdev_module()
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	DEVS="$(lsblk -o NAME -n -r)"
+	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	OPTS="-h -V -q
 		--report
 		--getsz
diff --git a/shell-completion/cfdisk b/shell-completion/cfdisk
index 8da32fd..4be5186 100644
--- a/shell-completion/cfdisk
+++ b/shell-completion/cfdisk
@@ -25,7 +25,11 @@ _cfdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
+	local DEV TYPE DEVICES=''
+	while read DEV TYPE; do
+		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
+	done < <(lsblk -pnro name,type)
+	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
 complete -F _cfdisk_module cfdisk
diff --git a/shell-completion/chfn b/shell-completion/chfn
index 1c5167a..a8eaee5 100644
--- a/shell-completion/chfn
+++ b/shell-completion/chfn
@@ -1,23 +1,8 @@
 _chfn_module()
 {
-	local cur prev OPTS
+	local cur OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-f'|'--full-name')
-			COMPREPLY=( $(compgen -W "name" -- $cur) )
-			return 0
-			;;
-		'-o'|'--office')
-			COMPREPLY=( $(compgen -W "office" -- $cur) )
-			return 0
-			;;
-		'-p'|'--office-phone'|'-h'|'--home-phone')
-			COMPREPLY=( $(compgen -W "phone-nr" -- $cur) )
-			return 0
-			;;
-	esac
 	case $cur in
 		-*)
 			OPTS="-f --full-name -o --office -p --office-phone -h --home-phone -u --help -v --version"
diff --git a/shell-completion/chrt b/shell-completion/chrt
index 08912c9..b85775a 100644
--- a/shell-completion/chrt
+++ b/shell-completion/chrt
@@ -25,7 +25,7 @@ _chrt_module()
 			;;
 	esac
 	local PIDS
-	PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+	PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
 	COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/delpart b/shell-completion/delpart
index 849c018..e3ee406 100644
--- a/shell-completion/delpart
+++ b/shell-completion/delpart
@@ -1,16 +1,20 @@
 _delpart_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $COMP_CWORD in
 		1)
-			local DEVS
-			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
-			OPTS="-h --help -V --version $DEVS"
+			local DEV TYPE DEVICES=''
+			while read DEV TYPE; do
+				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
+			done < <(lsblk -pnro name,type)
+			OPTS="-h --help -V --version $DEVICES"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
+			prev="${COMP_WORDS[COMP_CWORD-1]}"
 			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition 2>/dev/null)" -- $cur) )
 			;;
 	esac
diff --git a/shell-completion/fdformat b/shell-completion/fdformat
index f7d6a8e..4ad1c3d 100644
--- a/shell-completion/fdformat
+++ b/shell-completion/fdformat
@@ -3,7 +3,7 @@ _fdformat_module()
 	local cur OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
-	DEVS=$(ls /dev/fd[0-9]* 2>/dev/null)
+	DEVS=$(for I in echo /dev/fd*; do if [ -e $I ]; then echo $I; fi; done)
 	OPTS="-n --no-verify -h --help -V --version $DEVS"
 	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 	return 0
diff --git a/shell-completion/fdisk b/shell-completion/fdisk
index ccf2015..ae94f10 100644
--- a/shell-completion/fdisk
+++ b/shell-completion/fdisk
@@ -6,9 +6,11 @@ _fdisk_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-s')
-			local PARTITIONS
-			PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/'; DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
-			COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
+			local DEV TYPE DEVICES=''
+			while read DEV TYPE; do
+				[ $TYPE = 'part' ] && DEVICES+="$DEV "
+			done < <(lsblk -pnro name,type)
+			COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 			return 0
 			;;
 		'-b')
@@ -35,7 +37,11 @@ _fdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
+	local DEV TYPE DEVICES=''
+	while read DEV TYPE; do
+		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
+	done < <(lsblk -pnro name,type)
+	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
 complete -F _fdisk_module fdisk
diff --git a/shell-completion/findmnt b/shell-completion/findmnt
index 5207b97..413d36a 100644
--- a/shell-completion/findmnt
+++ b/shell-completion/findmnt
@@ -29,9 +29,16 @@ _findmnt_module()
 			return 0
 			;;
 		'-O'|'--options')
-			local MNT_OPTS
-			MNT_OPTS=$(awk '{ n = split($4, a, ","); for (i = 0; i <= n; i++) { mnt_opts[a[i]]=1 } } END { for (i in mnt_opts) { print i } }' /etc/mtab 2>/dev/null )
-			COMPREPLY=( $(compgen -W "$MNT_OPTS" -- $cur) )
+			local MTAB_3RD I
+			declare -a TMP_ARR
+			declare -A MNT_OPTS
+			while read _ _ _ MTAB_3RD _; do
+				IFS=',' read -ra TMP_ARR <<<"$MTAB_3RD"
+				for I in ${TMP_ARR[@]}; do
+					MNT_OPTS[$I]='1'
+				done
+			done </etc/mtab
+			COMPREPLY=( $(compgen -W "$(echo ${!MNT_OPTS[@]})" -- $cur) )
 			return 0
 			;;
 		'-o'|'--output')
diff --git a/shell-completion/fsck b/shell-completion/fsck
index c3da5f5..40b9a13 100644
--- a/shell-completion/fsck
+++ b/shell-completion/fsck
@@ -29,7 +29,7 @@ _fsck_module()
 			return 0
 			;;
 	esac
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/fsck.minix b/shell-completion/fsck.minix
index f01626a..6239ae4 100644
--- a/shell-completion/fsck.minix
+++ b/shell-completion/fsck.minix
@@ -3,7 +3,7 @@ _fsck.minix_module()
 	local cur OPTS DEVS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	OPTS="-l -a -r -v -s -m -f -V --version"
 	COMPREPLY=( $(compgen -W "${OPTS[*]} $DEVS" -- $cur) )
 	return 0
diff --git a/shell-completion/ionice b/shell-completion/ionice
index 3087c4a..2180718 100644
--- a/shell-completion/ionice
+++ b/shell-completion/ionice
@@ -15,7 +15,7 @@ _ionice_module()
 			;;
 		'-p'|'--pid')
 			local PIDS
-			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/ipcrm b/shell-completion/ipcrm
index 4b1024f..fd85091 100644
--- a/shell-completion/ipcrm
+++ b/shell-completion/ipcrm
@@ -36,13 +36,20 @@ _ipcrm_module()
 			return 0
 			;;
 	esac
+	case $cur in
+		'=')
+			cur=${cur#=}
+			COMPREPLY=( $(compgen -W "shm msg sem" -- $cur) )
+			return 0
+			;;
+	esac
 	OPTS="	-m --shmem-id
 		-M --shmem-key
 		-q --queue-id
 		-Q --queue-key
 		-s --semaphore-id
 		-S --semaphore-key
-		-a --all
+		-a= --all=
 		-v --verbose
 		-h --help
 		-V --version"
diff --git a/shell-completion/login b/shell-completion/login
deleted file mode 100644
index c075f64..0000000
--- a/shell-completion/login
+++ /dev/null
@@ -1,27 +0,0 @@
-_login_module()
-{
-	local cur prev OPTS
-	COMPREPLY=()
-	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-f')
-			COMPREPLY=( $(compgen -u -- $cur) )
-			return 0
-			;;
-		'-h')
-			COMPREPLY=( $(compgen -A hostname -- $cur) )
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS="-p -f -h -H -V"
-			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
-			return 0
-			;;
-	esac
-	COMPREPLY=( $(compgen -u -- $cur) )
-	return 0
-}
-complete -F _login_module login
diff --git a/shell-completion/losetup b/shell-completion/losetup
index b21f05d..329bb05 100644
--- a/shell-completion/losetup
+++ b/shell-completion/losetup
@@ -16,7 +16,7 @@ _losetup_module()
 			return 0
 			;;
 		'-c'|'--set-capacity')
-			ARG="$(\ls /dev/loop[0-9]* 2>/dev/null)"
+			ARG="$(for I in /dev/loop[0-9]*; do if [ -e $I ]; then echo $I; fi; done)"
 			COMPREPLY=( $(compgen -W "$ARG" -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/lsblk b/shell-completion/lsblk
index 521cead..5498199 100644
--- a/shell-completion/lsblk
+++ b/shell-completion/lsblk
@@ -1,12 +1,17 @@
 _lsblk_module()
 {
-	local cur prev OPTS MAJOR
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-e'|'--exclude'|'-I'|'--include')
-			MAJOR=$(\ls /sys/dev/block/ | sed 's/:.*//')
+			local MAJOR I J
+			MAJOR=''
+			for I in /sys/dev/block/*; do
+				J=${I##*/}
+				MAJOR="$MAJOR ${J%%:*}"
+			done
 			# FIXME: how to append to a string with compgen?
 			compopt -o nospace
 			COMPREPLY=( $(compgen -W "$MAJOR" -S ',' -- $cur) )
@@ -53,7 +58,7 @@ _lsblk_module()
 			;;
 	esac
 	local DEVS
-	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
+	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/lscpu b/shell-completion/lscpu
index bb76d4c..14926ec 100644
--- a/shell-completion/lscpu
+++ b/shell-completion/lscpu
@@ -1,19 +1,25 @@
 _lscpu_module()
 {
-	local cur prev OPTS
+	local cur OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'-e'|'--extended'|'-p'|'--parse')
+		'--extended'|'=')
+			cur=${cur#=}
 			# FIXME: how to append to a string with compgen?
-			# FIXME: space in between option and argument is
-			# 	 a problem.
-			local OUTPUT
-			OUTPUT="CPU CORE SOCKET NODE BOOK CACHE
-				POLARIZATION ADDRESS CONFIGURED ONLINE"
+			OPTS="CPU,
+				CORE,
+				SOCKET,
+				NODE,
+				BOOK,
+				CACHE,
+				POLARIZATION,
+				ADDRESS,
+				CONFIGURED,
+				ONLINE,"
 			compopt -o nospace
-			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			COMPREPLY=( $(compgen -W "$OPTS" -- $cur) )
 			return 0
 			;;
 	esac
@@ -22,8 +28,8 @@ _lscpu_module()
 			OPTS="-a --all
 				-b --online
 				-c --offline
-				-e --extended
-				-p --parse
+				-e= --extended=
+				-p= --parse=
 				-s --sysroot
 				-x --hex
 				-h --help
diff --git a/shell-completion/mkfs b/shell-completion/mkfs
index ee6a26b..1947119 100644
--- a/shell-completion/mkfs
+++ b/shell-completion/mkfs
@@ -6,7 +6,7 @@ _mkfs_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-t'|'--type')
-			FSTYPES=$(for I in $(\ls /sbin/mkfs.* /usr/sbin/mkfs.* 2>/dev/null); do echo ${I##*mkfs.}; done)
+			FSTYPES=$(for I in /sbin/mkfs.* /usr/sbin/mkfs.*; do if [ -e $I ]; then echo ${I##*mkfs.}; fi; done)
 			COMPREPLY=( $(compgen -W "$FSTYPES" -- $cur) )
 			return 0
 			;;
@@ -18,7 +18,7 @@ _mkfs_module()
 			return 0
 			;;
 	esac
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkfs.bfs b/shell-completion/mkfs.bfs
index b1a226a..7a47a76 100644
--- a/shell-completion/mkfs.bfs
+++ b/shell-completion/mkfs.bfs
@@ -21,7 +21,7 @@ _bfs_module()
 			return 0
 			;;
 	esac
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkfs.minix b/shell-completion/mkfs.minix
index c717b3c..085a058 100644
--- a/shell-completion/mkfs.minix
+++ b/shell-completion/mkfs.minix
@@ -26,7 +26,7 @@ _mkfs.minix_module()
 			;;
 	esac
 	local DEVS
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkswap b/shell-completion/mkswap
index c847aa9..30d517c 100644
--- a/shell-completion/mkswap
+++ b/shell-completion/mkswap
@@ -18,7 +18,6 @@ _mkswap_module()
 			return 0
 			;;
 		'-U'|--uuid)
-			COMPREPLY=( $(compgen -W "$(lsblk -n --output uuid)" -- $cur) )
 			return 0
 			;;
 	esac
diff --git a/shell-completion/nsenter b/shell-completion/nsenter
index f15a7f1..b8296b6 100644
--- a/shell-completion/nsenter
+++ b/shell-completion/nsenter
@@ -7,32 +7,29 @@ _nsenter_module()
 	case $prev in
 		'-t'|'--target')
 			local PIDS
-			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
-		'-m'|'--mount'|'-u'|'--uts'|'-i'|'--net'|'-n'|'--net'|'-p'|'--pid'|'-U'|'--user')
-			compopt -o filenames
-			COMPREPLY=( $(compgen -f -- $cur) )
-			return 0
-			;;
-		'-r'|'--root'|'-w'|'--wd')
-			compopt -o filenames
-			COMPREPLY=( $(compgen -o dirnames -- $cur) )
-			return 0
-			;;
 	esac
 	case $cur in
+		'=')
+			# FIXME: --root and --wd should use get only
+			# directories as compgen output.  If $cur is
+			# overwrote the same way as below in case segment
+			# for $prev the command-line will get mangled.
+			cur=${cur#=}
+			;;
 		-*)
 			OPTS="-t --target
-				-m --mount
-				-u --uts
-				-i --ipc
-				-n --net
-				-p --pid
-				-U --user
-				-r --root
-				-w --wd
+				-m= --mount=
+				-u= --uts=
+				-i= --ipc=
+				-n= --net=
+				-p= --pid=
+				-U= --user=
+				-r= --root=
+				-w= --wd=
 				-F --no-fork
 				-h --help
 				-V --version"
diff --git a/shell-completion/partx b/shell-completion/partx
index c558d36..db2eded 100644
--- a/shell-completion/partx
+++ b/shell-completion/partx
@@ -7,7 +7,6 @@ _partx_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-n'|'--nr')
-			COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /part/ {print "/dev/" $1}')" -- $cur) )
 			return 0
 			;;
 		'-o'|'--output')
@@ -29,9 +28,11 @@ _partx_module()
 			return 0
 			;;
 	esac
-	local DEVS
-	DEVS="$(sblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
-	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	local DEV TYPE DEVICES=''
+	while read DEV TYPE; do
+		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
+	done < <(lsblk -pnro name,type)
+	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
 complete -F _partx_module partx
diff --git a/shell-completion/prlimit b/shell-completion/prlimit
index ee49b79..bf5ff2f 100644
--- a/shell-completion/prlimit
+++ b/shell-completion/prlimit
@@ -6,7 +6,7 @@ _prlimit_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-p'|'--pid')
-			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
@@ -20,6 +20,11 @@ _prlimit_module()
 			;;
 	esac
 	case $cur in
+		'=')
+			cur=${cur#=}
+			# FIXME: is there anything what could be printed
+			# as limit value(s)
+			;;
 		-*)
 			OPTS="-p --pid
 				-o --output
@@ -28,21 +33,21 @@ _prlimit_module()
 				   --verbose
 				-h --help
 				-V --version
-				-c --core
-				-d --data
-				-e --nice
-				-f --fsize
-				-i --sigpending
-				-l --memlock
-				-m --rss
-				-n --nofile
-				-q --msgqueue
-				-r --rtprio
-				-s --stack
-				-t --cpu
-				-u --nproc
-				-v --as
-				-x --locks
+				-c= --core=
+				-d= --data=
+				-e= --nice=
+				-f= --fsize=
+				-i= --sigpending=
+				-l= --memlock=
+				-m= --rss=
+				-n= --nofile=
+				-q= --msgqueue=
+				-r= --rtprio=
+				-s= --stack=
+				-t= --cpu=
+				-u= --nproc=
+				-v= --as=
+				-x= --locks=
 				-y --rttime"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
diff --git a/shell-completion/raw b/shell-completion/raw
index 41e03f2..27f0354 100644
--- a/shell-completion/raw
+++ b/shell-completion/raw
@@ -11,7 +11,7 @@ _raw_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(ls 2>/dev/null /dev/raw/*)" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(for I in /dev/raw/*; do if [ -e $I ]; then echo $I; fi; done)" -- $cur) )
 	return 0
 }
 complete -F _raw_module raw
diff --git a/shell-completion/renice b/shell-completion/renice
index bc80dac..aba00d7 100644
--- a/shell-completion/renice
+++ b/shell-completion/renice
@@ -17,7 +17,7 @@ _renice_module()
 			;;
 		'-p'|'--pid')
 			local PIDS
-			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/resizepart b/shell-completion/resizepart
index 827638a..b178b52 100644
--- a/shell-completion/resizepart
+++ b/shell-completion/resizepart
@@ -1,16 +1,19 @@
 _resizepart_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
 		1)
-			local DEVS
-			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
-			OPTS="-h --help -V --version $DEVS"
+			local DEV TYPE DEVICES=''
+			while read DEV TYPE; do
+				[ $TYPE = 'disk' ] && DEVICES+="$DEV "
+			done < <(lsblk -pnro name,type)
+			OPTS="-h --help -V --version $DEVICES"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
+			prev="${COMP_WORDS[COMP_CWORD-1]}"
 			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition 2>/dev/null)" -- $cur) )
 			;;
 		3)
diff --git a/shell-completion/rtcwake b/shell-completion/rtcwake
index 2010a52..1f38df8 100644
--- a/shell-completion/rtcwake
+++ b/shell-completion/rtcwake
@@ -7,7 +7,7 @@ _rtcwake_module()
 	case $prev in
 		'-d'|'--device')
 			local RTC_DEVS
-			RTC_DEVS=$(\ls /sys/class/rtc/ 2>/dev/null)
+			RTC_DEVS=$(cd /sys/class/rtc/ && echo *)
 			COMPREPLY=( $(compgen -W "$RTC_DEVS" -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/script b/shell-completion/script
index fb6c106..48f50c3 100644
--- a/shell-completion/script
+++ b/shell-completion/script
@@ -10,13 +10,11 @@ _script_module()
 			COMPREPLY=( $(compgen -c -- $cur) )
 			return 0
 			;;
-		'-t'|'--timing')
-			compopt -o filenames
-			COMPREPLY=( $(compgen -f -- $cur) )
-			return 0
-			;;
 	esac
 	case $cur in
+		'=')
+			cur=${cur#=}
+			;;
 		-*)
 			OPTS="-a --append
 				-c --command
@@ -24,7 +22,7 @@ _script_module()
 				-f --flush
 				   --force
 				-q --quiet
-				-t --timing
+				-t= --timing=
 				-V --version
 				-h --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
diff --git a/shell-completion/setterm b/shell-completion/setterm
index a0dff44..33d2e56 100644
--- a/shell-completion/setterm
+++ b/shell-completion/setterm
@@ -6,8 +6,12 @@ _setterm_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-term')
-			# FIXME: terminal type list would be nice
-			COMPREPLY=( $(compgen -W "vt100 xterm linux screen etc" -- $cur) )
+			local TERM_LIST I
+			TERM_LIST=''
+			for I in /usr/share/terminfo/?/*; do
+				TERM_LIST+="${I##*/} "
+			done
+			COMPREPLY=( $(compgen -W "$TERM_LIST" -- $cur) )
 			return 0
 			;;
 		'-foreground'|'-background'|'-ulcolor'|'-hbcolor')
@@ -36,8 +40,8 @@ _setterm_module()
 			;;
 		'-dump'|'-append')
 			local NUM_CONS
-			NUM_CONS=$(ls /sys/class/tty | wc -l)
-			COMPREPLY=( $(compgen -W "$(echo {1..$NUM_CONS})" -- $cur) )
+			NUM_CONS=(/sys/class/tty/*)
+			COMPREPLY=( $(compgen -W "$(echo {1..${#NUM_CONS[*]}})" -- $cur) )
 			return 0
 			;;
 		'-file')
diff --git a/shell-completion/sfdisk b/shell-completion/sfdisk
index 041ce55..5498b0e 100644
--- a/shell-completion/sfdisk
+++ b/shell-completion/sfdisk
@@ -20,6 +20,9 @@ _sfdisk_module()
 			;;
 	esac
 	case $cur in
+		'=')
+			cur=${cur#=}
+			;;
 		-*)
 			OPTS="-s --show-size
 				-c --id
@@ -47,8 +50,8 @@ _sfdisk_module()
 				-L --Linux
 				-g --show-geometry
 				-G --show-pt-geometry
-				-A --activate
-				-U --unhide
+				-A= --activate=
+				-U= --unhide=
 				-x --show-extended
 				--leave-last
 				--IBM
@@ -66,7 +69,11 @@ _sfdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
+	local DEV TYPE DEVICES=''
+	while read DEV TYPE; do
+		[ $TYPE = 'disk' ] && DEVICES+="$DEV "
+	done < <(lsblk -pnro name,type)
+	COMPREPLY=( $(compgen -W "$DEVICES" -- $cur) )
 	return 0
 }
 complete -F _sfdisk_module sfdisk
diff --git a/shell-completion/su b/shell-completion/su
index ded4b7b..c5aa81e 100644
--- a/shell-completion/su
+++ b/shell-completion/su
@@ -20,15 +20,16 @@ _su_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="	-u --user
+			OPTS="	-
+				-u --user
 				-m -p --preserve-environment
 				-g --group
 				-G --supp-group
-				- -l --login
+				-l --login
 				-c --command
-				- -c
+				-c
 				--session-command
-				-- -c
+				-c
 				-f --fast
 				-s --shell
 				-h --help
diff --git a/shell-completion/sulogin b/shell-completion/sulogin
deleted file mode 100644
index 9fdc20e..0000000
--- a/shell-completion/sulogin
+++ /dev/null
@@ -1,24 +0,0 @@
-_sulogin_module()
-{
-	local cur prev OPTS
-	COMPREPLY=()
-	cur="${COMP_WORDS[COMP_CWORD]}"
-	prev="${COMP_WORDS[COMP_CWORD-1]}"
-	case $prev in
-		'-t'|'--timeout')
-			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS="-p --login-shell -t --timeout -V --version -h --help"
-			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
-			return 0
-			;;
-	esac
-	compopt -o filenames
-	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/tty"}) )
-	return 0
-}
-complete -F _sulogin_module sulogin
diff --git a/shell-completion/taskset b/shell-completion/taskset
index 81247cd..5311316 100644
--- a/shell-completion/taskset
+++ b/shell-completion/taskset
@@ -19,7 +19,7 @@ _taskset_module()
 			# setting an affinity the optarg has to be cpu
 			# mask.  The following is good only for getting
 			# affinity.
-			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			PIDS=$(for I in /proc/[0-9]*; do echo ${I##"/proc/"}; done)
 			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/ul b/shell-completion/ul
index 89e2800..07d0731 100644
--- a/shell-completion/ul
+++ b/shell-completion/ul
@@ -6,8 +6,12 @@ _ul_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-t'|'--terminal')
-			# FIXME: terminal type list would be nice
-			COMPREPLY=( $(compgen -W "vt100 xterm linux screen etc" -- $cur) )
+			local TERM_LIST I
+			TERM_LIST=''
+			for I in /usr/share/terminfo/?/*; do
+				TERM_LIST+="${I##*/} "
+			done
+			COMPREPLY=( $(compgen -W "$TERM_LIST" -- $cur) )
 			return 0
 			;;
 	esac
diff --git a/shell-completion/wdctl b/shell-completion/wdctl
index 6a85e0a..42889ac 100644
--- a/shell-completion/wdctl
+++ b/shell-completion/wdctl
@@ -6,8 +6,20 @@ _wdctl_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-f'|'--flags')
-			# FIXME: how to get flag list?
-			COMPREPLY=( $(compgen -W "flags" -- $cur) )
+			local FLAGS
+			FLAGS="ALARMONLY
+				CARDRESET
+				EXTERN1
+				EXTERN2
+				FANFAULT
+				KEEPALIVEPING
+				MAGICCLOSE
+				OVERHEAT
+				POWEROVER
+				POWERUNDER
+				PRETIMEOUT
+				SETTIMEOUT"
+			COMPREPLY=( $(compgen -W "$FLAGS" -- $cur) )
 			return 0
 			;;
 		'-o'|'--output')
diff --git a/shell-completion/wipefs b/shell-completion/wipefs
index 427f47b..db9426e 100644
--- a/shell-completion/wipefs
+++ b/shell-completion/wipefs
@@ -11,13 +11,7 @@ _wipefs_module()
 			;;
 		'-t'|'--types')
 			local TYPES
-			TYPES="adfs affs autofs cifs coda coherent cramfs
-				debugfs devpts efs ext ext2 ext3 ext4 hfs
-				hfsplus hpfs iso9660 jfs minix msdos
-				ncpfs nfs nfs4 ntfs proc qnx4 ramfs
-				reiserfs romfs squashfs smbfs sysv tmpfs
-				ubifs udf ufs umsdos usbfs vfat xenix xfs
-				xiafs"
+			TYPES="$(blkid -k)"
 			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
 			return 0
 			;;
@@ -31,7 +25,7 @@ _wipefs_module()
 			;;
 	esac
 	local DEVS
-	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
+	DEVS=''; while read dev; do DEVS+="$dev " ; done < <(lsblk -pnro name)
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/write b/shell-completion/write
index ba67569..d41159b 100644
--- a/shell-completion/write
+++ b/shell-completion/write
@@ -9,7 +9,10 @@ _write_module()
 			return 0
 			;;
 		2)
-			local TERMS=$(for I in $(\ls /sys/class/tty 2>/dev/null); do echo "/dev/$I"; done)
+			local I TERMS=''
+			for I in /sys/class/tty/*; do
+				TERMS+="/dev${I##/sys/class/tty} "
+			done
 			COMPREPLY=( $(compgen -W "$TERMS" -- $cur) )
 			return 0
 			;;


-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
