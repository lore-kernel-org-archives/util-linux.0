Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f179.google.com ([209.85.220.179]:53678 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbaIQPwh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Sep 2014 11:52:37 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so605632vcb.10
        for <util-linux@vger.kernel.org>; Wed, 17 Sep 2014 08:52:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140917131848.GA5366@x2.net.home>
References: <karelzak/util-linux/pull/117@github.com>
	<karelzak/util-linux/pull/117/c55868722@github.com>
	<CAP0zEAb8y+P-McdLc23dJyqG3_=mFQw9PEmkaLLbzGzmWL7p-A@mail.gmail.com>
	<CAP0zEAZhyOqM-VmBkGEA4sN2wC+YycOtP8h6AxytjTDXsw1K4A@mail.gmail.com>
	<20140917131848.GA5366@x2.net.home>
Date: Wed, 17 Sep 2014 21:52:36 +0600
Message-ID: <CAP0zEAZ9aMs-ky5ivweJoytTn7MvGcq0qyyDnFkk-5iMWRHz0w@mail.gmail.com>
Subject: Re: Fwd: [util-linux] cal: add landscape layout for yearly views (#117)
From: Gennady Kovshenin <gennady@kovshenin.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)@mail.corp.redhat.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I like the format=auto idea. But we can keep it to just the number of
columns instead of a full CxR format.
i.e. format=2 (2x6), format=3 (3x4), format=4 (4x3), and so on.
perhaps the parameter should be called --columns/-c instead of format.
We can either have an additional auto value to the format, or have it
be on by default.
Having auto on by default means breaking compatibility. Some users
might be parsing output expecting the default 3x4 view in place and if
we abruptly change this to be stretched automatically their scripts
might break.

Any thoughts on the above? --format vs. --columns? And the default
value thereof.

Regards,
Gennady Kovshenin
Regards,
Gennady Kovshenin


On Wed, Sep 17, 2014 at 7:18 PM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Sep 17, 2014 at 06:22:36PM +0600, Gennady Kovshenin wrote:
>> I don't think the filling in the terminal completely is a logical
>> approach. I feel that calendar year output has to be rectangular. T
>> here are always 12 months and the only way to arrange them into a
>> nice rectangular shape is 1x12, 2x6, 3x4, 4x3, 6x2, 12x1, other shapes
>> don't make much sense UI-wise, do they? All the printed mini calendars
>> I get are always laid out in 3x4, 4x3 or 6x2 (rare).
>
>  Well, "fill-in all terminal horizontally" does not mean that I want to
>  generate any unreadable mess :-)
>
>  I'd like to see "cal --landscape" *just works* and it automatically
>  selects the best output format (3x4, 4x3, 6x2, ...) which fits into
>  the current terminal width. That's all the story. As user I don't
>  want to think about number of -l options.
>
>  Additionally we can add a new option --format={3x4, 4x3, auto, ...}
>  to provide full control on the output for scripts that generate
>  something from cal(1) output.
>
>  IMHO, it's mistake that for example -y or -3 ignores terminal width
>  so on small terminals it's unreadable.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
