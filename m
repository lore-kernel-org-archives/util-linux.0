Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43634 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbaLOJpY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Dec 2014 04:45:24 -0500
Date: Mon, 15 Dec 2014 10:45:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/16] chfn: clean up parse_argv()
Message-ID: <20141215094513.GY19904@x2.net.home>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
 <1418579052-29386-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418579052-29386-15-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 14, 2014 at 05:44:10PM +0000, Sami Kerola wrote:
> Use switch() case ?: for all option parsing, as in most of the other
> source files.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/chfn.c | 48 ++++++++++++++++++------------------------------
>  1 file changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/login-utils/chfn.c b/login-utils/chfn.c
> index 81abd11..0d37a32 100644
> --- a/login-utils/chfn.c
> +++ b/login-utils/chfn.c
> @@ -121,11 +121,11 @@ static int check_gecos_string(const char *msg, char *gecos)
>   *	parse the command line arguments.
>   *	returns true if no information beyond the username was given.
>   */
> -static void parse_argv(struct chfn_control *ctl, int argc, char *argv[], struct finfo *pinfo)
> +static void parse_argv(struct chfn_control *ctl, int argc, char *argv[],
> +		       struct finfo *pinfo)
>  {
> -	int index, c, status;
> -
> -	static struct option long_options[] = {
^^^^^^^^^^^^
> +	int index, c, status = 0;
> +	const struct option long_options[] = {

static

>  		{"full-name", required_argument, 0, 'f'},
>  		{"office", required_argument, 0, 'o'},
>  		{"office-phone", required_argument, 0, 'p'},
> @@ -135,49 +135,37 @@ static void parse_argv(struct chfn_control *ctl, int argc, char *argv[], struct
>  		{NULL, no_argument, 0, '0'},
>  	};
>  
> -	optind = 0;
> -	while (true) {
> -		c = getopt_long(argc, argv, "f:r:p:h:o:uv", long_options,
> -				&index);
> -		if (c == -1)
> -			break;
> -		/* version?  output version and exit. */
> -		if (c == 'v') {
> -			printf(UTIL_LINUX_VERSION);
> -			exit(EXIT_SUCCESS);
> -		}
> -		if (c == 'u')
> -			usage(stdout);
> -		/* all other options must have an argument. */
> -		if (!optarg)
> -			usage(stderr);
> -		/* ok, we were given an argument */
> -		ctl->interactive = 0;
> -
> -		/* now store the argument */
> +	while ((c = getopt_long(argc, argv, "f:r:p:h:o:uv", long_options,
> +				&index)) != -1) {
>  		switch (c) {
>  		case 'f':
>  			pinfo->full_name = optarg;
> -			status = check_gecos_string(_("Name"), optarg);
> +			status += check_gecos_string(_("Name"), optarg);
>  			break;
>  		case 'o':
>  			pinfo->office = optarg;
> -			status = check_gecos_string(_("Office"), optarg);
> +			status += check_gecos_string(_("Office"), optarg);
>  			break;
>  		case 'p':
>  			pinfo->office_phone = optarg;
> -			status = check_gecos_string(_("Office Phone"), optarg);
> +			status += check_gecos_string(_("Office Phone"), optarg);
>  			break;
>  		case 'h':
>  			pinfo->home_phone = optarg;
> -			status = check_gecos_string(_("Home Phone"), optarg);
> +			status += check_gecos_string(_("Home Phone"), optarg);
>  			break;
> +		case 'v':
> +			printf(UTIL_LINUX_VERSION);
> +			exit(EXIT_SUCCESS);
> +		case 'u':
> +			usage(stdout);
>  		default:
>  			usage(stderr);
>  		}
> -		if (status != 0)
> -			exit(EXIT_FAILURE);
> +		ctl->interactive = 0;
>  	}
> +	if (status != 0)
> +		exit(EXIT_FAILURE);
>  	/* done parsing arguments.  check for a username. */
>  	if (optind < argc) {
>  		if (optind + 1 < argc)
> -- 
> 2.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
