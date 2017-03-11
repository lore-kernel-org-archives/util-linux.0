Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753818AbdCKROS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 11 Mar 2017 12:14:18 -0500
Subject: Re: [PATCH 07/13] blkid: define output names only once
To: Sami Kerola <kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-8-kerolasa@iki.fi>
 <c0779c68-d9cf-0eb0-f8e4-91130ee57db9@gmx.com>
 <1998d830-63b1-a477-d5ae-4219171c0b3c@gmx.com>
 <alpine.LNX.2.20.1703100917380.28674@imuri>
 <alpine.LNX.2.20.1703101434490.19808@imuri>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <a3d2a81a-4620-f0d8-993b-b71828fb1f57@gmx.com>
Date: Sat, 11 Mar 2017 12:14:04 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1703101434490.19808@imuri>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/10/2017 09:48 AM, Sami Kerola wrote:
> On Fri, 10 Mar 2017, Sami Kerola wrote:
>> Notably I did not move list of recommended arguments to usage(). To do 
>> that well will require inu_use_arguments() function, that can be used 
>> where ever needed. But lets leave this as-is, and do these tidy 
>> adjustments if there it's seen these option argument functions should be 
>> generalized.
> 
> Hi again,
> 
> Having day off and idea to generalize this did not go away from my mind, 

 I'm glad that I'm not the only one with this trouble :)

> so I decided to give it a shot. I'm not sure how many utils might need 
> this, but that is hardly a reason against or in favour to include this. 
> Better question is if this is the way argument lists should be managed 
> when they are deprecated.

Seems correct to me on both accounts; with a few caveats:

The following are based my interpretation of the patch. I haven't
actually tested it. So I may have misread something.

* Is arg_removed needed? I think a 'removed' argument should be handled
  the same as an 'invalid' argument. Saying it was removed doesn't seem
  helpful and could be confusing.

* blkid: 'udev' is deprecated
  Seems ambiguous to me. Perhaps follow your default message style of:
  "invalid argument: udev". Like "deprecated argument: udev".

* What about this scenario:
  mycommand -a udev -b udev -c udev
   mycommand: 'udev' is deprecated
   mycommand: 'udev' is removed

Which is deprecated, which is removed, and which is in_use?
Is it the calling code's job to add the option name somehow?
Do we add 'char *opt_name' to 'struct option_arguments'?
Do we whistle a happy song and pretend this scenario cannot happen? :)


> +	int id;
> +	char *name;
> +	int status;
> +}
> 
> The below change can also be found from
>   git://github.com/kerolasa/lelux-utiliteetit.git 2017wk09
> 
> --->8----
> From: Sami Kerola <kerolasa@iki.fi>
> Date: Fri, 10 Mar 2017 14:06:10 +0000
> Subject: [PATCH] include/optutils: add option argument parsing and printing functions
> 
> Functions parse_arg_name() and print_valid_args() add methods that make
> option argument life cycle management easy.
> 
> Based-on-feedback-from: J William Piggott <elseifthen@gmx.com>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/optutils.h | 50 +++++++++++++++++++++++++++++++
>  misc-utils/blkid.c | 87 
> +++++++++++++++---------------------------------------
>  2 files changed, 73 insertions(+), 64 deletions(-)
> 
> diff --git a/include/optutils.h b/include/optutils.h
> index 325cb8812..62ccc90ae 100644
> --- a/include/optutils.h
> +++ b/include/optutils.h
> @@ -6,6 +6,56 @@
>  #include "c.h"
>  #include "nls.h"
>  
> +enum {
> +	arg_in_use = 0,
> +	arg_hide,
> +	arg_deprecate,
> +	arg_removed
> +};
> +
> +struct option_arguments {
> +	int id;
> +	char *name;
> +	int status;
> +};
> +
> +static inline int parse_arg_name(const struct option_arguments *valid_args,
> +				 const char *arg)
> +{
> +	size_t i;
> +
> +	for (i = 0; valid_args[i].name; i++) {
> +		if (strcmp(valid_args[i].name, arg) != 0)
> +			continue;
> +		switch (valid_args[i].status) {
> +		case arg_in_use:
> +		case arg_hide:
> +			return valid_args[i].id;
> +		case arg_deprecate:
> +			warnx(_("'%s' is deprecated"), arg);
> +			return valid_args[i].id;
> +		case arg_removed:
> +			warnx(_("'%s' is removed"), arg);
> +			return -EINVAL;
> +		default:
> +			abort();
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static inline void print_valid_args(const struct option_arguments *valid_args,
> +				    const char *message, FILE *out)
> +{
> +	size_t i;
> +
> +	fprintf(out, message);
> +	for (i = 0; valid_args[i].name; i++)
> +		if (valid_args[i].status == arg_in_use)
> +			fprintf(out, " %s", valid_args[i].name);
> +	fputc('\n', out);
> +}
> +
>  static inline const char *option_to_longopt(int c, const struct option *opts)
>  {
>  	const struct option *o;
> diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
> index e0be5120c..5e3f58838 100644
> --- a/misc-utils/blkid.c
> +++ b/misc-utils/blkid.c
> @@ -19,36 +19,6 @@
>  #include <errno.h>
>  #include <getopt.h>
>  
> -enum {
> -	OUTPUT_FULL = 0,
> -	OUTPUT_VALUE_ONLY,
> -	OUTPUT_DEVICE_ONLY,
> -	OUTPUT_PRETTY_LIST,
> -	OUTPUT_UDEV_LIST,
> -	OUTPUT_EXPORT_LIST
> -};
> -
> -enum {
> -	opt_in_use = 0,
> -	opt_hide,
> -	opt_deprecate,
> -	opt_removed
> -};
> -
> -struct option_arguments {
> -	char *name;
> -	int status;
> -};
> -
> -static struct option_arguments output_formats[] = {
> -	[OUTPUT_FULL]		= { "full", opt_in_use },
> -	[OUTPUT_VALUE_ONLY]	= { "value", opt_in_use },
> -	[OUTPUT_DEVICE_ONLY]	= { "device", opt_in_use },
> -	[OUTPUT_PRETTY_LIST]	= { "list", opt_hide },		/* to be deprecated */
> -	[OUTPUT_UDEV_LIST]	= { "udev", opt_hide },		/* to be deprecated */
> -	[OUTPUT_EXPORT_LIST]	= { "export", opt_in_use },
> -};
> -
>  #define LOWPROBE_TOPOLOGY	(1 << 1)
>  #define LOWPROBE_SUPERBLOCKS	(1 << 2)
>  
> @@ -71,6 +41,25 @@ static struct option_arguments output_formats[] = {
>  #include "ttyutils.h"
>  #include "xalloc.h"
>  
> +enum {
> +	OUTPUT_FULL = 0,
> +	OUTPUT_VALUE_ONLY,
> +	OUTPUT_DEVICE_ONLY,
> +	OUTPUT_PRETTY_LIST,
> +	OUTPUT_UDEV_LIST,
> +	OUTPUT_EXPORT_LIST
> +};
> +
> +static struct option_arguments output_formats[] = {
> +	{ OUTPUT_FULL,  "full", arg_in_use },
> +	{ OUTPUT_VALUE_ONLY, "value", arg_in_use },
> +	{ OUTPUT_DEVICE_ONLY, "device", arg_in_use },
> +	{ OUTPUT_PRETTY_LIST, "list", arg_hide },	/* to be deprecated */
> +	{ OUTPUT_UDEV_LIST, "udev", arg_hide },		/* to be deprecated */
> +	{ OUTPUT_EXPORT_LIST, "export", arg_in_use },
> +	{ 0, NULL, 0 }
> +};
> +
>  static int raw_chars;
>  
>  static void print_version(FILE *out)
> @@ -98,8 +87,8 @@ static void usage(int error)
>  	fputs(_(	" -d          don't encode non-printing characters\n"), out);
>  	fputs(_(	" -h          print this usage message and exit\n"), out);
>  	fputs(_(	" -g          garbage collect the blkid cache\n"), out);
> -	fputs(_(	" -o <format> output format; can be one of:\n"
> -			"               value, device, export or full; (default: full)\n"), out);
> +	fputs(_(	" -o <format> output format; can be one of:\n"), out);
> +	print_valid_args(output_formats, "              ", out);
>  	fputs(_(	" -k          list all known filesystems/RAIDs and exit\n"), out);
>  	fputs(_(	" -s <tag>    show specified tag(s) (default show all tags)\n"), out);
>  	fputs(_(	" -t <token>  find device with a specific token (NAME=value pair)\n"), out);
> @@ -121,36 +110,6 @@ static void usage(int error)
>  	exit(error);
>  }
>  
> -static int parse_format_name(const char *arg)
> -{
> -	size_t i;
> -
> -	for (i = 0; i < ARRAY_SIZE(output_formats); i++) {
> -		if (strcmp(output_formats[i].name, arg) != 0)
> -			continue;
> -		switch (output_formats[i].status) {
> -		case opt_in_use:
> -		case opt_hide:
> -			return i;
> -		case opt_deprecate:
> -			warnx(_("'%s' is deprecated"), arg);
> -			return i;
> -		case opt_removed:
> -			warnx(_("'%s' is removed"), arg);
> -			return -EINVAL;
> -		default:
> -			abort();
> -		}
> -	}
> -	warnx(_("invalid argument: '%s'"), arg);
> -	fprintf(stderr, _("recommended arguments to use are:"));
> -	for (i = 0; i < ARRAY_SIZE(output_formats); i++)
> -		if (output_formats[i].status == opt_in_use)
> -			fprintf(stderr, " %s", output_formats[i].name);
> -	fputc('\n', stderr);
> -	return -EINVAL;
> -}
> -
>  /*
>   * This function does "safe" printing.  It will convert non-printable
>   * ASCII characters using '^' and M- notation.
> @@ -770,9 +729,9 @@ int main(int argc, char **argv)
>  			exit(EXIT_SUCCESS);
>  		}
>  		case 'o':
> -			output_format = parse_format_name(optarg);
> +			output_format = parse_arg_name(output_formats, optarg);
>  			if (output_format < 0)
> -				exit(BLKID_EXIT_OTHER);
> +				errx(BLKID_EXIT_OTHER, _("invalid argument: %s"), optarg);
>  			break;
>  		case 'O':
>  			offset = strtosize_or_err(optarg, _("invalid offset argument"));
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
