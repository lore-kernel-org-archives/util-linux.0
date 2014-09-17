Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f172.google.com ([209.85.220.172]:34164 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbaIQMWh convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Sep 2014 08:22:37 -0400
Received: by mail-vc0-f172.google.com with SMTP id hy10so1160290vcb.31
        for <util-linux@vger.kernel.org>; Wed, 17 Sep 2014 05:22:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
References: <karelzak/util-linux/pull/117@github.com>
	<karelzak/util-linux/pull/117/c55868722@github.com>
	<CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
Date: Wed, 17 Sep 2014 18:22:36 +0600
Message-ID: <CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
Subject: Fwd: [util-linux] cal: add landscape layout for yearly views (#117)
From: Gennady Kovshenin <gennady@kovshenin.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a follow-up to:

https://github.com/karelzak/util-linux/pull/117#issuecomment-55868722

> With the high availability of wide screens and high-resolution emulated
> terminals and terminal window managers it's sometimes useful to change
> the output of cal(1) yearly views to more stretched out ones
> horizontally.
>
> This patch adds a new -l/--landscape flag that stretches out the yearly
> view to 3x4 and 4x3 months in Julian mode and 4x3 and 6x2 in regular
> mode. The flag can be used up to two times.


Thank you for your response, Karel :)

"It would be better to make it completely dynamical and fill-in all
terminal horizontally if possible. It means to determine the number of
the months dynamically according to terminal width rather than
hardcode number of months (or require more -l options
(ctl.landscape++))."

I don't think the filling in the terminal completely is a logical
approach. I feel that calendar year output has to be rectangular. T
here are always 12 months and the only way to arrange them into a
nice rectangular shape is 1x12, 2x6, 3x4, 4x3, 6x2, 12x1, other shapes
don't make much sense UI-wise, do they? All the printed mini calendars
I get are always laid out in 3x4, 4x3 or 6x2 (rare).

This is what actually inspired me to hack cal in the first place.
Someone asked me to put together a simple mini calendar from print, it
had to be in landscape mode (4x3 months). cal would only output 3x4 so
I couldn't just copy and paste into GIMP. I couldn't even find a tool
online that would output nice text to paste in. Ended up downloading
the source and hacking a quick 4x3 mode for a once-off purpose,
writing down "cal landscape mode" in my todo list.

I did pick the most useful extensions of 4x3 and 6x2 for regular, and 3x4 and
4x3 for the Julian one. I have a 1080p monitor and 6x2 is the largest
it goes without wrapping on a 12pt mono font for a regular calendar
(Julian is a bit wider even so 6x2 barely fits).

If 12x1 is really useful (i.e. full length with month wrapping) adding
another -l to extend would work. But not having the flexibility of
wrapping to predefined sizes seems like a missing feature. I mean we
could resize the terminal window and wrap along the edges, but that's
not good UI. Forcing the user to resize the terminal window to get
perfect rectangular layouts seems like a hack.

I did pick the repetition of the flag to stretch out the layout akin
to the way verbose flags work in many programs, by repeating -vvvv one
gets more verbosity out of the program. And by repeating -lll one gets
more lanscape out of cal.

Hope this makes sense. I appreciate your feedback and hope to sort
this feature out with more input and brainstorming.

Regards,
Gennady Kovshenin

On Wed, Sep 17, 2014 at 3:18 PM, Karel Zak <notifications@github.com> wrote:
>
> Hi Gennady,
> don't care about po/ stuff, it's automatically updated before release.
>
> The request to make cal(1) more friendly to large screens makes sense, but your -l implementation does not seem to be user-friendly.
>
> It would be better to make it completely dynamical and fill-in all terminal horizontally if possible. It means to determine the number of the months dynamically according to terminal width rather than hardcode number
> of months (or require more -l options (ctl.landscape++)).
>
> See lib/ttyutils.c and get_terminal_width().
>
> Note the best way to discuss new features is util-linux@vger.kernel.org mailing
> list. You don't have to subscribe to send to the list.
>
> —
> Reply to this email directly or view it on GitHub.
