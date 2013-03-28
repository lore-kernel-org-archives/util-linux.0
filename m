Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f172.google.com ([209.85.216.172]:52530 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3C1Bm1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 21:42:27 -0400
Received: by mail-qc0-f172.google.com with SMTP id b25so3950456qca.17
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 18:42:26 -0700 (PDT)
Date: Wed, 27 Mar 2013 21:42:23 -0400
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/10] bash-completion: login-utils
Message-ID: <20130328014223.GX526@rampage>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:46PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  shell-completion/chfn     | 31 +++++++++++++++++++++++++++++++
>  shell-completion/chsh     | 23 +++++++++++++++++++++++
>  shell-completion/last     | 38 ++++++++++++++++++++++++++++++++++++++
>  shell-completion/login    | 27 +++++++++++++++++++++++++++
>  shell-completion/newgrp   | 16 ++++++++++++++++
>  shell-completion/su       | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  shell-completion/sulogin  | 24 ++++++++++++++++++++++++
>  shell-completion/utmpdump | 17 +++++++++++++++++
>  8 files changed, 221 insertions(+)
>  create mode 100644 shell-completion/chfn
>  create mode 100644 shell-completion/chsh
>  create mode 100644 shell-completion/last
>  create mode 100644 shell-completion/login
>  create mode 100644 shell-completion/newgrp
>  create mode 100644 shell-completion/su
>  create mode 100644 shell-completion/sulogin
>  create mode 100644 shell-completion/utmpdump
> 
> diff --git a/shell-completion/chfn b/shell-completion/chfn
> new file mode 100644
> index 0000000..1c5167a
> --- /dev/null
> +++ b/shell-completion/chfn
> @@ -0,0 +1,31 @@
> +_chfn_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-f'|'--full-name')
> +			COMPREPLY=( $(compgen -W "name" -- $cur) )
> +			return 0
> +			;;
> +		'-o'|'--office')
> +			COMPREPLY=( $(compgen -W "office" -- $cur) )
> +			return 0
> +			;;
> +		'-p'|'--office-phone'|'-h'|'--home-phone')
> +			COMPREPLY=( $(compgen -W "phone-nr" -- $cur) )
> +			return 0
> +			;;

I don't understand these. Given the previous argument being one of the
found flags, you're completing staticly defined strings. Why complete
anything at all?

> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-f --full-name -o --office -p --office-phone -h --home-phone -u --help -v --version"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -u -- $cur) )
> +	return 0
> +}
> +complete -F _chfn_module chfn
> diff --git a/shell-completion/chsh b/shell-completion/chsh
> new file mode 100644
> index 0000000..c0a194c
> --- /dev/null
> +++ b/shell-completion/chsh
> @@ -0,0 +1,23 @@
> +_chsh_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-s'|'--shell')
> +			COMPREPLY=( $(compgen -W "$(chsh -l)" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-s --shell -l --list-shells -V --version -u --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -u -- $cur) )
> +	return 0
> +}
> +complete -F _chsh_module chsh
> diff --git a/shell-completion/last b/shell-completion/last
> new file mode 100644
> index 0000000..493051e
> --- /dev/null
> +++ b/shell-completion/last
> @@ -0,0 +1,38 @@
> +_last_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-f')
> +			compopt -o filenames
> +			COMPREPLY=( $(compgen -f -- $cur) )
> +			return 0
> +			;;
> +		'-h')
> +			COMPREPLY=( $(compgen -A hostname -- $cur) )
> +			return 0
> +			;;
> +		'-i')
> +			COMPREPLY=( $(compgen -W "ipaddr" -- $cur) )
> +			return 0
> +			;;
> +		'-t')
> +			local TTYS
> +			TTYS=$(cd /sys/devices/virtual/tty && echo *)
> +			COMPREPLY=( $(compgen -W "$TTYS" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-f -h -i -l -t -y"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -u -- $cur) )
> +	return 0
> +}
> +complete -F _last_module last
> diff --git a/shell-completion/login b/shell-completion/login
> new file mode 100644
> index 0000000..c075f64
> --- /dev/null
> +++ b/shell-completion/login
> @@ -0,0 +1,27 @@
> +_login_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-f')
> +			COMPREPLY=( $(compgen -u -- $cur) )
> +			return 0
> +			;;
> +		'-h')
> +			COMPREPLY=( $(compgen -A hostname -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-p -f -h -H -V"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -u -- $cur) )
> +	return 0
> +}
> +complete -F _login_module login
> diff --git a/shell-completion/newgrp b/shell-completion/newgrp
> new file mode 100644
> index 0000000..567c08c
> --- /dev/null
> +++ b/shell-completion/newgrp
> @@ -0,0 +1,16 @@
> +_newgrp_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			OPTS="-V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	COMPREPLY=( $(compgen -g -- $cur) )
> +	return 0
> +}
> +complete -F _newgrp_module newgrp
> diff --git a/shell-completion/su b/shell-completion/su
> new file mode 100644
> index 0000000..ded4b7b
> --- /dev/null
> +++ b/shell-completion/su
> @@ -0,0 +1,45 @@
> +_su_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-'|'-u'|'--user')
> +			COMPREPLY=( $(compgen -u -- $cur) )
> +			return 0
> +			;;
> +		'-g'|'--group'|'-G'|'--supp-group')
> +			COMPREPLY=( $(compgen -g -- $cur) )
> +			return 0
> +			;;
> +		'-s'|'--shell')
> +			COMPREPLY=( $(compgen -W "$(chsh -l)" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="	-u --user
> +				-m -p --preserve-environment
> +				-g --group
> +				-G --supp-group
> +				- -l --login
> +				-c --command
> +				- -c
> +				--session-command
> +				-- -c

Please don't include the end of options marker in here. You appear to
have duplicated -c as well.

> +				-f --fast
> +				-s --shell
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
> +complete -F _su_module su
> +complete -F _su_module runuser
> diff --git a/shell-completion/sulogin b/shell-completion/sulogin
> new file mode 100644
> index 0000000..9fdc20e
> --- /dev/null
> +++ b/shell-completion/sulogin
> @@ -0,0 +1,24 @@
> +_sulogin_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> +	case $prev in
> +		'-t'|'--timeout')
> +			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	case $cur in
> +		-*)
> +			OPTS="-p --login-shell -t --timeout -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- ${cur:-"/dev/tty"}) )
> +	return 0
> +}
> +complete -F _sulogin_module sulogin
> diff --git a/shell-completion/utmpdump b/shell-completion/utmpdump
> new file mode 100644
> index 0000000..e306ef8
> --- /dev/null
> +++ b/shell-completion/utmpdump
> @@ -0,0 +1,17 @@
> +_utmpdump_module()
> +{
> +	local cur prev OPTS
> +	COMPREPLY=()
> +	cur="${COMP_WORDS[COMP_CWORD]}"
> +	case $cur in
> +		-*)
> +			OPTS="-f --follow -r --reverse -V --version -h --help"
> +			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
> +			return 0
> +			;;
> +	esac
> +	compopt -o filenames
> +	COMPREPLY=( $(compgen -f -- $cur) )
> +	return 0
> +}
> +complete -F _utmpdump_module utmpdump
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
