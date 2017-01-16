Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbdAPLZa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Jan 2017 06:25:30 -0500
Date: Mon, 16 Jan 2017 12:25:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] last: use --time-format instruction when printing wtmp
 creation time
Message-ID: <20170116112528.x72dn2pcxjxbfjp7@ws.net.home>
References: <20170115101718.8885-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170115101718.8885-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 15, 2017 at 10:17:18AM +0000, Sami Kerola wrote:
> This makes --time-format=iso timestamp to look the same as login/logout
> times.  When --time-format=noformat is used the file creation time not
> printed.  There is no change to default format.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/last.c             | 18 +++++++++++++++---
>  tests/expected/utmp/last-nodns |  4 +---
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/login-utils/last.c b/login-utils/last.c
> index 7c243f147..484e18e80 100644
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -874,11 +874,23 @@ static void process_wtmp_file(const struct last_control *ctl,
>  		}
>  	}
>  
> -	{
> -		char* tmp = xstrdup(filename);
> -		printf(_("\n%s begins %s"), basename(tmp), ctime(&begintime));
> +	if (ctl->time_fmt != LAST_TIMEFTM_NONE) {
> +		struct last_timefmt *fmt;
> +		char timestr[LAST_TIMESTAMP_LEN];
> +		size_t len;
> +		char *tmp = xstrdup(filename);
> +
> +		fmt = &timefmts[ctl->time_fmt];
> +		if (time_formatter(fmt->in_fmt, timestr,
> +				   sizeof(timestr), &begintime) < 0)
> +			errx(EXIT_FAILURE, _("preallocation size exceeded"));
> +		len = strlen(timestr) - 1;
> +		if (timestr[len] == '\n')
> +			timestr[len] = '\0';

Do we expect this '\n' somewhere in the code?

I guess that also for LAST_TIMEFTM_CTIME is the \n char truncated.
What about to remove \n from the string in the time_formatter() to
avoid this timestr[len] = '\0' in the code?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
