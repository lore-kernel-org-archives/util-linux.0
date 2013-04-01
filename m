Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:38066 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756930Ab3DAQwv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Apr 2013 12:52:51 -0400
Received: by mail-we0-f173.google.com with SMTP id t57so1869058wey.18
        for <util-linux@vger.kernel.org>; Mon, 01 Apr 2013 09:52:50 -0700 (PDT)
Date: Mon, 1 Apr 2013 17:52:46 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/10] bash-completion: misc-utils
Message-ID: <20130401165133.GB22182@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-6-git-send-email-kerolasa@iki.fi>
 <20130328014241.GY526@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130328014241.GY526@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 09:42:41PM -0400, Dave Reisner wrote:
> On Wed, Mar 27, 2013 at 10:07:47PM +0000, Sami Kerola wrote:
> > +	local PARTITIONS
> > +	PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/'; DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
> 
> You want the loop *outside* the assignment, rather than exploding the
> contents into the array via echo:
> 
>   for part in /sys/block/*/*/partition; do
>     IFS=/ read -ra a <<< "$part"
>     partitions+=("${a[4]}")
>   done

That was changed to use 'lsblk' rather than /sys files.

> > +		'-N'|'--task')
> > +			local TID I
> > +			TID="$(for I in /proc/*/mountinfo; do IFS='/'; TID=($I); echo "${TID[2]}"; done)"
> 
> Ditto here

Corrected.

> > +			COMPREPLY=( $(compgen -W "$TID" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-O'|'--options')
> > +			local MNT_OPTS
> > +			MNT_OPTS=$(awk '{ n = split($4, a, ","); for (i = 0; i <= n; i++) { mnt_opts[a[i]]=1 } } END { for (i in mnt_opts) { print i } }' /etc/mtab 2>/dev/null )
> 
> I'm not sure you want to get into this game. You're including values
> from key=val pairs (e.g. the 300 in timeout=300). Regardless, no awk
> required here
> 
>   declare -A mnt_opts
> 
>   while read _ _ _ optstring _; do
>     IFS=, read -ra opts <<< "$optstring"
>     for opt in "${opts[@]}"; do
>       mnt_opts["${opt%%=*}"]=1
>     done
>   done </etc/mtab
> 
>   opts=("${!mnt_opts[@]}")

Something similar to that was done with a small difference to avoid
reading /etc/mtab.  Notice that findmnt is using key=val pair when
matching with mount options, not key only.

> > +			COMPREPLY=( $(compgen -W "$MNT_OPTS" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-o'|'--output')
> > +			# FIXME: how to append to a string with compgen?
> 
> I've been down this road when I wrote some of the systemd completion. I
> don't think you want to go there.

I am not sure if CSV filling with compgen is currently possible.  I have
a feeling the whole issue would be easier if after a completetion which
resulted to nospace a word break would be inserted.  Is that missing bash
feature, bug, or my misunderstanding how this case would be nicest to
solve.  While I do not know belive leaving the FIXME items in place is
correct thing to do.

Thanks for reviews Dave.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
