Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:56741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdFIMBe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Jun 2017 08:01:34 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 02/11] line: do not print new line if nothing else was printed
Date: Fri, 9 Jun 2017 14:01:23 +0200
Cc: util-linux@vger.kernel.org
References: <20170608195215.1702-1-kerolasa@iki.fi> <20170608195215.1702-3-kerolasa@iki.fi>
In-Reply-To: <20170608195215.1702-3-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706091401.24156.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 08 June 2017, Sami Kerola wrote:
> Earlier the following printed stray new line.
>
> $ printf "" | ./line

This breaks test "misc/line", see commit caad4ded
and
https://github.com/karelzak/util-linux/issues/236

> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  text-utils/line.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/text-utils/line.c b/text-utils/line.c
> index 486e5dd31..ae10809c2 100644
> --- a/text-utils/line.c
> +++ b/text-utils/line.c
> @@ -42,7 +42,7 @@ static void __attribute__((__noreturn__))
> usage(FILE *out) int main(int argc, char **argv)
>  {
>  	wint_t c;
> -	int opt;
> +	int opt, print_nl = 0;
>  	int status = EXIT_SUCCESS;
>
>  	static const struct option longopts[] = {
> @@ -77,8 +77,10 @@ int main(int argc, char **argv)
>  		if (c == '\n')
>  			break;
>  		putwchar(c);
> +		print_nl = 1;
>  	}
> -	putwchar(L'\n');
> +	if (print_nl)
> +		putwchar(L'\n');
>
>  	return status;
>  }
