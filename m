Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:50900 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaDLP5i (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 11:57:38 -0400
Message-ID: <53496267.80502@bernhard-voelker.de>
Date: Sat, 12 Apr 2014 17:57:27 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] kill: make options --pid and --queue mutually exclusive
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi> <1397298524-3364-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-2-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 04/12/2014 12:28 PM, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/kill.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/misc-utils/kill.c b/misc-utils/kill.c
> index d461b36..e678661 100644
> --- a/misc-utils/kill.c
> +++ b/misc-utils/kill.c
> @@ -381,6 +381,10 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
>  			ctl->do_pid = 1;
>  			if (ctl->do_kill)
>  				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
> +#ifdef HAVE_SIGQUEUE
> +			if (ctl->use_sigval)
> +				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
> +#endif
>  			continue;
>  		}
>  		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
> @@ -399,6 +403,8 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
>  		if (!strcmp(arg, "-q") || !strcmp(arg, "--queue")) {
>  			if (argc < 2)
>  				errx(EXIT_FAILURE, _("option '%s' requires an argument"), arg);
> +			if (ctl->do_pid)
> +				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
>  			argc--, argv++;
>  			arg = *argv;
>  			if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
> 

Ain't this a good case for
  err_exclusive_options(c, longopts, excl, excl_st);
?

Have a nice day,
Berny


