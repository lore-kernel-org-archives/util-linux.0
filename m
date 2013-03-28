Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:7748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756982Ab3C1JyZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Mar 2013 05:54:25 -0400
Date: Thu, 28 Mar 2013 10:54:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] bash-completion: disk-utils
Message-ID: <20130328095414.GB24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:44PM +0000, Sami Kerola wrote:
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

The /sbin and /usr/sbin are the same directories on many systems, so you
need to de-duplicate the list or use only one directory (I suggest /sbin).

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

 The -U|--uuid is not a device identifier here, it's UUID you want to
 use for the new swap superblock. So ask lsblk does not make sense. 
 (It will generate duplicate UUIDS.)

 If you do not specify -U then mkswap will generate a new. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
