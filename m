Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57570 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbdF0MmW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jun 2017 08:42:22 -0400
Subject: Re: [PATCH 6/6] misc: update --help content again
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
 <20170626182952.15988-7-sweet_f_a@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <965eb1e3-7439-809e-5d71-bb794997a950@gmx.com>
Date: Tue, 27 Jun 2017 08:42:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170626182952.15988-7-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/26/2017 02:29 PM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> We change
> 
>  -h, --help     display this help and exit
>  -V, --version  output version information and exit
> 
> to
> 
>  -h, --help     display this help
>  -V, --version  print version
> 
> Some thoughts about this:
> 
>   * use "display" for --help because it matches better if we
>     would add pager support (like git --help)
>   * "print" for --version to be different

To be different why? It makes it sound like help and version will not
have the same action. Laymen think 'print' means send to the printer.
Translators will have to figure out which different words to use.

What is broken by:

 -h, --help     display this help
 -V, --version  display version

I really think it is a  good idea to use consistent language for
comparable actions. It is easier to comprehend, especially for
non-native speakers. Once they understand the meaning of a term,
possibly from a context that they the understand well, then that
knowledge is transferable to other contexts. Why add confusion by
constantly interchanging term synonyms?


>   * "this" for --help is important to make clear that running
>     --help would not give you any better information than the
>     one you see already
>   * remove "information and exit" because it's bloat for the
>     short-help, everybody knows what it does if it exists
> 
> In the manpages we should use the old, longer but more correct
> descriptions, inclusive a reminder if --help/--version are only
> working when used as the only option. Note the term "version
> information" indicates that we don't only print a single version
> number.
> 
> CC: J William Piggott <elseifthen@gmx.com>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  include/c.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/c.h b/include/c.h
> index ce5551535..be7e6fd53 100644
> --- a/include/c.h
> +++ b/include/c.h
> @@ -316,8 +316,8 @@ static inline int xusleep(useconds_t usec)
>  #define USAGE_COLUMNS    _("\nAvailable output columns:\n")
>  #define USAGE_SEPARATOR    "\n"
>  
> -#define USAGE_HELP_TXT    _("display this help and exit")
> -#define USAGE_VERSION_TXT _("output version information and exit")
> +#define USAGE_HELP_TXT    _("display this help")
> +#define USAGE_VERSION_TXT _("print version")
>  
>  #define PRINT_USAGE_HELP(marg_dsc) \
>  	printf( \
> 
