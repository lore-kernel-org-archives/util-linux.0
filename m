Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34559 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdANJe1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 14 Jan 2017 04:34:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so17152144wmi.1
        for <util-linux@vger.kernel.org>; Sat, 14 Jan 2017 01:34:26 -0800 (PST)
Date: Sat, 14 Jan 2017 09:34:16 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: J William Piggott <elseifthen@gmx.com>
cc: util-linux@vger.kernel.org
Subject: Re: pull: hwclock 27 changes
In-Reply-To: <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com>
Message-ID: <alpine.LNX.2.20.1701140930380.2049@imuri>
References: <20161231214107.8658-1-kerolasa@iki.fi> <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com> <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com> <alpine.LNX.2.20.1701072212010.9096@imuri> <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
 <alpine.LNX.2.20.1701112055190.2589@imuri> <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 12 Jan 2017, J William Piggott wrote:
> On 01/11/2017 04:44 PM, Sami Kerola wrote:
> > On Sun, 8 Jan 2017, J William Piggott wrote:
> >>> @@ -1031,9 +1032,7 @@ calculate_adjustment(const struct hwclock_control *ctl,
> >>>  	exact_adjustment =
> >>>  	    ((double)(systime - last_time)) * factor / (24 * 60 * 60)
> >>>  	    + not_adjusted;
> >>> -	tdrift_p->tv_sec = (int) exact_adjustment;
> >>> -	if (exact_adjustment < 0)
> >>> -		tdrift_p->tv_sec--;
> >>> +	tdrift_p->tv_sec = (int) floor(exact_adjustment);
> >>
> >> Is the cast required now?
> > 
> > floor(3) will return double, tv_sec is time_t. Yes I should and have 
> > fixed the cast from int to time_t.
> 
> Isn't the cast implied by assignment and done automatically? Isn't that
> why the previous mismatch with the (int) cast worked? In the next line
> of code we assign a double to tv_usec which is a mismatch also.
> 
> I built your latest branch with and without the cast and the results
> were binary identical.

Preferably there should not be casts at all. But sometimes they are hard 
to avoid, and then one should do as few casts as possible to avoid cutting 
bits out.

Think casting in terms of shape sorting toy. The more data is casted 
through none-matching types the more the original shape is modified to fit 
to storage where it is pushed.

That is also the reason why casting to time_t in this case makes sense. 
While it might be that right now, on systems we happen to use, int and 
time_t are the same type there are no guarantees about other systems and 
future. In practical terms; casting exactly to matching storage type is 
the right way to avoid damaging data.

> > ----------------------------------------------------------------
> > The following changes since commit 89958178f6d6ebe0944d423feaea66be521fff43:
> >   If mtab support is disabled, disable ro/rw mtab checks (2017-01-10 17:32:32 +0100)
> > are available in the git repository at:
> >   git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
> > for you to fetch changes up to d3e33557e6794446c712ca264e54fe4b186a17ca:
> >   hwclock: remove --compare option (2017-01-11 21:04:36 +0000)
> > ----------------------------------------------------------------
> > 
> > Thank you JWP for reviews, I hope I did not miss anything but if I did let 
> > me know and I will follow up. Even better if everyone agrees that this is 
> > now good enough to be merged, and we can move forward with other updates 
> > such as adjtimex(8) work.
> 
> Thanks for all the work, Sami. I've been testing your latest branch and
> haven't found any problems. I cannot test all of your changes though, for
> example I don't have libaudit installed. For what it's worth, I think it
> is ready.

Good point. I do not have libaudit either. Hearing that setup does not 
have functional problems would really nice.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
