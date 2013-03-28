Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f49.google.com ([209.85.216.49]:53345 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab3C1BmS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 21:42:18 -0400
Received: by mail-qa0-f49.google.com with SMTP id l8so1268384qaq.8
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 18:42:18 -0700 (PDT)
Date: Wed, 27 Mar 2013 21:42:15 -0400
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] bash-completion: disk-utils
Message-ID: <20130328014215.GW526@rampage>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:44PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  shell-completion/addpart     | 25 +++++++++++++++++++++++++
>  shell-completion/blockdev    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  shell-completion/delpart     | 19 +++++++++++++++++++
>  shell-completion/fdformat    | 11 +++++++++++
>  shell-completion/fsck        | 36 ++++++++++++++++++++++++++++++++++++
>  shell-completion/fsck.cramfs | 18 ++++++++++++++++++
>  shell-completion/fsck.minix  | 11 +++++++++++
>  shell-completion/isosize     | 17 +++++++++++++++++
>  shell-completion/mkfs        | 25 +++++++++++++++++++++++++
>  shell-completion/mkfs.bfs    | 28 ++++++++++++++++++++++++++++
>  shell-completion/mkfs.cramfs | 40 ++++++++++++++++++++++++++++++++++++++++
>  shell-completion/mkfs.minix  | 33 +++++++++++++++++++++++++++++++++
>  shell-completion/mkswap      | 36 ++++++++++++++++++++++++++++++++++++
>  shell-completion/partx       | 37 +++++++++++++++++++++++++++++++++++++
>  shell-completion/raw         | 17 +++++++++++++++++
>  shell-completion/resizepart  | 22 ++++++++++++++++++++++
>  shell-completion/swaplabel   | 28 ++++++++++++++++++++++++++++
>  17 files changed, 447 insertions(+)
>  create mode 100644 shell-completion/addpart
>  create mode 100644 shell-completion/blockdev
>  create mode 100644 shell-completion/delpart
>  create mode 100644 shell-completion/fdformat
>  create mode 100644 shell-completion/fsck
>  create mode 100644 shell-completion/fsck.cramfs
>  create mode 100644 shell-completion/fsck.minix
>  create mode 100644 shell-completion/isosize
>  create mode 100644 shell-completion/mkfs
>  create mode 100644 shell-completion/mkfs.bfs
>  create mode 100644 shell-completion/mkfs.cramfs
>  create mode 100644 shell-completion/mkfs.minix
>  create mode 100644 shell-completion/mkswap
>  create mode 100644 shell-completion/partx
>  create mode 100644 shell-completion/raw
>  create mode 100644 shell-completion/resizepart
>  create mode 100644 shell-completion/swaplabel
> 
> diff --git a/shell-completion/addpart b/shell-completion/addpart
> new file mode 100644
> index 0000000..07ebf5e
> --- /dev/null
> +++ b/shell-completion/addpart
> @@ -0,0 +1,25 @@
> +_addpart_module()
> +{
> +	local cur
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $COMP_CWORD in
> +		1)
> +			local DEVS
> +			DEVS="$(lsblk -o NAME -n -r)"
> +			OPTS="-h --help -V --version $DEVS"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )

You've defined OPTS as a simple string variable and then you're
expanding it as an array. Make sure to localize any variables you might
define in the completion function as well, or else they leak to the
user's environment (DEVS, OPTS). In general, I'd recommend *against*
using all capitalized variable names, particularly for local variables.

> +			;;
> +		2)
> +			COMPREPLY=( $(compgen -W "$((1 + $(ls $prev?* 2>/dev/null | wc -l)))" -- $cur) )

Please don't use ls to count items in a directory. It's slightly longer
winded, but bash does this just fine without forking:

 filecount=0
 files=("$prev"?*)
 [[ -e ${files[0]} ]] && filecount=${#files[*]}

This advice and the above apply to a bunch of your patches.

> +			;;
> +		3)
> +			COMPREPLY=( $(compgen -W "start" -- $cur) )
> +			;;
> +		4)
> +			COMPREPLY=( $(compgen -W "length" -- $cur) )
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _addpart_module addpart
> diff --git a/shell-completion/blockdev b/shell-completion/blockdev
> new file mode 100644
> index 0000000..82ac6c1
> --- /dev/null
> +++ b/shell-completion/blockdev
> @@ -0,0 +1,44 @@
> +_blockdev_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	DEVS="$(lsblk -o NAME -n -r)"
> +	OPTS="-h -V -q
> +		--report
> +		--getsz
> +		--setro
> +		--setrw
> +		--getro
> +		--getdiscardzeroes
> +		--getss
> +		--getpbsz
> +		--getiomin
> +		--getioopt
> +		--getalignoff
> +		--getmaxsect
> +		--getbsz
> +		--setbsz
> +		--getsize64
> +		--setra
> +		--getra
> +		--setfra
> +		--getfra
> +		--flushbufs
> +		--rereadpt
> +		$DEVS"
> +	case $prev in
> +		'--setbsz')
> +			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
> +			return 0
> +			;;
> +		'--setbsz'|'--setfra')
> +			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +	return 0
> +}
> +complete -F _blockdev_module blockdev
> diff --git a/shell-completion/delpart b/shell-completion/delpart
> new file mode 100644
> index 0000000..849c018
> --- /dev/null
> +++ b/shell-completion/delpart
> @@ -0,0 +1,19 @@
> +_delpart_module()
> +{
> +	local cur OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $COMP_CWORD in
> +		1)
> +			local DEVS
> +			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"

  local dev typ
  while read dev typ; do
    [[ $dev = 'disk' ]] && devices+=("/dev/$dev")
  done < <(lsblk -nro name,type)

> +			OPTS="-h --help -V --version $DEVS"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			;;
> +		2)
> +			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition 2>/dev/null)" -- $cur) )

Bash has a builtin "cat" which uses mmap instead of direct reads, and is
far more efficient:

  COMPREPLY=( $(compgen -W "$(</sys/block/"${prev##*/}"/*/partition 2>/dev/null)" -- $cur) )

> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _delpart_module delpart
> diff --git a/shell-completion/fdformat b/shell-completion/fdformat
> new file mode 100644
> index 0000000..f7d6a8e
> --- /dev/null
> +++ b/shell-completion/fdformat
> @@ -0,0 +1,11 @@
> +_fdformat_module()
> +{
> +	local cur OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	DEVS=$(ls /dev/fd[0-9]* 2>/dev/null)
> +	OPTS="-n --no-verify -h --help -V --version $DEVS"
> +	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +	return 0
> +}
> +complete -F _fdformat_module fdformat
> diff --git a/shell-completion/fsck b/shell-completion/fsck
> new file mode 100644
> index 0000000..c3da5f5
> --- /dev/null
> +++ b/shell-completion/fsck
> @@ -0,0 +1,36 @@
> +_fsck_module()
> +{
> +	local cur prev OPTS DEVS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-b')
> +			COMPREPLY=( $(compgen -W "superblock" -- $cur) )
> +			return 0
> +			;;
> +		'-B')
> +			COMPREPLY=( $(compgen -W "blocksize" -- $cur) )
> +			return 0
> +			;;
> +		'-j')
> +			COMPREPLY=( $(compgen -W "external_journal" -- $cur) )
> +			return 0
> +			;;
> +		'-l'|'-L')
> +			COMPREPLY=( $(compgen -W "bad_blocks_file" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-p -n -y -c -f -v -b -B -j -l -L"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
> +	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
> +	return 0
> +}
> +complete -F _fsck_module fsck
> diff --git a/shell-completion/fsck.cramfs b/shell-completion/fsck.cramfs
> new file mode 100644
> index 0000000..410b084
> --- /dev/null
> +++ b/shell-completion/fsck.cramfs
> @@ -0,0 +1,18 @@
> +_fsck.cramfs_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	OPTS='-v --verbose -x --destination -h --help -V --version file'
> +	case $prev in
> +		'-x'|'--destination')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -o dirnames -- ${cur:-"/"}) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -W "${OPTS[*]}" -S ' ' -- $cur) )
> +	return 0
> +}
> +complete -F _fsck.cramfs_module fsck.cramfs
> diff --git a/shell-completion/fsck.minix b/shell-completion/fsck.minix
> new file mode 100644
> index 0000000..f01626a
> --- /dev/null
> +++ b/shell-completion/fsck.minix
> @@ -0,0 +1,11 @@
> +_fsck.minix_module()
> +{
> +	local cur OPTS DEVS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
> +	OPTS="-l -a -r -v -s -m -f -V --version"
> +	COMPREPLY=( $(compgen -W "${OPTS[*]} $DEVS" -- $cur) )
> +	return 0
> +}
> +complete -F _fsck.minix_module fsck.minix
> diff --git a/shell-completion/isosize b/shell-completion/isosize
> new file mode 100644
> index 0000000..2b4a499
> --- /dev/null
> +++ b/shell-completion/isosize
> @@ -0,0 +1,17 @@
> +_isosize_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	OPTS='-d --divisor -x --sectors -h --help -V --version'
> +	case $prev in
> +		'-d'|'--divisor')
> +			COMPREPLY=( $(compgen -W "number" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +	return 0
> +}
> +complete -F _isosize_module isosize
> diff --git a/shell-completion/mkfs b/shell-completion/mkfs
> new file mode 100644
> index 0000000..ee6a26b
> --- /dev/null
> +++ b/shell-completion/mkfs
> @@ -0,0 +1,25 @@
> +_mkfs_module()
> +{
> +	local cur prev OPTS DEVS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-t'|'--type')
> +			FSTYPES=$(for I in $(\ls /sbin/mkfs.* /usr/sbin/mkfs.* 2>/dev/null); do echo ${I##*mkfs.}; done)
> +			COMPREPLY=( $(compgen -W "$FSTYPES" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS='-t --type --verbose -h --help -V --version'
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
> +	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
> +	return 0
> +}
> +complete -F _mkfs_module mkfs
> diff --git a/shell-completion/mkfs.bfs b/shell-completion/mkfs.bfs
> new file mode 100644
> index 0000000..b1a226a
> --- /dev/null
> +++ b/shell-completion/mkfs.bfs
> @@ -0,0 +1,28 @@
> +_bfs_module()
> +{
> +	local cur prev OPTS DEVS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-N'|'--inodes')
> +			COMPREPLY=( $(compgen -W "number" -- $cur) )
> +			return 0
> +			;;
> +		'-V'|'--vname'|'-F'|'--fname')
> +			COMPREPLY=( $(compgen -W "name" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS='-N --inodes --vname --fname -v --verbose -h --help -V --version'
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
> +	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
> +	return 0
> +}
> +complete -F _bfs_module bfs
> diff --git a/shell-completion/mkfs.cramfs b/shell-completion/mkfs.cramfs
> new file mode 100644
> index 0000000..65ee988
> --- /dev/null
> +++ b/shell-completion/mkfs.cramfs
> @@ -0,0 +1,40 @@
> +_mkfs.cramfs_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-b')
> +			COMPREPLY=( $(compgen -W "blksize" -- $cur) )
> +			return 0
> +			;;
> +		'-e')
> +			COMPREPLY=( $(compgen -W "edition" -- $cur) )
> +			return 0
> +			;;
> +		'-N')
> +			COMPREPLY=( $(compgen -W "big little host" -- $cur) )
> +			return 0
> +			;;
> +		'-i')
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +		'-n')
> +			COMPREPLY=( $(compgen -W "name" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-h -v -E -b -e -N -i -n -p -s -z"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _mkfs.cramfs_module mkfs.cramfs
> diff --git a/shell-completion/mkfs.minix b/shell-completion/mkfs.minix
> new file mode 100644
> index 0000000..c717b3c
> --- /dev/null
> +++ b/shell-completion/mkfs.minix
> @@ -0,0 +1,33 @@
> +_mkfs.minix_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-i')
> +			COMPREPLY=( $(compgen -W "inodes" -- $cur) )
> +			return 0
> +			;;
> +		'-l')
> +			COMPREPLY=( $(compgen -W "badblocks-file" -- $cur) )
> +			return 0
> +			;;
> +		'-n')
> +			COMPREPLY=( $(compgen -W "14 30" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-c -i -l -n -1 -2 -3"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local DEVS
> +	DEVS="$(lsblk -o NAME -n -r | awk '{print "/dev/" $1}')"
> +	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
> +	return 0
> +}
> +complete -F _mkfs.minix_module mkfs.minix
> diff --git a/shell-completion/mkswap b/shell-completion/mkswap
> new file mode 100644
> index 0000000..c847aa9
> --- /dev/null
> +++ b/shell-completion/mkswap
> @@ -0,0 +1,36 @@
> +_mkswap_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-p'|'--pagesize')
> +			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
> +			return 0
> +			;;
> +		'-L'|'--label')
> +			COMPREPLY=( $(compgen -W "label" -- $cur) )
> +			return 0
> +			;;
> +		'-v'|'--swapversion')
> +			COMPREPLY=( $(compgen -W "1" -- $cur) )
> +			return 0
> +			;;
> +		'-U'|--uuid)
> +			COMPREPLY=( $(compgen -W "$(lsblk -n --output uuid)" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-c --check -f --force -p --pagesize -L  --label -v --swapversion -U --uuid -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _mkswap_module mkswap
> diff --git a/shell-completion/partx b/shell-completion/partx
> new file mode 100644
> index 0000000..c558d36
> --- /dev/null
> +++ b/shell-completion/partx
> @@ -0,0 +1,37 @@
> +_partx_module()
> +{
> +	local cur prev OPTS OUTPUT
> +	COMPREPLY=()
> +	OUTPUT="NR START END SECTORS SIZE NAME UUID TYPE FLAGS SCHEME"
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-n'|'--nr')
> +			COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /part/ {print "/dev/" $1}')" -- $cur) )
> +			return 0
> +			;;
> +		'-o'|'--output')
> +			# FIXME: how to append to a string with compgen?
> +			compopt -o nospace
> +			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
> +			return 0
> +			;;
> +		'-t'|'--type')
> +			# FIXME: some command should list type libblkid knows.
> +			COMPREPLY=( $(compgen -W "aix bsd dos gpt mac minix sgi solaris_x86 sun ultrix unixware" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-a --add -d --delete -s --show -u --update -b --bytes -g --noheadings -n --nr -o --output -P --pairs -r --raw -t --type -v --verbose -h --help -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local DEVS
> +	DEVS="$(sblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
> +	COMPREPLY=( $(compgen -W "$DEVS" -- $cur) )
> +	return 0
> +}
> +complete -F _partx_module partx
> diff --git a/shell-completion/raw b/shell-completion/raw
> new file mode 100644
> index 0000000..41e03f2
> --- /dev/null
> +++ b/shell-completion/raw
> @@ -0,0 +1,17 @@
> +_raw_module()
> +{
> +	local cur
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			local OPTS
> +			OPTS="-q --query -a --all -h --help -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -W "$(ls 2>/dev/null /dev/raw/*)" -- $cur) )
> +	return 0
> +}
> +complete -F _raw_module raw
> diff --git a/shell-completion/resizepart b/shell-completion/resizepart
> new file mode 100644
> index 0000000..827638a
> --- /dev/null
> +++ b/shell-completion/resizepart
> @@ -0,0 +1,22 @@
> +_resizepart_module()
> +{
> +	local cur OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $COMP_CWORD in
> +		1)
> +			local DEVS
> +			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
> +			OPTS="-h --help -V --version $DEVS"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			;;
> +		2)
> +			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition 2>/dev/null)" -- $cur) )
> +			;;
> +		3)
> +			COMPREPLY="length"
> +			;;
> +	esac
> +	return 0
> +}
> +complete -F _resizepart_module resizepart
> diff --git a/shell-completion/swaplabel b/shell-completion/swaplabel
> new file mode 100644
> index 0000000..c857d15
> --- /dev/null
> +++ b/shell-completion/swaplabel
> @@ -0,0 +1,28 @@
> +_swaplabel_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-L'|'--label')
> +			COMPREPLY=( $(compgen -W "label" -- $cur) )
> +			return 0
> +			;;
> +		'-U'|'--uuid')
> +			COMPREPLY=( $(compgen -W '$(uuidgen)' -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-L --label -U --uuid -h --help -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _swaplabel_module swaplabel
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
