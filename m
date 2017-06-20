Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54798 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdFTJfr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 05:35:47 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MZxch-1d5IWF3VvT-00Lo3I for <util-linux@vger.kernel.org>; Tue, 20 Jun 2017
 11:35:44 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] agetty: cleanup usage issues
Date: Tue, 20 Jun 2017 11:35:43 +0200
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de> <1497872174-9852-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1497872174-9852-5-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706201135.43824.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 19 June 2017, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Fixed checkusage.sh warnings:
>   agetty: --unknownopt, stderr too long: 45
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  term-utils/agetty.c | 102
> ++++++++++++++++++++++++++-------------------------- 1 file changed,
> 51 insertions(+), 51 deletions(-)
>
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 938fa2f..542cbce 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -308,7 +308,7 @@ static void termio_final(struct options *op,
>  			 struct termios *tp, struct chardata *cp);
>  static int caps_lock(char *s);
>  static speed_t bcode(char *s);
> -static void usage(FILE * out) __attribute__((__noreturn__));
> +static void usage(void) __attribute__((__noreturn__));
>  static void log_err(const char *, ...) __attribute__((__noreturn__))
>  			       __attribute__((__format__(printf, 1, 2)));
>  static void log_warn (const char *, ...)
> @@ -785,9 +785,9 @@ static void parse_args(int argc, char **argv,
> struct options *op) printf(UTIL_LINUX_VERSION);
>  			exit(EXIT_SUCCESS);
>  		case HELP_OPTION:
> -			usage(stdout);
> +			usage();
>  		default:
> -			usage(stderr);
> +			errtryhelp(EXIT_FAILURE);
>  		}
>  	}
>
> @@ -795,7 +795,7 @@ static void parse_args(int argc, char **argv,
> struct options *op)
>
>  	if (argc < optind + 1) {
>  		log_warn(_("not enough arguments"));
> -		usage(stderr);
> +		errtryhelp(EXIT_FAILURE);
>  	}

BTW here we print the real warning to syslog only. But a few lines below 
we have this
            warn(_("not enough arguments"));
            errtryhelp(EXIT_FAILURE);

Could somebody review this, I'm not sure when agetty is allowed to write 
to the terminal and when not. 

cu,
Rudi
