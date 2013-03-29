Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab3C2Qdr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Mar 2013 12:33:47 -0400
Date: Fri, 29 Mar 2013 17:33:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] bash-completion: sys-utils
Message-ID: <20130329163335.GI24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:49PM +0000, Sami Kerola wrote:
> @@ -0,0 +1,25 @@
> +_blkdiscard_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-o'|'--offset'|'-l'|'--length')
> +			COMPREPLY=( $(compgen -W "num" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-o --offset -l --length -s --secure -v --verbose -h --help -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local DEVS
> +	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"

It does not look like the right way how to generate the paths, because
/sys/class/block/ contains also paths to unassociated loop devices and
all the paths are based on kernel device names (e.g. dm-X).

I have add --paths to lsblk(8), so now you can use:

 lsblk -p -o NAME -n -l

to list the paths, for exmaple:
 
 /dev/sda
 /dev/sda1
 /dev/sda2
 /dev/sda3
 /dev/sda4
 /dev/sda5
 /dev/sda6
 /dev/mapper/luks-10d813de-fa82-4f67-a86c-23d5d0e7c30e
 /dev/sdb
 /dev/sr0

it would be nice to use this solution everywhere.

> +_eject_module()
> +{
 ....
> +	DEVS="$(for I in /sys/class/block/*/removable; do
> +		if [ $(cat $I) -ne 0 ]; then
> +			OLD_IFS=$IFS
> +			IFS='/';
> +			ARR=($I)
> +			echo "/dev/${ARR[4]}"
> +			IFS=$OLD_IFS
> +		fi
> +	done)"

 lsblk -rpn -o RM,NAME | awk '/^1/ { print $2 }'

 The common rule is to not read data from /sys if possible.

> diff --git a/shell-completion/fstrim b/shell-completion/fstrim
> new file mode 100644
> index 0000000..87cb050
> --- /dev/null
> +++ b/shell-completion/fstrim
> @@ -0,0 +1,25 @@
> +_fstrim_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-o'|'--offset'|'-l'|'--length'|'-m'|'--minimum')
> +			COMPREPLY=( $(compgen -W "num" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-o --offset -l --length -m --minimum -v --verbose -h --help -V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	local MPOINTS
> +	MPOINTS=$(awk '{if ($1 ~ /^\//){print $2}}' /etc/mtab 2>/dev/null)

 The same problem, don't read mtab directly (for example because
 some chars could be escaped...). Use:

   findmnt -rno SOURCE | grep '/dev'

    Karel
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
