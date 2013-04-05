Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161562Ab3DEOpD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Apr 2013 10:45:03 -0400
Date: Fri, 5 Apr 2013 16:44:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] bash-completion: sys-utils
Message-ID: <20130405144453.GL14350@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:49PM +0000, Sami Kerola wrote:
> diff --git a/shell-completion/swapon b/shell-completion/swapon
> new file mode 100644
> index 0000000..83e7e24
> --- /dev/null
> +++ b/shell-completion/swapon
> @@ -0,0 +1,48 @@
> +_swapon_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-p'|'--priority')
> +			# Priority range is -1 to 32767.  Perhaps these
> +			# few are enough.
> +			COMPREPLY=( $(compgen -W "$(echo {-1..9} 32767)" -- $cur) )
> +			return 0
> +			;;
> +		'--show')
> +			# FIXME: how to append to a string with compgen?
> +			local OUTPUT
> +			OUTPUT="NAME TYPE SIZE USED PRIO"
> +			compopt -o nospace
> +			COMPREPLY=( $(compgen -W "$OUTPUT" -S ',' -- $cur) )
> +			return 0
> +			;;

What about to -L <label> and -U <uuid>? For example:

  lsblk -nrp -o FSTYPE,UUID | awk '$1 ~ /swap/ { print $2 }'

returns all swaps UUIDs

> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-a --all
> +				-d --discard
> +				-e --ifexists
> +				-f --fixpgsz
> +				-p --priority
> +				-s --summary
> +				   --show
> +				   --noheadings
> +				   --raw
> +				   --bytes
> +				-v --verbose
> +				-h --help
> +				-V --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	# FIXME: compgen will split SPEC= from '=' point.  The append
> +	# comma separated value problem is very similar.
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}

 Would be better to offer list of block devices where is swap header?

   lsblk -nrp -o FSTYPE,NAME | awk '$1 ~ /swap/ { print $2 }'

 rather than list of files? I think that swap to files is unusual.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
