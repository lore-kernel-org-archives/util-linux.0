Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53650 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932693AbXBONDP (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 15 Feb 2007 08:03:15 -0500
Date: Thu, 15 Feb 2007 14:03:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Christian Schlotter <schlotter@users.sourceforge.net>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] cal: Output unaligned with "-3" option and libtermcap
Message-ID: <20070215130303.GG3925@petra.dvoda.cz>
References: <45868535.5030402@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45868535.5030402@users.sourceforge.net>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Christian,

 some ideas from your patch are really good, but the rest is not so
 perfect after all.

On Mon, Dec 18, 2006 at 01:10:29PM +0100, Christian Schlotter wrote:

> +monthly3(int day, int month, int year, const int show_year) {

> -	do_monthly(day, prev_month, prev_year, &out_prev);
> -	do_monthly(day, month,      year,      &out_curm);
> -	do_monthly(day, next_month, next_year, &out_next);

 This is basic idea of the old monthly3() implementation and I think
 it's definitely good idea. There must be only one place
 (= do_monthly()) where we generate output for months.

> -        width = (julian ? J_WEEK_LEN : WEEK_LEN) -1;
> -	for (i = 0; i < 2; i++)
> -		printf("%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
> -	for (i = 2; i < FMT_ST_LINES; i++) {
> -		snprintf(lineout, SIZE(lineout), "%-*s  %-*s  %-*s\n",
> -		       width, out_prev.s[i],
> -		       width, out_curm.s[i],
> -		       width, out_next.s[i]);
> +    memset(lineout, ' ', sizeof(lineout) - 1);
> +    lineout[sizeof(lineout) - 1] = '\0';
> +
> +    for (i = 0; i < 3; i++) {
> +	    day_array(day, months[i], years[i], days[i]);
> +	    if (show_year) {
> +		    snprintf(head, sizeof(head), _("%s %d"),
> +			     full_month[months[i] - 1], years[i]);
> +	    } else {
> +		    snprintf(head, sizeof(head), _("%s"),
> +			     full_month[months[i] - 1]);
> +	    }
> +	    center(head, week_len, (i == 2) ? 0 : head_sep);
> +    }

 Here you *duplicate* functionality from do_monthly(). I think a
 better way will be add support for the "show_year" option to the
 do_monthly() function.

 Should be something like:

 monthly3(int day, int month, int year, const int show_year) {

  for (i = 0; i < 3; i++)
      do_monthly(day, month[i], year[i], out[i], show_year);
 }

> +		my_putstring(lineout);putchar('\n');

 Ah.., please, two lines:

     my_putstring(lineout);
     putchar('\n');

 :-)

>  yearly(int day, int year) {

> +	for (month = 0; month < 12; month += 3)
> +		monthly3(day, month + 2, year, show_year);
>  }

  Good idea.

  yearly   = 4 * monthly3
  monthly3 = 3 * do_monthly


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
