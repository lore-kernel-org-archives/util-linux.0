Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388172AbeGXNhM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 24 Jul 2018 09:37:12 -0400
Date: Tue, 24 Jul 2018 14:30:52 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: stop supporting alpha cpu architecture
Message-ID: <20180724123052.szmsn3yguneebree@ws.net.home>
References: <20180626211343.4675-1-kerolasa@iki.fi>
 <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
 <CAG27Bk3Z7zCQpZv_0Ubd+pfo3f1G6NnKyxr4mRJYT-kyK9+p=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3Z7zCQpZv_0Ubd+pfo3f1G6NnKyxr4mRJYT-kyK9+p=A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 27, 2018 at 10:24:47PM +0100, Sami Kerola wrote:
> On 27 June 2018 at 06:58, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> > On 06/26/2018 11:13 PM, Sami Kerola wrote:
> >> @@ -255,16 +249,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
> >>       } else {
> >>               int rc;         /* Return code from ioctl */
> >>               /* Turn on update interrupts (one per second) */
> >> -#if defined(__alpha__) || defined(__sparc__)
> >> -             /*
> >> -              * Not all alpha kernels reject RTC_UIE_ON, but probably
> >> -              * they should.
> >> -              */
> >> -             rc = -1;
> >> -             errno = EINVAL;
> >> -#else
> >>               rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
> >> -#endif
> >
> > Are you sure you want to change the code path for SPARC?
> 
> Hi Berny,
> 
> After reading linux kernel code, and trying to find references where sparc
> condition might be originating I could not find good reason why sparc should
> hard code RTC_UIE_ON not to be supported.  There is message from 2005 about
> chrony having issue with sparc RTC_UIE_ON, but later in that thread Dave
> Miller tells there is no problem with rtc and sparc.  I am fairly confident
> ioctl(rtc_fd, RTC_UIE_ON, 0) will either do the right thing or return -1.
> 
> Reference: https://lists.debian.org/debian-sparc/2005/04/msg00115.html

Maybe the best would be to postpone this to v2.34 and in v2.33 just
inform about this plan. Frankly, I'm not sure where and what is
supported for alpha...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
