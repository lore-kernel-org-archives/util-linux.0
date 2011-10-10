Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36271 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1JJTpa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 15:45:30 -0400
Received: by vws1 with SMTP id 1so4914336vws.19
        for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 12:45:30 -0700 (PDT)
Date: Mon, 10 Oct 2011 15:45:45 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <20111010194545.GB8822@rampage>
References: <1318173125-16156-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318173125-16156-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 09, 2011 at 11:12:04AM -0400, Dave Reisner wrote:
> There's only one condition for which we declare success, but many for
> failure. Initialize rc as failure and set to success on this single
> condition. In all cases, jump to a label to exit instead of exiting
> immediately. This will be used later on to ease cleanup of any heap
> allocations.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---

Noticing that this could be done better -- the return/goto calls here
don't do anything because err/errx are exiting after throwing the error
message. They should be replaced with equivalent warn/warnx calls so we
hit the goto on error and cleanup before exiting.

@Karel: I can resend this if you like.

Regards,
dave

>  sys-utils/mountpoint.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
> index 1297d82..e021c70 100644
> --- a/sys-utils/mountpoint.c
> +++ b/sys-utils/mountpoint.c
> @@ -105,7 +105,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>  
>  int main(int argc, char **argv)
>  {
> -	int c, fs_devno = 0, dev_devno = 0, rc = 0;
> +	int c, fs_devno = 0, dev_devno = 0, rc = EXIT_FAILURE;
>  	char *spec;
>  	struct stat st;
>  
> @@ -152,7 +152,7 @@ int main(int argc, char **argv)
>  	if (stat(spec, &st)) {
>  		if (!quiet)
>  			err(EXIT_FAILURE, "%s", spec);
> -		return EXIT_FAILURE;
> +		goto finish;
>  	}
>  	if (dev_devno)
>  		rc = print_devno(spec, &st);
> @@ -162,19 +162,22 @@ int main(int argc, char **argv)
>  		if (!S_ISDIR(st.st_mode)) {
>  			if (!quiet)
>  				errx(EXIT_FAILURE, _("%s: not a directory"), spec);
> -			return EXIT_FAILURE;
> +			goto finish;
>  		}
>  		src = dir_to_device(spec);
>  		if (src == (dev_t)-1) {
>  			if (!quiet)
>  				printf(_("%s is not a mountpoint\n"), spec);
> -			return EXIT_FAILURE;
> +			goto finish;
>  		}
>  		if (fs_devno)
>  			printf("%u:%u\n", major(src), minor(src));
> -		else if (!quiet)
> +		else if (!quiet) {
>  			printf(_("%s is a mountpoint\n"), spec);
> +			rc = EXIT_SUCCESS;
> +		}
>  	}
>  
> -	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
> +finish:
> +	return rc;
>  }
> -- 
> 1.7.7
> 
