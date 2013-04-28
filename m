Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f53.google.com ([209.85.128.53]:56010 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab3D1R2n (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:28:43 -0400
Received: by mail-qe0-f53.google.com with SMTP id i11so3602920qej.26
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:28:43 -0700 (PDT)
Date: Sun, 28 Apr 2013 13:28:40 -0400
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/11] cal: convert function like definitions to functions
Message-ID: <20130428172840.GE1925@rampage>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
 <1367169067-23705-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367169067-23705-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 28, 2013 at 06:10:58PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---

I agree with the change, but the new functions (all functions here,
really) should be marked as static.

>  misc-utils/cal.c | 45 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 13830de..eacf3dd 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -209,23 +209,6 @@ char j_day_headings[J_WEEK_LEN*6+1];
>  /* weekstart = 1  =>   "  M  Tu   W  Th   F   S   S " */
>  const char *full_month[12];
>  
> -/* leap year -- account for gregorian reformation in 1752 */
> -#define	leap_year(yr) \
> -	((yr) <= 1752 ? !((yr) % 4) : \
> -	(!((yr) % 4) && ((yr) % 100)) || !((yr) % 400))
> -
> -/* number of centuries since 1700, not inclusive */
> -#define	centuries_since_1700(yr) \
> -	((yr) > 1700 ? (yr) / 100 - 17 : 0)
> -
> -/* number of centuries since 1700 whose modulo of 400 is 0 */
> -#define	quad_centuries_since_1700(yr) \
> -	((yr) > 1600 ? ((yr) - 1600) / 400 : 0)
> -
> -/* number of leap years between year 1 and this year, not inclusive */
> -#define	leap_years_since_year_1(yr) \
> -	((yr) / 4 - centuries_since_1700(yr) + quad_centuries_since_1700(yr))
> -
>  /* 0 => sunday, 1 => monday */
>  int weekstart=0;
>  int julian;
> @@ -239,6 +222,9 @@ struct fmt_st
>    char s[FMT_ST_LINES][FMT_ST_CHARS];
>  };
>  
> +int leap_year(int year);
> +int centuries_since_1700(int year, int centuries);
> +int leap_years_since_year_1(int year);
>  char * ascii_day(char *, int);
>  int center_str(const char* src, char* dest, size_t dest_size, size_t width);
>  void center(const char *, size_t, int);
> @@ -413,6 +399,31 @@ main(int argc, char **argv) {
>  	return EXIT_SUCCESS;
>  }
>  
> +/* leap year -- account for gregorian reformation in 1752 */
> +int leap_year(int year)
> +{
> +	if (year <= 1752)
> +		return !(year % 4);
> +	else
> +		return !(year % 4 && (year % 100 || year % 400));
> +}
> +
> +/* number of centuries since 1700 */
> +int centuries_since_1700(int year, int n)
> +{
> +	if (year < 1700)
> +		return 0;
> +	else
> +		return ((year / (100 * n)) - (17 / n));
> +}
> +
> +/* number of leap years between year 1 and this year, not inclusive */
> +int leap_years_since_year_1(int year)
> +{
> +	return (year / 4 - centuries_since_1700(year, 1) +
> +		centuries_since_1700(year, 4));
> +}
> +
>  void headers_init(void)
>  {
>  	int i, wd;
> -- 
> 1.8.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
