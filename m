Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:4732 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3EFALe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 May 2013 20:11:34 -0400
Message-ID: <5186F533.2060905@draigBrady.com>
Date: Mon, 06 May 2013 01:11:31 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/16] cal: add --highligth option which uses argmatch
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi> <1367520701-14962-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-10-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/02/2013 07:51 PM, Sami Kerola wrote:
> This switch will allow an user to choose when highlighting is outputed.
> The default remains the same as it has been, e.g., highlighting is used
> depending on whether stdout is a terminal or not.
> 
> CC: Pádraig Brady <P@draigBrady.com>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/Makemodule.am |  2 +-
>  misc-utils/cal.c         | 40 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
> index a615047..3f95458 100644
> --- a/misc-utils/Makemodule.am
> +++ b/misc-utils/Makemodule.am
> @@ -10,7 +10,7 @@ if !HAVE_LANGINFO
>  cal_SOURCES += lib/langinfo.c
>  endif
>  
> -cal_LDADD = $(LDADD)
> +cal_LDADD = $(LDADD) libcommon.la
>  
>  if HAVE_TINFO
>  cal_LDADD += -ltinfo @NCURSES_LIBS@
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 665dbcd..cf50c57 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -66,6 +66,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  
> +#include "argmatch.h"
>  #include "c.h"
>  #include "closestream.h"
>  #include "nls.h"
> @@ -256,6 +257,24 @@ main(int argc, char **argv) {
>  	int ch, day = 0, month = 0, year = 0, yflag = 0;
>  	int num_months = NUM_MONTHS;
>  
> +	enum Highlight_type {
> +		HIGHLIGHT_UNUSED,
> +		HIGHLIGHT_NEVER,
> +		HIGHLIGHT_AUTO,
> +		HIGHLIGHT_ALWAYS
> +	};
> +	int highlight = HIGHLIGHT_AUTO;
> +	static char const *const highlight_type_string[] = {
> +		"never", "auto", "always", NULL
> +	};
> +	static enum Highlight_type const highlight_type[] = {
> +		HIGHLIGHT_NEVER, HIGHLIGHT_AUTO, HIGHLIGHT_ALWAYS
> +	};
> +
> +	enum {
> +		OPT_HIGHLIGHT = CHAR_MAX + 1
> +	};
> +
>  	static const struct option longopts[] = {
>  		{"one", no_argument, NULL, '1'},
>  		{"three", no_argument, NULL, '3'},
> @@ -263,6 +282,7 @@ main(int argc, char **argv) {
>  		{"monday", no_argument, NULL, 'm'},
>  		{"julian", no_argument, NULL, 'j'},
>  		{"year", no_argument, NULL, 'y'},
> +		{"highlight", required_argument, NULL, OPT_HIGHLIGHT},

I'd have it as an optional arg, defaulting to auto.

>  		{"version", no_argument, NULL, 'V'},
>  		{"help", no_argument, NULL, 'h'},
>  		{NULL, 0, NULL, 0}
> @@ -340,6 +360,9 @@ main(int argc, char **argv) {
>  		case 'y':
>  			yflag = 1;
>  			break;
> +		case OPT_HIGHLIGHT:
> +			highlight = XARGMATCH("--highlight", optarg, highlight_type_string, highlight_type);
> +			break;
>  		case 'V':
>  			printf(UTIL_LINUX_VERSION);
>  			return EXIT_SUCCESS;
> @@ -391,8 +414,21 @@ main(int argc, char **argv) {
>  	}
>  	headers_init(julian);
>  
> -	if (!isatty(STDOUT_FILENO))
> -		day = 0; /* don't highlight */
> +	switch (highlight) {
> +	case HIGHLIGHT_NEVER:
> +		day = 0;
> +		break;
> +	case HIGHLIGHT_AUTO:
> +		if (!isatty(STDOUT_FILENO))
> +			day = 0;	/* don't highlight */
> +		break;
> +	case HIGHLIGHT_ALWAYS:
> +		if (day == 0)
> +			day = local_time->tm_yday + 1;;

s/;;/;/ shellism :)

> +		break;
> +	default:
> +		abort();
> +	}
>  
>  	if (yflag)
>  		yearly(day, year, julian);
> 

s/highligth/highlight/ in the subject line

Also I'd s/--highlight/--color/ to align with dmesg and other utils.
Only highlighting is done at present, but that could be set up
to use color in the user's environment.  Also in future other parts
of the output could be colored etc.

BTW, dmesg could get the same support for specifying "always" and "never".

thanks!
Pádraig.
