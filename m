Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:43778 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab3DAPyR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Apr 2013 11:54:17 -0400
Received: by mail-we0-f181.google.com with SMTP id d7so1858825wer.40
        for <util-linux@vger.kernel.org>; Mon, 01 Apr 2013 08:54:15 -0700 (PDT)
Date: Mon, 1 Apr 2013 16:54:12 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] bash-completion: disk-utils
Message-ID: <20130401155341.GB20549@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-3-git-send-email-kerolasa@iki.fi>
 <20130328014215.GW526@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130328014215.GW526@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 09:42:15PM -0400, Dave Reisner wrote:
> On Wed, Mar 27, 2013 at 10:07:44PM +0000, Sami Kerola wrote:
> > +			local DEVS
> > +			DEVS="$(lsblk -o NAME -n -r)"
> > +			OPTS="-h --help -V --version $DEVS"
> > +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> 
> You've defined OPTS as a simple string variable and then you're
> expanding it as an array. Make sure to localize any variables you might
> define in the completion function as well, or else they leak to the
> user's environment (DEVS, OPTS). In general, I'd recommend *against*
> using all capitalized variable names, particularly for local variables.

I made attempt to find non-localized variables, and correct them.  It
could be that there are still some left.

> > +			;;
> > +		2)
> > +			COMPREPLY=( $(compgen -W "$((1 + $(ls $prev?* 2>/dev/null | wc -l)))" -- $cur) )
> 
> Please don't use ls to count items in a directory. It's slightly longer
> winded, but bash does this just fine without forking:
> 
>  filecount=0
>  files=("$prev"?*)
>  [[ -e ${files[0]} ]] && filecount=${#files[*]}
> 
> This advice and the above apply to a bunch of your patches.

All instances of 'ls' execution are gone.

> > +_delpart_module()
> > +{
> > +	local cur OPTS
> > +	COMPREPLY=()
> > +	cur="${COMP_WORDS[COMP_CWORD]}"
> > +	case $COMP_CWORD in
> > +		1)
> > +			local DEVS
> > +			DEVS="$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')"
> 
>   local dev typ
>   while read dev typ; do
>     [[ $dev = 'disk' ]] && devices+=("/dev/$dev")
>   done < <(lsblk -nro name,type)

Changed to version you proposed.

> > +			OPTS="-h --help -V --version $DEVS"
> > +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> > +			;;
> > +		2)
> > +			COMPREPLY=( $(compgen -W "$(cat /sys/block/${prev##*/}/*/partition 2>/dev/null)" -- $cur) )
> 
> Bash has a builtin "cat" which uses mmap instead of direct reads, and is
> far more efficient:
> 
>   COMPREPLY=( $(compgen -W "$(</sys/block/"${prev##*/}"/*/partition 2>/dev/null)" -- $cur) )

I left that as-is.  Reading from a bunch of files would require a loop,
which and I don't think avoiding cat is worth of the mess.

Thank you for advice Dave.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
