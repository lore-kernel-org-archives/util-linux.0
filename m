Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbcEKIyW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 May 2016 04:54:22 -0400
Date: Wed, 11 May 2016 10:54:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/12] write: improve coding style
Message-ID: <20160511085420.y6menmghp6qydbac@ws.net.home>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
 <1462829248-6935-12-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462829248-6935-12-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 09, 2016 at 10:27:27PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/write.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/term-utils/write.c b/term-utils/write.c
> index b10c129..e3e749e 100644
> --- a/term-utils/write.c
> +++ b/term-utils/write.c
> @@ -76,7 +76,7 @@ struct write_control {
>  	char dst_tty[PATH_MAX];
>  };
>  
> -static void __attribute__ ((__noreturn__)) usage(FILE * out)
> +static void __attribute__((__noreturn__)) usage(FILE *out)
>  {
>  	fputs(USAGE_HEADER, out);
>  	fprintf(out,
> @@ -199,11 +199,9 @@ static void search_utmp(struct write_control *ctl)
>  			return;
>  		}
>  		errx(EXIT_FAILURE, _("%s has messages disabled"), ctl->dst_login);
> -	} else if (valid_ttys > 1) {
> +	} else if (valid_ttys > 1)
>  		warnx(_("%s is logged in more than once; writing to %s"),
>  		      ctl->dst_login, ctl->dst_tty);
> -	}
> -
>  }
>  
>  /*
> @@ -215,6 +213,15 @@ static void signal_handler(int signo)
>  }
>  
>  /*
> + * PUTC - fputc_careful wrapper
> + */
> +static inline void PUTC(char c)
> +{
> +	if (fputc_careful(c, stdout, '^') == EOF)
> +		err(EXIT_FAILURE, _("carefulputc failed"));
> +}
> +
> +/*
>   * write_line - like fputs(), but makes control characters visible and
>   *     turns \n into \r\n.
>   */
> @@ -222,8 +229,6 @@ static void write_line(char *s)
>  {
>  	char c;
>  
> -#define	PUTC(c)	if (fputc_careful(c, stdout, '^') == EOF) \
> -    err(EXIT_FAILURE, _("carefulputc failed"));
>  	while (*s) {
>  		c = *s++;
>  		if (c == '\n')
> @@ -231,7 +236,6 @@ static void write_line(char *s)
>  		PUTC(c);
>  	}
>  	return;
> -#undef PUTC
>  }

You do not need the crazy macro at all

   while (*s) {
        int rc = 0;
        int c = *s++;

        if (c == '\n')
            rc = fputc_careful('\n', stdout, '^');
        if (rc == 0)
            rc = fputc_careful(c, stdout, '^');
        if (rc == EOF)
            err(EXIT_FAILURE, _("carefulputc failed"));
   }

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
