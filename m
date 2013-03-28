Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab3C1KB6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Mar 2013 06:01:58 -0400
Date: Thu, 28 Mar 2013 11:01:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] bash-completion: fdisks
Message-ID: <20130328100148.GC24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:45PM +0000, Sami Kerola wrote:
> +++ b/shell-completion/fdisk
> @@ -0,0 +1,41 @@
> +_fdisk_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-s')
> +			local PARTITIONS
> +			PARTITIONS="$(for I in /sys/block/*/*/partition; do IFS='/'; DIR_ARR=($I); echo "/dev/${DIR_ARR[4]}"; done)"
> +			COMPREPLY=( $(compgen -W "$PARTITIONS" -- $cur) )
> +			return 0
> +			;;
> +		'-b')
> +			COMPREPLY=( $(compgen -W "512 1024 2048 4096" -- $cur) )
> +			return 0
> +			;;
> +		'-c')
> +			COMPREPLY=( $(compgen -W "dos nondos" -- $cur) )

 optional arguments, it means the result has to be "-c=dos" or
 "-c=nondos" and no blank spaces.

 I guess you need to use -o nospace for compgen or so.

> +			return 0
> +			;;
> +		'-u')
> +			COMPREPLY=( $(compgen -W "cylinders sectors" -- $cur) )
> +			return 0

 the same situation, -u=

> +			;;
> +		'-C'|'-H'|'-S')
> +			COMPREPLY=( $(compgen -W "number" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-l -s -b -c -h -u -v -C -H -S"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -W "$(lsblk -o NAME,TYPE -n -r | awk '$2 ~ /disk/ {print "/dev/" $1}')" -- $cur) )
> +	return 0
> +}

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
