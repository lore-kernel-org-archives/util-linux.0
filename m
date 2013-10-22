Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62424 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab3JVPXW (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 22 Oct 2013 11:23:22 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so6272594pab.34
        for <util-linux-ng@vger.kernel.org>; Tue, 22 Oct 2013 08:23:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20131022103214.GG15115@x2.net.home>
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
	<20131022103214.GG15115@x2.net.home>
Date: Tue, 22 Oct 2013 16:23:22 +0100
Message-ID: <CAG27Bk3+XOmDrSumdaqWn_tTH1OxYQjwfeoaZ0pM8jN6OJuNQA@mail.gmail.com>
Subject: Re: [RFC/PATCH] week numbers for cal
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Tommi Kyntola <tommi.kyntola@gmail.com>, util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 October 2013 11:32, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Oct 05, 2013 at 11:59:54PM +0300, Tommi Kyntola wrote:
>> I keep trying -w with cal from time to time and I finally decided it's
>> about time to do something about it. I'm not sure if this is something
>> you'd be interested in incorporating into util-linux cal, but it's
>> something I wanted, so here it is. There's gcal of course, but I only
>> wanted a toothpick not the whole forest.
>
> Applied, thanks.

FYI

I started think, and play with the cal code, in order to make the source a
little bit more maintainable.  My plan is to add run time configuration
and parameters structures. With bit of luck changing data structures
allows less strange functions.

Broken peak preview:
https://github.com/kerolasa/lelux-utiliteetit/tree/cal-ng

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
