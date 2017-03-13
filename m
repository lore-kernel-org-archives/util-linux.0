Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36297 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751941AbdCMNoB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 09:44:01 -0400
Date: Mon, 13 Mar 2017 14:43:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/13] lib/colors: assert rathen than overflow
Message-ID: <20170313134354.ximcvarayhcv7b5s@ws.net.home>
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-14-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170305205232.24030-14-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 05, 2017 at 08:52:32PM +0000, Sami Kerola wrote:
> lib/colors.c: In function 'colors_read_schemes':
> lib/colors.c:412:7: warning: potential null pointer dereference [-Wnull-dereference]
>   *out = '\0';
>   ~~~~~^~~~~~
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  lib/colors.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/colors.c b/lib/colors.c
> index 4b280fe27..baafe0a90 100644
> --- a/lib/colors.c
> +++ b/lib/colors.c
> @@ -342,6 +342,7 @@ static char *colors_get_homedir(char *buf, size_t bufsz)
>  static int cn_sequence(const char *str, char **seq)
>  {
>  	char *in, *out;
> +	int len;
>  
>  	if (!str)
>  		return -EINVAL;
> @@ -357,7 +358,7 @@ static int cn_sequence(const char *str, char **seq)
>  	}
>  
>  	/* convert xx;yy sequences to "\033[xx;yy" */
> -	if (asprintf(seq, "\033[%sm", str) < 1)
> +	if ((len = asprintf(seq, "\033[%sm", str)) < 1)
>  		return -ENOMEM;
>  
>  	for (in = *seq, out = *seq; in && *in; in++) {
> @@ -409,6 +410,7 @@ static int cn_sequence(const char *str, char **seq)
>  		}
>  		in++;
>  	}
> +	assert (len < (out - *seq));

This seems incorrect. Should be:

    assert ((out - *seq) <= len);

note that asprintf() returns size without terminating byte.

Hmm.. we have no test_colors used in our regression tests. Simple
test:

 $ echo 'mybell \a' > ~/.config/terminal-colors.d/foo.scheme
 $ TERMINAL_COLORS_DEBUG=all ./test_colors --name foo --color-scheme mybell

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
