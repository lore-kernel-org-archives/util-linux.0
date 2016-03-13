Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:47993 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbcCMMME (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 08:12:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1af4sK-000327-70
	for util-linux@vger.kernel.org; Sun, 13 Mar 2016 13:12:00 +0100
Received: from ppp37-190-56-84.pppoe.spdop.ru ([37.190.56.84])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 13:12:00 +0100
Received: from yumkam by ppp37-190-56-84.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 13:12:00 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 02/10] getopt: fix memory leaks and integer overflows [ASAN & valgrind]
Date: Sun, 13 Mar 2016 15:11:54 +0300
Message-ID: <m37fh6inlh.fsf@gmail.com>
References: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
	<1457865109-2881-3-git-send-email-kerolasa@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 03/13/16 13:31 , Sami Kerola wrote:
> The getopt(1) is short living command, and one could argue ensuring all
> allocations are freed at end of execution is waste of time.  There is a
> point in that, but making test-suite runs to be less noisy with ASAN is also
> nice as it encourages reading the errors when/if they happen.
>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/getopt.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
> index c4144f6..be2ed38 100644
> --- a/misc-utils/getopt.c
> +++ b/misc-utils/getopt.c
> @@ -79,13 +79,23 @@
>  /* The shells recognized. */
>  typedef enum { BASH, TCSH } shell_t;
>  
> +/* This is a copy of getopt_long(3) structure, in which *name does not have
> + * const, so that is can be free'd at end of execution.  */
> +struct getoption {
> +	char *name;
> +	int has_arg;
> +	int *flag;
> +	int val;
> +};

What will happen if some implementation will add new fields in `struct
option`? (Sure, unlikely, but).
IMO, `free((char *)option->name)` is *much* safer.

>  struct getopt_control {
>  	shell_t shell;			/* the shell we generate output for */
>  	char *optstr;			/* getopt(3) optstring */
> -	struct option *long_options;	/* long options */
> +	struct getoption *long_options;	/* long options */
>  	int long_options_length;	/* length of options array */
>  	int long_options_nr;		/* number of used elements in array */
>  	unsigned int
> +		free_name:1,		/* free up argv[0] after printout */
>  		compatible:1,		/* compatibility mode for 'difficult' programs */
>  		quiet_errors:1,		/* print errors */
>  		quiet_output:1,		/* print output */
> @@ -181,7 +191,7 @@ static void print_normalized(const struct getopt_control *ctl, const char *arg)
>   * optstr must contain the short options, and longopts the long options.
>   * Other settings are found in global variables.
>   */
> -static int generate_output(const struct getopt_control *ctl, char *argv[], int argc)
> +static int generate_output(struct getopt_control *ctl, char *argv[], int argc)
>  {
>  	int exit_code = EXIT_SUCCESS;	/* Assume everything will be OK */
>  	int opt;
> @@ -195,8 +205,10 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
>  	optind = 0;
>  
>  	while ((opt =
> -		(getopt_long_fp(argc, argv, ctl->optstr, ctl->long_options, &longindex)))
> -	       != EOF)
> +		(getopt_long_fp
> +		 (argc, argv, ctl->optstr,
> +		  (const struct option *)ctl->long_options, &longindex)))
> +	       != EOF) {
>  		if (opt == '?' || opt == ':')
>  			exit_code = GETOPT_EXIT_CODE;
>  		else if (!ctl->quiet_output) {
> @@ -216,13 +228,19 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
>  					print_normalized(ctl, optarg ? optarg : "");
>  			}
>  		}
> -
> +	}
>  	if (!ctl->quiet_output) {
>  		printf(" --");
>  		while (optind < argc)
>  			print_normalized(ctl, argv[optind++]);
>  		printf("\n");
>  	}
> +	for (longindex = 0; longindex < ctl->long_options_nr; longindex++)
> +		free(ctl->long_options[longindex].name);
> +	free(ctl->long_options);
> +	free(ctl->optstr);
> +	if (ctl->free_name)
> +		free(argv[0]);
>  	return exit_code;
>  }
>  
> @@ -373,9 +391,6 @@ int main(int argc, char *argv[])
>  	textdomain(PACKAGE);
>  	atexit(close_stdout);
>  
> -	add_longopt(&ctl, NULL, 0);	/* init */
> -	getopt_long_fp = getopt_long;
> -
>  	if (getenv("GETOPT_COMPATIBLE"))
>  		ctl.compatible = 1;
>  
> @@ -391,6 +406,9 @@ int main(int argc, char *argv[])
>  			parse_error(_("missing optstring argument"));
>  	}
>  
> +	add_longopt(&ctl, NULL, 0);	/* init */
> +	getopt_long_fp = getopt_long;
> +
>  	if (argv[1][0] != '-' || ctl.compatible) {
>  		ctl.quote = 0;
>  		ctl.optstr = xmalloc(strlen(argv[1]) + 1);
> @@ -417,6 +435,7 @@ int main(int argc, char *argv[])
>  		case 'n':
>  			free(name);
>  			name = xstrdup(optarg);
> +			ctl.free_name = 1;
>  			break;
>  		case 'q':
>  			ctl.quiet_errors = 1;
> @@ -428,6 +447,7 @@ int main(int argc, char *argv[])
>  			ctl.shell = shell_type(optarg);
>  			break;
>  		case 'T':
> +			free(ctl.long_options);
>  			return TEST_EXIT_CODE;
>  		case 'u':
>  			ctl.quote = 0;
> -- 
> 2.7.2

