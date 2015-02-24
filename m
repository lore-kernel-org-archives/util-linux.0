Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbbBXMSL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 07:18:11 -0500
Date: Tue, 24 Feb 2015 13:18:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/16] tailf: ensure file argument really is a file
Message-ID: <20150224121800.GO19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-15-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:44PM +0000, Sami Kerola wrote:
>  text-utils/tailf.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/text-utils/tailf.c b/text-utils/tailf.c
> index d856203..7f053a4 100644
> --- a/text-utils/tailf.c
> +++ b/text-utils/tailf.c
> @@ -233,6 +233,28 @@ static long old_style_option(int *argc, char **argv, unsigned long *lines)
>  	return ret;
>  }
>  
> +static int is_file(const char *filename, const struct stat sb)
> +{
> +	switch (sb.st_mode & S_IFMT) {
> +	case S_IFREG:
> +		return 0;
> +	case S_IFLNK:
> +		{
> +			char *resolved_path = NULL;
> +			struct stat follow;
> +			int ret;
> +
> +			if (realpath(filename, resolved_path)) {
> +				stat(resolved_path, &follow);
> +				ret = is_file(resolved_path, follow);
> +				free(resolved_path);
> +				return ret;
> +			}
> +		}

 but you use stat() and no lstat(), so you don't have to care about
 symlinks, right? :-)

>  	if (stat(filename, &old) != 0)
>  		err(EXIT_FAILURE, _("stat of %s failed"), filename);

 if (IS_REG(old.st_mode))
        errx(EXIT_FAILURE, _("%s: is not a file"), filename);

> +	if (is_file(filename, old))
> +		errx(EXIT_FAILURE, _("%s: is not a file"), filename);
>  	if (lines && old.st_size)
>  		tailf(filename, lines, &old);

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
