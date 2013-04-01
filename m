Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:65170 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233Ab3DARAb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Apr 2013 13:00:31 -0400
Received: by mail-we0-f173.google.com with SMTP id t57so1873348wey.32
        for <util-linux@vger.kernel.org>; Mon, 01 Apr 2013 10:00:30 -0700 (PDT)
Date: Mon, 1 Apr 2013 18:00:26 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] bash-completion: disk-utils
Message-ID: <20130401170018.GC22182@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-3-git-send-email-kerolasa@iki.fi>
 <20130328095414.GB24678@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130328095414.GB24678@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 28, 2013 at 10:54:14AM +0100, Karel Zak wrote:
> On Wed, Mar 27, 2013 at 10:07:44PM +0000, Sami Kerola wrote:
> > diff --git a/shell-completion/mkfs b/shell-completion/mkfs
> > new file mode 100644
> > index 0000000..ee6a26b
> > --- /dev/null
> > +++ b/shell-completion/mkfs
> > @@ -0,0 +1,25 @@
> > +_mkfs_module()
> > +{
> > +	local cur prev OPTS DEVS
> > +	COMPREPLY=()
> > +	cur="${COMP_WORDS[COMP_CWORD]}"
> > +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> > +	case $prev in
> > +		'-t'|'--type')
> > +			FSTYPES=$(for I in $(\ls /sbin/mkfs.* /usr/sbin/mkfs.* 2>/dev/null); do echo ${I##*mkfs.}; done)
> 
> The /sbin and /usr/sbin are the same directories on many systems, so you
> need to de-duplicate the list or use only one directory (I suggest /sbin).

The compgen will remove duplicates.  Perhaps most systems now a days has
/sbin -> /usr/sbin symlink, but because that cannot be guaranteed I would
rather let the later command to sort out duplicates than being over
clever about what is necessary.

> > diff --git a/shell-completion/mkswap b/shell-completion/mkswap
> > new file mode 100644
> > index 0000000..c847aa9
> > --- /dev/null
> > +++ b/shell-completion/mkswap
> > @@ -0,0 +1,36 @@
> > +_mkswap_module()
> > +{
> > +	local cur prev OPTS
> > +	COMPREPLY=()
> > +	cur="${COMP_WORDS[COMP_CWORD]}"
> > +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> > +	case $prev in
> > +		'-p'|'--pagesize')
> > +			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-L'|'--label')
> > +			COMPREPLY=( $(compgen -W "label" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-v'|'--swapversion')
> > +			COMPREPLY=( $(compgen -W "1" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-U'|--uuid)
> > +			COMPREPLY=( $(compgen -W "$(lsblk -n --output uuid)" -- $cur) )
> 
>  The -U|--uuid is not a device identifier here, it's UUID you want to
>  use for the new swap superblock. So ask lsblk does not make sense. 
>  (It will generate duplicate UUIDS.)
> 
>  If you do not specify -U then mkswap will generate a new. 

Fixed.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
