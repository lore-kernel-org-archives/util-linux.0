Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 1/2] cal: honor num_months when only a year argument
Date: Wed, 24 Jan 2018 15:24:02 +0100
Cc: Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org
References: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
In-Reply-To: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201801241524.02617.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 22 January 2018, J William Piggott wrote:
> I don't know if this was an oversight or an overzealous
> interpretation of POSIX. Just in case, I'll address the
> POSIX possibility. POSIX description for cal(1) says:
>
>   If only the year operand is given, cal shall produce a
>   calendar for all twelve months in the given calendar year.
>
> It also says that cal(1) has no options, so in that context
> if an option is given then it should be expected to override
> POSIX behavior.

We still don't need to fight against POSIX.

"cal -1" behaves like POSIX cal without options.
"cal -3" behaves like POSIX except that it prints 3 months whereever  
POSIX would print only 1.

> Before patched all of these command displayed a full year:
> cal -1 2020
> cal -3 2020
> cal -n6 2020

Seriously, I find the new behavior quiet useless and unwanted. In past 
it seemed to work fine to have such alias in ~./profile

  alias cal="cal -3"


But now "cal -3 2019" always shows Dec, Jan, Feb. Can't believe that any 
user finds this useful. At least it should output of the "current" 
months of the given year. But I wouldn't change this at all. It's just 
an annoying incompatible change without any benefit.


cu,
Rudi


> Patched the number of months options are honored.
>
> This patch also fixes the -1 option which was a no-op.
>
> Signed-off-by: J William Piggott <elseifthen@gmx.com>
> ---
>  misc-utils/cal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 5a6364a27..8a715d94c 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -267,7 +267,6 @@ int main(int argc, char **argv)
>  	static struct cal_control ctl = {
>  		.reform_year = DEFAULT_REFORM_YEAR,
>  		.weekstart = SUNDAY,
> -		.num_months = 1,		/* default is "cal -1" */
>  		.span_months = 0,
>  		.colormode = UL_COLORMODE_UNDEF,
>  		.weektype = WEEK_NUM_DISABLED,
> @@ -363,7 +362,7 @@ int main(int argc, char **argv)
>
>  		switch(ch) {
>  		case '1':
> -			/* default */
> +			ctl.num_months = 1;
>  			break;
>  		case '3':
>  			ctl.num_months = 3;
> @@ -536,7 +535,8 @@ int main(int argc, char **argv)
>
>  	if (yflag || Yflag) {
>  		ctl.gutter_width = 3;
> -		ctl.num_months = MONTHS_IN_YEAR;
> +		if (!ctl.num_months)
> +			ctl.num_months = MONTHS_IN_YEAR;
>  		if (yflag) {
>  			ctl.req.start_month = 1;	/* start from Jan */
>  			ctl.header_year = 1;		/* print year number */
> @@ -549,6 +549,9 @@ int main(int argc, char **argv)
>  	else if (!ctl.months_in_row)
>  		ctl.months_in_row = 1;
>
> +	if (!ctl.num_months)
> +		ctl.num_months = 1;		/* display at least one month */
> +
>  	if (yflag || Yflag)
>  		yearly(&ctl);
>  	else
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
