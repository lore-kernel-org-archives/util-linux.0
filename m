Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f54.google.com ([209.85.128.54]:60764 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab3IBXWm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Sep 2013 19:22:42 -0400
Received: by mail-qe0-f54.google.com with SMTP id cz11so1199869qeb.27
        for <util-linux@vger.kernel.org>; Mon, 02 Sep 2013 16:22:41 -0700 (PDT)
Date: Mon, 2 Sep 2013 19:22:39 -0400
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/15] hexdump: remove unnecessary global variables
Message-ID: <20130902232239.GA6888@rampage>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
 <1371408836-16663-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371408836-16663-15-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 16, 2013 at 07:53:55PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  text-utils/display.c | 6 +++---
>  text-utils/hexdump.c | 4 ++--
>  text-utils/hexdump.h | 2 --
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/text-utils/display.c b/text-utils/display.c
> index 1f9a11b..41ddd8d 100644
> --- a/text-utils/display.c
> +++ b/text-utils/display.c
> @@ -295,7 +295,7 @@ get(void)
>  int next(char **argv)
>  {
>  	static int done;
> -	int statok;
> +	int statok, exitval = 0;
>  
>  	if (argv) {
>  		_argv = argv;
> @@ -305,14 +305,14 @@ int next(char **argv)
>  		if (*_argv) {
>  			if (!(freopen(*_argv, "r", stdin))) {
>  				warn("%s", *_argv);
> -				exitval = EXIT_FAILURE;
> +				exitval = 1;
>  				++_argv;
>  				continue;
>  			}
>  			statok = done = 1;
>  		} else {
>  			if (done++)
> -				return(0);
> +				return(exitval);
>  			statok = 0;
>  		}
>  		if (skip)
> diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
> index e966cc3..411d809 100644
> --- a/text-utils/hexdump.c
> +++ b/text-utils/hexdump.c
> @@ -47,11 +47,11 @@
>  
>  FS *fshead;				/* head of format strings */
>  ssize_t blocksize;			/* data block size */
> -int exitval;				/* final exit value */
>  ssize_t length = -1;			/* max bytes to read */
>  
>  int main(int argc, char **argv)
>  {
> +	int exitval;			/* final exit value */
>  	FS *tfs;
>  	char *p;
>  
> @@ -76,7 +76,7 @@ int main(int argc, char **argv)
>  	for (tfs = fshead; tfs; tfs = tfs->nextfs)
>  		rewrite(tfs);
>  
> -	(void)next(argv);
> +	exitval = next(argv);

A little late to the game, but this commit breaks the return value of
hexdump and causes it to always return 1, even on successful invocation.
next(char**) will always return 1 for the usual (non-NULL) values of argv.

d

>  	display();
>  	return exitval;
>  }
> diff --git a/text-utils/hexdump.h b/text-utils/hexdump.h
> index b9e67a1..b2ea1f1 100644
> --- a/text-utils/hexdump.h
> +++ b/text-utils/hexdump.h
> @@ -73,8 +73,6 @@ typedef struct _fs {			/* format strings */
>  extern FU *endfu;
>  extern FS *fshead;			/* head of format strings list */
>  extern ssize_t blocksize;		/* data block size */
> -extern int deprecated;			/* od compatibility */
> -extern int exitval;			/* final exit value */
>  extern ssize_t length;			/* max bytes to read */
>  extern off_t skip;                      /* bytes to skip */
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
