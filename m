Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33537 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcCHWfC convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 17:35:02 -0500
Received: by mail-vk0-f52.google.com with SMTP id k1so35344858vkb.0
        for <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 14:35:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201603081437.31966.sweet_f_a@gmx.de>
References: <201603081437.31966.sweet_f_a@gmx.de>
Date: Tue, 8 Mar 2016 22:35:01 +0000
Message-ID: <CAG27Bk02Yx5fxpV0sWGaLF7W4jSVOcKwGXWQBBQ7DLT48kZF8w@mail.gmail.com>
Subject: Re: cal: bug on FreeBSD
From: Sami Kerola <kerolasa@iki.fi>
To: =?UTF-8?Q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 8 March 2016 at 13:37, Rüdiger Meier <sweet_f_a@gmx.de> wrote:
> cal skips the first day of the week if it has 2 digits.
>
> # diff ./cal
>  Mo Tu We Th Fr Sa Su
>               1  2  3
>   4  5  6  7  8  9 10
> -11 12 13 14 15 16 17
> -18 19 20 21 22 23 24
> -25 26 27 28 29 30
> + 12 13 14 15 16 17
> + 19 20 21 22 23 24
> + 26 27 28 29 30
>
> The bug was introduced by my own commit
> 07ac4aa9  cal: all output must use my_putstring
>
> This is the related code in cal_output_months()
>
> for (d = DAYS_IN_WEEK * week_line;
>      d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
>         if (0 < i->days[d]) {
>                 if (reqday == i->days[d])
>                         sprintf(out, "%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
>                                "", Senter, (ctl->julian ? 3 : 2),
>                                i->days[d], Sexit);
>                 else
>                         sprintf(out, "%*d", skip, i->days[d]);
> /*                             ^^^^^
>  *         if we print this with fputs instead of my_putstring/putp
>  *         below than it looks good */
>         } else
>                 sprintf(out, "%*s", skip, "");
>         my_putstring(out);
>         if (skip < (int)ctl->day_width)
>                 skip++;
> }
>
>
> Is putp() broken on that machine or could we fix it?

Hi Rudi,

Does this happen with putp() only? The following should enable you to
test the fputs() output.

-- snip
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 2a53b89..3e513ad 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -291,6 +291,7 @@ int main(int argc, char **argv)
  Senter = my_tgetstr("smso");
  Sexit = my_tgetstr("rmso");
  }
+ has_term = 0;
  }
  }
 #endif
-- snip

p.s. What is 'that' machine.. just wondering if problem could be reproduced.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
