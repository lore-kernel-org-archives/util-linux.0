Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:58026 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758869Ab3DAQdE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Apr 2013 12:33:04 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so2210535wgh.17
        for <util-linux@vger.kernel.org>; Mon, 01 Apr 2013 09:33:02 -0700 (PDT)
Date: Mon, 1 Apr 2013 17:32:53 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] bash-completion: sys-utils
Message-ID: <20130401163233.GA22182@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-8-git-send-email-kerolasa@iki.fi>
 <20130329163335.GI24678@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130329163335.GI24678@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 29, 2013 at 05:33:35PM +0100, Karel Zak wrote:
> On Wed, Mar 27, 2013 at 10:07:49PM +0000, Sami Kerola wrote:
> > @@ -0,0 +1,25 @@
> > +_blkdiscard_module()
> > +{
> > +	local cur prev OPTS
> > +	COMPREPLY=()
> > +	cur="${COMP_WORDS[COMP_CWORD]}"
> > +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> > +	case $prev in
> > +		'-o'|'--offset'|'-l'|'--length')
> > +			COMPREPLY=( $(compgen -W "num" -- $cur) )
> > +			return 0
> > +			;;
> > +	esac
> > +	case $cur in
> > +		-*)
> > +			OPTS="-o --offset -l --length -s --secure -v --verbose -h --help -V --version"
> > +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> > +			return 0
> > +			;;
> > +	esac
> > +	local DEVS
> > +	DEVS="$(\ls -d /sys/class/block/* | sed 's|/sys/class/block/|/dev/|g')"
> 
> It does not look like the right way how to generate the paths, because
> /sys/class/block/ contains also paths to unassociated loop devices and
> all the paths are based on kernel device names (e.g. dm-X).
> 
> I have add --paths to lsblk(8), so now you can use:
> 
>  lsblk -p -o NAME -n -l
> 
> to list the paths, for exmaple:
>  
>  /dev/sda
>  /dev/sda1
>  /dev/sda2
>  /dev/sda3
>  /dev/sda4
>  /dev/sda5
>  /dev/sda6
>  /dev/mapper/luks-10d813de-fa82-4f67-a86c-23d5d0e7c30e
>  /dev/sdb
>  /dev/sr0
> 
> it would be nice to use this solution everywhere.

I think I found all references to block devices, and replaced them with
lsblk which is using Dave's while loop.

> > +_eject_module()
> > +{
>  ....
> > +	DEVS="$(for I in /sys/class/block/*/removable; do
> > +		if [ $(cat $I) -ne 0 ]; then
> > +			OLD_IFS=$IFS
> > +			IFS='/';
> > +			ARR=($I)
> > +			echo "/dev/${ARR[4]}"
> > +			IFS=$OLD_IFS
> > +		fi
> > +	done)"
> 
>  lsblk -rpn -o RM,NAME | awk '/^1/ { print $2 }'
> 
>  The common rule is to not read data from /sys if possible.
> 
> > diff --git a/shell-completion/fstrim b/shell-completion/fstrim
> > new file mode 100644
> > index 0000000..87cb050
> > --- /dev/null
> > +++ b/shell-completion/fstrim
> > @@ -0,0 +1,25 @@
> > +_fstrim_module()
> > +{
> > +	local cur prev OPTS
> > +	COMPREPLY=()
> > +	cur="${COMP_WORDS[COMP_CWORD]}"
> > +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> > +	case $prev in
> > +		'-o'|'--offset'|'-l'|'--length'|'-m'|'--minimum')
> > +			COMPREPLY=( $(compgen -W "num" -- $cur) )
> > +			return 0
> > +			;;
> > +	esac
> > +	case $cur in
> > +		-*)
> > +			OPTS="-o --offset -l --length -m --minimum -v --verbose -h --help -V --version"
> > +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> > +			return 0
> > +			;;
> > +	esac
> > +	local MPOINTS
> > +	MPOINTS=$(awk '{if ($1 ~ /^\//){print $2}}' /etc/mtab 2>/dev/null)
> 
>  The same problem, don't read mtab directly (for example because
>  some chars could be escaped...). Use:
> 
>    findmnt -rno SOURCE | grep '/dev'

With this I had a small whoops.  The diff I sent moment ago did not have
findmnt v.s. /etc/mtab fixes, which are now in my git.

What comes to principle of using helper commands rather than /sys or
/proc files I fully agree this is better.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
