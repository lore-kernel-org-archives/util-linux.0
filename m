Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f42.google.com ([209.85.128.42]:35795 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3C1Bmo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 21:42:44 -0400
Received: by mail-qe0-f42.google.com with SMTP id da11so4080029qeb.15
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 18:42:43 -0700 (PDT)
Date: Wed, 27 Mar 2013 21:42:41 -0400
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/10] bash-completion: misc-utils
Message-ID: <20130328014241.GY526@rampage>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:47PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  shell-completion/blkid   |  62 ++++++++++++++++++++++++++
>  shell-completion/cal     |  15 +++++++
>  shell-completion/findmnt | 114 +++++++++++++++++++++++++++++++++++++++++++++++
>  shell-completion/getopt  |  34 ++++++++++++++
>  shell-completion/logger  |  43 ++++++++++++++++++
>  shell-completion/look    |  24 ++++++++++
>  shell-completion/lsblk   |  60 +++++++++++++++++++++++++
>  shell-completion/lslocks |  43 ++++++++++++++++++
>  shell-completion/mcookie |  23 ++++++++++
>  shell-completion/namei   |  17 +++++++
>  shell-completion/rename  |  27 +++++++++++
>  shell-completion/uuidd   |  33 ++++++++++++++
>  shell-completion/uuidgen |  15 +++++++
>  shell-completion/whereis |  24 ++++++++++
>  shell-completion/wipefs  |  38 ++++++++++++++++
>  15 files changed, 572 insertions(+)
>  create mode 100644 shell-completion/blkid
>  create mode 100644 shell-completion/cal
>  create mode 100644 shell-completion/findmnt
>  create mode 100644 shell-completion/getopt
>  create mode 100644 shell-completion/logger
>  create mode 100644 shell-completion/look
>  create mode 100644 shell-completion/lsblk
>  create mode 100644 shell-completion/lslocks
>  create mode 100644 shell-completion/mcookie
>  create mode 100644 shell-completion/namei
>  create mode 100644 shell-completion/rename
>  create mode 100644 shell-completion/uuidd
>  create mode 100644 shell-completion/uuidgen
>  create mode 100644 shell-completion/whereis
>  create mode 100644 shell-completion/wipefs
> 
> diff --git a/shell-completion/blkid b/shell-completion/blkid
> new file mode 100644
> index 0000000..dce41e0
> --- /dev/null
> +++ b/shell-completion/blkid
> @@ -0,0 +1,62 @@
> +_blkid_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-c')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +		'-o')
> +			COMPREPLY=( $(compgen -W "value device export full" -- $cur) )
> +			return 0
> +			;;
> +		'-s')
> +			COMPREPLY=( $(compgen -W "tag" -- $cur) )
> +			return 0
> +			;;
> +		'-t')
> +			COMPREPLY=( $(compgen -W "token" -- $cur) )
> +			return 0
> +			;;
> +		'-L')
> +			COMPREPLY=( $(compgen -W "$(\ls /dev/disk/by-label/ 2>/dev/null)" -- $cur) )
> +			return 0
> +			;;
> +		'-U')
> +			COMPREPLY=( $(compgen -W "$(\ls /dev/disk/by-uuid/ 2>/dev/null)" -- $cur) )
> +			return 0
> +			;;
> +		'-s')
> +			COMPREPLY=( $(compgen -W "size" -- $cur) )
> +			return 0
> +			;;
> +		'-O')
> +			COMPREPLY=( $(compgen -W "offset" -- $cur) )
> +			return 0
> +			;;
> +		'-u')
> +			COMPREPLY=( $(compgen -W "filesystem raid crypto other nofilesystem noraid nocrypto noother" -- $cur) )
> +			return 0
> +			;;
> +		'-n')
> +			COMPREPLY=( $(compgen -W "$(awk '{print $NF}' /proc/filesystems)" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-c -d -h -g -o -k -s -t -l -L -U -V -p -i -S -O -u -n"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local PARTITIONS
> +	PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/'; DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"

You want the loop *outside* the assignment, rather than exploding the
contents into the array via echo:

  for part in /sys/block/*/*/partition; do
    IFS=/ read -ra a <<< "$part"
    partitions+=("${a[4]}")
  done

> +	COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
> +	return 0
> +}
> +complete -F _blkid_module blkid
> diff --git a/shell-completion/cal b/shell-completion/cal
> new file mode 100644
> index 0000000..d50c8bb
> --- /dev/null
> +++ b/shell-completion/cal
> @@ -0,0 +1,15 @@
> +_cal_module()
> +{
> +	local cur OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			OPTS="-1 --one -3 --three -s --sunday -m --monday -j --julian -y --year -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _cal_module cal
> diff --git a/shell-completion/findmnt b/shell-completion/findmnt
> new file mode 100644
> index 0000000..5207b97
> --- /dev/null
> +++ b/shell-completion/findmnt
> @@ -0,0 +1,114 @@
> +_findmnt_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-p'|'--poll')
> +			COMPREPLY=( $(compgen -W "=list" -- $cur) )
> +			return 0
> +			;;
> +		'-w'|'--timeout')
> +			COMPREPLY=( $(compgen -W "timeout" -- $cur) )
> +			return 0
> +			;;
> +		'-d'|'--direction')
> +			COMPREPLY=( $(compgen -W "forward backward" -- $cur) )
> +			return 0
> +			;;
> +		'-F'|'--tab-file')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +		'-N'|'--task')
> +			local TID I
> +			TID="$(for I in /proc/*/mountinfo; do IFS='/'; TID=($I); echo "${TID[2]}"; done)"

Ditto here

> +			COMPREPLY=( $(compgen -W "$TID" -- $cur) )
> +			return 0
> +			;;
> +		'-O'|'--options')
> +			local MNT_OPTS
> +			MNT_OPTS=$(awk '{ n = split($4, a, ","); for (i = 0; i <= n; i++) { mnt_opts[a[i]]=1 } } END { for (i in mnt_opts) { print i } }' /etc/mtab 2>/dev/null )

I'm not sure you want to get into this game. You're including values
from key=val pairs (e.g. the 300 in timeout=300). Regardless, no awk
required here

  declare -A mnt_opts

  while read _ _ _ optstring _; do
    IFS=, read -ra opts <<< "$optstring"
    for opt in "${opts[@]}"; do
      mnt_opts["${opt%%=*}"]=1
    done
  done </etc/mtab

  opts=("${!mnt_opts[@]}")

> +			COMPREPLY=( $(compgen -W "$MNT_OPTS" -- $cur) )
> +			return 0
> +			;;
> +		'-o'|'--output')
> +			# FIXME: how to append to a string with compgen?

I've been down this road when I wrote some of the systemd completion. I
don't think you want to go there.

> +			local OUTPUT
> +			OUTPUT="SOURCE TARGET FSTYPE OPTIONS VFS-OPTIONS
> +				FS-OPTIONS LABEL UUID PARTLABEL PARTUUID
> +				MAJ\:MIN ACTION OLD-TARGET OLD-OPTIONS
> +				SIZE AVAIL USED USE% FSROOT TID ID
> +				OPT-FIELDS PROPAGATION FREQ PASSNO"
> +			compopt -o nospace
> +			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
> +			return 0
> +			;;
> +		'-t'|'--types')
> +			local TYPES
> +			TYPES="adfs affs autofs cifs coda coherent cramfs
> +				debugfs devpts efs ext ext2 ext3 ext4 hfs
> +				hfsplus hpfs iso9660 jfs minix msdos
> +				ncpfs nfs nfs4 ntfs proc qnx4 ramfs
> +				reiserfs romfs squashfs smbfs sysv tmpfs
> +				ubifs udf ufs umsdos usbfs vfat xenix xfs
> +				xiafs"
> +			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
> +			return 0
> +			;;
> +		'-S'|'--source')
> +			local DEV_MPOINT
> +			DEV_MPOINT=$(awk '{ print $1 }' /etc/mtab 2>/dev/null)
> +			COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
> +			return 0
> +			;;
> +		'-T'|'--target')
> +			local DEV_MPOINT
> +			DEV_MPOINT=$(awk '{ print $2 }' /etc/mtab 2>/dev/null)
> +			COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-s --fstab
> +				-m --mtab
> +				-k --kernel
> +				-p --poll
> +				-w --timeout
> +				-A --all
> +				-a --ascii
> +				-c --canonicalize
> +				-D --df
> +				-d --direction
> +				-e --evaluate
> +				-F --tab-file
> +				-f --first-only
> +				-i --invert
> +				-l --list
> +				-N --task
> +				-n --noheadings
> +				-u --notruncate
> +				-O --options
> +				-o --output
> +				-P --pairs
> +				-r --raw
> +				-t --types
> +				-v --nofsroot
> +				-R --submounts
> +				-S --source
> +				-T --target
> +				-h --help
> +				-V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local DEV_MPOINT
> +	DEV_MPOINT=$(awk '{ print $1, $2 }' /etc/mtab 2>/dev/null)
> +	COMPREPLY=( $(compgen -W "$DEV_MPOINT" -- $cur) )
> +	return 0
> +}
> +complete -F _findmnt_module findmnt
> diff --git a/shell-completion/getopt b/shell-completion/getopt
> new file mode 100644
> index 0000000..ea8c8e2
> --- /dev/null
> +++ b/shell-completion/getopt
> @@ -0,0 +1,34 @@
> +_getopt_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-l'|'--longoptions')
> +			COMPREPLY=( $(compgen -W "longopts" -- $cur) )
> +			return 0
> +			;;
> +		'-n'|'--name')
> +			COMPREPLY=( $(compgen -W "name" -- $cur) )
> +			return 0
> +			;;
> +		'-o'|'--options')
> +			COMPREPLY=( $(compgen -W "optstring" -- $cur) )
> +			return 0
> +			;;
> +		'-s'|'--shell')
> +			COMPREPLY=( $(compgen -W "sh bash csh tcsh" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-a --alternative -h --help -l --longoptions -n --name -o --options -q --quiet -Q --quiet-output -s --shell -T --test -u --unquote -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _getopt_module getopt
> diff --git a/shell-completion/logger b/shell-completion/logger
> new file mode 100644
> index 0000000..f572302
> --- /dev/null
> +++ b/shell-completion/logger
> @@ -0,0 +1,43 @@
> +_logger_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-f'|'--file')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +		'-n'|'--server')
> +			COMPREPLY=( $(compgen -A hostname -- $cur) )
> +			return 0
> +			;;
> +		'-P'|'--port')
> +			COMPREPLY=( $(compgen -W "$(awk '$1 ~ /^syslog$/  {split($2, a, "/"); print a[1]}' /etc/services)" -- $cur) )
> +			return 0
> +			;;
> +		'-p'|'--priority')
> +			COMPREPLY=( $(compgen -W "$(echo {auth,authpriv,cron,daemon,ftp,lpr,mail,news,security}.{alert,crit,debug,emerg,err,error})" -- $cur) )
> +			return 0
> +			;;
> +		'-t'|'--tag')
> +			COMPREPLY=( $(compgen -W "tag" -- $cur) )
> +			return 0
> +			;;
> +		'-u'|'--socket')
> +			COMPREPLY=( $(compgen -W "$(awk '$NF ~ /^\// {print $NF}' /proc/net/unix)" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-d --udp -i --id -f --file -h --help -n --server -P --port -p --priority -s --stderr -t --tag -u --socket -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _logger_module logger
> diff --git a/shell-completion/look b/shell-completion/look
> new file mode 100644
> index 0000000..68cea56
> --- /dev/null
> +++ b/shell-completion/look
> @@ -0,0 +1,24 @@
> +_look_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-t'|'--terminate')
> +			COMPREPLY=( $(compgen -W "char" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-a --alternative -d --alphanum -f --ignore-case -t --terminate -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _look_module look
> diff --git a/shell-completion/lsblk b/shell-completion/lsblk
> new file mode 100644
> index 0000000..521cead
> --- /dev/null
> +++ b/shell-completion/lsblk
> @@ -0,0 +1,60 @@
> +_lsblk_module()
> +{
> +	local cur prev OPTS MAJOR
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-e'|'--exclude'|'-I'|'--include')
> +			MAJOR=$(\ls /sys/dev/block/ | sed 's/:.*//')
> +			# FIXME: how to append to a string with compgen?
> +			compopt -o nospace
> +			COMPREPLY=( $(compgen -W "$MAJOR" -S ',' -- $cur) )
> +			return 0
> +			;;
> +		'-o'|'--output')
> +			# FIXME: how to append to a string with compgen?
> +			OUTPUT="NAME KNAME MAJ:MIN FSTYPE MOUNTPOINT
> +				LABEL UUID PARTLABEL PARTUUID RA RO RM
> +				MODEL SIZE STATE OWNER GROUP MODE
> +				ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC
> +				ROTA SCHED RQ-SIZE TYPE DISC-ALN
> +				DISC-GRAN DISC-MAX DISC-ZERO WSAME WWN
> +				RAND PKNAME HCTL TRAN REV VENDOR"
> +			compopt -o nospace
> +			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-a --all
> +				-b --bytes
> +				-d --nodeps
> +				-D --discard
> +				-e --exclude
> +				-I --include
> +				-f --fs
> +				-h --help
> +				-i --ascii
> +				-m --perms
> +				-l --list
> +				-n --noheadings
> +				-o --output
> +				-P --pairs
> +				-r --raw
> +				-s --inverse
> +				-t --topology
> +				-S --scsi
> +				-h --help
> +				-V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local DEVS
> +	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
> +	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
> +	return 0
> +}
> +complete -F _lsblk_module lsblk
> diff --git a/shell-completion/lslocks b/shell-completion/lslocks
> new file mode 100644
> index 0000000..f55c17e
> --- /dev/null
> +++ b/shell-completion/lslocks
> @@ -0,0 +1,43 @@
> +_lslocks_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-p'|'--pid')
> +			local PIDS
> +			# /proc/locks can have 8 to 9 fields, see commit
> +			# 55c0d16bab8cc84b72bf11cb2fdd8aa6205ac608
> +			PIDS="$(awk '{print $(NF-3)}' /proc/locks)"
> +			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
> +			return 0
> +			;;
> +		'-o'|'--output')
> +			# FIXME: how to append to a string with compgen?
> +			local OUTPUT
> +			OUTPUT="COMMAND PID TYPE SIZE MODE M START END PATH BLOCKER"
> +			compopt -o nospace
> +			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
> +			return 0
> +			;;
> +
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-p --pid
> +				-o --output
> +				-n --noheadings
> +				-r --raw
> +				-u --notruncate
> +				-h --help
> +				-V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _lslocks_module lslocks
> diff --git a/shell-completion/mcookie b/shell-completion/mcookie
> new file mode 100644
> index 0000000..1c01a55
> --- /dev/null
> +++ b/shell-completion/mcookie
> @@ -0,0 +1,23 @@
> +_mcookie_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-f'|'--file')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-f --file -v --verbose -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _mcookie_module mcookie
> diff --git a/shell-completion/namei b/shell-completion/namei
> new file mode 100644
> index 0000000..c44821c
> --- /dev/null
> +++ b/shell-completion/namei
> @@ -0,0 +1,17 @@
> +_namei_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			OPTS="-h --help -V --version -x --mountpoints -m --modes -o --owners -l --long -n --nosymlinks -v --vertical"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _namei_module namei
> diff --git a/shell-completion/rename b/shell-completion/rename
> new file mode 100644
> index 0000000..0fe4cc6
> --- /dev/null
> +++ b/shell-completion/rename
> @@ -0,0 +1,27 @@
> +_rename_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			OPTS="-v --verbose -s --symlink  -h --help -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $COMP_CWORD in
> +		1)
> +			COMPREPLY=( $(compgen -W "expression" -- $cur) )
> +			;;
> +		2)
> +			COMPREPLY=( $(compgen -W "replacement" -- $cur) )
> +			;;
> +		*)
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _rename_module rename
> diff --git a/shell-completion/uuidd b/shell-completion/uuidd
> new file mode 100644
> index 0000000..23c1a49
> --- /dev/null
> +++ b/shell-completion/uuidd
> @@ -0,0 +1,33 @@
> +_uuidd_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-p'|'--pid'|'-s'|'--socket')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +		'-T'|'--timeout')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -W "timeout" -- $cur) )
> +			return 0
> +			;;
> +		'-n'|'--uuids')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -W "number" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-p --pid -s --socket -T --timeout -k --kill -r --random -t --time -n --uuids -P --no-pid -F --no-fork -S --socket-activation -d --debug -q --quiet -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _uuidd_module uuidd
> diff --git a/shell-completion/uuidgen b/shell-completion/uuidgen
> new file mode 100644
> index 0000000..d9edde9
> --- /dev/null
> +++ b/shell-completion/uuidgen
> @@ -0,0 +1,15 @@
> +_uuidgen_module()
> +{
> +	local cur OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			OPTS="-r --random -t --time -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _uuidgen_module uuidgen
> diff --git a/shell-completion/whereis b/shell-completion/whereis
> new file mode 100644
> index 0000000..96e4117
> --- /dev/null
> +++ b/shell-completion/whereis
> @@ -0,0 +1,24 @@
> +_whereis_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-B'|'-M'|'-S')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/"}) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-b -B -m -M -s -S -f -u -l"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -W "file" -- $cur) )
> +	return 0
> +}
> +complete -F _whereis_module whereis
> diff --git a/shell-completion/wipefs b/shell-completion/wipefs
> new file mode 100644
> index 0000000..427f47b
> --- /dev/null
> +++ b/shell-completion/wipefs
> @@ -0,0 +1,38 @@
> +_wipefs_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-o'|'--offset')
> +			COMPREPLY=( $(compgen -W "offset" -- $cur) )
> +			return 0
> +			;;
> +		'-t'|'--types')
> +			local TYPES
> +			TYPES="adfs affs autofs cifs coda coherent cramfs
> +				debugfs devpts efs ext ext2 ext3 ext4 hfs
> +				hfsplus hpfs iso9660 jfs minix msdos
> +				ncpfs nfs nfs4 ntfs proc qnx4 ramfs
> +				reiserfs romfs squashfs smbfs sysv tmpfs
> +				ubifs udf ufs umsdos usbfs vfat xenix xfs
> +				xiafs"
> +			COMPREPLY=( $(compgen -W "$TYPES" -- $cur) )
> +			return 0
> +			;;
> +
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-a --all -f --force -h --help -n --no-actn -o --offset -p --parsable -q --quiet -t --types -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local DEVS
> +	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
> +	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
> +	return 0
> +}
> +complete -F _wipefs_module wipefs
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
