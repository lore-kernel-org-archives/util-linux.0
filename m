Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130328093754.GA24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
	<20130328093754.GA24678@x2.net.home>
Date: Mon, 1 Apr 2013 00:49:49 +0100
Message-ID: <CAG27Bk0JB0kiOtSSYtF0C7Yevdw+g4+W41OFJo+KJgR8QvAFnQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] [pull] bash-completion
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: multipart/alternative; boundary=20cf307f3626f34ac904d9412832
List-ID: <util-linux.vger.kernel.org>

--20cf307f3626f34ac904d9412832
Content-Type: text/plain; charset=ISO-8859-1

On 28 March 2013 09:37, Karel Zak <kzak@redhat.com> wrote:

> On Wed, Mar 27, 2013 at 10:07:42PM +0000, Sami Kerola wrote:
> > > Some FIXME's are slightly more difficult to fix.  For example I do not
> > > know how to get list of possible TERM values distribution agnostic way.
>
>  Well, I think we can start with some nice hardcoded list..
>
> > > And with 'wdctl' I have no how to determine flags.  Same goes for
> SELinux
>
>     wdctl --flags-only -o FLAG
>
>  returns currently supported flags (by the device), the complete list of
>  the flags is:
>
>         CARDRESET
>         EXTERN1
>         EXTERN2
>         FANFAULT
>         KEEPALIVEPING
>         MAGICCLOSE
>         OVERHEAT
>         POWEROVER
>         POWERUNDER
>         PRETIMEOUT
>         SETTIMEOUT
>         ALARMONLY
>
> I think it's fine to use this hardcoded list.
>

Hello,

I did something to some of the stuff that was mentioned by Dave & Karel.
The following changes can be found from git://
github.com/kerolasa/lelux-utiliteetit.git shell-completion.

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
index 07ebf5e..1fa34a7 100644
--- a/shell-completion/addpart
+++ b/shell-completion/addpart
@@ -1,6 +1,6 @@
 _addpart_module()
 {
-	local cur
+	local cur prev
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
@@ -11,7 +11,7 @@ _addpart_module()
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
-			COMPREPLY=( $(compgen -W "$((1 + $(ls $prev?* 2>/dev/null | wc
-l)))" -- $cur) )
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
index e907a1b..7d85bce 100644
--- a/shell-completion/blkdiscard
+++ b/shell-completion/blkdiscard
@@ -18,7 +18,7 @@ _blkdiscard_module()
 			;;
 	esac
 	local DEVS
-	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
+	DEVS="$(lsblk -o NAME -n -r -p)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/blkid b/shell-completion/blkid
index dce41e0..05e337b 100644
--- a/shell-completion/blkid
+++ b/shell-completion/blkid
@@ -23,11 +23,11 @@ _blkid_module()
 			return 0
 			;;
 		'-L')
-			COMPREPLY=( $(compgen -W "$(\ls /dev/disk/by-label/ 2>/dev/null)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(cd /dev/disk/by-label/ 2>/dev/null &&
echo *)" -- $cur) )
 			return 0
 			;;
 		'-U')
-			COMPREPLY=( $(compgen -W "$(\ls /dev/disk/by-uuid/ 2>/dev/null)" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(cd /dev/disk/by-uuid/ 2>/dev/null &&
echo *)" -- $cur) )
 			return 0
 			;;
 		'-s')
@@ -55,7 +55,7 @@ _blkid_module()
 			;;
 	esac
 	local PARTITIONS
-	PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/';
DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
+	PARTITIONS="$(lsblk -o NAME,TYPE -n -r -p | awk '$2 ~ /part/ {print $1}')"
 	COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/cfdisk b/shell-completion/cfdisk
index 8da32fd..3725645 100644
--- a/shell-completion/cfdisk
+++ b/shell-completion/cfdisk
@@ -25,7 +25,7 @@ _cfdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~
/disk/ {print "/dev/" $1}')" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r -p | awk '$2 ~
/disk/ {print $1}')" -- $cur) )
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
 			OPTS="-f --full-name -o --office -p --office-phone -h --home-phone
-u --help -v --version"
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
index 849c018..a9cd3b7 100644
--- a/shell-completion/delpart
+++ b/shell-completion/delpart
@@ -1,16 +1,17 @@
 _delpart_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
 		1)
 			local DEVS
-			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
+			DEVS="$(lsblk -o NAME,TYPE -n -p -r | awk '$2 ~ /disk/ {print $1}')"
 			OPTS="-h --help -V --version $DEVS"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
+			prev="${COMP_WORDS[COMP_CWORD-1]}"
 			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition
2>/dev/null)" -- $cur) )
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
index ccf2015..a8a2a37 100644
--- a/shell-completion/fdisk
+++ b/shell-completion/fdisk
@@ -7,7 +7,7 @@ _fdisk_module()
 	case $prev in
 		'-s')
 			local PARTITIONS
-			PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/';
DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
+			PARTITIONS="$(lsblk -o NAME,TYPE -n -r -p | awk '$2 ~ /part/ {print $1}')"
 			COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
 			return 0
 			;;
@@ -35,7 +35,7 @@ _fdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~
/disk/ {print "/dev/" $1}')" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r -p | awk '$2 ~
/disk/ {print $1}')" -- $cur) )
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
-			MNT_OPTS=$(awk '{ n = split($4, a, ","); for (i = 0; i <= n; i++)
{ mnt_opts[a[i]]=1 } } END { for (i in mnt_opts) { print i } }'
/etc/mtab 2>/dev/null )
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
index c3da5f5..a8f054f 100644
--- a/shell-completion/fsck
+++ b/shell-completion/fsck
@@ -29,7 +29,7 @@ _fsck_module()
 			return 0
 			;;
 	esac
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	DEVS="$(lsblk -o NAME -n -r -p)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/fsck.minix b/shell-completion/fsck.minix
index f01626a..69ac714 100644
--- a/shell-completion/fsck.minix
+++ b/shell-completion/fsck.minix
@@ -3,7 +3,7 @@ _fsck.minix_module()
 	local cur OPTS DEVS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	DEVS="$(lsblk -o NAME -n -r -p)"
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
index 4b1024f..da9f783 100644
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
+		-a --all=
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
index 521cead..4b5973d 100644
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
+	DEVS="$(lsblk -o NAME -n -r -p)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/lscpu b/shell-completion/lscpu
index bb76d4c..38ef07b 100644
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
+				-e --extended=
+				-p --parse=
 				-s --sysroot
 				-x --hex
 				-h --help
diff --git a/shell-completion/mkfs b/shell-completion/mkfs
index ee6a26b..ac56841 100644
--- a/shell-completion/mkfs
+++ b/shell-completion/mkfs
@@ -6,7 +6,7 @@ _mkfs_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-t'|'--type')
-			FSTYPES=$(for I in $(\ls /sbin/mkfs.* /usr/sbin/mkfs.*
2>/dev/null); do echo ${I##*mkfs.}; done)
+			FSTYPES=$(for I in /sbin/mkfs.* /usr/sbin/mkfs.*; do if [ -e $I ];
then echo ${I##*mkfs.}; fi; done)
 			COMPREPLY=( $(compgen -W "$FSTYPES" -- $cur) )
 			return 0
 			;;
@@ -18,7 +18,7 @@ _mkfs_module()
 			return 0
 			;;
 	esac
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	DEVS="$(lsblk -o NAME -n -r -p)"
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkfs.bfs b/shell-completion/mkfs.bfs
index b1a226a..2d8e796 100644
--- a/shell-completion/mkfs.bfs
+++ b/shell-completion/mkfs.bfs
@@ -21,7 +21,7 @@ _bfs_module()
 			return 0
 			;;
 	esac
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	DEVS="$(lsblk -o NAME -n -r -p)"
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkfs.minix b/shell-completion/mkfs.minix
index c717b3c..884a09b 100644
--- a/shell-completion/mkfs.minix
+++ b/shell-completion/mkfs.minix
@@ -26,7 +26,7 @@ _mkfs.minix_module()
 			;;
 	esac
 	local DEVS
-	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
+	DEVS="$(lsblk -o NAME -n -r -p)"
 	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
 	return 0
 }
diff --git a/shell-completion/nsenter b/shell-completion/nsenter
index f15a7f1..168f740 100644
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
+				-m --mount=
+				-u --uts=
+				-i --ipc=
+				-n --net=
+				-p --pid=
+				-U --user=
+				-r --root=
+				-w --wd=
 				-F --no-fork
 				-h --help
 				-V --version"
diff --git a/shell-completion/partx b/shell-completion/partx
index c558d36..8187965 100644
--- a/shell-completion/partx
+++ b/shell-completion/partx
@@ -7,7 +7,7 @@ _partx_module()
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
 		'-n'|'--nr')
-			COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~
/part/ {print "/dev/" $1}')" -- $cur) )
+			COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r -p | awk '$2
~ /part/ {print $1}')" -- $cur) )
 			return 0
 			;;
 		'-o'|'--output')
diff --git a/shell-completion/prlimit b/shell-completion/prlimit
index ee49b79..55bd13f 100644
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
+				-c --core=
+				-d --data=
+				-e --nice=
+				-f --fsize=
+				-i --sigpending=
+				-l --memlock=
+				-m --rss=
+				-n --nofile=
+				-q --msgqueue=
+				-r --rtprio=
+				-s --stack=
+				-t --cpu=
+				-u --nproc=
+				-v --as=
+				-x --locks=
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
+	COMPREPLY=( $(compgen -W "$(for I in /dev/raw/*; do if [ -e $I ];
then echo $I; fi; done)" -- $cur) )
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
index 827638a..cdd76d0 100644
--- a/shell-completion/resizepart
+++ b/shell-completion/resizepart
@@ -1,16 +1,17 @@
 _resizepart_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
 		1)
 			local DEVS
-			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
+			DEVS="$(lsblk -o NAME,TYPE -n -r -p | awk '$2 ~ /disk/ {print $1}')"
 			OPTS="-h --help -V --version $DEVS"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			;;
 		2)
+			prev="${COMP_WORDS[COMP_CWORD-1]}"
 			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition
2>/dev/null)" -- $cur) )
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
index fb6c106..e58dbd8 100644
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
+				-t --timing=
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
index 041ce55..835ecd2 100644
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
+				-A --activate=
+				-U --unhide=
 				-x --show-extended
 				--leave-last
 				--IBM
@@ -66,7 +69,7 @@ _sfdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~
/disk/ {print "/dev/" $1}')" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r -p | awk '$2 ~
/disk/ {print $1}')" -- $cur) )
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
index 427f47b..52c25b4 100644
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
+	DEVS="$(lsblk-o NAME -n -r -p)"
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
-			local TERMS=$(for I in $(\ls /sys/class/tty 2>/dev/null); do echo
"/dev/$I"; done)
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

--20cf307f3626f34ac904d9412832
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 28 March 2013 09:37, Karel Zak <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:kzak@redhat.com" target=3D"_blank">kzak@redhat.com</a>&gt;<=
/span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">

<div>On Wed, Mar 27, 2013 at 10:07:42PM +0000, Sami Kerola wrote:<br>
</div><div>&gt; &gt; Some FIXME&#39;s are slightly more difficult to fix. =
=A0For example I do not<br>
&gt; &gt; know how to get list of possible TERM values distribution agnosti=
c way.<br>
<br>
</div>=A0Well, I think we can start with some nice hardcoded list..<br>
<div><br>
&gt; &gt; And with &#39;wdctl&#39; I have no how to determine flags. =A0Sam=
e goes for SELinux<br>
<br>
</div>=A0 =A0 wdctl --flags-only -o FLAG<br>
<br>
=A0returns currently supported flags (by the device), the complete list of<=
br>
=A0the flags is:<br>
<br>
=A0 =A0 =A0 =A0 CARDRESET<br>
=A0 =A0 =A0 =A0 EXTERN1<br>
=A0 =A0 =A0 =A0 EXTERN2<br>
=A0 =A0 =A0 =A0 FANFAULT<br>
=A0 =A0 =A0 =A0 KEEPALIVEPING<br>
=A0 =A0 =A0 =A0 MAGICCLOSE<br>
=A0 =A0 =A0 =A0 OVERHEAT<br>
=A0 =A0 =A0 =A0 POWEROVER<br>
=A0 =A0 =A0 =A0 POWERUNDER<br>
=A0 =A0 =A0 =A0 PRETIMEOUT<br>
=A0 =A0 =A0 =A0 SETTIMEOUT<br>
=A0 =A0 =A0 =A0 ALARMONLY<br>
<br>
I think it&#39;s fine to use this hardcoded list.<span></span><br clear=3D"=
all"></blockquote></div><br></div><div class=3D"gmail_extra">Hello,<br><br>=
</div><div class=3D"gmail_extra">I did something to some of the stuff that =
was mentioned by Dave &amp; Karel. The following changes can be found from =
git://<a href=3D"http://github.com/kerolasa/lelux-utiliteetit.git" target=
=3D"_blank">github.com/kerolasa/lelux-utiliteetit.git</a> shell-completion.=
<br>
<br></div><div class=3D"gmail_extra"><pre>diff --git a/shell-completion/Mak=
emodule.am b/shell-completion/Makemodule.am
index 0bb8652..b657604 100644
--- a/shell-completion/Makemodule.am
+++ b/shell-completion/Makemodule.am
@@ -90,10 +90,6 @@ if BUILD_LAST
 dist_bashcompletion_DATA +=3D \
 	shell-completion/last
 endif
-if BUILD_LOGIN
-dist_bashcompletion_DATA +=3D \
-	shell-completion/login
-endif
 if BUILD_NEWGRP
 dist_bashcompletion_DATA +=3D \
 	shell-completion/newgrp
@@ -102,10 +98,6 @@ if BUILD_SU
 dist_bashcompletion_DATA +=3D \
 	shell-completion/su
 endif
-if BUILD_SULOGIN
-dist_bashcompletion_DATA +=3D \
-	shell-completion/sulogin
-endif
 if BUILD_UTMPDUMP
 dist_bashcompletion_DATA +=3D \
 	shell-completion/utmpdump
@@ -222,10 +214,6 @@ endif
 # ...sys-utils
=20
 # term-utils...
-if BUILD_AGETTY
-dist_bashcompletion_DATA +=3D \
-	shell-completion/agetty
-endif
 if BUILD_MESG
 dist_bashcompletion_DATA +=3D \
 	shell-completion/mesg
diff --git a/shell-completion/addpart b/shell-completion/addpart
index 07ebf5e..1fa34a7 100644
--- a/shell-completion/addpart
+++ b/shell-completion/addpart
@@ -1,6 +1,6 @@
 _addpart_module()
 {
-	local cur
+	local cur prev
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
 	case $COMP_CWORD in
@@ -11,7 +11,7 @@ _addpart_module()
 			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
 			;;
 		2)
-			COMPREPLY=3D( $(compgen -W &quot;$((1 + $(ls $prev?* 2&gt;/dev/null | w=
c -l)))&quot; -- $cur) )
+			# FIXME: how to determine next free partition number
 			;;
 		3)
 			COMPREPLY=3D( $(compgen -W &quot;start&quot; -- $cur) )
diff --git a/shell-completion/agetty b/shell-completion/agetty
deleted file mode 100644
index dc37a68..0000000
--- a/shell-completion/agetty
+++ /dev/null
@@ -1,70 +0,0 @@
-_agetty_module()
-{
-	local cur prev OPTS
-	COMPREPLY=3D()
-	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
-	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
-	case $prev in
-		&#39;-a&#39;|&#39;--autologin&#39;)
-			COMPREPLY=3D( $(compgen -u -- $cur) )
-			return 0
-			;;
-		&#39;-o&#39;|&#39;--issue-file&#39;|&#39;-I&#39;|&#39;--login-program&#3=
9;)
-			compopt -o filenames
-			COMPREPLY=3D( $(compgen -f -- $cur) )
-			return 0
-			;;
-		&#39;-I&#39;|&#39;--init-string&#39;|&#39;--erase-chars&#39;|&#39;--kill=
-chars&#39;)
-			compopt -o filenames
-			COMPREPLY=3D( $(compgen -W &quot;string&quot; -- $cur) )
-			return 0
-			;;
-		&#39;-o&#39;|&#39;--login-options&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;login-options&quot; -- $cur) )
-			return 0
-			;;
-		&#39;-t&#39;|&#39;--timeout&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;seconds&quot; -- $cur) )
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS=3D&quot;-8 --8bits
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
-				-V --version&quot;
-			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
-			return 0
-			;;
-	esac
-	local BAUD_RATES
-	BAUD_RATES=3D&quot;75 110 300 1200 2400 4800 9600 19200 38400 57600 11520=
0&quot;
-	COMPREPLY=3D( $(compgen -W &quot;$BAUD_RATES $(echo /dev/tty*)&quot; -- $=
cur) )
-	return 0
-}
-complete -F _agetty_module agetty
diff --git a/shell-completion/blkdiscard b/shell-completion/blkdiscard
index e907a1b..7d85bce 100644
--- a/shell-completion/blkdiscard
+++ b/shell-completion/blkdiscard
@@ -18,7 +18,7 @@ _blkdiscard_module()
 			;;
 	esac
 	local DEVS
-	DEVS=3D&quot;$(\ls -d /sys/class/block/* | sed &#39;s|/sys/class/block/|/=
dev/|g&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/blkid b/shell-completion/blkid
index dce41e0..05e337b 100644
--- a/shell-completion/blkid
+++ b/shell-completion/blkid
@@ -23,11 +23,11 @@ _blkid_module()
 			return 0
 			;;
 		&#39;-L&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;$(\ls /dev/disk/by-label/ 2&gt;/dev/nu=
ll)&quot; -- $cur) )
+			COMPREPLY=3D( $(compgen -W &quot;$(cd /dev/disk/by-label/ 2&gt;/dev/nul=
l &amp;&amp; echo *)&quot; -- $cur) )
 			return 0
 			;;
 		&#39;-U&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;$(\ls /dev/disk/by-uuid/ 2&gt;/dev/nul=
l)&quot; -- $cur) )
+			COMPREPLY=3D( $(compgen -W &quot;$(cd /dev/disk/by-uuid/ 2&gt;/dev/null=
 &amp;&amp; echo *)&quot; -- $cur) )
 			return 0
 			;;
 		&#39;-s&#39;)
@@ -55,7 +55,7 @@ _blkid_module()
 			;;
 	esac
 	local PARTITIONS
-	PARTITIONS=3D&quot;$(for I in /sys/block/*/*/partition; do IFS=3D&#39;/&#=
39;; DIR_ARR=3D($I); echo &quot;/dev/${DIR_ARR[4]}&quot;; done)&quot;
+	PARTITIONS=3D&quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#39;$2 ~ /part/ {=
print $1}&#39;)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$PARTITIONS&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/cfdisk b/shell-completion/cfdisk
index 8da32fd..3725645 100644
--- a/shell-completion/cfdisk
+++ b/shell-completion/cfdisk
@@ -25,7 +25,7 @@ _cfdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r | awk &#39;$2=
 ~ /disk/ {print &quot;/dev/&quot; $1}&#39;)&quot; -- $cur) )
+	COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#39=
;$2 ~ /disk/ {print $1}&#39;)&quot; -- $cur) )
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
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
-	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
-	case $prev in
-		&#39;-f&#39;|&#39;--full-name&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;name&quot; -- $cur) )
-			return 0
-			;;
-		&#39;-o&#39;|&#39;--office&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;office&quot; -- $cur) )
-			return 0
-			;;
-		&#39;-p&#39;|&#39;--office-phone&#39;|&#39;-h&#39;|&#39;--home-phone&#39=
;)
-			COMPREPLY=3D( $(compgen -W &quot;phone-nr&quot; -- $cur) )
-			return 0
-			;;
-	esac
 	case $cur in
 		-*)
 			OPTS=3D&quot;-f --full-name -o --office -p --office-phone -h --home-pho=
ne -u --help -v --version&quot;
diff --git a/shell-completion/chrt b/shell-completion/chrt
index 08912c9..b85775a 100644
--- a/shell-completion/chrt
+++ b/shell-completion/chrt
@@ -25,7 +25,7 @@ _chrt_module()
 			;;
 	esac
 	local PIDS
-	PIDS=3D$(\ls -d /proc/[0-9]* | sed &#39;s|/proc/||&#39;)
+	PIDS=3D$(for I in /proc/[0-9]*; do echo ${I##&quot;/proc/&quot;}; done)
 	COMPREPLY=3D( $(compgen -W &quot;$PIDS&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/delpart b/shell-completion/delpart
index 849c018..a9cd3b7 100644
--- a/shell-completion/delpart
+++ b/shell-completion/delpart
@@ -1,16 +1,17 @@
 _delpart_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
 	case $COMP_CWORD in
 		1)
 			local DEVS
-			DEVS=3D&quot;$(lsblk -o NAME,TYPE -n -r | awk &#39;$2 ~ /disk/ {print &=
quot;/dev/&quot; $1}&#39;)&quot;
+			DEVS=3D&quot;$(lsblk -o NAME,TYPE -n -p -r | awk &#39;$2 ~ /disk/ {prin=
t $1}&#39;)&quot;
 			OPTS=3D&quot;-h --help -V --version $DEVS&quot;
 			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
 			;;
 		2)
+			prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 			COMPREPLY=3D( $(compgen -W &quot;$(cat /sys/block/${prev##*/}/*/partiti=
on 2&gt;/dev/null)&quot; -- $cur) )
 			;;
 	esac
diff --git a/shell-completion/fdformat b/shell-completion/fdformat
index f7d6a8e..4ad1c3d 100644
--- a/shell-completion/fdformat
+++ b/shell-completion/fdformat
@@ -3,7 +3,7 @@ _fdformat_module()
 	local cur OPTS
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
-	DEVS=3D$(ls /dev/fd[0-9]* 2&gt;/dev/null)
+	DEVS=3D$(for I in echo /dev/fd*; do if [ -e $I ]; then echo $I; fi; done)
 	OPTS=3D&quot;-n --no-verify -h --help -V --version $DEVS&quot;
 	COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
 	return 0
diff --git a/shell-completion/fdisk b/shell-completion/fdisk
index ccf2015..a8a2a37 100644
--- a/shell-completion/fdisk
+++ b/shell-completion/fdisk
@@ -7,7 +7,7 @@ _fdisk_module()
 	case $prev in
 		&#39;-s&#39;)
 			local PARTITIONS
-			PARTITIONS=3D&quot;$(for I in /sys/block/*/*/partition; do IFS=3D&#39;/=
&#39;; DIR_ARR=3D($I); echo &quot;/dev/${DIR_ARR[4]}&quot;; done)&quot;
+			PARTITIONS=3D&quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#39;$2 ~ /part/=
 {print $1}&#39;)&quot;
 			COMPREPLY=3D( $(compgen -W &quot;$PARTITIONS&quot; -- $cur) )
 			return 0
 			;;
@@ -35,7 +35,7 @@ _fdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r | awk &#39;$2=
 ~ /disk/ {print &quot;/dev/&quot; $1}&#39;)&quot; -- $cur) )
+	COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#39=
;$2 ~ /disk/ {print $1}&#39;)&quot; -- $cur) )
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
 		&#39;-O&#39;|&#39;--options&#39;)
-			local MNT_OPTS
-			MNT_OPTS=3D$(awk &#39;{ n =3D split($4, a, &quot;,&quot;); for (i =3D 0=
; i &lt;=3D n; i++) { mnt_opts[a[i]]=3D1 } } END { for (i in mnt_opts) { pr=
int i } }&#39; /etc/mtab 2&gt;/dev/null )
-			COMPREPLY=3D( $(compgen -W &quot;$MNT_OPTS&quot; -- $cur) )
+			local MTAB_3RD I
+			declare -a TMP_ARR
+			declare -A MNT_OPTS
+			while read _ _ _ MTAB_3RD _; do
+				IFS=3D&#39;,&#39; read -ra TMP_ARR &lt;&lt;&lt;&quot;$MTAB_3RD&quot;
+				for I in ${TMP_ARR[@]}; do
+					MNT_OPTS[$I]=3D&#39;1&#39;
+				done
+			done &lt;/etc/mtab
+			COMPREPLY=3D( $(compgen -W &quot;$(echo ${!MNT_OPTS[@]})&quot; -- $cur)=
 )
 			return 0
 			;;
 		&#39;-o&#39;|&#39;--output&#39;)
diff --git a/shell-completion/fsck b/shell-completion/fsck
index c3da5f5..a8f054f 100644
--- a/shell-completion/fsck
+++ b/shell-completion/fsck
@@ -29,7 +29,7 @@ _fsck_module()
 			return 0
 			;;
 	esac
-	DEVS=3D&quot;$(lsblk -o NAME -n -r | awk &#39;{print &quot;/dev/&quot; $1=
}&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/fsck.minix b/shell-completion/fsck.minix
index f01626a..69ac714 100644
--- a/shell-completion/fsck.minix
+++ b/shell-completion/fsck.minix
@@ -3,7 +3,7 @@ _fsck.minix_module()
 	local cur OPTS DEVS
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
-	DEVS=3D&quot;$(lsblk -o NAME -n -r | awk &#39;{print &quot;/dev/&quot; $1=
}&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	OPTS=3D&quot;-l -a -r -v -s -m -f -V --version&quot;
 	COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]} $DEVS&quot; -- $cur) )
 	return 0
diff --git a/shell-completion/ionice b/shell-completion/ionice
index 3087c4a..2180718 100644
--- a/shell-completion/ionice
+++ b/shell-completion/ionice
@@ -15,7 +15,7 @@ _ionice_module()
 			;;
 		&#39;-p&#39;|&#39;--pid&#39;)
 			local PIDS
-			PIDS=3D$(\ls -d /proc/[0-9]* | sed &#39;s|/proc/||&#39;)
+			PIDS=3D$(for I in /proc/[0-9]*; do echo ${I##&quot;/proc/&quot;}; done)
 			COMPREPLY=3D( $(compgen -W &quot;$PIDS&quot; -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/ipcrm b/shell-completion/ipcrm
index 4b1024f..da9f783 100644
--- a/shell-completion/ipcrm
+++ b/shell-completion/ipcrm
@@ -36,13 +36,20 @@ _ipcrm_module()
 			return 0
 			;;
 	esac
+	case $cur in
+		&#39;=3D&#39;)
+			cur=3D${cur#=3D}
+			COMPREPLY=3D( $(compgen -W &quot;shm msg sem&quot; -- $cur) )
+			return 0
+			;;
+	esac
 	OPTS=3D&quot;	-m --shmem-id
 		-M --shmem-key
 		-q --queue-id
 		-Q --queue-key
 		-s --semaphore-id
 		-S --semaphore-key
-		-a --all
+		-a --all=3D
 		-v --verbose
 		-h --help
 		-V --version&quot;
diff --git a/shell-completion/login b/shell-completion/login
deleted file mode 100644
index c075f64..0000000
--- a/shell-completion/login
+++ /dev/null
@@ -1,27 +0,0 @@
-_login_module()
-{
-	local cur prev OPTS
-	COMPREPLY=3D()
-	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
-	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
-	case $prev in
-		&#39;-f&#39;)
-			COMPREPLY=3D( $(compgen -u -- $cur) )
-			return 0
-			;;
-		&#39;-h&#39;)
-			COMPREPLY=3D( $(compgen -A hostname -- $cur) )
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS=3D&quot;-p -f -h -H -V&quot;
-			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
-			return 0
-			;;
-	esac
-	COMPREPLY=3D( $(compgen -u -- $cur) )
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
 		&#39;-c&#39;|&#39;--set-capacity&#39;)
-			ARG=3D&quot;$(\ls /dev/loop[0-9]* 2&gt;/dev/null)&quot;
+			ARG=3D&quot;$(for I in /dev/loop[0-9]*; do if [ -e $I ]; then echo $I; =
fi; done)&quot;
 			COMPREPLY=3D( $(compgen -W &quot;$ARG&quot; -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/lsblk b/shell-completion/lsblk
index 521cead..4b5973d 100644
--- a/shell-completion/lsblk
+++ b/shell-completion/lsblk
@@ -1,12 +1,17 @@
 _lsblk_module()
 {
-	local cur prev OPTS MAJOR
+	local cur prev OPTS
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-e&#39;|&#39;--exclude&#39;|&#39;-I&#39;|&#39;--include&#39;)
-			MAJOR=3D$(\ls /sys/dev/block/ | sed &#39;s/:.*//&#39;)
+			local MAJOR I J
+			MAJOR=3D&#39;&#39;
+			for I in /sys/dev/block/*; do
+				J=3D${I##*/}
+				MAJOR=3D&quot;$MAJOR ${J%%:*}&quot;
+			done
 			# FIXME: how to append to a string with compgen?
 			compopt -o nospace
 			COMPREPLY=3D( $(compgen -W &quot;$MAJOR&quot; -S &#39;,&#39; -- $cur) )
@@ -53,7 +58,7 @@ _lsblk_module()
 			;;
 	esac
 	local DEVS
-	DEVS=3D&quot;$(\ls -d /sys/class/block/* | sed &#39;s|/sys/class/block/|/=
dev/|g&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/lscpu b/shell-completion/lscpu
index bb76d4c..38ef07b 100644
--- a/shell-completion/lscpu
+++ b/shell-completion/lscpu
@@ -1,19 +1,25 @@
 _lscpu_module()
 {
-	local cur prev OPTS
+	local cur OPTS
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
-		&#39;-e&#39;|&#39;--extended&#39;|&#39;-p&#39;|&#39;--parse&#39;)
+		&#39;--extended&#39;|&#39;=3D&#39;)
+			cur=3D${cur#=3D}
 			# FIXME: how to append to a string with compgen?
-			# FIXME: space in between option and argument is
-			# 	 a problem.
-			local OUTPUT
-			OUTPUT=3D&quot;CPU CORE SOCKET NODE BOOK CACHE
-				POLARIZATION ADDRESS CONFIGURED ONLINE&quot;
+			OPTS=3D&quot;CPU,
+				CORE,
+				SOCKET,
+				NODE,
+				BOOK,
+				CACHE,
+				POLARIZATION,
+				ADDRESS,
+				CONFIGURED,
+				ONLINE,&quot;
 			compopt -o nospace
-			COMPREPLY=3D( $(compgen -W &quot;$OUTPUT&quot; -S &#39;,&#39; -- $cur) =
)
+			COMPREPLY=3D( $(compgen -W &quot;$OPTS&quot; -- $cur) )
 			return 0
 			;;
 	esac
@@ -22,8 +28,8 @@ _lscpu_module()
 			OPTS=3D&quot;-a --all
 				-b --online
 				-c --offline
-				-e --extended
-				-p --parse
+				-e --extended=3D
+				-p --parse=3D
 				-s --sysroot
 				-x --hex
 				-h --help
diff --git a/shell-completion/mkfs b/shell-completion/mkfs
index ee6a26b..ac56841 100644
--- a/shell-completion/mkfs
+++ b/shell-completion/mkfs
@@ -6,7 +6,7 @@ _mkfs_module()
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-t&#39;|&#39;--type&#39;)
-			FSTYPES=3D$(for I in $(\ls /sbin/mkfs.* /usr/sbin/mkfs.* 2&gt;/dev/null=
); do echo ${I##*mkfs.}; done)
+			FSTYPES=3D$(for I in /sbin/mkfs.* /usr/sbin/mkfs.*; do if [ -e $I ]; th=
en echo ${I##*mkfs.}; fi; done)
 			COMPREPLY=3D( $(compgen -W &quot;$FSTYPES&quot; -- $cur) )
 			return 0
 			;;
@@ -18,7 +18,7 @@ _mkfs_module()
 			return 0
 			;;
 	esac
-	DEVS=3D&quot;$(lsblk -o NAME -n -r | awk &#39;{print &quot;/dev/&quot; $1=
}&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS /path/to/file&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkfs.bfs b/shell-completion/mkfs.bfs
index b1a226a..2d8e796 100644
--- a/shell-completion/mkfs.bfs
+++ b/shell-completion/mkfs.bfs
@@ -21,7 +21,7 @@ _bfs_module()
 			return 0
 			;;
 	esac
-	DEVS=3D&quot;$(lsblk -o NAME -n -r | awk &#39;{print &quot;/dev/&quot; $1=
}&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS /path/to/file&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/mkfs.minix b/shell-completion/mkfs.minix
index c717b3c..884a09b 100644
--- a/shell-completion/mkfs.minix
+++ b/shell-completion/mkfs.minix
@@ -26,7 +26,7 @@ _mkfs.minix_module()
 			;;
 	esac
 	local DEVS
-	DEVS=3D&quot;$(lsblk -o NAME -n -r | awk &#39;{print &quot;/dev/&quot; $1=
}&#39;)&quot;
+	DEVS=3D&quot;$(lsblk -o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS&quot; -- $cur) )
 	return 0
 }
diff --git a/shell-completion/nsenter b/shell-completion/nsenter
index f15a7f1..168f740 100644
--- a/shell-completion/nsenter
+++ b/shell-completion/nsenter
@@ -7,32 +7,29 @@ _nsenter_module()
 	case $prev in
 		&#39;-t&#39;|&#39;--target&#39;)
 			local PIDS
-			PIDS=3D$(\ls -d /proc/[0-9]* | sed &#39;s|/proc/||&#39;)
+			PIDS=3D$(for I in /proc/[0-9]*; do echo ${I##&quot;/proc/&quot;}; done)
 			COMPREPLY=3D( $(compgen -W &quot;$PIDS&quot; -- $cur) )
 			return 0
 			;;
-		&#39;-m&#39;|&#39;--mount&#39;|&#39;-u&#39;|&#39;--uts&#39;|&#39;-i&#39;=
|&#39;--net&#39;|&#39;-n&#39;|&#39;--net&#39;|&#39;-p&#39;|&#39;--pid&#39;|=
&#39;-U&#39;|&#39;--user&#39;)
-			compopt -o filenames
-			COMPREPLY=3D( $(compgen -f -- $cur) )
-			return 0
-			;;
-		&#39;-r&#39;|&#39;--root&#39;|&#39;-w&#39;|&#39;--wd&#39;)
-			compopt -o filenames
-			COMPREPLY=3D( $(compgen -o dirnames -- $cur) )
-			return 0
-			;;
 	esac
 	case $cur in
+		&#39;=3D&#39;)
+			# FIXME: --root and --wd should use get only
+			# directories as compgen output.  If $cur is
+			# overwrote the same way as below in case segment
+			# for $prev the command-line will get mangled.
+			cur=3D${cur#=3D}
+			;;
 		-*)
 			OPTS=3D&quot;-t --target
-				-m --mount
-				-u --uts
-				-i --ipc
-				-n --net
-				-p --pid
-				-U --user
-				-r --root
-				-w --wd
+				-m --mount=3D
+				-u --uts=3D
+				-i --ipc=3D
+				-n --net=3D
+				-p --pid=3D
+				-U --user=3D
+				-r --root=3D
+				-w --wd=3D
 				-F --no-fork
 				-h --help
 				-V --version&quot;
diff --git a/shell-completion/partx b/shell-completion/partx
index c558d36..8187965 100644
--- a/shell-completion/partx
+++ b/shell-completion/partx
@@ -7,7 +7,7 @@ _partx_module()
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-n&#39;|&#39;--nr&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r | awk &#39;=
$2 ~ /part/ {print &quot;/dev/&quot; $1}&#39;)&quot; -- $cur) )
+			COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#=
39;$2 ~ /part/ {print $1}&#39;)&quot; -- $cur) )
 			return 0
 			;;
 		&#39;-o&#39;|&#39;--output&#39;)
diff --git a/shell-completion/prlimit b/shell-completion/prlimit
index ee49b79..55bd13f 100644
--- a/shell-completion/prlimit
+++ b/shell-completion/prlimit
@@ -6,7 +6,7 @@ _prlimit_module()
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-p&#39;|&#39;--pid&#39;)
-			PIDS=3D$(\ls -d /proc/[0-9]* | sed &#39;s|/proc/||&#39;)
+			PIDS=3D$(for I in /proc/[0-9]*; do echo ${I##&quot;/proc/&quot;}; done)
 			COMPREPLY=3D( $(compgen -W &quot;$PIDS&quot; -- $cur) )
 			return 0
 			;;
@@ -20,6 +20,11 @@ _prlimit_module()
 			;;
 	esac
 	case $cur in
+		&#39;=3D&#39;)
+			cur=3D${cur#=3D}
+			# FIXME: is there anything what could be printed
+			# as limit value(s)
+			;;
 		-*)
 			OPTS=3D&quot;-p --pid
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
+				-c --core=3D
+				-d --data=3D
+				-e --nice=3D
+				-f --fsize=3D
+				-i --sigpending=3D
+				-l --memlock=3D
+				-m --rss=3D
+				-n --nofile=3D
+				-q --msgqueue=3D
+				-r --rtprio=3D
+				-s --stack=3D
+				-t --cpu=3D
+				-u --nproc=3D
+				-v --as=3D
+				-x --locks=3D
 				-y --rttime&quot;
 			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
 			return 0
diff --git a/shell-completion/raw b/shell-completion/raw
index 41e03f2..27f0354 100644
--- a/shell-completion/raw
+++ b/shell-completion/raw
@@ -11,7 +11,7 @@ _raw_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=3D( $(compgen -W &quot;$(ls 2&gt;/dev/null /dev/raw/*)&quot; --=
 $cur) )
+	COMPREPLY=3D( $(compgen -W &quot;$(for I in /dev/raw/*; do if [ -e $I ]; =
then echo $I; fi; done)&quot; -- $cur) )
 	return 0
 }
 complete -F _raw_module raw
diff --git a/shell-completion/renice b/shell-completion/renice
index bc80dac..aba00d7 100644
--- a/shell-completion/renice
+++ b/shell-completion/renice
@@ -17,7 +17,7 @@ _renice_module()
 			;;
 		&#39;-p&#39;|&#39;--pid&#39;)
 			local PIDS
-			PIDS=3D$(\ls -d /proc/[0-9]* | sed &#39;s|/proc/||&#39;)
+			PIDS=3D$(for I in /proc/[0-9]*; do echo ${I##&quot;/proc/&quot;}; done)
 			COMPREPLY=3D( $(compgen -W &quot;$PIDS&quot; -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/resizepart b/shell-completion/resizepart
index 827638a..cdd76d0 100644
--- a/shell-completion/resizepart
+++ b/shell-completion/resizepart
@@ -1,16 +1,17 @@
 _resizepart_module()
 {
-	local cur OPTS
+	local cur prev OPTS
 	COMPREPLY=3D()
 	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
 	case $COMP_CWORD in
 		1)
 			local DEVS
-			DEVS=3D&quot;$(lsblk -o NAME,TYPE -n -r | awk &#39;$2 ~ /disk/ {print &=
quot;/dev/&quot; $1}&#39;)&quot;
+			DEVS=3D&quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#39;$2 ~ /disk/ {prin=
t $1}&#39;)&quot;
 			OPTS=3D&quot;-h --help -V --version $DEVS&quot;
 			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
 			;;
 		2)
+			prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 			COMPREPLY=3D( $(compgen -W &quot;$(cat /sys/block/${prev##*/}/*/partiti=
on 2&gt;/dev/null)&quot; -- $cur) )
 			;;
 		3)
diff --git a/shell-completion/rtcwake b/shell-completion/rtcwake
index 2010a52..1f38df8 100644
--- a/shell-completion/rtcwake
+++ b/shell-completion/rtcwake
@@ -7,7 +7,7 @@ _rtcwake_module()
 	case $prev in
 		&#39;-d&#39;|&#39;--device&#39;)
 			local RTC_DEVS
-			RTC_DEVS=3D$(\ls /sys/class/rtc/ 2&gt;/dev/null)
+			RTC_DEVS=3D$(cd /sys/class/rtc/ &amp;&amp; echo *)
 			COMPREPLY=3D( $(compgen -W &quot;$RTC_DEVS&quot; -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/script b/shell-completion/script
index fb6c106..e58dbd8 100644
--- a/shell-completion/script
+++ b/shell-completion/script
@@ -10,13 +10,11 @@ _script_module()
 			COMPREPLY=3D( $(compgen -c -- $cur) )
 			return 0
 			;;
-		&#39;-t&#39;|&#39;--timing&#39;)
-			compopt -o filenames
-			COMPREPLY=3D( $(compgen -f -- $cur) )
-			return 0
-			;;
 	esac
 	case $cur in
+		&#39;=3D&#39;)
+			cur=3D${cur#=3D}
+			;;
 		-*)
 			OPTS=3D&quot;-a --append
 				-c --command
@@ -24,7 +22,7 @@ _script_module()
 				-f --flush
 				   --force
 				-q --quiet
-				-t --timing
+				-t --timing=3D
 				-V --version
 				-h --help&quot;
 			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
diff --git a/shell-completion/setterm b/shell-completion/setterm
index a0dff44..33d2e56 100644
--- a/shell-completion/setterm
+++ b/shell-completion/setterm
@@ -6,8 +6,12 @@ _setterm_module()
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-term&#39;)
-			# FIXME: terminal type list would be nice
-			COMPREPLY=3D( $(compgen -W &quot;vt100 xterm linux screen etc&quot; -- =
$cur) )
+			local TERM_LIST I
+			TERM_LIST=3D&#39;&#39;
+			for I in /usr/share/terminfo/?/*; do
+				TERM_LIST+=3D&quot;${I##*/} &quot;
+			done
+			COMPREPLY=3D( $(compgen -W &quot;$TERM_LIST&quot; -- $cur) )
 			return 0
 			;;
 		&#39;-foreground&#39;|&#39;-background&#39;|&#39;-ulcolor&#39;|&#39;-hbc=
olor&#39;)
@@ -36,8 +40,8 @@ _setterm_module()
 			;;
 		&#39;-dump&#39;|&#39;-append&#39;)
 			local NUM_CONS
-			NUM_CONS=3D$(ls /sys/class/tty | wc -l)
-			COMPREPLY=3D( $(compgen -W &quot;$(echo {1..$NUM_CONS})&quot; -- $cur) =
)
+			NUM_CONS=3D(/sys/class/tty/*)
+			COMPREPLY=3D( $(compgen -W &quot;$(echo {1..${#NUM_CONS[*]}})&quot; -- =
$cur) )
 			return 0
 			;;
 		&#39;-file&#39;)
diff --git a/shell-completion/sfdisk b/shell-completion/sfdisk
index 041ce55..835ecd2 100644
--- a/shell-completion/sfdisk
+++ b/shell-completion/sfdisk
@@ -20,6 +20,9 @@ _sfdisk_module()
 			;;
 	esac
 	case $cur in
+		&#39;=3D&#39;)
+			cur=3D${cur#=3D}
+			;;
 		-*)
 			OPTS=3D&quot;-s --show-size
 				-c --id
@@ -47,8 +50,8 @@ _sfdisk_module()
 				-L --Linux
 				-g --show-geometry
 				-G --show-pt-geometry
-				-A --activate
-				-U --unhide
+				-A --activate=3D
+				-U --unhide=3D
 				-x --show-extended
 				--leave-last
 				--IBM
@@ -66,7 +69,7 @@ _sfdisk_module()
 			return 0
 			;;
 	esac
-	COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r | awk &#39;$2=
 ~ /disk/ {print &quot;/dev/&quot; $1}&#39;)&quot; -- $cur) )
+	COMPREPLY=3D( $(compgen -W &quot;$(lsblk -o NAME,TYPE -n -r -p | awk &#39=
;$2 ~ /disk/ {print $1}&#39;)&quot; -- $cur) )
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
-			OPTS=3D&quot;	-u --user
+			OPTS=3D&quot;	-
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
-	COMPREPLY=3D()
-	cur=3D&quot;${COMP_WORDS[COMP_CWORD]}&quot;
-	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
-	case $prev in
-		&#39;-t&#39;|&#39;--timeout&#39;)
-			COMPREPLY=3D( $(compgen -W &quot;seconds&quot; -- $cur) )
-			return 0
-			;;
-	esac
-	case $cur in
-		-*)
-			OPTS=3D&quot;-p --login-shell -t --timeout -V --version -h --help&quot;
-			COMPREPLY=3D( $(compgen -W &quot;${OPTS[*]}&quot; -- $cur) )
-			return 0
-			;;
-	esac
-	compopt -o filenames
-	COMPREPLY=3D( $(compgen -f -- ${cur:-&quot;/dev/tty&quot;}) )
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
-			PIDS=3D$(\ls -d /proc/[0-9]* | sed &#39;s|/proc/||&#39;)
+			PIDS=3D$(for I in /proc/[0-9]*; do echo ${I##&quot;/proc/&quot;}; done)
 			COMPREPLY=3D( $(compgen -W &quot;$PIDS&quot; -- $cur) )
 			return 0
 			;;
diff --git a/shell-completion/ul b/shell-completion/ul
index 89e2800..07d0731 100644
--- a/shell-completion/ul
+++ b/shell-completion/ul
@@ -6,8 +6,12 @@ _ul_module()
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-t&#39;|&#39;--terminal&#39;)
-			# FIXME: terminal type list would be nice
-			COMPREPLY=3D( $(compgen -W &quot;vt100 xterm linux screen etc&quot; -- =
$cur) )
+			local TERM_LIST I
+			TERM_LIST=3D&#39;&#39;
+			for I in /usr/share/terminfo/?/*; do
+				TERM_LIST+=3D&quot;${I##*/} &quot;
+			done
+			COMPREPLY=3D( $(compgen -W &quot;$TERM_LIST&quot; -- $cur) )
 			return 0
 			;;
 	esac
diff --git a/shell-completion/wdctl b/shell-completion/wdctl
index 6a85e0a..42889ac 100644
--- a/shell-completion/wdctl
+++ b/shell-completion/wdctl
@@ -6,8 +6,20 @@ _wdctl_module()
 	prev=3D&quot;${COMP_WORDS[COMP_CWORD-1]}&quot;
 	case $prev in
 		&#39;-f&#39;|&#39;--flags&#39;)
-			# FIXME: how to get flag list?
-			COMPREPLY=3D( $(compgen -W &quot;flags&quot; -- $cur) )
+			local FLAGS
+			FLAGS=3D&quot;ALARMONLY
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
+				SETTIMEOUT&quot;
+			COMPREPLY=3D( $(compgen -W &quot;$FLAGS&quot; -- $cur) )
 			return 0
 			;;
 		&#39;-o&#39;|&#39;--output&#39;)
diff --git a/shell-completion/wipefs b/shell-completion/wipefs
index 427f47b..52c25b4 100644
--- a/shell-completion/wipefs
+++ b/shell-completion/wipefs
@@ -11,13 +11,7 @@ _wipefs_module()
 			;;
 		&#39;-t&#39;|&#39;--types&#39;)
 			local TYPES
-			TYPES=3D&quot;adfs affs autofs cifs coda coherent cramfs
-				debugfs devpts efs ext ext2 ext3 ext4 hfs
-				hfsplus hpfs iso9660 jfs minix msdos
-				ncpfs nfs nfs4 ntfs proc qnx4 ramfs
-				reiserfs romfs squashfs smbfs sysv tmpfs
-				ubifs udf ufs umsdos usbfs vfat xenix xfs
-				xiafs&quot;
+			TYPES=3D&quot;$(blkid -k)&quot;
 			COMPREPLY=3D( $(compgen -W &quot;$TYPES&quot; -- $cur) )
 			return 0
 			;;
@@ -31,7 +25,7 @@ _wipefs_module()
 			;;
 	esac
 	local DEVS
-	DEVS=3D&quot;$(\ls -d /sys/class/block/* | sed &#39;s|/sys/class/block/|/=
dev/|g&#39;)&quot;
+	DEVS=3D&quot;$(lsblk-o NAME -n -r -p)&quot;
 	COMPREPLY=3D( $(compgen -W &quot;$DEVS&quot; -- $cur) )
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
-			local TERMS=3D$(for I in $(\ls /sys/class/tty 2&gt;/dev/null); do echo =
&quot;/dev/$I&quot;; done)
+			local I TERMS=3D&#39;&#39;
+			for I in /sys/class/tty/*; do
+				TERMS+=3D&quot;/dev${I##/sys/class/tty} &quot;
+			done
 			COMPREPLY=3D( $(compgen -W &quot;$TERMS&quot; -- $cur) )
 			return 0
 			;;
</pre>-- <br>=A0=A0 Sami Kerola<br>=A0=A0 <a href=3D"http://www.iki.fi/kero=
lasa/" target=3D"_blank">http://www.iki.fi/kerolasa/</a>
</div></div>

--20cf307f3626f34ac904d9412832--
