Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:9446 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab1KNIwI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 03:52:08 -0500
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LUN00AVP7A5D040@damascus.uab.es> for
 util-linux@vger.kernel.org; Mon, 14 Nov 2011 09:51:41 +0100 (CET)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LUN00B1Y7A53M70@damascus.uab.es>
 forutil-linux@vger.kernel.org; Mon, 14 Nov 2011 09:51:41 +0100 (CET)
Date: Mon, 14 Nov 2011 11:54:21 +0100
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 10/15] prlimit: refactor code: separate modify and
	showclearly
In-reply-to: <4EC07375.20005@bernhard-voelker.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Message-id: <1321268061.8015.3.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <4EC07375.20005@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-11-14 at 02:48 +0100, Bernhard Voelker wrote:
> [PATCH 10/15] prlimit: refactor code: separate modify and show clearly
> 
> Struct prlimit now has a flag whether a limit has to be modified,
> and a flag whether the limit has to be shown; names "modify" and
> "show". Furthermore, move show_limits() to main().
> 
> Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
> ---
>   sys-utils/prlimit.c |   37 +++++++++++++++++++------------------
>   1 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
> index 4124faa..fc11a94 100644
> --- a/sys-utils/prlimit.c
> +++ b/sys-utils/prlimit.c
> @@ -85,12 +85,12 @@ static struct prlimit_desc prlimit_desc[] =
> 
>   struct prlimit {
>   	struct rlimit rlim;
> -	int found;

Wait, doesn't patch 07 add this variable?

>   	struct prlimit_desc *desc;
>   	int modify;
> +	int show;
>   };
> 
> -#define PRLIMIT_EMPTY_LIMIT	{{ 0, 0, }, NULL, 0 }
> +#define PRLIMIT_EMPTY_LIMIT	{{ 0, 0, }, NULL, 0, 0 }
> 
>   enum {
>   	COL_HELP,
> @@ -286,7 +286,7 @@ static int show_limits(struct prlimit lims[], size_t 
> n, int tt_flags)
>   	}
> 
>   	for (i = 0; (size_t) i < n; i++)
> -		if (!lims[i].modify) /* only display old limits */
> +		if (lims[i].show)
>   			add_tt_line(tt, &lims[i]);
> 
>   	tt_print_table(tt);
> @@ -302,23 +302,23 @@ static void get_unknown_hardsoft(struct prlimit *lim)
>   	 * passed), we need to get the current limit and use it.
>   	 * I see no other way other than using prlimit(2).
>   	 */
> -	if (lim->found != (PRLIMIT_HARD | PRLIMIT_SOFT)) {
> +	if (lim->modify != (PRLIMIT_HARD | PRLIMIT_SOFT)) {
>   		struct rlimit old;
> 
>   		if (prlimit(pid, lim->desc->resource, NULL, &old) == -1)
>   			errx(EXIT_FAILURE, _("failed to get old %s limit"),
>   				lim->desc->resource);
> 
> -		if (!(lim->found & PRLIMIT_SOFT))
> +		if (!(lim->modify & PRLIMIT_SOFT))
>   			lim->rlim.rlim_cur = old.rlim_cur;
> -		else if (!(lim->found & PRLIMIT_HARD))
> +		else if (!(lim->modify & PRLIMIT_HARD))
>   			lim->rlim.rlim_max = old.rlim_max;
>   			
>   		/* give better diagnostic in cases where the new hard limit
>   		 * would be lower than the current soft limit, and the user
>   		 * did not give a new soft limit.
>   		 */
> -		if (!(lim->found & PRLIMIT_SOFT) &&
> +		if (!(lim->modify & PRLIMIT_SOFT) &&
>   			(lim->rlim.rlim_cur > lim->rlim.rlim_max)) {
>   			errx(EXIT_FAILURE,
>   				_("current soft limit %s is greater than new hard limit"),
> @@ -329,7 +329,7 @@ static void get_unknown_hardsoft(struct prlimit *lim)
> 
>   static void do_prlimit(struct prlimit lims[], size_t n, int tt_flags)
>   {
> -	size_t i, nshows = 0;
> +	size_t i;
> 
>   	for (i = 0; i < n; i++) {
>   		struct rlimit *new = NULL;
> @@ -349,8 +349,6 @@ static void do_prlimit(struct prlimit lims[], size_t 
> n, int tt_flags)
>   				errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling 
> value"));
> 
>   			new = &lims[i].rlim;
> -		} else {
> -			nshows++;
>   		}
> 
>   		if (verbose && new) {
> @@ -384,9 +382,6 @@ static void do_prlimit(struct prlimit lims[], size_t 
> n, int tt_flags)
>   			}
>   		}
>   	}
> -
> -	if (nshows)
> -		show_limits(lims, n, tt_flags);
>   }
> 
> 
> @@ -457,16 +452,16 @@ static int get_range(char *str, rlim_t *soft, 
> rlim_t *hard, int *found)
>   static int parse_prlim(struct rlimit *lim, char *ops, size_t id)
>   {
>   	rlim_t soft, hard;
> -	int found = 0;
> +	int modify = 0;
> 
> -	if (get_range(ops, &soft, &hard, &found))
> +	if (get_range(ops, &soft, &hard, &modify))
>   		errx(EXIT_FAILURE, _("failed to parse %s limit"),
>   		     prlimit_desc[id].name);
> 
>   	lim->rlim_cur = soft;
>   	lim->rlim_max = hard;
> 
> -	return found;
> +	return modify;
>   }
> 
>   /*
> @@ -477,8 +472,13 @@ static int add_prlim(char *ops, struct prlimit 
> *lim, size_t id)
>   	lim->desc = &prlimit_desc[id];
> 
>   	if (ops) { /* planning on modifying a limit? */
> -		lim->modify = 1;
> -		lim->found = parse_prlim(&lim->rlim, ops, id);
> +		int modify = parse_prlim(&lim->rlim, ops, id);
> +		if (modify)
> +			lim->modify = 1;
> +		else
> +			lim->show = 1;
> +	} else {
> +		lim->show = 1;
>   	}
> 
>   	return 0;
> @@ -630,6 +630,7 @@ int main(int argc, char **argv)
>   	}
> 
>   	do_prlimit(lims, n, tt_flags);
> +	show_limits(lims, n, tt_flags);
> 
>   	return EXIT_SUCCESS;
>   }
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


