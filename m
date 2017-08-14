Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25447 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbdHNJNB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Aug 2017 05:13:01 -0400
Date: Mon, 14 Aug 2017 11:12:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] look: use WORDLIST environment variable to find word list
Message-ID: <20170814091257.rq7kqgoi4vsqo2rb@ws.net.home>
References: <20170812083208.1208-1-kerolasa@iki.fi>
 <20170812083208.1208-2-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170812083208.1208-2-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 12, 2017 at 09:32:08AM +0100, Sami Kerola wrote:
> The WORDLIST is the same hunspell(1) and ispell(1) uses to achieve the same.
> Apparently aspell(1) does not work with files like traditional dict lists.
> 
> Reference: https://github.com/hunspell/hunspell/blob/master/man/hunspell.1#L388
> Reference: http://www.skrenta.com/rt/man/ispell.1.html
> Reference: http://aspell.net/man-html/Creating-an-Individual-Word-List.html#Creating-an-Individual-Word-List
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/look.1 | 5 +++++
>  misc-utils/look.c | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/misc-utils/look.1 b/misc-utils/look.1
> index 503e38584..cca83416e 100644
> --- a/misc-utils/look.1
> +++ b/misc-utils/look.1
> @@ -101,6 +101,11 @@ sort -d /etc/passwd -o /tmp/look.dict
>  look -t: root:foobar /tmp/look.dict
>  .nf
>  .RE
> +.SH ENVIRONMENT
> +.TP
> +.B WORDLIST
> +Path to a dictionary file.  The environment variable has greater priority
> +than the dictionary path defined in FILES segment.
>  .SH FILES
>  .IP "\fB/usr/share/dict/words\fR" 4
>  the dictionary
> diff --git a/misc-utils/look.c b/misc-utils/look.c
> index 60fbbbfca..00061f2a3 100644
> --- a/misc-utils/look.c
> +++ b/misc-utils/look.c
> @@ -104,7 +104,12 @@ main(int argc, char *argv[])
>  
>  	setlocale(LC_ALL, "");
>  
> -	file = _PATH_WORDS;
> +	if ((file = getenv("WORDLIST"))) {
> +		if (access(file, R_OK))
> +			err(EXIT_FAILURE, "WORDLIST=%s", file);
> +	} else
> +		file = _PATH_WORDS;
> +


Would be better fallback to _PATH_WORDS if WORDLIST= points to
nowhere?

    file = _PATH_WORDS; /* default */
    if ((x = getenv("WORDLIST")) && access(file, R_OK) == 0)
        file = x;

seems like more backwardly compatible way.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
