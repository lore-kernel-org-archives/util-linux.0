Return-Path: util-linux-owner@vger.kernel.org
Received: from mail4.vodafone.ie ([213.233.128.170]:34557 "EHLO
	mail4.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaE1L33 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 May 2014 07:29:29 -0400
Message-ID: <5384770F.7040402@draigBrady.com>
Date: Tue, 27 May 2014 12:29:19 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: BUG: cal prints bad month headers
References: <201405271145.56596.sweet_f_a@gmx.de> <201405271250.41256.sweet_f_a@gmx.de>
In-Reply-To: <201405271250.41256.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/27/2014 11:50 AM, Ruediger Meier wrote:
> On Tuesday 27 May 2014, Ruediger Meier wrote:
>> This happens only if output is redirected into a file
>> $ ./cal -ym > bla ;cat bla
>> It looks good in terminal.
>>
>> Reverting 95f4adde (plus 0c6dc4b9 and 4a7424a5) fixes the problem.
> 
> Just another hint. Adding a fflush() like you see below also "fixes" the 
> problem. Maybe we are mixing several output methods (printf, puts, 
> my_putstring, etc.) like we shouldn't.
> 
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 81375fe..2b61a30 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -760,6 +760,7 @@ static void yearly(const struct cal_control *ctl)
>                 set_consecutive_months(&m1, month, ctl->req.year);
>                 for (i = &m1; i; i = i->next)
>                         cal_fill_month(i, ctl);
> +               fflush(NULL);
>                 cal_output_header(&m1, ctl);
>                 cal_output_months(&m1, ctl);
>         }
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

This would avoid the problem.
The correct fix would to have all output go through
the same channel (buffer), i.e. all output should use
my_putstring()

cheers,
Pádraig.
