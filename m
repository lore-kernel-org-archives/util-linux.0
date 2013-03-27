Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:48457 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C0WIX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:23 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so970368wgh.17
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/10] bash-completion: sys-utils
Date: Wed, 27 Mar 2013 22:07:49 +0000
Message-Id: <1364422072-23552-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 shell-completion/blkdiscard  | 25 ++++++++++++++
 shell-completion/chcpu       | 44 ++++++++++++++++++++++++
 shell-completion/ctrlaltdel  | 11 ++++++
 shell-completion/cytune      | 37 ++++++++++++++++++++
 shell-completion/dmesg       | 53 ++++++++++++++++++++++++++++
 shell-completion/eject       | 61 ++++++++++++++++++++++++++++++++
 shell-completion/fallocate   | 24 +++++++++++++
 shell-completion/flock       | 42 +++++++++++++++++++++++
 shell-completion/fsfreeze    | 18 ++++++++++
 shell-completion/fstrim      | 25 ++++++++++++++
 shell-completion/hwclock     | 53 ++++++++++++++++++++++++++++
 shell-completion/ipcrm       | 52 ++++++++++++++++++++++++++++
 shell-completion/ipcs        | 30 ++++++++++++++++
 shell-completion/ldattach    | 54 +++++++++++++++++++++++++++++
 shell-completion/losetup     | 64 ++++++++++++++++++++++++++++++++++
 shell-completion/lscpu       | 39 +++++++++++++++++++++
 shell-completion/mountpoint  | 24 +++++++++++++
 shell-completion/nsenter     | 47 +++++++++++++++++++++++++
 shell-completion/pivot_root  | 14 ++++++++
 shell-completion/prlimit     | 55 +++++++++++++++++++++++++++++
 shell-completion/readprofile | 33 ++++++++++++++++++
 shell-completion/renice      | 38 ++++++++++++++++++++
 shell-completion/rtcwake     | 40 +++++++++++++++++++++
 shell-completion/setarch     | 42 +++++++++++++++++++++++
 shell-completion/setpriv     | 82 ++++++++++++++++++++++++++++++++++++++++++++
 shell-completion/setsid      | 17 +++++++++
 shell-completion/swapon      | 48 ++++++++++++++++++++++++++
 shell-completion/tunelp      | 48 ++++++++++++++++++++++++++
 shell-completion/unshare     | 24 +++++++++++++
 shell-completion/wdctl       | 48 ++++++++++++++++++++++++++
 30 files changed, 1192 insertions(+)
 create mode 100644 shell-completion/blkdiscard
 create mode 100644 shell-completion/chcpu
 create mode 100644 shell-completion/ctrlaltdel
 create mode 100644 shell-completion/cytune
 create mode 100644 shell-completion/dmesg
 create mode 100644 shell-completion/eject
 create mode 100644 shell-completion/fallocate
 create mode 100644 shell-completion/flock
 create mode 100644 shell-completion/fsfreeze
 create mode 100644 shell-completion/fstrim
 create mode 100644 shell-completion/hwclock
 create mode 100644 shell-completion/ipcrm
 create mode 100644 shell-completion/ipcs
 create mode 100644 shell-completion/ldattach
 create mode 100644 shell-completion/losetup
 create mode 100644 shell-completion/lscpu
 create mode 100644 shell-completion/mountpoint
 create mode 100644 shell-completion/nsenter
 create mode 100644 shell-completion/pivot_root
 create mode 100644 shell-completion/prlimit
 create mode 100644 shell-completion/readprofile
 create mode 100644 shell-completion/renice
 create mode 100644 shell-completion/rtcwake
 create mode 100644 shell-completion/setarch
 create mode 100644 shell-completion/setpriv
 create mode 100644 shell-completion/setsid
 create mode 100644 shell-completion/swapon
 create mode 100644 shell-completion/tunelp
 create mode 100644 shell-completion/unshare
 create mode 100644 shell-completion/wdctl

diff --git a/shell-completion/blkdiscard b/shell-completion/blkdiscard
new file mode 100644
index 0000000..e907a1b
--- /dev/null
+++ b/shell-completion/blkdiscard
@@ -0,0 +1,25 @@
+_blkdiscard_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-o'|'--offset'|'-l'|'--length')
+			COMPREPLY=( $(compgen -W "num" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-o --offset -l --length -s --secure -v --verbose -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local DEVS
+	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
+	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
+	return 0
+}
+complete -F _blkdiscard_module blkdiscard
diff --git a/shell-completion/chcpu b/shell-completion/chcpu
new file mode 100644
index 0000000..19386e2
--- /dev/null
+++ b/shell-completion/chcpu
@@ -0,0 +1,44 @@
+_chcpu_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-e'|'--enable')
+			local CPULIST
+			# FIXME: will propose only binding to a cpu.
+			# Maybe this should add comma, and continue?
+			CPULIST=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/offline)
+			COMPREPLY=( $(compgen -W "$(eval echo $CPULIST)" -- $cur) )
+			return 0
+			;;
+		'-d'|'--disable')
+			local CPULIST
+			# FIXME: will propose only binding to a cpu.
+			# Maybe this should add comma, and continue?
+			CPULIST=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
+			COMPREPLY=( $(compgen -W "$(eval echo $CPULIST)" -- $cur) )
+			return 0
+			;;
+		'-c'|'--configure'|'-g'|'--deconfigure')
+			COMPREPLY=( $(compgen -W "cpu-list" -- $cur) )
+			return 0
+			;;
+		'-p'|'--dispatch')
+			COMPREPLY=( $(compgen -W "horizontal vertical" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-h --help
+		-e --enable
+		-d --disable
+		-c --configure
+		-g --deconfigure
+		-p --dispatch
+		-r --rescan
+		-V --version"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _chcpu_module chcpu
diff --git a/shell-completion/ctrlaltdel b/shell-completion/ctrlaltdel
new file mode 100644
index 0000000..e725752
--- /dev/null
+++ b/shell-completion/ctrlaltdel
@@ -0,0 +1,11 @@
+_ctrlaltdel_module()
+{
+	local cur
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=()
+	if [ $COMP_CWORD -eq 1 ]; then
+		COMPREPLY=( $(compgen -W "hard soft" -- $cur) )
+	fi
+	return 0
+}
+complete -F _ctrlaltdel_module ctrlaltdel
diff --git a/shell-completion/cytune b/shell-completion/cytune
new file mode 100644
index 0000000..9a90d34
--- /dev/null
+++ b/shell-completion/cytune
@@ -0,0 +1,37 @@
+_cytune_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-s'|'--set-threshold'|'-S'|'--set-default-threshold'|'-t'|'--set-flush'|'-T'|'--set-default-flush')
+			COMPREPLY=( $(compgen -W "num" -- $cur) )
+			return 0
+			;;
+		'-i'|'--interval')
+			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-s --set-threshold
+				-g --get-threshold
+				-S --set-default-threshold
+				-t --set-flush
+				-G --get-glush
+				-T --set-default-flush
+				-q --stats
+				-i --interval
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/tty"}) )
+	return 0
+}
+complete -F _cytune_module cytune
diff --git a/shell-completion/dmesg b/shell-completion/dmesg
new file mode 100644
index 0000000..18ee59f
--- /dev/null
+++ b/shell-completion/dmesg
@@ -0,0 +1,53 @@
+_dmesg_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-F'|'--file')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-f'|'--facility')
+			COMPREPLY=( $(compgen -W "kern user mail daemon auth syslog lpr news" -- $cur) )
+			return 0
+			;;
+		'-l'|'--level'|'-n'|'--console-level')
+			COMPREPLY=( $(compgen -W "emerg alert crit err warn notice info debug" -- $cur) )
+			return 0
+			;;
+		'-s'|'--buffer-size')
+			COMPREPLY=( $(compgen -W "size" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-C --clear
+		-c --read-clear
+		-D --console-off
+		-d --show-delta
+		-e --reltime
+		-E --console-on
+		-F --file
+		-f --facility
+		-H --human
+		-k --kernel
+		-L --color
+		-l --level
+		-n --console-level
+		-P --nopager
+		-r --raw
+		-S --syslog
+		-s --buffer-size
+		-T --ctime
+		-t --notime
+		-u --userspace
+		-w --follow
+		-x --decode
+		-h --help
+		-V --version"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _dmesg_module dmesg
diff --git a/shell-completion/eject b/shell-completion/eject
new file mode 100644
index 0000000..b767e81
--- /dev/null
+++ b/shell-completion/eject
@@ -0,0 +1,61 @@
+_eject_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-a'|'--auto'|'-i'|'--manualeject')
+			COMPREPLY=( $(compgen -W "off on" -- $cur) )
+			return 0
+			;;
+		'-c'|'--changerslot')
+			# FIXME: there must be way to determine slots
+			COMPREPLY=( $(compgen -W "slot" -- $cur) )
+			return 0
+			;;
+		'-x'|'--cdspeed')
+			COMPREPLY=( $(compgen -W "$(eject -X)" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a --auto
+			-c --changerslot
+			-d --default
+			-f --floppy
+			-F --force
+			-i --manualeject
+			-m --no-unmount
+			-M --no-partitions-unmount
+			-n --noop
+			-p --proc
+			-q --tape
+			-r --cdrom
+			-s --scsi
+			-t --trayclose
+			-T --traytoggle
+			-v --verbose
+			-x --cdspeed
+			-X --listspeed
+			-h --help
+			-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local DEVS
+	DEVS="$(for I in /sys/class/block/*/removable; do
+		if [ $(cat $I) -ne 0 ]; then
+			OLD_IFS=$IFS
+			IFS='/';
+			ARR=($I)
+			echo "/dev/${ARR[4]}"
+			IFS=$OLD_IFS
+		fi
+	done)"
+	COMPREPLY=( $(compgen -W "$DEVS" $cur) )
+	return 0
+}
+complete -F _eject_module eject
diff --git a/shell-completion/fallocate b/shell-completion/fallocate
new file mode 100644
index 0000000..132858c
--- /dev/null
+++ b/shell-completion/fallocate
@@ -0,0 +1,24 @@
+_fallocate_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-o'|'--offset'|'-l'|'--length')
+			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-n --keep-size -p --punch-hole -o --offset -l --length -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _fallocate_module fallocate
diff --git a/shell-completion/flock b/shell-completion/flock
new file mode 100644
index 0000000..cfa9b66
--- /dev/null
+++ b/shell-completion/flock
@@ -0,0 +1,42 @@
+_flock_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-w'|'--timeout')
+			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
+			return 0
+			;;
+		'-E'|'--conflict-exit-code')
+			COMPREPLY=( $(compgen -W "$(echo {0..255})" -- $cur) )
+			return 0
+			;;
+		'-c'|'--command')
+			compopt -o bashdefault
+			COMPREPLY=( $(compgen -c -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-s --shared
+				-x --exclusive
+				-u --unlock
+				-n --nonblock
+				-w --timeout
+				-E --conflict-exit-code
+				-o --close
+				-c --command
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/"}) )
+	return 0
+}
+complete -F _flock_module flock
diff --git a/shell-completion/fsfreeze b/shell-completion/fsfreeze
new file mode 100644
index 0000000..7933c15
--- /dev/null
+++ b/shell-completion/fsfreeze
@@ -0,0 +1,18 @@
+_fsfreeze_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-f --freeze -u --unfreeze -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local MPOINT
+	MPOINT="$(findmnt -t ext2,ext3,ext4,reiserfs,jfs,xfs -o TARGET -n -r)"
+	COMPREPLY=( $(compgen -W "$MPOINT" -- $cur) )
+	return 0
+}
+complete -F _fsfreeze_module fsfreeze
diff --git a/shell-completion/fstrim b/shell-completion/fstrim
new file mode 100644
index 0000000..87cb050
--- /dev/null
+++ b/shell-completion/fstrim
@@ -0,0 +1,25 @@
+_fstrim_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-o'|'--offset'|'-l'|'--length'|'-m'|'--minimum')
+			COMPREPLY=( $(compgen -W "num" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-o --offset -l --length -m --minimum -v --verbose -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local MPOINTS
+	MPOINTS=$(awk '{if ($1 ~ /^\//){print $2}}' /etc/mtab 2>/dev/null)
+	COMPREPLY=( $(compgen -W "$MPOINTS" -- $cur) )
+	return 0
+}
+complete -F _fstrim_module fstrim
diff --git a/shell-completion/hwclock b/shell-completion/hwclock
new file mode 100644
index 0000000..855e885
--- /dev/null
+++ b/shell-completion/hwclock
@@ -0,0 +1,53 @@
+_hwclock_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-f'|'--rtc'|'--adjfile')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'--date')
+			COMPREPLY=( $(compgen -W "date" -- $cur) )
+			return 0
+			;;
+		'--epoch')
+			COMPREPLY=( $(compgen -W "year" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-h --help
+				-r --show
+				   --set
+				-s --hctosys
+				-w --systohc
+				   --systz
+				   --adjust
+				-c --compare
+				   --getepoch
+				   --setepoch
+				   --predict
+				-V --version
+				-u --utc
+				   --localtime
+				-f --rtc
+				   --directisa
+				   --badyear
+				   --date
+				   --epoch
+				   --noadjfile
+				   --adjfile
+				   --test
+				-D --debug"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	return 0
+}
+complete -F _hwclock_module hwclock
diff --git a/shell-completion/ipcrm b/shell-completion/ipcrm
new file mode 100644
index 0000000..4b1024f
--- /dev/null
+++ b/shell-completion/ipcrm
@@ -0,0 +1,52 @@
+_ipcrm_module()
+{
+	local cur prev OPTS KEYIDS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-m'|'--shmem-id')
+			KEYIDS="$(ipcs -m | awk '{if (3 < NR) {print $2}}')"
+			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
+			return 0
+			;;
+		'-M'|'--shmem-key')
+			KEYIDS="$(ipcs -m | awk '{if (3 < NR) {print $1}}')"
+			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
+			return 0
+			;;
+		'-q'|'--queue-id')
+			KEYIDS="$(ipcs -q | awk '{if (3 < NR) {print $2}}')"
+			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
+			return 0
+			;;
+		'-Q'|'--queue-key')
+			KEYIDS="$(ipcs -q | awk '{if (3 < NR) {print $1}}')"
+			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
+			return 0
+			;;
+		'-s'|'--semaphore-id')
+			KEYIDS="$(ipcs -s | awk '{if (3 < NR) {print $2}}')"
+			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
+			return 0
+			;;
+		'-S'|'--semaphore-key')
+			KEYIDS="$(ipcs -s | awk '{if (3 < NR) {print $1}}')"
+			COMPREPLY=( $(compgen -W "$KEYIDS" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="	-m --shmem-id
+		-M --shmem-key
+		-q --queue-id
+		-Q --queue-key
+		-s --semaphore-id
+		-S --semaphore-key
+		-a --all
+		-v --verbose
+		-h --help
+		-V --version"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _ipcrm_module ipcrm
diff --git a/shell-completion/ipcs b/shell-completion/ipcs
new file mode 100644
index 0000000..51502bb
--- /dev/null
+++ b/shell-completion/ipcs
@@ -0,0 +1,30 @@
+_ipcs_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-i'|'--id')
+			COMPREPLY=( $(compgen -W "id" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-i --id
+		-h --help
+		-V --version
+		-m --shmems
+		-q --queues
+		-s --semaphores
+		-a --all
+		-t --time
+		-p --pid
+		-c --creator
+		-l --limits
+		-u --summary
+		   --human
+		-b --bytes"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _ipcs_module ipcs
diff --git a/shell-completion/ldattach b/shell-completion/ldattach
new file mode 100644
index 0000000..dc83dfc
--- /dev/null
+++ b/shell-completion/ldattach
@@ -0,0 +1,54 @@
+_ldattach_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-s'|'--speed')
+			COMPREPLY=( $(compgen -W "speed" -- $cur) )
+			return 0
+			;;
+		'-i'|'--iflag')
+			local IFLAGS
+			IFLAGS="BRKINT ICRNL IGNBRK IGNCR IGNPAR IMAXBEL
+				INLCR INPCK ISTRIP IUCLC IUTF8 IXANY
+				IXOFF IXON PARMRK
+				-BRKINT -ICRNL -IGNBRK -IGNCR -IGNPAR -IMAXBEL
+				-INLCR -INPCK -ISTRIP -IUCLC -IUTF8 -IXANY
+				-IXOFF -IXON -PARMRK"
+			COMPREPLY=( $(compgen -W "$IFLAGS" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-d --debug
+				-s --speed
+				-7 --sevenbits
+				-8 --eightbits
+				-n --noparity
+				-e --evenparity
+				-o --oddparity
+				-1 --onestopbit
+				-2 --twostopbits
+				-i --iflag
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+		/*)
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+	esac
+	local LDISC_DEVICE
+	LDISC_DEVICE="6PACK AX25 GIGASET GIGASET_M101 HCI HDLC IRDA M101
+			MOUSE PPP PPS R3964 SLIP STRIP SYNCPPP SYNC_PPP
+			TTY X25 /dev/"
+	COMPREPLY=( $(compgen -W "$LDISC_DEVICE" -- $cur) )
+	return 0
+}
+complete -F _ldattach_module ldattach
diff --git a/shell-completion/losetup b/shell-completion/losetup
new file mode 100644
index 0000000..b21f05d
--- /dev/null
+++ b/shell-completion/losetup
@@ -0,0 +1,64 @@
+_losetup_module()
+{
+	local cur prev OPTS ARG
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-d'|'--detach')
+			ARG="$(losetup --output NAME | awk '{if (1 < NR) {print}}')"
+			COMPREPLY=( $(compgen -W "$ARG" -- $cur) )
+			return 0
+			;;
+		'-j'|'--associated')
+			ARG="$(losetup --output BACK-FILE | awk '{if (1 < NR) {print}}')"
+			COMPREPLY=( $(compgen -W "$ARG" -- $cur) )
+			return 0
+			;;
+		'-c'|'--set-capacity')
+			ARG="$(\ls /dev/loop[0-9]* 2>/dev/null)"
+			COMPREPLY=( $(compgen -W "$ARG" -- $cur) )
+			return 0
+			;;
+		'-o'|'--offset'|'--sizelimit')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+		'-O'|'--output')
+			# FIXME: how to append to a string with compgen?
+			local OUTPUT
+			OUTPUT="NAME AUTOCLEAR BACK-FILE BACK-INO
+				BACK-MAJ:MIN MAJ:MIN OFFSET PARTSCAN RO
+				SIZELIMIT"
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a --all
+				-d --detach
+				-D --detach-all
+				-f --find
+				-c --set-capacity
+				-j --associated
+				-l --list
+				-o --offset
+				-O --output
+				   --sizelimit
+				-P --partscan
+				-r --read-only
+				   --show
+				-v --verbose
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _losetup_module losetup
diff --git a/shell-completion/lscpu b/shell-completion/lscpu
new file mode 100644
index 0000000..bb76d4c
--- /dev/null
+++ b/shell-completion/lscpu
@@ -0,0 +1,39 @@
+_lscpu_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-e'|'--extended'|'-p'|'--parse')
+			# FIXME: how to append to a string with compgen?
+			# FIXME: space in between option and argument is
+			# 	 a problem.
+			local OUTPUT
+			OUTPUT="CPU CORE SOCKET NODE BOOK CACHE
+				POLARIZATION ADDRESS CONFIGURED ONLINE"
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a --all
+				-b --online
+				-c --offline
+				-e --extended
+				-p --parse
+				-s --sysroot
+				-x --hex
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _lscpu_module lscpu
diff --git a/shell-completion/mountpoint b/shell-completion/mountpoint
new file mode 100644
index 0000000..e2f1d56
--- /dev/null
+++ b/shell-completion/mountpoint
@@ -0,0 +1,24 @@
+_mountpoint_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-f'|'--fixme')
+			COMPREPLY=( $(compgen -W "fixme" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-q --quiet -d --fs-devno -x --devno -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/"}) )
+	return 0
+}
+complete -F _mountpoint_module mountpoint
diff --git a/shell-completion/nsenter b/shell-completion/nsenter
new file mode 100644
index 0000000..f15a7f1
--- /dev/null
+++ b/shell-completion/nsenter
@@ -0,0 +1,47 @@
+_nsenter_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-t'|'--target')
+			local PIDS
+			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+			return 0
+			;;
+		'-m'|'--mount'|'-u'|'--uts'|'-i'|'--net'|'-n'|'--net'|'-p'|'--pid'|'-U'|'--user')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-r'|'--root'|'-w'|'--wd')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -o dirnames -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-t --target
+				-m --mount
+				-u --uts
+				-i --ipc
+				-n --net
+				-p --pid
+				-U --user
+				-r --root
+				-w --wd
+				-F --no-fork
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _nsenter_module nsenter
diff --git a/shell-completion/pivot_root b/shell-completion/pivot_root
new file mode 100644
index 0000000..54f1734
--- /dev/null
+++ b/shell-completion/pivot_root
@@ -0,0 +1,14 @@
+_pivot_root_module()
+{
+	local cur
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $COMP_CWORD in
+		1|2)
+			compopt -o filenames
+			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/"}) )
+			;;
+	esac
+	return 0
+}
+complete -F _pivot_root_module pivot_root
diff --git a/shell-completion/prlimit b/shell-completion/prlimit
new file mode 100644
index 0000000..ee49b79
--- /dev/null
+++ b/shell-completion/prlimit
@@ -0,0 +1,55 @@
+_prlimit_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-p'|'--pid')
+			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+			return 0
+			;;
+		'-o'|'--output')
+			# FIXME: how to append to a string with compgen?
+			local OUTPUT
+			OUTPUT="DESCRIPTION RESOURCE SOFT HARD UNITS"
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-p --pid
+				-o --output
+				   --noheadings
+				   --raw
+				   --verbose
+				-h --help
+				-V --version
+				-c --core
+				-d --data
+				-e --nice
+				-f --fsize
+				-i --sigpending
+				-l --memlock
+				-m --rss
+				-n --nofile
+				-q --msgqueue
+				-r --rtprio
+				-s --stack
+				-t --cpu
+				-u --nproc
+				-v --as
+				-x --locks
+				-y --rttime"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _prlimit_module prlimit
diff --git a/shell-completion/readprofile b/shell-completion/readprofile
new file mode 100644
index 0000000..c1eb514
--- /dev/null
+++ b/shell-completion/readprofile
@@ -0,0 +1,33 @@
+_readprofile_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-m'|'--mapfile'|'-p'|'--profile')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-M'|'--multiplier')
+			COMPREPLY=( $(compgen -W "multiplier" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-m --mapfile
+		-p --profile
+		-M --multiplier
+		-i --info
+		-v --verbose
+		-a --all
+		-b --histbin
+		-s --counters
+		-r --reset
+		-n --no-auto
+		-h --help
+		-V --version"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _readprofile_module readprofile
diff --git a/shell-completion/renice b/shell-completion/renice
new file mode 100644
index 0000000..bc80dac
--- /dev/null
+++ b/shell-completion/renice
@@ -0,0 +1,38 @@
+_renice_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-g'|'--pgrp')
+			local PGRP
+			PGRP=$(ps -ax -opgrp | sed '1d')
+			COMPREPLY=( $(compgen -W "$PGRP" -- $cur) )
+			return 0
+			;;
+		'-n'|'--priority')
+			COMPREPLY=( $(compgen -W "$(echo {-20..20})" -- $cur) )
+			return 0
+			;;
+		'-p'|'--pid')
+			local PIDS
+			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+			return 0
+			;;
+		'-u'|'--user')
+			COMPREPLY=( $(compgen -u -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-g --pgrp
+		-n --priority
+		-p --pid
+		-u --user
+		-h --help
+		-V --version"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _renice_module renice
diff --git a/shell-completion/rtcwake b/shell-completion/rtcwake
new file mode 100644
index 0000000..2010a52
--- /dev/null
+++ b/shell-completion/rtcwake
@@ -0,0 +1,40 @@
+_rtcwake_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-d'|'--device')
+			local RTC_DEVS
+			RTC_DEVS=$(\ls /sys/class/rtc/ 2>/dev/null)
+			COMPREPLY=( $(compgen -W "$RTC_DEVS" -- $cur) )
+			return 0
+			;;
+		'-m'|'--mode')
+			COMPREPLY=( $(compgen -W "standby mem disk off no on disable show" -- $cur) )
+			return 0
+			;;
+		'-s'|'--seconds')
+			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
+			return 0
+			;;
+		'-t'|'--time')
+			COMPREPLY=( $(compgen -W "time_t" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-d --device
+		-n --dry-run
+		-l --local
+		-m --mode
+		-s --seconds
+		-t --time
+		-u --utc
+		-v --verbose
+		-h --help
+		-V --version"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _rtcwake_module rtcwake
diff --git a/shell-completion/setarch b/shell-completion/setarch
new file mode 100644
index 0000000..b84d399
--- /dev/null
+++ b/shell-completion/setarch
@@ -0,0 +1,42 @@
+_setarch_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	if [ $COMP_CWORD -eq 1 ]; then
+		COMPREPLY=( $(compgen -W "linux32 linux64 ppc32 ppc ppc64
+					  ppc64pseries ppc64iseries i386
+					  i486 i586 i686 athlon x86_64
+					  ia64 parisc32 parisc parisc64
+					  s390 s390x sparc sparc32bash
+					  sparc32 sparc64 mips32 mips
+					  mips64 alpha alphaev5 alphaev56
+					  alphaev6 alphaev67" -- $cur) )
+		return 0
+	fi
+	case $cur in
+		-*)
+			OPTS="-v, --verbose
+				-R, --addr-no-randomize
+				-F, --fdpic-funcptrs
+				-Z, --mmap-page-zero
+				-L, --addr-compat-layout
+				-X, --read-implies-exec
+				-B, --32bit
+				-I, --short-inode
+				-S, --whole-seconds
+				-T, --sticky-timeouts
+				-3, --3gb
+				    --4gb
+				    --uname-2.6
+				-h, --help
+				-V, --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _setarch_module setarch
diff --git a/shell-completion/setpriv b/shell-completion/setpriv
new file mode 100644
index 0000000..b05affe
--- /dev/null
+++ b/shell-completion/setpriv
@@ -0,0 +1,82 @@
+_setpriv_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'--inh-caps'|'--bounding-set')
+			# FIXME: how to append to a string with compgen?
+			local INHERIT
+			INHERIT=$(setpriv --list-caps| awk '{print $1, "-" $1}')
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "all $INHERIT" -S ',' -- $cur) )
+			return 0
+			;;
+		'--ruid'|'--euid'|'--reuid')
+			local UIDS
+			UIDS=$(getent passwd | awk -F: '{print $3}')
+			COMPREPLY=( $(compgen -W "$UIDS" -- $cur) )
+			return 0
+			;;
+		'--rgid'|'--egid'|'--regid')
+			local GIDS
+			GIDS=$(getent group | awk -F: '{print $3}')
+			COMPREPLY=( $(compgen -W "$GIDS" -- $cur) )
+			return 0
+			;;
+		'--groups')
+			# FIXME: how to append to a string with compgen?
+			local GIDS
+			GIDS=$(getent group | awk -F: '{print $3}')
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$GIDS" -S ',' -- $cur) )
+			return 0
+			;;
+		'--securebits')
+			local SBITS
+			SBITS="noroot noroot_locked no_setuid_fixup no_setuid_fixup_locked keep_caps_locked
+			-noroot -noroot_locked -no_setuid_fixup -no_setuid_fixup_locked -keep_caps_locked"
+			COMPREPLY=( $(compgen -W "$SBITS" -- $cur) )
+			return 0
+			;;
+		'--selinux-label')
+			# FIXME: how to list selinux labels?
+			COMPREPLY=( $(compgen -W "label" -- $cur) )
+			return 0
+			;;
+		'--apparmor-profile')
+			# FIXME: how to list apparmor profiles?
+			COMPREPLY=( $(compgen -W "profile" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-d --dump
+				--nnp --no-new-privs
+				--inh-caps
+				--bounding-set
+				--ruid
+				--euid
+				--rgid
+				--egid
+				--reuid
+				--regid
+				--clear-groupsclear
+				--keep-groupskeep
+				--groups
+				--securebits
+				--selinux-label
+				--apparmor-profile
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _setpriv_module setpriv
diff --git a/shell-completion/setsid b/shell-completion/setsid
new file mode 100644
index 0000000..dcefc2f
--- /dev/null
+++ b/shell-completion/setsid
@@ -0,0 +1,17 @@
+_setsid_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-c --ctty -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _setsid_module setsid
diff --git a/shell-completion/swapon b/shell-completion/swapon
new file mode 100644
index 0000000..83e7e24
--- /dev/null
+++ b/shell-completion/swapon
@@ -0,0 +1,48 @@
+_swapon_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-p'|'--priority')
+			# Priority range is -1 to 32767.  Perhaps these
+			# few are enough.
+			COMPREPLY=( $(compgen -W "$(echo {-1..9} 32767)" -- $cur) )
+			return 0
+			;;
+		'--show')
+			# FIXME: how to append to a string with compgen?
+			local OUTPUT
+			OUTPUT="NAME TYPE SIZE USED PRIO"
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a --all
+				-d --discard
+				-e --ifexists
+				-f --fixpgsz
+				-p --priority
+				-s --summary
+				   --show
+				   --noheadings
+				   --raw
+				   --bytes
+				-v --verbose
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	# FIXME: compgen will split SPEC= from '=' point.  The append
+	# comma separated value problem is very similar.
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _swapon_module swapon
diff --git a/shell-completion/tunelp b/shell-completion/tunelp
new file mode 100644
index 0000000..0f04842
--- /dev/null
+++ b/shell-completion/tunelp
@@ -0,0 +1,48 @@
+_tunelp_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-i'|'--irq'|'-c'|'--chars')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+		'-t'|'--time')
+			COMPREPLY=( $(compgen -W "milliseconds" -- $cur) )
+			return 0
+			;;
+		'-w'|'--wait')
+			COMPREPLY=( $(compgen -W "microseconds" -- $cur) )
+			return 0
+			;;
+		'-a'|'--abort'|'-o'|'--check-status'|'-C'|'--careful'|'-T'|'--trust-irq'|'-q'|'--print-irq')
+			COMPREPLY=( $(compgen -W "off on" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-i --irq
+				-t --time
+				-c --chars
+				-w --wait
+				-a --abort
+				-o --check-status
+				-C --careful
+				-s --status
+				-T --trust-irq
+				-r --reset
+				-q --print-irq
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/lp"}) )
+	return 0
+}
+complete -F _tunelp_module tunelp
diff --git a/shell-completion/unshare b/shell-completion/unshare
new file mode 100644
index 0000000..295d02f
--- /dev/null
+++ b/shell-completion/unshare
@@ -0,0 +1,24 @@
+_unshare_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-m --mount
+				-u --uts
+				-i --ipc
+				-n --net
+				-p --pid
+				-U --user
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _unshare_module unshare
diff --git a/shell-completion/wdctl b/shell-completion/wdctl
new file mode 100644
index 0000000..6a85e0a
--- /dev/null
+++ b/shell-completion/wdctl
@@ -0,0 +1,48 @@
+_wdctl_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-f'|'--flags')
+			# FIXME: how to get flag list?
+			COMPREPLY=( $(compgen -W "flags" -- $cur) )
+			return 0
+			;;
+		'-o'|'--output')
+			# FIXME: how to append to a string with compgen?
+			local OUTPUT
+			OUTPUT="FLAG DESCRIPTION STATUS BOOT-STATUS DEVICE"
+			compopt -o nospace
+			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
+			return 0
+			;;
+		'-s'|'--settimeout')
+			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-f --flags
+				-F --noflags
+				-I --noident
+				-n --noheadings
+				-O --oneline
+				-o --output
+				-r --raw
+				-T --notimeouts
+				-s --settimeout
+				-x --flags-only
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/"}) )
+	return 0
+}
+complete -F _wdctl_module wdctl
-- 
1.8.2

